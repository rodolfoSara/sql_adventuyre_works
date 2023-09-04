use AdventureWorks2017
--JOINS
---------------------------------------------------------------------------------------------------------

/* QUERY 39:MOSTRAR  LOS EMPLEADOS QUE TAMBIÉN SON VENDEDORES */
SELECT * FROM [HumanResources].[Employee] AS e
INNER JOIN [Sales].[SalesPerson] AS s 
ON e.[BusinessEntityID] = s.[BusinessEntityID]

/* QUERY 40: MOSTRAR  LOS EMPLEADOS ORDENADOS ALFABETICAMENTE POR APELLIDO Y POR NOMBRE*/


/* QUERY 41: MOSTRAR EL CODIGO DE LOGUEO, NUMERO DE TERRITORIO Y SUELDO BASICO DE LOS VENDEDORES */
SELECT e.[LoginID], s.[TerritoryID], s.[SalesLastYear]
FROM [HumanResources].[Employee] as e
INNER JOIN [Sales].[SalesPerson] AS s
ON e.[BusinessEntityID] = s.[BusinessEntityID]

/* QUERY 42:MOSTRAR LOS PRODUCTOS QUE SEAN RUEDAS */
SELECT p.[Name]
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductSubcategory] AS s
ON p.[ProductSubcategoryID]= s.[ProductSubcategoryID]
WHERE s.[Name] = 'Wheels'

/* QUERY 43: MOSTRAR LOS NOMBRES DE LOS PRODUCTOS QUE NO SON BICICLETAS */
SELECT p.[Name] producto
FROM [Production].[Product] AS p
INNER JOIN  [Production].[ProductSubcategory] AS s
ON s.[ProductCategoryID] = p.[ProductSubcategoryID]
WHERE s.[Name] NOT LIKE '%Bikes'

/* QUERY 44:MOSTRAR LOS PRECIOS DE VENTA DE AQUELLOS  PRODUCTOS 
DONDE EL PRECIO DE VENTA SEA INFERIOR AL PRECIO DE LISTA RECOMENDADO 
PARA ESE PRODUCTO ORDENADOS POR NOMBRE DE PRODUCTO*/
SELECT p.[Name], p.[ListPrice]
FROM [Production].[Product] AS p
INNER JOIN [Sales].[SalesOrderDetail] AS sd
ON sd.[ProductID] = p.[ProductID]
WHERE sd.[UnitPrice] < p.[ListPrice]

/* QUERY 45: MOSTRAR TODOS LOS PRODUCTOS QUE TENGAN IGUAL PRECIO. 
SE DEBEN MOSTRAR DE A PARES: CODIGO Y NOMBRE DE CADA UNO DE LOS DOS PRODUCTOS 
Y EL PRECIO DE AMBOS.ORDENAR POR PRECIO EN FORMA DESCENDENTE */

SELECT p1.[ProductID], p1.[Name], p2.[ProductID], p2.[Name], p1.[ListPrice]
FROM [Production].[Product] AS p1
INNER JOIN [Production].[Product] AS p2
ON p1.[ListPrice] = p2.[ListPrice] AND p1.[ProductID] < p2.[ProductID]
ORDER BY p1.[ListPrice] DESC;

/* QUERY 46:MOSTRAR TODOS LOS PRODUCTOS QUE TENGAN IGUAL PRECIO. 
SE DEBEN MOSTRAR DE A PARES: CODIGO Y NOMBRE DE CADA UNO DE LOS DOS PRODUCTOS Y EL PRECIO DE AMBOS 
MAYOES A $15*/
SELECT p1.[ProductID], p1.[Name], p2.[ProductID], p2.[Name], p1.[ListPrice]
FROM [Production].[Product] AS p1
INNER JOIN [Production].[Product] AS p2
ON p1.[ListPrice] = p2.[ListPrice] AND p1.[ProductID] < p2.[ProductID]
WHERE p1.[ListPrice] > 15
ORDER BY	p1.ListPrice DESC


/* QUERY 47:MOSTRAR EL NOMBRE DE LOS PRODUCTOS Y DE LOS PROVEEDORES CUYA SUBCATEGORIA ES 15 ORDENADOS POR NOMBRE 
DE PROVEEDOR */
SELECT p.[Name], v.[Name]
FROM [Production].[Product] AS p
INNER JOIN [Purchasing].[ProductVendor] AS pv
ON p.[ProductID] = pv.[ProductID]
INNER JOIN [Purchasing].[Vendor] AS v
ON pv.[BusinessEntityID] = v.[BusinessEntityID]
WHERE p.[ProductSubcategoryID] = 15

/* QUERY 48:MOSTRAR TODAS LAS PERSONAS (NOMBRE Y APELLIDO) 
Y EN EL CASO QUE SEAN EMPLEADOS MOSTRAR TAMBIEN EL LOGIN ID, SINO MOSTRAR NULL */
SELECT p.[FirstName], p.[LastName], hr.[LoginID]
FROM [Person].[Person] AS p
LEFT JOIN [HumanResources].[Employee] AS hr
ON p.[BusinessEntityID] = hr.[BusinessEntityID]


/* QUERY 49: MOSTRAR LOS VENDEDORES (NOMBRE Y APELLIDO) Y EL TERRITORIO ASIGNADO 
A C/U(IDENTIFICADOR Y NOMBRE DE TERRITORIO).
EN LOS CASOS EN QUE UN TERRITORIO NO TIENE VENDEDORES MOSTRAR IGUAL
LOS DATOS DEL TERRITORIO UNICAMENTE SIN DATOS DE VENDEDORES*/
SELECT p.[FirstName], p.[LastName], st.[Name]
FROM [Person].[Person] AS p
INNER JOIN [Sales].[SalesPerson] AS sp
ON p.[BusinessEntityID] = sp.[BusinessEntityID]
RIGHT JOIN [Sales].[SalesTerritory] AS st
ON sp.[TerritoryID] = st.[TerritoryID]

/* QUERY 50:MOSTRAR EL PRODUCTO CARTESIANO ENTE LA TABLA DE VENDEDORES CUYO NUMERO DE IDENTIFICACION DE NEGOCIO 
SEA 280 Y EL TERRITORIO DE VENTA SEA EL DE FRANCIA */
SELECT sp.[BusinessEntityID], st.[Name]
FROM [Sales].[SalesPerson] AS sp
CROSS JOIN [Sales].[SalesTerritory] AS st
WHERE sp.BusinessEntityID=280 AND st.Name='france'

