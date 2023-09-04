/* QUERY 1: MOSTRAR TODOS LOS PORDUCTOS CUYO PRECIO DE LISTA ESTE ENTRE 200 Y 300 */
SELECT [Name], [ListPrice] FROM [Production].[Product]
WHERE [ListPrice] BETWEEN 200 AND 300

/* QUERY 2: MOSTRAR TODOS LOS EMPLEADOS QUE NACIERON ENTRE 1970 Y 1985 */
SELECT * FROM [HumanResources].[Employee] 
WHERE [BirthDate] BETWEEN '1970-01-01' AND '1985-12-30'

/* QUERY 3: MOSTRAR LOS CODIGOS DE VENTA Y PRODUCTO,CANTIDAD DE VENTA Y PRECIO UNITARIO DE LOS ARTICULOS 750,753 Y 770 */
SELECT [SalesOrderID], [ProductID], [OrderQty], [UnitPrice]
FROM [Sales].[SalesOrderDetail]
WHERE [ProductID] IN (750,753, 770)

/* QUERY 4: MOSTRAR TODOS LOS PORDUCTOS CUYO COLOR SEA VERDE, BLANCO Y AZUL */
SELECT [Name], [Color] FROM [Production].[Product]
WHERE [Color] IN ('Green', 'White', 'Blue')


/* QUERY 5: MOSTRAR EL LA FECHA,NUERO DE VERSION Y SUBTOTAL DE LAS VENTAS EFECTUADAS EN LOS AÑOS 2011 Y 20014 */
SET DATEFORMAT DMY
GO
SELECT [OrderDate], [SalesOrderNumber], [SubTotal] FROM [Sales].[SalesOrderHeader]
WHERE OrderDate BETWEEN '01-01-2011' AND '31-12-2014'

---------------------------------------------------------------------------------------------------------
--LIKE
---------------------------------------------------------------------------------------------------------

/* QUERY 6: MOSTRAR EL NOMBRE, PRECIO Y COLOR DE LOS ACCESORIOS PARA ASIENTOS DE LAS BICICLETAS CUYO PRECIO SEA  MAYOR A 100 PESOS*/
SELECT [Name], [ListPrice], [Color] 
FROM [Production].[Product]
WHERE [Name] IN ('HL Mountain Seat/Saddle', 'HL Mountain Seat Assembly')
AND [ListPrice] > 100

/* QUERY 7: MOSTRAR LAS BICICLETAS DE MONTAÑA QUE  CUESTAN ENTRE $1000 Y $1200 */
SELECT [Name], [ListPrice]
FROM [Production].[Product]
WHERE [Name] LIKE '%[Mountain]'
AND [ListPrice] BETWEEN 1000 AND 1200
 
/* QUERY 8: MOSTRAR LOS NOMBRE DE LOS PRODUCTOS QUE TENGAN CUALQUIER COMBINACION DE MOUNTAIN BIKE */
SELECT [Name]
FROM [Production].[Product]
WHERE [Name] LIKE '%[Mountain Bike]'


/* QUERY 9: MOSTRAR LAS PERSONAS QUE SU NOMBRE EMPIECE CON LA LETRA Y */
SELECT [FirstName]
FROM [Person].[Person]
WHERE [FirstName] LIKE 'Y%'

/* QUERY 10: MOSTRAR LAS PERSONAS QUE LA SEGUNDA LETRA DE SU APELLIDO ES UNA S */
SELECT [FirstName], [LastName]
FROM [Person].[Person]
WHERE [LastName] LIKE '_s%'

/* QUERY 11: MOSTRAR EL NOMBRE CONCATENADO CON EL APELLIDO DE LAS PERSONAS CUYO APELLIDO TENGAN TERMINACION ESPAÑOLA (EZ)*/
SELECT [FirstName] + ' ' + [LastName]
FROM [Person].[Person]
WHERE [LastName] LIKE '%ez'

/* QUERY 12: MOSTRAR LOS NOMBRES DE LOS PRODUCTOS QUE SU NOMBRE TERMINE EN UN NUMERO */
SELECT [Name] 
FROM [Production].[Product]
WHERE Name LIKE '%[0-9]'

/* QUERY 13: MOSTRAR LAS PERSONAS CUYO  NOMBRE TENGA UNA C O c COMO PRIMER CARACTER, 
	CUALQUIER OTRO COMO SEGUNDO CARACTER, NI D NI d NI F NI g COMO TERCER CARACTER, CUALQUIERA 
	ENTRE J Y R O ENTRE S Y W COMO CUARTO CARACTER Y EL RESTO SIN RESTRICCIONES */

SELECT [FirstName]
FROM [Person].[Person]
WHERE [FirstName] LIKE '[C,c]_[^DdFg][J-W]%'


---------------------------------------------------------------------------------------------------------
--UTILIZACION DE ORDER BY
---------------------------------------------------------------------------------------------------------

/* QUERY 14: MOSTRAR las personas ordernadas primero por su apellido y luego por su nombre*/
SELECT [FirstName], [LastName]
FROM [Person].[Person]
ORDER BY [LastName]


/* QUERY 15: MOSTRAR CINCO PRODUCTOS MAS CAROS Y SU NOMBRE ORDENADO EN FORMA ALFABETICA*/
SELECT  TOP 5 [Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC, [Name] ASC


---------------------------------------------------------------------------------------------------------
--FUNCIONES DE AGRUPACION
---------------------------------------------------------------------------------------------------------


/* QUERY 16: MOSTRAR LA FECHA MAS RECIENTE DE VENTA */
SELECT [CurrencyRateDate]  
FROM [Sales].[CurrencyRate]
ORDER BY [CurrencyRateDate]  DESC

/* QUERY 17: MOSTRAR EL PRECIO MAS BARATO DE TODAS LAS BICICLETAS */
SELECT  MIN([ListPrice]) AS 'Precio Mas Bajo'
FROM [Production].[Product]
WHERE [ProductNumber] like 'bk%'

/* QUERY 18: MOSTRAR LA FECHA DE NACIMIENTO DEL EMPLEADO MAS JOVEN */
SELECT MAX ([BirthDate])
FROM [HumanResources].[Employee]



---------------------------------------------------------------------------------------------------------
--NULL
---------------------------------------------------------------------------------------------------------

/* QUERY 19: MOSTRAR LOS REPRESENTANTES DE VENTAS (VENDEDORES) QUE NO TIENEN DEFINIDO EL NUMERO DE TERRITORIO*/
SELECT *
FROM [Sales].[SalesPerson]
WHERE [TerritoryID] IS NULL


/* QUERY 20: MOSTRAR EL PESO PROMEDIO DE TODOS LOS ARTICULOS. SI EL PESO NO ESTUVIESE DEFINIDO, REEMPLAZAR POR CERO*/
SELECT AVG(ISNULL([Weight],0)) AS PROMEDIO
FROM [Production].[Product]


--UTILIZACION DE GROUP BY

/* QUERY 21: MOSTRAR EL CODIGO DE SUBCATEGORIA Y EL PRECIO DEL PRODUCTO MAS BARATO DE CADA UNA DE ELLAS */
SELECT [ProductSubcategoryID], MIN([ListPrice])
FROM [Production].[Product]
GROUP BY [ProductSubcategoryID]


/* QUERY 22: MOSTRAR LOS PRODUCTOS Y LA CANTIDAD TOTAL VENDIDA DE CADA UNO DE ELLOS*/
SELECT [ProductID], SUM([OrderQty]) AS CANTIDAD_TOTAL
FROM [Sales].[SalesOrderDetail]
GROUP BY [ProductID]

/* QUERY 23: MOSTRAR LOS PRODUCTOS Y LA CANTIDAD TOTAL VENDIDA DE CADA UNO DE ELLOS, ORDENARLOS POR MAYOR CANTIDAD DE VENTAS*/
SELECT [ProductID], SUM([OrderQty]) AS CANTIDAD_TOTAL
FROM [Sales].[SalesOrderDetail]
GROUP BY [ProductID]
ORDER BY CANTIDAD_TOTAL DESC

/* QUERY 24: MOSTRAR TODAS LAS FACTURAS REALIZADAS Y EL TOTAL FACTURADO DE CADA UNA DE ELLAS ORDENADO POR NRO DE FACT.*/
SELECT [SalesOrderDetailID], SUM([OrderQty] * [UnitPrice]) AS TOTAL_FACTURADO
FROM [Sales].[SalesOrderDetail]
GROUP BY [SalesOrderDetailID]
ORDER BY [SalesOrderDetailID]

---------------------------------------------------------------------------------------------------------
--UTILIZACION DE HAVING
---------------------------------------------------------------------------------------------------------

/* QUERY 25: MOSTRAR TODAS LAS FACTURAS REALIZADAS Y EL TOTAL FACTURADO DE CADA UNA DE ELLAS ORDENADO POR NRO DE FACTURA
 PERO SOLO DE AQUELLAS ORDENES SUPEREN UN TOTAL DE $10.000 */
 SELECT [SalesOrderID], SUM([OrderQty]*[UnitPrice]) AS TOTAL_FACTURADO
 FROM [Sales].[SalesOrderDetail]
 GROUP BY [SalesOrderID]
 HAVING SUM([OrderQty]*[UnitPrice]) > 10000
 ORDER BY [SalesOrderID]


/* QUERY 26: MOSTRAR LA CANTIDAD DE FACTURAS QUE VENDIERON MAS DE 20 UNIDADES */
SELECT [SalesOrderID], SUM([OrderQty]) AS CANTIDAD
FROM [Sales].[SalesOrderDetail]
GROUP BY [SalesOrderID]
HAVING  SUM([OrderQty]) > 20

/* QUERY 27: MOSTRAR LAS SUBCATEGORIAS DE LOS PRODUCTOS QUE TIENEN DOS O MAS PRODUCTOS QUE CUESTAN MENOS DE $150 */
SELECT [ProductSubcategoryID], COUNT(*) CANTIDAD 
FROM  [Production].[Product] 
WHERE [ListPrice] < 150
GROUP BY ProductSubcategoryID
HAVING COUNT(*) >1

/* QUERY 28: MOSTRAR TODOS LOS CODIGOS DE CATEGORIAS EXISTENTES JUNTO CON LA CANTIDAD DE PRODUCTOS Y EL PRECIO DE LISTA PROMEDIO
POR CADA UNO DE AQUELLOS PRODUCTOS QUE CUESTAN MAS DE $70 Y EL PRECIO PROMEDIO ES MAYOR A $300 */
SELECT DISTINCT [ProductSubcategoryID], COUNT(*) CANTIDAD, AVG([ListPrice]) AS PROMEDIO
FROM  [Production].[Product]
WHERE [ListPrice] > 70
GROUP BY ProductSubcategoryID
HAVING AVG([ListPrice]) > 300


---------------------------------------------------------------------------------------------------------
--ROLLUP
---------------------------------------------------------------------------------------------------------

/* QUERY 29: MOSTRAR NUMERO DE FACTURA, EL MONTo VENDIDO Y AL FINAL TOTALIZAR LA FACTURACION */
SELECT SalesOrderID, SUM(UnitPrice*OrderQty) AS SubTotalt
FROM Sales.SalesOrderDetail 
GROUP BY SalesOrderID WITH ROLLUP