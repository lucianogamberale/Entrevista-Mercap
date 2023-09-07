# Entrevista Mercap

## Realizado por: *Gamberale Luciano Martín*

## Ejercicio: *Sistema de Facturación de Llamadas Telefónicas*

### Consigna:

Realizar un sistema de facturación de llamadas telefónicas teniendo en cuenta los siguientes
requerimientos:
- La facturación se realiza de manera mensual
- La facturación está compuesta por:
  - Un abono mensual básico
  - Consumo por llamadas Locales
  - Consumo por llamadas Nacionales e Internacionales
- Las llamadas locales tienen distintos valores según la franja horaria en la que se realizan y el día. Para los días hábiles, de 8 a 20 hrs. el costo es de 0,20 centavos el minuto, mientras en el resto de las horas es de 0,10 centavos el minuto. Los sábados y domingos cuesta 0,10 centavos el minuto
- Las llamadas Internacionales tienen un costo distinto según el país al que se llame
- Las llamadas Nacionales tienen un costo distinto según la localidad a la que se
llame

#### Consideraciones adicionales:

- No es necesario realizar una interfaz de usuario visual.
- No es necesario realizar persistencia de los datos (o sea, conexión a base de datos, archivos, etc.). Alcanza con simular los datos creándolos en memoria
- Como salida alcanza ver por pantalla como sería una factura (sin preocuparse por darle un formato especial)

### Consideraciones propuestas por el desarrollador:
- Las llamadas nacionales realizadas a las provincias de Jujuy o Ushauia poseen un costo mayor que la de las demás provincias.
- Las llamadas internacionales realizadas a Uruguay o Brasil son mas económicas que las de los demás paises.

### Esquemas para explicar resolución:
![Diagrama en blanco - Página 3 (1)](https://github.com/lucianogamberale/Entrevista-Mercap/assets/86788163/ef4ca369-df29-45ca-b4d6-88bbe09316ed)



