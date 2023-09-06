!classDefinition: #TestsTelephoneBill category: 'Entrevista Mercap'!
TestCase subclass: #TestsTelephoneBill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!TestsTelephoneBill methodsFor: 'Tests - NewTelephoneBill' stamp: 'Luciano Martín Gamberale 9/3/2023 13:05:32'!
test01ANewTelephoneBillContainsAFixedMonthlyFeeEqualToZero

	| aTelephoneBill |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 06.
	
	self assert: aTelephoneBill getFixedMonyhlyFee equals: 0.
	! !

!TestsTelephoneBill methodsFor: 'Tests - NewTelephoneBill' stamp: 'Luciano Martín Gamberale 9/3/2023 13:05:36'!
test02ANewTelephoneBillContainsZeroCostForLocalCalls

	| aTelephoneBill |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 06.
	
	self assert: aTelephoneBill getTheCostOfLocalCalls equals: 0.
	! !

!TestsTelephoneBill methodsFor: 'Tests - NewTelephoneBill' stamp: 'Luciano Martín Gamberale 9/3/2023 13:05:40'!
test03ANewTelephoneBillContainsZeroCostForNationalAndInternatinalCalls

	| aTelephoneBill |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 06.
	
	self assert: aTelephoneBill getTheCostOfNationalAndInternationalCalls equals: 0.
	! !

!TestsTelephoneBill methodsFor: 'Tests - NewTelephoneBill' stamp: 'Luciano Martín Gamberale 9/3/2023 13:05:48'!
test04ANewTelephoneContainsTheCorrectAccountNameAndCorrectIssueDate

	| aTelephoneBill |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 06.
	
	self assert: aTelephoneBill getTheAccountName equals: 'Account Name'.
	self assert: aTelephoneBill getTheIssueDate equals: (Date year: 2023 month: 06 day: TelephoneBill issueDayNumberOfMonth).! !


!TestsTelephoneBill methodsFor: 'Tests - WithCosts' stamp: 'Luciano Martín Gamberale 9/3/2023 13:05:53'!
test05TheFixedMonthlyBillFeeIsConfiguredCorrectly

	| aTelephoneBill |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 06.
	aTelephoneBill setUpFixedMonthlyFeeOf: 100.
	
	self assert: aTelephoneBill getFixedMonyhlyFee equals: 100
! !

!TestsTelephoneBill methodsFor: 'Tests - WithCosts' stamp: 'Luciano Martín Gamberale 9/6/2023 19:49:25'!
test06ATelephoneBillWithOneLocalTelephoneCallHasTheCorrectCosts

	| aTelephoneBill aBusinessStartDate aBusinessEndDate aTelephoneCallBillItem  |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 02.
	aTelephoneBill setUpFixedMonthlyFeeOf: 100.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
	
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	aTelephoneCallBillItem := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate.
	
	aTelephoneBill add: aTelephoneCallBillItem.
	
	self assert: (aTelephoneBill getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill getTheCostOfLocalCalls) equals: (aTelephoneCallBillItem getCost).
	self assert: (aTelephoneBill getTheCostOfNationalAndInternationalCalls ) equals: 0.
! !

!TestsTelephoneBill methodsFor: 'Tests - WithCosts' stamp: 'Luciano Martín Gamberale 9/6/2023 19:49:52'!
test07ATelephoneBillWithTwoLocalTelephoneCallHasTheCorrectCosts

	| aTelephoneBill aBusinessStartDate aBusinessEndDate aTelephoneCallBillItem1 aTelephoneCallBillItem2 |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 02.
	aTelephoneBill setUpFixedMonthlyFeeOf: 100.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).

	aTelephoneCallBillItem1 := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 3 hour: 22 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 3 hour: 23 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Tuesday).
	
	aTelephoneCallBillItem2 := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate.
	
	aTelephoneBill add: aTelephoneCallBillItem1.
	aTelephoneBill add: aTelephoneCallBillItem2.
	
	self assert: (aTelephoneBill getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill getTheCostOfLocalCalls) equals: ((aTelephoneCallBillItem1 getCost) + (aTelephoneCallBillItem2 getCost)).
	self assert: (aTelephoneBill getTheCostOfNationalAndInternationalCalls ) equals: 0.
! !

!TestsTelephoneBill methodsFor: 'Tests - WithCosts' stamp: 'Luciano Martín Gamberale 9/6/2023 19:50:22'!
test08ATelephoneBillWithOneNationalTelephoneCallHasTheCorrectCosts

	| aTelephoneBill aBusinessStartDate aBusinessEndDate aTelephoneCallBillItem  |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 02.
	aTelephoneBill setUpFixedMonthlyFeeOf: 100.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
	
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	aTelephoneCallBillItem := NationalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate to: #Jujuy.
	
	aTelephoneBill add: aTelephoneCallBillItem.
	
	self assert: (aTelephoneBill getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBill getTheCostOfNationalAndInternationalCalls ) equals: (aTelephoneCallBillItem getCost).
! !

!TestsTelephoneBill methodsFor: 'Tests - WithCosts' stamp: 'Luciano Martín Gamberale 9/6/2023 19:50:39'!
test09ATelephoneBillWithOneInternationalTelephoneCallHasTheCorrectCosts

	| aTelephoneBill aBusinessStartDate aBusinessEndDate aTelephoneCallBillItem  |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 02.
	aTelephoneBill setUpFixedMonthlyFeeOf: 100.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
	
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	aTelephoneCallBillItem := InternationalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate to: #Brazil.
	
	aTelephoneBill add: aTelephoneCallBillItem.
	
	self assert: (aTelephoneBill getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBill getTheCostOfNationalAndInternationalCalls ) equals: (aTelephoneCallBillItem getCost).
! !

!TestsTelephoneBill methodsFor: 'Tests - WithCosts' stamp: 'Luciano Martín Gamberale 9/6/2023 19:51:21'!
test10ATelephoneBillWithTwoInternationalTelephoneCallHasTheCorrectCosts

	| aTelephoneBill aBusinessStartDate aBusinessEndDate aTelephoneCallBillItem1 aTelephoneCallBillItem2 |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 02.
	aTelephoneBill setUpFixedMonthlyFeeOf: 100.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	aTelephoneCallBillItem1 := InternationalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate to: #Brazil.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 3 hour: 22 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 3 hour: 23 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Tuesday).
	
	aTelephoneCallBillItem2 := InternationalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate to: #Brazil.
	
	aTelephoneBill add: aTelephoneCallBillItem1.
	aTelephoneBill add: aTelephoneCallBillItem2.
	
	self assert: (aTelephoneBill getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBill getTheCostOfNationalAndInternationalCalls ) equals: ((aTelephoneCallBillItem1 getCost) + (aTelephoneCallBillItem2 getCost)).
! !

!TestsTelephoneBill methodsFor: 'Tests - WithCosts' stamp: 'Luciano Martín Gamberale 9/6/2023 19:52:47'!
test11TheAccountOfTheTelephoneBillMustBeTheSameAsTheTelephoneCall

	| aTelephoneBill aBusinessStartDate aBusinessEndDate aTelephoneCallBillItem  |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 02.
	aTelephoneBill setUpFixedMonthlyFeeOf: 100.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
		
	aTelephoneCallBillItem := LocalTelephoneCallBillItem of: 'Invalid Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate.
	
	self
		should: [aTelephoneBill add: aTelephoneCallBillItem.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: TelephoneBill telephoneCallBillItemDoesNotCorrespondToThisBill.
		].
	
! !

!TestsTelephoneBill methodsFor: 'Tests - WithCosts' stamp: 'Luciano Martín Gamberale 9/6/2023 19:53:54'!
test12TheTelephoneCallDateMustBeLaterThatTheTelephoneBillDate

	| aTelephoneBill aBusinessStartDate aBusinessEndDate aTelephoneCallBillItem  |
	
	aTelephoneBill := TelephoneBill newFor: 'Account Name' ofTheyear: 2023 monthOf: 01.
	aTelephoneBill setUpFixedMonthlyFeeOf: 100.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
		
	aTelephoneCallBillItem := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate.
	
	self
		should: [aTelephoneBill add: aTelephoneCallBillItem.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: TelephoneBill telephoneCallBillItemDoesNotCorrespondToThisBill.
		].
	
! !


!classDefinition: #TestsTelephoneBillingSystem category: 'Entrevista Mercap'!
TestCase subclass: #TestsTelephoneBillingSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!TestsTelephoneBillingSystem methodsFor: 'Tests' stamp: 'Luciano Martín Gamberale 9/6/2023 19:55:38'!
test01TheDateOfTheRequestedBillMustBeLaterThanThisMonth

	| telephoneBillingSystem |
	
	telephoneBillingSystem := TelephoneBillingSystem new.
	
	self
		should: [telephoneBillingSystem			getBillOf: 'Account Name' ofTheyear: (Date today yearNumber + 1) monthOf: 01 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: TelephoneBillingSystem requestedBillNotIssuedDescriptionError.
		].
	! !

!TestsTelephoneBillingSystem methodsFor: 'Tests' stamp: 'Luciano Martín Gamberale 9/6/2023 19:58:09'!
test02ATelephoneBillingSystemWithNoCallsReturnsBillsWithoutCallCost

	| telephoneBillingSystem aTelephoneBill |
	
	telephoneBillingSystem := TelephoneBillingSystem new.
	
	aTelephoneBill := telephoneBillingSystem getBillOf: 'Account Name' ofTheyear: 2023 monthOf: 01.
	
	self assert: (aTelephoneBill getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBill getTheCostOfNationalAndInternationalCalls ) equals: 0.
	
	
	! !

!TestsTelephoneBillingSystem methodsFor: 'Tests' stamp: 'Luciano Martín Gamberale 9/6/2023 19:59:54'!
test03ATelephoneBillingSystemWithALocalCallReturnsTheCorrectBill

	| telephoneBillingSystem aTelephoneBill aBusinessEndDate aBusinessStartDate |
	
	telephoneBillingSystem := TelephoneBillingSystem new.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	telephoneBillingSystem addLocalTelephoneCallOf: 'Account Name' startedAt: aBusinessStartDate endedAt: aBusinessEndDate. 
	aTelephoneBill := telephoneBillingSystem getBillOf: 'Account Name' ofTheyear: 2023 monthOf: 02.
	
	self assert: (aTelephoneBill getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill getTheCostOfLocalCalls) equals: ((60 * 0.1) + (60 * 0.2)).
	self assert: (aTelephoneBill getTheCostOfNationalAndInternationalCalls ) equals: 0.
	
	
	! !

!TestsTelephoneBillingSystem methodsFor: 'Tests' stamp: 'Luciano Martín Gamberale 9/6/2023 20:00:19'!
test04ATelephoneBillingSystemWithAnInternationalCallReturnsTheCorrectBill

	| telephoneBillingSystem aTelephoneBill aBusinessEndDate aBusinessStartDate |
	
	telephoneBillingSystem := TelephoneBillingSystem new.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	telephoneBillingSystem addInternationalTelephoneCallOf: 'Account Name' startedAt: aBusinessStartDate endedAt: aBusinessEndDate to: #Brazil. 
	aTelephoneBill := telephoneBillingSystem getBillOf: 'Account Name' ofTheyear: 2023 monthOf: 02.
	
	self assert: (aTelephoneBill getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBill getTheCostOfNationalAndInternationalCalls ) equals: (2 * 60 * 0.5).
	
	
	! !

!TestsTelephoneBillingSystem methodsFor: 'Tests' stamp: 'Luciano Martín Gamberale 9/6/2023 20:01:30'!
test05ATelephoneBillingSystemWithMultipleAccountsReturnsTheCorrectBills

	| telephoneBillingSystem aBusinessEndDate aBusinessStartDate aTelephoneBill1 aTelephoneBill2 aTelephoneBill3 |
	
	telephoneBillingSystem := TelephoneBillingSystem new.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	telephoneBillingSystem addInternationalTelephoneCallOf: 'Account Name 1' startedAt: aBusinessStartDate endedAt: aBusinessEndDate to: #Chile.
	telephoneBillingSystem addLocalTelephoneCallOf: 'Account Name 2' startedAt: aBusinessStartDate endedAt: aBusinessEndDate.
	telephoneBillingSystem addNationalTelephoneCallOf: 'Account Name 3' startedAt: aBusinessStartDate endedAt: aBusinessEndDate to: #Mendoza. 
	
	aTelephoneBill1 := telephoneBillingSystem getBillOf: 'Account Name 1' ofTheyear: 2023 monthOf: 02.
	aTelephoneBill2 := telephoneBillingSystem getBillOf: 'Account Name 2' ofTheyear: 2023 monthOf: 02.
	aTelephoneBill3 := telephoneBillingSystem getBillOf: 'Account Name 3' ofTheyear: 2023 monthOf: 02.
	
	self assert: (aTelephoneBill1 getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill1 getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBill1 getTheCostOfNationalAndInternationalCalls ) equals: (2 * 60 * 1).
	
	self assert: (aTelephoneBill2 getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill2 getTheCostOfLocalCalls) equals: ((60 * 0.1) + (60 * 0.2)).
	self assert: (aTelephoneBill2 getTheCostOfNationalAndInternationalCalls ) equals: 0.
	
	self assert: (aTelephoneBill3 getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBill3 getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBill3 getTheCostOfNationalAndInternationalCalls ) equals: (2 * 60 * 0.3).
	
	
	! !

!TestsTelephoneBillingSystem methodsFor: 'Tests' stamp: 'Luciano Martín Gamberale 9/6/2023 20:02:29'!
test06ATelephoneBillingSystemWithMultiplesCallsOfTheSameAccountReturnsTheCorrectBills

	| telephoneBillingSystem aBusinessEndDate aBusinessStartDate aTelephoneBillOfJanuary aTelephoneBillOfFebruary aTelephoneBillOfMarch |
	
	telephoneBillingSystem := TelephoneBillingSystem new.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 2 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 2 hour: 9 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	telephoneBillingSystem addInternationalTelephoneCallOf: 'Account Name' startedAt: aBusinessStartDate endedAt: aBusinessEndDate to: #Chile.
	
	aBusinessStartDate := DateAndTime year: 2023 month: 02 day: 6 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 02 day: 6 hour: 9 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	telephoneBillingSystem addLocalTelephoneCallOf: 'Account Name' startedAt: aBusinessStartDate endedAt: aBusinessEndDate.
	
	aTelephoneBillOfJanuary := telephoneBillingSystem getBillOf: 'Account Name' ofTheyear: 2023 monthOf: 01.
	aTelephoneBillOfFebruary := telephoneBillingSystem getBillOf: 'Account Name' ofTheyear: 2023 monthOf: 02.
	aTelephoneBillOfMarch := telephoneBillingSystem getBillOf: 'Account Name' ofTheyear: 2023 monthOf: 03.
	
	self assert: (aTelephoneBillOfJanuary getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBillOfJanuary getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBillOfJanuary getTheCostOfNationalAndInternationalCalls) equals: 0.
	
	self assert: (aTelephoneBillOfFebruary getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBillOfFebruary getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBillOfFebruary getTheCostOfNationalAndInternationalCalls) equals: (2 * 60 * 1).
	
	self assert: (aTelephoneBillOfMarch getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBillOfMarch getTheCostOfLocalCalls) equals: ((60 * 0.1) + (60 * 0.2)).
	self assert: (aTelephoneBillOfMarch getTheCostOfNationalAndInternationalCalls) equals: 0.
	
	
	! !

!TestsTelephoneBillingSystem methodsFor: 'Tests' stamp: 'Luciano Martín Gamberale 9/6/2023 20:03:50'!
test07ATelephoneBillingSystemWithMultiplesCallsFromDifferentYearsReturnsTheCorrectBills

	| telephoneBillingSystem aBusinessEndDate aBusinessStartDate aTelephoneBillOfDecember2022 aTelephoneBillOfJanuary2023 |
	
	telephoneBillingSystem := TelephoneBillingSystem new.
	
	aBusinessStartDate := DateAndTime year: 2022 month: 11 day: 7 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2022 month: 11 day: 7 hour: 9 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	telephoneBillingSystem addInternationalTelephoneCallOf: 'Account Name' startedAt: aBusinessStartDate endedAt: aBusinessEndDate to: #Chile.
	
	aBusinessStartDate := DateAndTime year: 2022 month: 12 day: 5 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2022 month: 12 day: 5 hour: 9 minute: 0 second: 0.
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	telephoneBillingSystem addLocalTelephoneCallOf: 'Account Name' startedAt: aBusinessStartDate endedAt: aBusinessEndDate.
	
	aTelephoneBillOfDecember2022 := telephoneBillingSystem getBillOf: 'Account Name' ofTheyear: 2022 monthOf: 12.
	aTelephoneBillOfJanuary2023 := telephoneBillingSystem getBillOf: 'Account Name' ofTheyear: 2023 monthOf: 01.
	
	self assert: (aTelephoneBillOfDecember2022 getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBillOfDecember2022 getTheCostOfLocalCalls) equals: 0.
	self assert: (aTelephoneBillOfDecember2022 getTheCostOfNationalAndInternationalCalls) equals: (2 * 60 * 1).
	
	self assert: (aTelephoneBillOfJanuary2023 getFixedMonyhlyFee) equals: 100.
	self assert: (aTelephoneBillOfJanuary2023 getTheCostOfLocalCalls) equals: ((60 * 0.1) + (60 * 0.2)).
	self assert: (aTelephoneBillOfJanuary2023 getTheCostOfNationalAndInternationalCalls) equals: 0.

	
	
	! !


!classDefinition: #TestsTelephoneCallBillItem category: 'Entrevista Mercap'!
TestCase subclass: #TestsTelephoneCallBillItem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!TestsTelephoneCallBillItem methodsFor: 'Test - LocalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/5/2023 23:46:08'!
test01EndDateTimeMustBeLaterThanStartDateTimeOnANewLocalTelephoneCallBillItem
	
	| aStartDateTime anEndDateTime |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 12 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 11 minute: 0 second: 0.
	
	self
		should: [LocalTelephoneCallBillItem of: 'Account Name' startedAt: aStartDateTime andEndedAt: anEndDateTime.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: LocalTelephoneCallBillItem endDateTimeMustBeLaterThanStartDateTimeDescriptionError.
		].! !

!TestsTelephoneCallBillItem methodsFor: 'Test - LocalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/5/2023 23:53:07'!
test02ALocalTelephoneCallOnABusinessDayThatIsNotBetween8amAnd8pmHasTheLowestCost
	
	| aBusinessStartDate aBusinessEndDate aLocalTelephoneCallBillItem |
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 09 hour: 0 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 09 hour: 1 minute: 0 second: 0.
	
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	aLocalTelephoneCallBillItem := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate.
	
	self assert: (aLocalTelephoneCallBillItem getCost) equals: (60 * 0.1).
	! !

!TestsTelephoneCallBillItem methodsFor: 'Test - LocalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/5/2023 23:53:46'!
test03ALocalTimeFractionOnABusinessDayThatIsBetween8amAnd8pmHasTheHighestCost
	
	| aBusinessStartDate aBusinessEndDate aLocalTelephoneCallBillItem |
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 10 hour: 8 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 10 hour: 9 minute: 0 second: 0.
	
	self assert: (aBusinessStartDate dayOfWeekName = #Tuesday).
	
	aLocalTelephoneCallBillItem := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate.
	
	self assert: (aLocalTelephoneCallBillItem getCost) equals: (60 * 0.2).
	! !

!TestsTelephoneCallBillItem methodsFor: 'Test - LocalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/5/2023 23:54:53'!
test04ALocalTimeFractionOnABusinessDayThatIsFrom7amTo8amHasAMixedCost

	| aBusinessStartDate aBusinessEndDate aLocalTelephoneCallBillItem |
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 11 hour: 7 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 11 hour: 9 minute: 0 second: 0.
	
	self assert: (aBusinessStartDate dayOfWeekName = #Wednesday).
	
	aLocalTelephoneCallBillItem := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aBusinessEndDate.
	
	self assert: (aLocalTelephoneCallBillItem getCost) equals: ((60 * 0.1) + (60 * 0.2)).
	! !

!TestsTelephoneCallBillItem methodsFor: 'Test - LocalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/5/2023 23:55:30'!
test05ALocalTimeFractionOnANonWorkingDayHasTheLowestCost
	
	| aNonWorkingStartDate aNonWorkingEndDate aLocalTelephoneCallBillItem |
	
	aNonWorkingStartDate := DateAndTime year: 2023 month: 01 day: 14 hour: 8 minute: 0 second: 0.
	aNonWorkingEndDate := DateAndTime year: 2023 month: 01 day: 14 hour: 9 minute: 0 second: 0.
	
	self assert: (aNonWorkingStartDate dayOfWeekName = #Saturday).
	
	aLocalTelephoneCallBillItem := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aNonWorkingStartDate andEndedAt: aNonWorkingEndDate.
	
	self assert: (aLocalTelephoneCallBillItem getCost) equals: (60 * 0.1).
	! !

!TestsTelephoneCallBillItem methodsFor: 'Test - LocalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/5/2023 23:56:37'!
test06ALocalTimeFractionOnABusinessDayThatIsFromSunday8pmToMonday9amHasAMixedCost
	
	| aNonWorkingStartDate aBusinessEndDate aLocalTelephoneCallBillItem |
	
	aNonWorkingStartDate := DateAndTime year: 2023 month: 01 day: 15 hour: 20 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 16 hour: 21 minute: 0 second: 0.
	
	self assert: (aNonWorkingStartDate dayOfWeekName = #Sunday).
	self assert: (aBusinessEndDate dayOfWeekName = #Monday).
	
	aLocalTelephoneCallBillItem := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aNonWorkingStartDate andEndedAt: aBusinessEndDate.
	
	self assert: (aLocalTelephoneCallBillItem getCost) equals: ((12 * 60 * 0.1) + (12 * 60 * 0.2) + (60 * 0.1)).
	! !

!TestsTelephoneCallBillItem methodsFor: 'Test - LocalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/5/2023 23:57:21'!
test07ALocalTimeFractionOnABusinessDayThatIsFromFriday8amToSaturday9amHasAMixedCost
	
	| aBusinessStartDate aNonWorkingEndDate aLocalTelephoneCallBillItem |
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 13 hour: 8 minute: 0 second: 0.
	aNonWorkingEndDate := DateAndTime year: 2023 month: 01 day: 14 hour: 9 minute: 0 second: 0.
	
	self assert: (aBusinessStartDate dayOfWeekName = #Friday).
	self assert: (aNonWorkingEndDate dayOfWeekName = #Saturday).
	
	aLocalTelephoneCallBillItem := LocalTelephoneCallBillItem of: 'Account Name' startedAt: aBusinessStartDate andEndedAt: aNonWorkingEndDate.
	
	self assert: (aLocalTelephoneCallBillItem getCost) equals: ((12 * 60 * 0.2) + (12 * 60 * 0.1) + (60 * 0.1)).
	! !


!TestsTelephoneCallBillItem methodsFor: 'Test - NationalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/6/2023 00:12:12'!
test08EndDateTimeMustBeLaterThanStartDateTimeOnANewNationalTelephoneCallBillItem
	
	| aStartDateTime anEndDateTime |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 12 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 11 minute: 0 second: 0.
	
	self
		should: [NationalTelephoneCallBillItem of: 'Account Name' startedAt: aStartDateTime andEndedAt: anEndDateTime to: #Jujuy.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: NationalTelephoneCallBillItem endDateTimeMustBeLaterThanStartDateTimeDescriptionError.
		].! !

!TestsTelephoneCallBillItem methodsFor: 'Test - NationalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/6/2023 00:28:27'!
test09ANationalTelephoneCallToJujuyOrUshuaiaHasTheHighestCost
	
	| aStartDate aEndDate aNationalTelephoneCallBillItem1 aNationalTelephoneCallBillItem2 |
	
	aStartDate := DateAndTime year: 2023 month: 01 day: 09 hour: 7 minute: 0 second: 0.
	aEndDate := DateAndTime year: 2023 month: 01 day: 09 hour: 9 minute: 0 second: 0.
		
	aNationalTelephoneCallBillItem1 := NationalTelephoneCallBillItem of: 'Account Name' startedAt: aStartDate andEndedAt: aEndDate to: #Jujuy.
	aNationalTelephoneCallBillItem2 := NationalTelephoneCallBillItem of: 'Account Name' startedAt: aStartDate andEndedAt: aEndDate to: #Ushuaia.
	
	self assert: (aNationalTelephoneCallBillItem1 getCost) equals: (2 * 60 * 0.5).
	self assert: (aNationalTelephoneCallBillItem2 getCost) equals: (2 * 60 * 0.5).
	! !

!TestsTelephoneCallBillItem methodsFor: 'Test - NationalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/6/2023 00:29:00'!
test10ANationalTelephoneCallNotToJujuyOrUshuaiaHasTheHighestCost
	
	| aStartDate aEndDate aNationalTelephoneCallBillItem |
	
	aStartDate := DateAndTime year: 2023 month: 01 day: 09 hour: 7 minute: 0 second: 0.
	aEndDate := DateAndTime year: 2023 month: 01 day: 09 hour: 9 minute: 0 second: 0.
		
	aNationalTelephoneCallBillItem := NationalTelephoneCallBillItem of: 'Account Name' startedAt: aStartDate andEndedAt: aEndDate to: #Mendoza.
	
	self assert: (aNationalTelephoneCallBillItem getCost) equals: (2 * 60 * 0.3).
	! !


!TestsTelephoneCallBillItem methodsFor: 'Test - InternationalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/6/2023 00:37:46'!
test11EndDateTimeMustBeLaterThanStartDateTimeOnANewInternationalTelephoneCallBillItem
	
	| aStartDateTime anEndDateTime |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 12 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 11 minute: 0 second: 0.
	
	self
		should: [InternationalTelephoneCallBillItem of: 'Account Name' startedAt: aStartDateTime andEndedAt: anEndDateTime to: #Uruguay.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: InternationalTelephoneCallBillItem endDateTimeMustBeLaterThanStartDateTimeDescriptionError.
		].! !

!TestsTelephoneCallBillItem methodsFor: 'Test - InternationalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/6/2023 00:41:09'!
test12AnInternationalTelephoneCallToUruguayOrBrazilHasTheLowestCost
	
	| aStartDate aEndDate anInternationalTelephoneCallBillItem1 anInternationalTelephoneCallBillItem2 |
	
	aStartDate := DateAndTime year: 2023 month: 01 day: 09 hour: 7 minute: 0 second: 0.
	aEndDate := DateAndTime year: 2023 month: 01 day: 09 hour: 9 minute: 0 second: 0.
		
	anInternationalTelephoneCallBillItem1 := InternationalTelephoneCallBillItem of: 'Account Name' startedAt: aStartDate andEndedAt: aEndDate to: #Uruguay.
	anInternationalTelephoneCallBillItem2 := InternationalTelephoneCallBillItem of: 'Account Name' startedAt: aStartDate andEndedAt: aEndDate to: #Brazil.
	
	self assert: (anInternationalTelephoneCallBillItem1 getCost) equals: (2 * 60 * 0.5).
	self assert: (anInternationalTelephoneCallBillItem2 getCost) equals: (2 * 60 * 0.5).
	! !

!TestsTelephoneCallBillItem methodsFor: 'Test - InternationalTelephoneCallBillItem' stamp: 'Luciano Martín Gamberale 9/6/2023 00:41:37'!
test13AnInternationalTelephoneCallNotToUruguayOrBrazilHasTheHighestCost
	
	| aStartDate aEndDate anInternationalTelephoneCallBillItem |
	
	aStartDate := DateAndTime year: 2023 month: 01 day: 09 hour: 7 minute: 0 second: 0.
	aEndDate := DateAndTime year: 2023 month: 01 day: 09 hour: 9 minute: 0 second: 0.
		
	anInternationalTelephoneCallBillItem := InternationalTelephoneCallBillItem of: 'Account Name' startedAt: aStartDate andEndedAt: aEndDate to: #Chile.
	
	self assert: (anInternationalTelephoneCallBillItem getCost) equals: (2 * 60 * 1).
	! !


!classDefinition: #TestsTelephoneCallTimeFractions category: 'Entrevista Mercap'!
TestCase subclass: #TestsTelephoneCallTimeFractions
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!TestsTelephoneCallTimeFractions methodsFor: 'Test - LocalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/5/2023 07:10:05'!
test01EndDateTimeMustBeLaterThanStartDateTimeOnANewLocalTelephoneCallTimeFraction
	
	| aStartDateTime anEndDateTime |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 12 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 11 minute: 0 second: 0.
	
	self
		should: [LocalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: LocalTelephoneCallTimeFraction endDateTimeMustBeLaterThanStartDateTimeDescriptionError.
		].! !

!TestsTelephoneCallTimeFractions methodsFor: 'Test - LocalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/5/2023 22:08:38'!
test02ALocalTimeFractionOnABusinessDayThatIsNotBetween8amAnd8pmHasTheLowestCost
	
	| aBusinessStartDate aBusinessEndDate aLocalTelephoneCallTimeFraction |
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 09 hour: 0 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 09 hour: 1 minute: 0 second: 0.
	
	self assert: (aBusinessStartDate dayOfWeekName = #Monday).
	
	aLocalTelephoneCallTimeFraction := LocalTelephoneCallTimeFraction from: aBusinessStartDate to: aBusinessEndDate.
	
	self assert: (aLocalTelephoneCallTimeFraction getCost ) equals: (60 * 0.1).! !

!TestsTelephoneCallTimeFractions methodsFor: 'Test - LocalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/5/2023 22:08:47'!
test03ALocalTimeFractionOnABusinessDayThatIsBetween8amAnd8pmHasTheHighestCost
	
	| aBusinessStartDate aBusinessEndDate aLocalTelephoneCallTimeFraction |
	
	aBusinessStartDate := DateAndTime year: 2023 month: 01 day: 10 hour: 8 minute: 0 second: 0.
	aBusinessEndDate := DateAndTime year: 2023 month: 01 day: 10 hour: 9 minute: 0 second: 0.
	
	self assert: (aBusinessStartDate dayOfWeekName = #Tuesday).
	
	aLocalTelephoneCallTimeFraction := LocalTelephoneCallTimeFraction from: aBusinessStartDate to: aBusinessEndDate.
	
	self assert: (aLocalTelephoneCallTimeFraction getCost ) equals: (60 * 0.2).! !

!TestsTelephoneCallTimeFractions methodsFor: 'Test - LocalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/5/2023 22:09:16'!
test04ALocalTimeFractionOnANonWorkingDayHasTheLowestCost
	
	| aNonWorkingStartDate aNonWorkingEndDate aLocalTelephoneCallTimeFraction |
	
	aNonWorkingStartDate := DateAndTime year: 2023 month: 01 day: 14 hour: 7 minute: 0 second: 0.
	aNonWorkingEndDate := DateAndTime year: 2023 month: 01 day: 14 hour: 9 minute: 0 second: 0.
	
	self assert: (aNonWorkingStartDate dayOfWeekName = #Saturday).
	
	aLocalTelephoneCallTimeFraction := LocalTelephoneCallTimeFraction from: aNonWorkingStartDate to: aNonWorkingEndDate.
	
	self assert: (aLocalTelephoneCallTimeFraction getCost ) equals: (2 * 60 * 0.1).! !


!TestsTelephoneCallTimeFractions methodsFor: 'Test - NationalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/5/2023 22:10:41'!
test05EndDateTimeMustBeLaterThanStartDateTimeOnANewNationalTelephoneCallTimeFraction
	
	| aStartDateTime anEndDateTime |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 12 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 11 minute: 0 second: 0.
	
	self
		should: [NationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: #Cordoba]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: LocalTelephoneCallTimeFraction endDateTimeMustBeLaterThanStartDateTimeDescriptionError.
		].! !

!TestsTelephoneCallTimeFractions methodsFor: 'Test - NationalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/6/2023 00:14:19'!
test06ANationalTimeFractionToJujuyOrUshuaiaHasTheHighestCost
	
	| aStartDateTime anEndDateTime aNationalTelephoneCallTimeFraction1 aNationalTelephoneCallTimeFraction2 |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 09 hour: 0 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 09 hour: 1 minute: 0 second: 0.
		
	aNationalTelephoneCallTimeFraction1 := NationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: #Ushuaia.
	aNationalTelephoneCallTimeFraction2 := NationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: #Jujuy.
		
	self assert: (aNationalTelephoneCallTimeFraction1 getCost ) equals: (60 * 0.5).
	self assert: (aNationalTelephoneCallTimeFraction2 getCost ) equals: (60 * 0.5).! !

!TestsTelephoneCallTimeFractions methodsFor: 'Test - NationalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/6/2023 00:14:28'!
test07ANationalTimeFractionNotToJujuyOrUshuaiaHasTheLowestCost
	
	| aStartDateTime anEndDateTime aNationalTelephoneCallTimeFraction |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 09 hour: 0 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 09 hour: 1 minute: 0 second: 0.
		
	aNationalTelephoneCallTimeFraction := NationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: #Cordoba.
		
	self assert: (aNationalTelephoneCallTimeFraction getCost ) equals: (60 * 0.3).! !


!TestsTelephoneCallTimeFractions methodsFor: 'Test - InternationalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/5/2023 23:36:15'!
test08EndDateTimeMustBeLaterThanStartDateTimeOnANewInternationalTelephoneCallTimeFraction
	
	| aStartDateTime anEndDateTime |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 12 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 10 hour: 11 minute: 0 second: 0.
	
	self
		should: [InternationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: #Uruguay]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self 
				assert: anError messageText 
				equals: LocalTelephoneCallTimeFraction endDateTimeMustBeLaterThanStartDateTimeDescriptionError.
		].! !

!TestsTelephoneCallTimeFractions methodsFor: 'Test - InternationalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/6/2023 00:14:35'!
test09AnInternationalTimeFractionToUruguayOrBrazilHasTheLowestCost
	
	| aStartDateTime anEndDateTime anInternationalTelephoneCallTimeFraction1 anInternationalTelephoneCallTimeFraction2 |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 09 hour: 0 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 09 hour: 1 minute: 0 second: 0.
		
	anInternationalTelephoneCallTimeFraction1 := InternationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: #Brazil.
	anInternationalTelephoneCallTimeFraction2 := InternationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: #Uruguay.
		
	self assert: (anInternationalTelephoneCallTimeFraction1 getCost ) equals: (60 * 0.5).
	self assert: (anInternationalTelephoneCallTimeFraction2 getCost ) equals: (60 * 0.5).! !

!TestsTelephoneCallTimeFractions methodsFor: 'Test - InternationalTelephoneCallTimeFractions' stamp: 'Luciano Martín Gamberale 9/6/2023 00:14:43'!
test10AnInternationalTimeFractionNotToUruguayOrBrazilHasTheHighestCost
	
	| aStartDateTime anEndDateTime anInternationalTelephoneCallTimeFraction |
	
	aStartDateTime := DateAndTime year: 2023 month: 01 day: 09 hour: 0 minute: 0 second: 0.
	anEndDateTime := DateAndTime year: 2023 month: 01 day: 09 hour: 1 minute: 0 second: 0.
		
	anInternationalTelephoneCallTimeFraction := InternationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: #Chile.
		
	self assert: (anInternationalTelephoneCallTimeFraction getCost ) equals: (60 * 1)..! !


!classDefinition: #TelephoneBill category: 'Entrevista Mercap'!
Object subclass: #TelephoneBill
	instanceVariableNames: 'accountName issueDate fixedMonthlyFee telephoneCallsBillItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!TelephoneBill methodsFor: 'get - bill information' stamp: 'Luciano Martín Gamberale 9/3/2023 12:47:06'!
getFixedMonyhlyFee
	^fixedMonthlyFee ! !

!TelephoneBill methodsFor: 'get - bill information' stamp: 'Luciano Martín Gamberale 9/3/2023 12:46:31'!
getTheAccountName
	^accountName ! !

!TelephoneBill methodsFor: 'get - bill information' stamp: 'Luciano Martín Gamberale 9/6/2023 09:21:54'!
getTheCostOfLocalCalls
	
	| localTelephoneCallsCost |
	
	localTelephoneCallsCost := 0.
	
	telephoneCallsBillItems do: [: aTelephoneCallBillItem | 
		(aTelephoneCallBillItem isKindOf: LocalTelephoneCallBillItem) ifTrue: [
			localTelephoneCallsCost := localTelephoneCallsCost + aTelephoneCallBillItem getCost.
		].
	].
	
	^localTelephoneCallsCost.! !

!TelephoneBill methodsFor: 'get - bill information' stamp: 'Luciano Martín Gamberale 9/6/2023 09:44:53'!
getTheCostOfNationalAndInternationalCalls
	
	| localTelephoneCallsCost |
	
	localTelephoneCallsCost := 0.
	
	telephoneCallsBillItems do: [: aTelephoneCallBillItem | 
		((aTelephoneCallBillItem isKindOf: NationalTelephoneCallBillItem) or: (aTelephoneCallBillItem isKindOf: InternationalTelephoneCallBillItem)) ifTrue: [
			localTelephoneCallsCost := localTelephoneCallsCost + aTelephoneCallBillItem getCost.
		].
	].
	
	^localTelephoneCallsCost.! !

!TelephoneBill methodsFor: 'get - bill information' stamp: 'Luciano Martín Gamberale 9/3/2023 12:46:16'!
getTheIssueDate
	^issueDate ! !


!TelephoneBill methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/6/2023 10:28:48'!
initializeFor: anAccountName ofTheYear: aYear monthOf: aMonth
	accountName := anAccountName.
	issueDate := Date year: aYear month: aMonth day: (TelephoneBill issueDayNumberOfMonth).
	fixedMonthlyFee := 0.
	telephoneCallsBillItems := OrderedCollection new.! !


!TelephoneBill methodsFor: 'printing' stamp: 'Luciano Martín Gamberale 9/6/2023 13:39:29'!
printOn: aStream	
	(self printedTelephoneBill) printOn: aStream.! !

!TelephoneBill methodsFor: 'printing' stamp: 'Luciano Martín Gamberale 9/6/2023 19:44:32'!
printedTelephoneBill
	
	| aPrintedTelephoneBill currPrint |
	
	aPrintedTelephoneBill := 	'
 ==========	========== TELEPHONE BILL ==========	==========
'.
	aPrintedTelephoneBill := aPrintedTelephoneBill append: '
DESCRIPTION:
	
	Local Telephone Calls:
'.
	telephoneCallsBillItems do: [: aTelephoneCallBillitem | 
		(aTelephoneCallBillitem isKindOf: LocalTelephoneCallBillItem) ifTrue:[
			currPrint := '		$' append: ((aTelephoneCallBillitem getCost) printString).
			currPrint := currPrint append: ' :      '.
			currPrint := currPrint append: (aTelephoneCallBillitem getTheStartDate) printString.
			currPrint := currPrint append: ' - '.
			currPrint := currPrint append: (aTelephoneCallBillitem getTheEndDate) printString.
			currPrint := currPrint append: '
'.			
			aPrintedTelephoneBill := aPrintedTelephoneBill append: currPrint.
		]
	].

	aPrintedTelephoneBill := aPrintedTelephoneBill append: '
	National Telephone Calls:
'.
	telephoneCallsBillItems do: [: aTelephoneCallBillitem | 
		(aTelephoneCallBillitem isKindOf: NationalTelephoneCallBillItem) ifTrue:[
			currPrint := '		$' append: ((aTelephoneCallBillitem getCost) printString).
			currPrint := currPrint append: ' :      '.
			currPrint := currPrint append: (aTelephoneCallBillitem getTheStartDate) printString.
			currPrint := currPrint append: ' - '.
			currPrint := currPrint append: (aTelephoneCallBillitem getTheEndDate) printString.
			currPrint := currPrint append: '
'.			
			aPrintedTelephoneBill := aPrintedTelephoneBill append: currPrint.
		]
	].

	aPrintedTelephoneBill := aPrintedTelephoneBill append: '
	International Telephone Calls:
'.
	telephoneCallsBillItems do: [: aTelephoneCallBillitem | 
		(aTelephoneCallBillitem isKindOf: InternationalTelephoneCallBillItem) ifTrue:[
			currPrint := '		$' append: ((aTelephoneCallBillitem getCost) printString).
			currPrint := currPrint append: ' :      '.
			currPrint := currPrint append: (aTelephoneCallBillitem getTheStartDate) printString.
			currPrint := currPrint append: ' - '.
			currPrint := currPrint append: (aTelephoneCallBillitem getTheEndDate) printString.
			currPrint := currPrint append: '
'.			
			aPrintedTelephoneBill := aPrintedTelephoneBill append: currPrint.
		]
	].

	aPrintedTelephoneBill := aPrintedTelephoneBill append: '
---

LOCAL TELEPHONE CALLS: $'.
	aPrintedTelephoneBill := aPrintedTelephoneBill append: ((self getTheCostOfLocalCalls) printString).
	aPrintedTelephoneBill := aPrintedTelephoneBill append: '
NATIONAL AND INTERNATIONAL TELEPHONE CALLS: $'.
	aPrintedTelephoneBill := aPrintedTelephoneBill append: ((self getTheCostOfNationalAndInternationalCalls) printString).
	aPrintedTelephoneBill := aPrintedTelephoneBill append: '
	
---

TOTAL COST: $'.
	aPrintedTelephoneBill := aPrintedTelephoneBill append: ((self getTheCostOfLocalCalls + self getTheCostOfNationalAndInternationalCalls) printString).
	aPrintedTelephoneBill := aPrintedTelephoneBill append: '
	
==================================================='.
	
	^ aPrintedTelephoneBill.! !


!TelephoneBill methodsFor: 'set - bill information' stamp: 'Luciano Martín Gamberale 9/6/2023 10:35:58'!
add: aTelephoneCallBillItem
	self assertTelephoneCallCorrespondToThisBill: aTelephoneCallBillItem.
	telephoneCallsBillItems add: aTelephoneCallBillItem.
	! !

!TelephoneBill methodsFor: 'set - bill information' stamp: 'Luciano Martín Gamberale 9/3/2023 12:45:59'!
setUpFixedMonthlyFeeOf: aFixedMonthlyFee 
	fixedMonthlyFee := aFixedMonthlyFee.! !


!TelephoneBill methodsFor: 'private' stamp: 'Luciano Martín Gamberale 9/6/2023 10:43:39'!
assertTelephoneCallCorrespondToThisBill: aTelephoneCallBillItem

	(self getTheAccountName = aTelephoneCallBillItem getTheAccountName) ifFalse: [
		self error: TelephoneBill telephoneCallBillItemDoesNotCorrespondToThisBill
	].

	(issueDate yearNumber = (aTelephoneCallBillItem getTheStartDate) yearNumber) ifTrue: [
		(issueDate monthIndex <= (aTelephoneCallBillItem getTheStartDate) monthIndex) ifTrue: [
			self error: TelephoneBill telephoneCallBillItemDoesNotCorrespondToThisBill
		]
	].

	(issueDate yearNumber < (aTelephoneCallBillItem getTheStartDate) yearNumber) ifTrue: [
		self error: TelephoneBill telephoneCallBillItemDoesNotCorrespondToThisBill
	].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TelephoneBill class' category: 'Entrevista Mercap'!
TelephoneBill class
	instanceVariableNames: ''!

!TelephoneBill class methodsFor: 'description errors' stamp: 'Luciano Martín Gamberale 9/6/2023 09:55:22'!
telephoneCallBillItemDoesNotCorrespondToThisBill
	^'The added telephone call bill item does not correspond to this telephone bill.'! !


!TelephoneBill class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/3/2023 13:06:07'!
issueDayNumberOfMonth
	^1! !

!TelephoneBill class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/3/2023 12:24:55'!
newFor: anAccountName ofTheyear: aYear monthOf: aMonth
	^self new initializeFor: anAccountName ofTheYear: aYear monthOf: aMonth.! !



!classDefinition: #TelephoneBillingSystem category: 'Entrevista Mercap'!
Object subclass: #TelephoneBillingSystem
	instanceVariableNames: 'telephoneBillsByAccountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!TelephoneBillingSystem methodsFor: 'add - public' stamp: 'Luciano Martín Gamberale 9/6/2023 11:44:23'!
addLocalTelephoneCallOf: anAccount startedAt: aStartDate endedAt: anEndDate
	
	| aTelephoneBill |
	
	aTelephoneBill := self 
						getBillOf: anAccount 
						ofTheyear: ((self getBillDateFrom: aStartDate) yearNumber) 
						monthOf: ((self getBillDateFrom: aStartDate) monthIndex).
	
	aTelephoneBill add: (LocalTelephoneCallBillItem of: anAccount startedAt: aStartDate andEndedAt: anEndDate).! !

!TelephoneBillingSystem methodsFor: 'add - public' stamp: 'Luciano Martín Gamberale 9/6/2023 11:58:03'!
addNationalTelephoneCallOf: anAccount startedAt: aStartDate endedAt: anEndDate to: aLocation 
	
	| aTelephoneBill |
	
	aTelephoneBill := self 
						getBillOf: anAccount 
						ofTheyear: ((self getBillDateFrom: aStartDate) yearNumber) 
						monthOf: ((self getBillDateFrom: aStartDate) monthIndex).
	
	aTelephoneBill add: (NationalTelephoneCallBillItem of: anAccount startedAt: aStartDate andEndedAt: anEndDate to: aLocation)! !


!TelephoneBillingSystem methodsFor: 'get - public' stamp: 'Luciano Martín Gamberale 9/6/2023 11:39:59'!
getBillOf: anAccount ofTheyear: aYear monthOf: aMonth

	| telephoneBillsByYear telephoneBillsByMonth |
	
	self assertCanGetBillOfTheYear: aYear MonthOf: aMonth.	
	
	telephoneBillsByYear := telephoneBillsByAccountName at: anAccount ifAbsentPut: [		Dictionary new	].
	telephoneBillsByMonth := telephoneBillsByYear at: aYear ifAbsentPut: [		Dictionary new	].
	
	^ telephoneBillsByMonth at: aMonth ifAbsentPut: [ | aTelephoneBill |
		aTelephoneBill := TelephoneBill newFor: anAccount ofTheyear: aYear monthOf: aMonth.
		aTelephoneBill setUpFixedMonthlyFeeOf: 100.
	].

	! !


!TelephoneBillingSystem methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/6/2023 10:47:26'!
initialize
	telephoneBillsByAccountName := Dictionary new.! !


!TelephoneBillingSystem methodsFor: 'private' stamp: 'Luciano Martín Gamberale 9/6/2023 11:58:24'!
addInternationalTelephoneCallOf: anAccount startedAt: aStartDate endedAt: anEndDate to: aLocation 
	
	| aTelephoneBill |
	
	aTelephoneBill := self 
						getBillOf: anAccount 
						ofTheyear: ((self getBillDateFrom: aStartDate) yearNumber) 
						monthOf: ((self getBillDateFrom: aStartDate) monthIndex).
	
	aTelephoneBill add: (InternationalTelephoneCallBillItem of: anAccount startedAt: aStartDate andEndedAt: anEndDate to: aLocation)! !

!TelephoneBillingSystem methodsFor: 'private' stamp: 'Luciano Martín Gamberale 9/6/2023 10:52:51'!
assertCanGetBillOfTheYear: aYear MonthOf: aMonth

	(aYear = Date today yearNumber) ifTrue: [
		(aMonth >= Date today monthIndex) ifTrue: [
			self error: TelephoneBillingSystem requestedBillNotIssuedDescriptionError.
		]
	].

	(aYear > Date today yearNumber) ifTrue: [
		self error: TelephoneBillingSystem requestedBillNotIssuedDescriptionError.
	].

	! !

!TelephoneBillingSystem methodsFor: 'private' stamp: 'Luciano Martín Gamberale 9/6/2023 20:16:47'!
getBillDateFrom: aDate

	(aDate monthIndex = 12) 
		ifTrue: [
			^ Date year: (aDate yearNumber + 1) month: 01 day: 01
		] ifFalse: [
			^ Date year: (aDate yearNumber) month: (aDate monthIndex + 1) day: 01
		]..! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TelephoneBillingSystem class' category: 'Entrevista Mercap'!
TelephoneBillingSystem class
	instanceVariableNames: ''!

!TelephoneBillingSystem class methodsFor: 'description errors' stamp: 'Luciano Martín Gamberale 9/3/2023 11:31:48'!
requestedBillNotIssuedDescriptionError
	^'The requested bill has not yet been issued, please choose a date prior to the current date.'! !


!classDefinition: #TelephoneCallBillItem category: 'Entrevista Mercap'!
Object subclass: #TelephoneCallBillItem
	instanceVariableNames: 'accountName startDateTime endDateTime telephoneCallTimeFractions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!TelephoneCallBillItem methodsFor: 'get - public' stamp: 'Luciano Martín Gamberale 9/6/2023 00:03:15'!
getCost
	
	| costCounter |
	
	costCounter := 0.
	
	telephoneCallTimeFractions do: [:aTimeFraction | 
		costCounter := costCounter + aTimeFraction getCost.
	].

	^costCounter.! !

!TelephoneCallBillItem methodsFor: 'get - public' stamp: 'Luciano Martín Gamberale 9/6/2023 09:52:04'!
getTheAccountName
	^ accountName.! !

!TelephoneCallBillItem methodsFor: 'get - public' stamp: 'Luciano Martín Gamberale 9/6/2023 10:32:40'!
getTheEndDate
	^ endDateTime.! !

!TelephoneCallBillItem methodsFor: 'get - public' stamp: 'Luciano Martín Gamberale 9/6/2023 10:32:30'!
getTheStartDate
	^ startDateTime.! !


!TelephoneCallBillItem methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/6/2023 00:30:32'!
initializeWith: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TelephoneCallBillItem class' category: 'Entrevista Mercap'!
TelephoneCallBillItem class
	instanceVariableNames: ''!

!TelephoneCallBillItem class methodsFor: 'description errors' stamp: 'Luciano Martín Gamberale 9/6/2023 00:10:40'!
endDateTimeMustBeLaterThanStartDateTimeDescriptionError
	^'The end time must be later than the start date.'! !


!TelephoneCallBillItem class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/6/2023 00:34:52'!
of: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation
	self subclassResponsibility! !


!classDefinition: #InternationalTelephoneCallBillItem category: 'Entrevista Mercap'!
TelephoneCallBillItem subclass: #InternationalTelephoneCallBillItem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!InternationalTelephoneCallBillItem methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/6/2023 00:36:15'!
initializeWith: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation 
	
	accountName := anAccountName.
	
	startDateTime := aStartDateTime.
	endDateTime := anEndDateTime.
	
	telephoneCallTimeFractions := OrderedCollection with: (InternationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: aLocation).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternationalTelephoneCallBillItem class' category: 'Entrevista Mercap'!
InternationalTelephoneCallBillItem class
	instanceVariableNames: ''!

!InternationalTelephoneCallBillItem class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/6/2023 00:35:42'!
of: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation
	(aStartDateTime >= anEndDateTime) ifTrue: [self error: self endDateTimeMustBeLaterThanStartDateTimeDescriptionError].
	^ self new initializeWith: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation.! !


!classDefinition: #LocalTelephoneCallBillItem category: 'Entrevista Mercap'!
TelephoneCallBillItem subclass: #LocalTelephoneCallBillItem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!LocalTelephoneCallBillItem methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/6/2023 00:30:08'!
initializeWith: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation
	
	accountName := anAccountName.
	
	startDateTime := aStartDateTime.
	endDateTime := anEndDateTime.
	
	telephoneCallTimeFractions := self splitTimeAndGenerateTelephoneCallTimeFractions.! !

!LocalTelephoneCallBillItem methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/5/2023 23:45:14'!
splitTimeAndGenerateTelephoneCallTimeFractions
	
	| aTelephoneCallTimeFractions currEndDateTimeFraction currStartDateTimeFraction |
	
	aTelephoneCallTimeFractions := OrderedCollection new.
	
	currStartDateTimeFraction := startDateTime .
	currEndDateTimeFraction := self getTheClosestEndDateTimeOfTimeFractionFrom: currStartDateTimeFraction.
	
	[endDateTime > currEndDateTimeFraction] whileTrue: [
		aTelephoneCallTimeFractions add: (LocalTelephoneCallTimeFraction from: currStartDateTimeFraction to: currEndDateTimeFraction).
		
		currStartDateTimeFraction := currEndDateTimeFraction.
		currEndDateTimeFraction := self getTheClosestEndDateTimeOfTimeFractionFrom: currStartDateTimeFraction.
	].

	
	aTelephoneCallTimeFractions add: (LocalTelephoneCallTimeFraction from: currStartDateTimeFraction to: endDateTime).
	^aTelephoneCallTimeFractions.! !


!LocalTelephoneCallBillItem methodsFor: 'private' stamp: 'Luciano Martín Gamberale 9/4/2023 15:27:52'!
getTheClosestEndDateTimeOfTimeFractionFrom: aDate

	| closestEndDateTime offset |
	
	closestEndDateTime := DateAndTime
								year: (aDate yearNumber) 
								month: (aDate monthIndex) 
								day: (aDate dayOfMonth)  
								hour: (aDate hour) 
								minute: 0 
								second: 0. 
										
	((aDate hour >= 0) and: (aDate hour < 8)) ifTrue: [offset := 8 - aDate hour.	].
	((aDate hour >= 8) and: (aDate hour < 20)) ifTrue: [		offset := 20 - aDate hour.	].
	((aDate hour >= 20) and: (aDate hour < 24)) ifTrue: [		offset := 32 - aDate hour.	].
	
	^ (closestEndDateTime + (Duration hours: offset)).
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LocalTelephoneCallBillItem class' category: 'Entrevista Mercap'!
LocalTelephoneCallBillItem class
	instanceVariableNames: ''!

!LocalTelephoneCallBillItem class methodsFor: 'description errors' stamp: 'Luciano Martín Gamberale 9/6/2023 00:34:27'!
localTelephoneCallsDoNotHaveSpecifiedLocationDescriptionError
	^'Local telephone calls do not have a specified location'! !


!LocalTelephoneCallBillItem class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/6/2023 00:33:42'!
of: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime 
	^ self of: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: #NoLocation.! !

!LocalTelephoneCallBillItem class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/6/2023 00:33:11'!
of: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation
	(aLocation = #NoLocation) ifFalse: [self error: self localTelephoneCallsDoNotHaveSpecifiedLocationDescriptionError].	
	(aStartDateTime >= anEndDateTime) ifTrue: [self error: self endDateTimeMustBeLaterThanStartDateTimeDescriptionError].
	^ self new initializeWith: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation.! !


!classDefinition: #NationalTelephoneCallBillItem category: 'Entrevista Mercap'!
TelephoneCallBillItem subclass: #NationalTelephoneCallBillItem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!NationalTelephoneCallBillItem methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/6/2023 00:29:22'!
initializeWith: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation 
	
	accountName := anAccountName.
	
	startDateTime := aStartDateTime.
	endDateTime := anEndDateTime.
	
	telephoneCallTimeFractions := OrderedCollection with: (NationalTelephoneCallTimeFraction from: aStartDateTime to: anEndDateTime to: aLocation).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NationalTelephoneCallBillItem class' category: 'Entrevista Mercap'!
NationalTelephoneCallBillItem class
	instanceVariableNames: ''!

!NationalTelephoneCallBillItem class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/6/2023 00:11:00'!
of: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation
	(aStartDateTime >= anEndDateTime) ifTrue: [self error: self endDateTimeMustBeLaterThanStartDateTimeDescriptionError].
	^ self new initializeWith: anAccountName startedAt: aStartDateTime andEndedAt: anEndDateTime to: aLocation.! !


!classDefinition: #TelephoneCallTimeFraction category: 'Entrevista Mercap'!
Object subclass: #TelephoneCallTimeFraction
	instanceVariableNames: 'duration costPerMinute'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!TelephoneCallTimeFraction methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/4/2023 16:56:17'!
initializeFrom: aStartDateTime to: anEndDateTime to: aLocation
	self subclassResponsibility.! !


!TelephoneCallTimeFraction methodsFor: 'get - public' stamp: 'Luciano Martín Gamberale 9/4/2023 16:45:24'!
getCost
	^ (duration totalMinutes * costPerMinute)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TelephoneCallTimeFraction class' category: 'Entrevista Mercap'!
TelephoneCallTimeFraction class
	instanceVariableNames: ''!

!TelephoneCallTimeFraction class methodsFor: 'description errors' stamp: 'Luciano Martín Gamberale 9/5/2023 07:03:18'!
endDateTimeMustBeLaterThanStartDateTimeDescriptionError
	^'The end time must be later than the start date.'! !


!TelephoneCallTimeFraction class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/4/2023 16:57:13'!
from: aStartDateTime to: anEndDateTime to: aLocation
	self subclassResponsibility.! !


!TelephoneCallTimeFraction class methodsFor: 'private' stamp: 'Luciano Martín Gamberale 9/5/2023 07:31:58'!
checkDateChronologyBetweenStartDate: aStartDateTime AndEndDate: anEndDateTime
	(aStartDateTime >= anEndDateTime) ifTrue: [self error: self endDateTimeMustBeLaterThanStartDateTimeDescriptionError].
! !


!classDefinition: #InternationalTelephoneCallTimeFraction category: 'Entrevista Mercap'!
TelephoneCallTimeFraction subclass: #InternationalTelephoneCallTimeFraction
	instanceVariableNames: 'country'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!InternationalTelephoneCallTimeFraction methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/6/2023 09:34:05'!
initializeFrom: aStartDateTime to: anEndDateTime to: aLocation
	duration := (anEndDateTime -  aStartDateTime).		
	((aLocation  = #Uruguay) or: (aLocation = #Brazil)) ifTrue: [costPerMinute := 0.5] ifFalse: [costPerMinute := 1].
	country := aLocation.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternationalTelephoneCallTimeFraction class' category: 'Entrevista Mercap'!
InternationalTelephoneCallTimeFraction class
	instanceVariableNames: ''!

!InternationalTelephoneCallTimeFraction class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/5/2023 07:31:58'!
from: aStartDateTime to: anEndDateTime to: aLocation
	self checkDateChronologyBetweenStartDate: aStartDateTime AndEndDate: anEndDateTime.
	^ self new initializeFrom: aStartDateTime to: anEndDateTime to: aLocation.! !


!classDefinition: #LocalTelephoneCallTimeFraction category: 'Entrevista Mercap'!
TelephoneCallTimeFraction subclass: #LocalTelephoneCallTimeFraction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!LocalTelephoneCallTimeFraction methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/5/2023 07:23:58'!
initializeFrom: aStartDateTime to: anEndDateTime to: aLocation
	
	duration := (anEndDateTime -  aStartDateTime).		
	
	(((aStartDateTime hour >= 8) and: (aStartDateTime hour < 20))	 and: (anEndDateTime hour > 8) and: (anEndDateTime hour <= 20)) 
	ifFalse: [costPerMinute := 0.1] ifTrue: [
		((aStartDateTime dayOfWeekName = #Saturday) or: (aStartDateTime dayOfWeekName = #Sunday)) 
																					ifTrue: [costPerMinute := 0.1] 
																					ifFalse: [costPerMinute := 0.2]
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LocalTelephoneCallTimeFraction class' category: 'Entrevista Mercap'!
LocalTelephoneCallTimeFraction class
	instanceVariableNames: ''!

!LocalTelephoneCallTimeFraction class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/5/2023 07:05:20'!
from: aStartDateTime to: anEndDateTime
	^ self from: aStartDateTime to: anEndDateTime to: #NoLocation! !

!LocalTelephoneCallTimeFraction class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/6/2023 00:01:45'!
from: aStartDateTime to: anEndDateTime to: aLocation
	(aLocation = #NoLocation) ifFalse: [self error: self localTelephoneCallsDoNotHaveSpecifiedLocationDescriptionError].	
	self checkDateChronologyBetweenStartDate: aStartDateTime AndEndDate: anEndDateTime.	
	^ self new initializeFrom: aStartDateTime to: anEndDateTime to: aLocation! !


!LocalTelephoneCallTimeFraction class methodsFor: 'description errors' stamp: 'Luciano Martín Gamberale 9/4/2023 16:49:30'!
localTelephoneCallsDoNotHaveSpecifiedLocationDescriptionError
	^'Local telephone calls do not have a specified location'! !


!classDefinition: #NationalTelephoneCallTimeFraction category: 'Entrevista Mercap'!
TelephoneCallTimeFraction subclass: #NationalTelephoneCallTimeFraction
	instanceVariableNames: 'province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Entrevista Mercap'!

!NationalTelephoneCallTimeFraction methodsFor: 'initialization' stamp: 'Luciano Martín Gamberale 9/6/2023 09:34:19'!
initializeFrom: aStartDateTime to: anEndDateTime to: aLocation
	duration := (anEndDateTime -  aStartDateTime).		
	((aLocation  = #Ushuaia) or: (aLocation = #Jujuy)) ifTrue: [costPerMinute := 0.5] ifFalse: [costPerMinute := 0.3].
	province := aLocation.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NationalTelephoneCallTimeFraction class' category: 'Entrevista Mercap'!
NationalTelephoneCallTimeFraction class
	instanceVariableNames: ''!

!NationalTelephoneCallTimeFraction class methodsFor: 'creation' stamp: 'Luciano Martín Gamberale 9/5/2023 07:31:58'!
from: aStartDateTime to: anEndDateTime to: aLocation
	self checkDateChronologyBetweenStartDate: aStartDateTime AndEndDate: anEndDateTime.
	^ self new initializeFrom: aStartDateTime to: anEndDateTime to: aLocation.! !
