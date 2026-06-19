--Creacion del Metodo trigger
create or replace function verificar_disponibilidad()
returns trigger as 
$$
begin 
	if exists(select 1 from reservacion where id_habitacion = new.id_habitacion 
	and estado <> 'Cancelado' 
    and (new.fecha_inicio <= fecha_fin and new.fecha_fin >= fecha_inicio)) 
then raise exception 'La habitacion se encuentra reservada para esas fechas'; 
end if;
return new;

end;
$$

language plpgsql;

--trigger 
create trigger trg_verificar_disponibilidad
before insert on reservacion 
for each row 
execute function verificar_disponibilidad();
--select 1 from reservacion where id_habitacion = new.id_reservacion;