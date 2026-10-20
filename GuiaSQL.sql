--recorda cambiar la master a gd2015c1

--SQL

--1. Mostrar el código, razón social de todos los clientes  
--cuyo límite de crédito sea mayor o 
--igual a $ 1000 ordenado por código de cliente.
select clie_codigo, clie_razon_social, clie_limite_credito
from cliente 
where clie_limite_credito >= 1000 --where es un filter
order by clie_codigo

--2. Mostrar el código, detalle de todos los artículos 
--vendidos en el año 2012 ordenados por cantidad vendida.
select prod_codigo, prod_detalle, 
	sum(item_cantidad) as cant_vendida
from producto 
-- para conseguir cantidad vendida
join item_factura 
	on prod_codigo = item_producto 
	--pk producto = fk item_producto
-- para conseguir fecha
join factura 
	on fact_tipo+fact_sucursal+fact_numero 
		= item_tipo+item_sucursal+item_numero
-- pk factura = fk item_factura
where year(fact_fecha) = 2012
--un mismo producto puede aparecer en muchas facturas.
--asi q hay q agrupar las ventas del mismo producto
group by prod_codigo, prod_detalle, item_cantidad
order by cant_vendida

--3. Realizar una consulta que muestre código de producto, 
--nombre de producto y el stock total, sin importar 
--en que deposito se encuentre, los datos deben ser 
--ordenados por nombre del artículo de menor a mayor.
select prod_codigo, prod_detalle, 
	sum(isnull(stoc_cantidad,0)) as cantidad_stock --para q quede mas lindo
--el stock podria ser 0 y sumo el stock que hay en cada deposito
from producto left join stock on prod_codigo = stoc_producto
--join solo productos con stock
--right join devolveria solo si un stock coincide con un producto o stocks huerfanos
--left join incluye productos sin stock (null), isnull les pondria 0
group by prod_codigo, prod_detalle
ORDER BY cantidad_stock ASC --me gusto mas ordenarlo por cant_stock

--4. Realizar una consulta que muestre para todos los artículos código, 
--detalle y cantidad de artículos que lo componen. Mostrar solo aquellos 
--artículos para los cuales el stock promedio por depósito sea mayor a 100.
select prod_codigo, prod_detalle, 
	count(comp_producto) as cant_componentes
from producto left join composicion on prod_codigo = comp_producto
--filtrar por prod_cod en stock como stoc_prod
where prod_codigo in ( select stoc_producto from stock
	group by stoc_producto
	having avg(stoc_cantidad) > 100 )
--avg es para el promedio entre la cantidad de stock x deposito
--where filtra antes de agrupar
--having filtra dsp de agrupar
--filtra que la coincidencia de prod_cod en stock_prod tenga 
--promedio stock x deposito > 100
group by prod_codigo, prod_detalle

--5. Realizar una consulta que muestre código de artículo, 
--detalle y cantidad de egresos de stock (ventas) que se realizaron  
--para ese artículo en el año 2012. Mostrar solo aquellos que hayan   
--tenido más egresos que en el 2011.
select prod_codigo, prod_detalle,
	sum(item_cantidad) as cant_vendida
from producto 
join item_factura on prod_codigo = item_producto 
join factura on fact_tipo+fact_sucursal+fact_numero 
	= item_tipo+item_sucursal+item_numero
where year(fact_fecha) = 2012
group by prod_codigo, prod_detalle, item_cantidad
having sum(item_cantidad) > COALESCE(( select sum(item_cantidad) 
	from item_factura
	join factura on fact_tipo+fact_sucursal+fact_numero 
		= item_tipo+item_sucursal+item_numero
	where prod_codigo = item_producto and year(fact_fecha) = 2011 ), 0)
	--prod_codigo = item_producto xq necesito que sean los mismos
	--productos considerados del 2012 q esten en el 2011
	--coalesce trata los casos en los q no hayan habido ventas en 2011

--6. Mostrar para todos los rubros de artículos código, detalle, 
--cantidad de artículos de ese rubro y stock total de ese rubro de 
--artículos. Solo tener en cuenta aquellos artículos que
--tengan un stock mayor al del artículo ‘00000000’ en el depósito ‘00’.
select rubr_id, rubr_detalle, 
	count(prod_rubro) as cant_prodsEnRubro,
	sum(isnull(stoc_cantidad,0)) as stock_rubro
from rubro
--incluyo rubros sin productos
left join producto on prod_rubro = rubr_id
--durante ejecucion xq no tomo todos los productos del rubro
	and prod_codigo in (select stoc_producto from stock
		group by stoc_producto
		having sum(stoc_cantidad) > (select stoc_cantidad from stock
			where stoc_producto = '00000000' and stoc_deposito = '00'))
left join stock on stoc_producto = prod_codigo
group by rubr_id, rubr_detalle




--T-SQL

