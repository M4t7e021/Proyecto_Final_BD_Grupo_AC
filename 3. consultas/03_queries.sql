-- ===============================================================
-- Catálogo general de habitaciones con hotel, tipo y tarifa
-- ===============================================================
select
    hab.id_habitacion,
    hot.nombre as hotel,
    hab.numero as numero_habitacion,
    hab.piso,
    hab.estado,
    tip.nombre_tipo as tipo_habitacion,
    tip.capacidad,
    tip.precio_noche
from habitacion hab
inner join hotel hot
    on hot.id_hotel = hab.id_hotel
inner join tipo_habitacion tip
    on tip.id_tipo = hab.id_tipo
order by hab.piso, hab.numero;

-- ===============================================================
-- Reservaciones activas con detalle del huésped y habitación
-- ===============================================================
select
    res.id_reservacion,
    res.fecha_reserva,
    res.fecha_inicio,
    res.fecha_fin,
    (res.fecha_fin - res.fecha_inicio) as noches,
    hue.nombre || ' ' || hue.apellido as huesped,
    hue.telefono,
    hue.correo,
    hab.numero as numero_habitacion,
    tip.nombre_tipo as tipo_habitacion,
    tip.precio_noche,
    tip.precio_noche * (res.fecha_fin - res.fecha_inicio) as total_hospedaje
from reservacion res
inner join huesped hue
    on hue.id_huesped = res.id_huesped
inner join habitacion hab
    on hab.id_habitacion = res.id_habitacion
inner join tipo_habitacion tip
    on tip.id_tipo = hab.id_tipo
where res.estado = 'Activa'
order by res.fecha_inicio, hab.numero;

-- ===============================================================
-- Habitaciones sin reservaciones registradas
-- ===============================================================
select
    hab.id_habitacion,
    hab.numero as numero_habitacion,
    hab.piso,
    hab.estado,
    tip.nombre_tipo as tipo_habitacion
from habitacion hab
inner join tipo_habitacion tip
    on tip.id_tipo = hab.id_tipo
left join reservacion res
    on res.id_habitacion = hab.id_habitacion
where res.id_reservacion is null
order by hab.piso, hab.numero;

-- ===============================================================
-- Huéspedes con mayor gasto total
-- ===============================================================

SELECT hu.id_huesped, hu.nombre, hu.apellido,
       SUM(f.total) AS gasto_total
FROM huesped hu
JOIN reservacion r ON hu.id_huesped = r.id_huesped
JOIN factura f ON r.id_reservacion = f.id_reservacion
GROUP BY hu.id_huesped, hu.nombre, hu.apellido
ORDER BY gasto_total DESC;

-- ===============================================================
-- Servicios con mayor consumo
-- ===============================================================
SELECT th.nombre_tipo, s.nombre,
       SUM(cs.cantidad) AS total
FROM consumo_servicio cs
JOIN servicio s ON cs.id_servicio = s.id_servicio
JOIN reservacion r ON cs.id_reservacion = r.id_reservacion
JOIN habitacion h ON r.id_habitacion = h.id_habitacion
JOIN tipo_habitacion th ON h.id_tipo = th.id_tipo
GROUP BY th.nombre_tipo, s.nombre
ORDER BY th.nombre_tipo, total DESC;

-- ===============================================================
--  Consumos detallados por reservación
-- ===============================================================
select
    res.id_reservacion,
    hue.nombre || ' ' || hue.apellido as huesped,
    hab.numero as numero_habitacion,
    ser.nombre as servicio,
    ser.precio as precio_unitario,
    con.cantidad,
    con.subtotal,
    con.fecha_consumo
from consumo_servicio con
inner join servicio ser
    on ser.id_servicio = con.id_servicio
inner join reservacion res
    on res.id_reservacion = con.id_reservacion
inner join huesped hue
    on hue.id_huesped = res.id_huesped
inner join habitacion hab
    on hab.id_habitacion = res.id_habitacion
order by con.fecha_consumo desc, res.id_reservacion;

-- ===============================================================
-- Habitaciones con mayor reservación
-- ===============================================================

SELECT h.numero, COUNT(r.id_reservacion) AS total_reservas
FROM habitacion h
JOIN reservacion r ON h.id_habitacion = r.id_habitacion
GROUP BY h.numero
ORDER BY total_reservas DESC;
