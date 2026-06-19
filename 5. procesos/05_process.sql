--Creacion del proceso check-out y generacion de factura

create or replace procedure realizar_checkout(p_id_reservacion int,p_metodo_pago varchar)
language plpgsql
as
$$
declare
v_precio_noche numeric(10,2);
v_dias int;
v_total_habitacion numeric(10,2);
v_total_servicios numeric(10,2);
v_total numeric(10,2);

begin 
--verificar si ya existe una factura
if exists(select 1 from factura where id_reservacion = p_id_reservacion)
then raise exception 'La factura ya existe para esta reservacion';
end if;

--obtener precio y dias de hospedaje
select th.precio_noche, (r.fecha_fin - r.fecha_inicio) into v_precio_noche, v_dias
from reservacion r 
join habitacion h on r.id_habitacion = h.id_habitacion 
join tipo_habitacion th on h.id_tipo = th.id_tipo 
where r.id_reservacion = p_id_reservacion;

--obtener el total habitacion 
v_total_habitacion := v_precio_noche * v_dias;

--obtener el total de servicios
select coalesce(SUM(subtotal) , 0) into v_total_servicios 
from consumo_servicio 
where id_reservacion = p_id_reservacion;

--obtener rl Total general
v_total := v_total_habitacion + v_total_servicios;

--Generacion de factura
insert into factura(fecha_factura, total, metodo_pago, id_reservacion)
values(current_date, v_total , p_metodo_pago , p_id_reservacion);

--Actualizacion de estado de reservacion 
update reservacion 
set estado = 'Finalizada'
where id_reservacion = p_id_reservacion;

end;
$$;

select * from reservacion;
select * from empleado;
select * from servicio;
select count(*) from reservacion;
select * from consumo_servicio where id_reservacion = 1;

call realizar_checkout(1, 'Tarjeta');







