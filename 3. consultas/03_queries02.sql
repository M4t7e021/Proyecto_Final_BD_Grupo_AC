-- ===============================================================
-- Habitaciones disponibles en un rango de fechas dado
-- ===============================================================
select hab.id_habitacion, hab.numero as numero_habitacion, hab.piso,
hab.estado, tip.nombre_tipo as tipo_habitacion, tip.capacidad,
tip.precio_noche
from habitacion hab
inner join tipo_habitacion tip on tip.id_tipo = hab.id_tipo
where hab.estado != 'Mantenimiento'
  and hab.id_habitacion not in(
  select res.id_habitacion
  from reservacion res
  where res.estado != 'Cancelada'
  and res.fecha_inicio < '2025-06-10' --FECHA FINAL DEL RANGO A BUSCAR
  and res.fecha_fin    > '2025-06-01' --FECHA INICIAL DEL RANGO A BUSCAR
)
order by tip.nombre_tipo, hab.piso, hab.numero;
-- ===============================================================
-- Tasa de ocupacion mensual por tipo de habitacion
-- ===============================================================
select to_char(res.fecha_inicio, 'YYYY-MM') as mes,
tip.nombre_tipo as tipo_habitacion,
count(distinct hab.id_habitacion)as habitaciones_del_tipo,
sum(res.fecha_fin - res.fecha_inicio) as noches_ocupadas,
round(sum(res.fecha_fin - res.fecha_inicio)::numeric/(count(distinct hab.id_habitacion) * 30) * 100, 2) as tasa_ocupacion_pct
from reservacion res
inner join habitacion hab on hab.id_habitacion = res.id_habitacion
inner join tipo_habitacion tip on tip.id_tipo = hab.id_tipo
where res.estado != 'Cancelada'
group by to_char(res.fecha_inicio, 'YYYY-MM'), tip.nombre_tipo
order by mes, tip.nombre_tipo;
-- ===============================================================
-- Ingresos totales por mes en el anio en curso
-- ===============================================================
select to_char(fac.fecha_factura, 'YYYY-MM') as mes,
count(fac.id_factura) as facturas_emitidas,
sum(fac.total) as ingresos_totales
from factura fac
where extract(year from fac.fecha_factura) = extract(year from current_date)
group by to_char(fac.fecha_factura, 'YYYY-MM')
order by mes;
-- ===============================================================
-- Se consulta la facturacion
-- =============================================================== 
select 
f.id_factura as numero_factura,
f.fecha_factura,
f.total,
f.metodo_pago,
h.nombre || ' ' || h.apellido as nombre_huesped
from factura f 
inner join reservacion r on f.id_reservacion = r.id_reservacion 
inner join huesped h on r.id_huesped = h.id_huesped 
order by f.fecha_factura desc;