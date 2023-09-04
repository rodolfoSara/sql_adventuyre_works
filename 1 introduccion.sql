/* QUERY 1: MOSTRAR LOS EMPLEADOS QUE TIENEN MAS DE 90 HORAS DE VACACIONES */
SELECT * 
FROM HumanResources.Employee 
WHERE VacationHours > 90;

/* QUERY 2: MOSTRAR EL NOMBRE, PRECIO Y PRECIO CON IVA DE LOS PRODUCTOS FABRICADOS*/
SELECT Name, ListPrice, ListPrice * 1.21 AS "Precio con IVA" 
FROM Production.Product;

/* QUERY 3: MOSTRAR LOS DIFERENTES TITULOS DE TRABAJO QUE EXISTEN*/
SELECT [JobTitle] FROM HumanResources.Employee;

/*QUERY 4: MOSTRAR TODOS LOS POSIBLES COLORES DE PRODUCTOS */
SELECT DISTINCT Color FROM [Production].[Product];

/*QUERY 5: MOSTRAR TODOS LOS TIPOS DE PESONAS QUE EXISTEN */
SELECT DISTINCT [PersonType] FROM [Person].[Person];

/* QUERY 6: MOSTRAR EL  NOMBRE CONCATENADO CON EL APELLIDO DE LAS PERSONAS CUYO APELLIDO SEA JOHNSON*/
SELECT [FirstName]+ '   ' + [LastName] AS NombreCompleto 
FROM [Person].[Person] 
WHERE [LastName] = 'Johnson';

/* QUERY 7: MOSTRAR TODOS LOS PRODUCTOS CUYO PRECIO SEA INFERIOR A 150$ DE COLOR ROJO O CUYO PRECIO SEA MAYOR A 500$ DE COLOR NEGRO*/
SELECT * FROM Production.Product 
WHERE ([ListPrice]<150 AND [Color]= 'Red') OR ([ListPrice] > 150 and Color = 'Black')
 
/* QUERY 8: MOSTRAR EL CODIGO, FECHA DE INGRESO Y HORAS DE VACACIONES DE LOS EMPLEADOS INGRESARON A PARTIR DEL A�O 2000 */
SELECT [BusinessEntityID]  CODIGO, 
[HireDate]  'FECHA DE INGRESO',
[VacationHours]  'HORAS DE VACACIONES'
FROM  [HumanResources].[Employee]
WHERE [HireDate] > '2000-01-01'

/* QUERY 9: MOSTRAR EL NOMBRE,NMERO DE PRODUCTO, PRECIO DE LISTA Y EL PRECIO DE LISTA INCREMENTADO EN UN 10% DE LOS PRODUSCTOS CUYA FECHA DE FIN DE VENTA SEA ANERIOR AL DIA DE HOY*/
SELECT [Name],[ProductNumber],[ListPrice], [ListPrice] * 1.1 AS 'PRECIO INCREMENTADO EN UN 10%'
FROM [Production].[Product]
WHERE [SellEndDate] < GETDATE();