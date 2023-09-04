
use AdventureWorks2017

---------------------------------------------------------------------------------------------------------
--SUBCONSULTAS
---------------------------------------------------------------------------------------------------------

/* QUERY 51:LISTAR TODOS LAS PRODUCTOS CUYO PRECIO SEA INFERIOR AL PRECIO PROMEDIO DE TODOS LOS PRODUCTOS */ 
SELECT * 
FROM [Production].[Product]
WHERE [ListPrice] < (SELECT AVG([ListPrice]) FROM [Production].[Product])


/* QUERY 52:LISTAR EL NOMBRE, PRECIO DE LISTA, PRECIO PROMEDIO Y DIFERENCIA DE PRECIOS ENTRE CADA PRODUCTO Y EL VALOR 
PROMEDIO GENERAL */
SELECT [Name], [ListPrice],
(SELECT AVG([ListPrice]) FROM [Production].[Product]) AS 'Promedio',
[ListPrice] - (SELECT AVG([ListPrice]) FROM [Production].[Product]) AS 'Diferencia de precio con el promedio'
FROM [Production].[Product]

/* QUERY 53: MOSTRAR EL O LOS CODIGOS DEL PRODUCTO MAS CARO */
SELECT [ProductID], [Name], [ListPrice]
FROM [Production].[Product]
WHERE [ListPrice] = (SELECT MAX([ListPrice]) FROM [Production].[Product])

/* QUERY 54: MOSTRAR EL PRODUCTO MAS BARATO DE CADA SUBCATEGORÍA. MOSTRAR SUBCATEROGIA, CODIGO DE PRODUCTO 
Y EL PRECIO DE LISTA MAS BARATO ORDENADO POR SUBCATEGORIA */
SELECT P1.[Name], P1.[ListPrice], P1.[ProductID]
FROM [Production].[Product] AS P1
WHERE [ListPrice] = (SELECT MIN([ListPrice]) FROM [Production].[Product] AS P2
WHERE P1.[ProductSubcategoryID] = P2.[ProductSubcategoryID])
ORDER BY P1.[ProductSubcategoryID]




---------------------------------------------------------------------------------------------------------
--SUBCONSULTAS CON EXISTS
---------------------------------------------------------------------------------------------------------
/* QUERY 55:MOSTRAR LOS NOMBRES DE TODOS LOS PRODUCTOS PRESENTES EN LA SUBCATEGORÍA DE RUEDAS */
SELECT *
FROM [Production].[Product] AS P
WHERE EXISTS ( SELECT * FROM [Production].[ProductSubcategory] AS SC
			WHERE P.[ProductSubcategoryID] = SC.[ProductCategoryID]
			AND [Name] LIKE '%Wheels%')


/* QUERY 56:MOSTRAR TODOS LOS PRODUCTOS QUE NO FUERON VENDIDOS*/
SELECT P.[ProductID], P.[Name]
FROM [Production].[Product] AS P
WHERE NOT EXISTS (SELECT * FROM [Sales].[SalesOrderDetail] AS SO
					WHERE SO.[ProductID] = P.[ProductID])

/* QUERY 57: MOSTRAR LA CANTIDAD DE PERSONAS QUE NO SON VENDEDORRES */
SELECT COUNT(*) 
FROM [Person].[Person] AS P
WHERE NOT EXISTS (SELECT * FROM [Sales].[SalesPerson] AS SP
WHERE P.[BusinessEntityID] = SP.[BusinessEntityID])

/* QUERY 58:MOSTRAR TODOS LOS VENDEDORES (NOMBRE Y APELLIDO) QUE NO TENGAN ASIGNADO UN TERRITORIO DE VENTAS */
SELECT [FirstName], [LastName] FROM [Person].[Person] AS P
INNER JOIN [Sales].[SalesPerson] AS SP
ON P.[BusinessEntityID] = SP.[BusinessEntityID]
WHERE NOT EXISTS (SELECT * FROM [Sales].[SalesTerritory] ST
					WHERE ST.[TerritoryID] = SP.[TerritoryID])
---------------------------------------------------------------------------------------------------------
--SUBCONSULTAS CON IN Y NOT IN
---------------------------------------------------------------------------------------------------------

/* QUERY 59: MOSTRAR LAS ORDENES DE VENTA QUE SE HAYAN FACTURADO EN TERRITORIO DE ESTADO UNIDOS UNICAMENTE 'US' */
SELECT * FROM [Sales].[SalesOrderHeader] SOH
WHERE SOH.[TerritoryID] IN (SELECT ST.[TerritoryID] FROM [Sales].[SalesTerritory] AS ST WHERE [CountryRegionCode] = 'US')

SELECT [CountryRegionCode] FROM [Sales].[SalesTerritory]

/* QUERY 60: AL EJERCICIO ANTERIOR AGREGAR ORDENES DE FRANCIA E INGLATERRA */
SELECT * FROM [Sales].[SalesOrderHeader] SOH
WHERE SOH.[TerritoryID] IN (SELECT ST.[TerritoryID] FROM [Sales].[SalesTerritory] AS ST WHERE [CountryRegionCode] IN ('US', 'FR', 'GB'))

/* QUERY 61:MOSTRAR LOS NOMBRES DE LOS DIEZ PRODUCTOS MAS CAROS */
SELECT [ProductID],[Name], [ListPrice]FROM [Production].[Product]
WHERE [ListPrice] IN (SELECT TOP 10  MAX([ListPrice]) FROM [Production].[Product])

/* QUERY 62:MOSTRAR AQUELLOS PRODUCTOS CUYA CANTIDAD DE PEDIDOS DE VENTA SEA IGUAL O SUPERIOR A 20 */
SELECT [ProductID], [Name] 
FROM [Production].[Product] AS P
WHERE [ProductID] IN (SELECT [ProductID] FROM [Sales].[SalesOrderDetail]
					WHERE [OrderQty] >= 20)



/* QUERY 63: LISTAR EL NOMBRE Y APELLIDO DE LOS EMPLEADOS QUE TIENEN UN SUELDO BASICO DE 5000 PESOS. 
NO UTILIZAR RELACIONES  PARA SU RESOLUCION */

NO ENTENDI
					


SELECT DISTINCT p.LastName apellido, p.FirstName 
FROM Person.Person p JOIN HumanResources.Employee e
ON e.BusinessEntityID = p.BusinessEntityID
WHERE 5000.00 IN  ( SELECT Bonus FROM Sales.SalesPerson sp WHERE e.BusinessEntityID = sp.BusinessEntityID);

---------------------------------------------------------------------------------------------------------
--SUBCONSULTAS CON ALL (IN) Y ANY (NOT IN)
---------------------------------------------------------------------------------------------------------

/*QUERY 64:MOSTRAR LOS NOMBRES DE TODOS LOS PRODUCTOS DE RUEDAS QUE FABRICA ADVENTURE WORKS CYCLES */
SELECT [Name] 
FROM [Production].[Product]
WHERE [ProductSubcategoryID] = ANY ( SELECT ProductSubcategoryID FROM [Production].[ProductSubcategory]
								WHERE Name = 'Wheels')


/* QUERY 65:MOSTRAR LOS CLIENTES UBICADOS EN UN TERRITORIO NO CUBIERTO POR NINGÚN VENDEDOR */
SELECT * FROM [Sales].[Customer]
WHERE [TerritoryID] <> ALL (SELECT [TerritoryID]
							FROM [Sales].[SalesPerson])


--QUERY 66: LISTAR LOS PRODUCTOS CUYOS PRECIOS DE VENTA SEAN MAYORES O IGUALES QUE EL PRECIO DE VENTA MÁXIMO 
--DE CUALQUIER SUBCATEGORÍA DE PRODUCTO.

NO PUDE HACERLO
 

---------------------------------------------------------------------------------------------------------
--USO DE LA EXPRESION CASE
---------------------------------------------------------------------------------------------------------


/* QUERY 67:LISTAR EL NOMBRE DE LOS PRODUCTOS, EL NOMBRE DE LA SUBCATEGORIA A LA QUE PERTENECE 
JUNTO A SU CATEGORÍA DE PRECIO.
LA CATEGORÍA DE PRECIO SE CALCULA DE LA SIGUIENTE MANERA: 
	-SI EL PRECIO ESTÁ ENTRE 0 Y 1000 LA CATEGORÍA ES ECONÓMICA.
	-SI LA CATEGORÍA ESTÁ ENTRE 1000 Y 2000, NORMAL 
	-Y SI SU VALOR ES MAYOR A 2000 LA CATEGORÍA ES CARA. */

SELECT P.[Name], 
PSC.[Name] AS 'SUBCATEGORIA', 
P.[ListPrice],
(CASE  
				WHEN ListPrice BETWEEN 0 AND 1000 THEN 'Economica'
				WHEN ListPrice BETWEEN 1000 AND 2000 THEN 'Normal'
				ELSE 'Caro'
				END) AS miTabla
FROM		[Production].[Product] AS P
INNER JOIN [Production].[ProductSubcategory] AS PSC
ON			(PSC.[ProductSubcategoryID] = P.[ProductSubcategoryID])


/* QUERY 68:TOMANDO EL EJERCICIO ANTERIOR, MOSTRAR UNICAMENTE AQUELLOS PRODUCTOS CUYA CATEGORIA SEA "ECONOMICA"*/
SELECT *
	FROM (SELECT P.[Name], 
			PSC.[Name] AS 'SUBCATEGORIA', 
			P.[ListPrice],
			(CASE  
							WHEN ListPrice BETWEEN 0 AND 1000 THEN 'Economica'
							WHEN ListPrice BETWEEN 1000 AND 2000 THEN 'Normal'
							ELSE 'Caro'
							END) AS Categoria
			FROM		[Production].[Product] AS P
			INNER JOIN [Production].[ProductSubcategory] AS PSC
			ON			(PSC.[ProductSubcategoryID] = P.[ProductSubcategoryID])
			)miTabla
	WHERE miTabla.Categoria = 'Economica'