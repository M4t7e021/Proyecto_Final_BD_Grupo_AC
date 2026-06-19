create table hotel(
id_hotel serial primary key,
nombre varchar(100) not null,
direccion varchar(200) not null,
telefono varchar(20) unique not null 
);

create table tipo_habitacion(
id_tipo serial primary key,
nombre_tipo varchar(100) 
check (nombre_tipo in ('Simple' , 'Doble' , 'Suite')),
precio_noche decimal(10,2) check (precio_noche > 0 ),
capacidad int check (capacidad > 0 )
);

create table habitacion(
id_habitacion serial primary key,
numero varchar(10) unique not null,
piso int check (piso > 0 ),
estado varchar(20) default 'Disponible'
check (estado in ('Disponible' , 'Ocupada' , 'Mantenimiento')),
id_hotel int not null,
id_tipo int not null,

foreign key (id_hotel)
references hotel(id_hotel),
foreign key (id_tipo)
references tipo_habitacion(id_tipo)
);

create table huesped(
id_huesped serial primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
dui varchar(10) unique not null,
telefono varchar(15),
correo varchar(100) unique not null
check(correo like '%@%')
);

create table reservacion(
id_reservacion serial primary key,
fecha_reserva date default current_date,
fecha_inicio date not null,
fecha_fin date not null,
estado varchar(20) default 'Activa' 
check (estado in ('Activa' , 'Cancelada' , 'Finalizada')),
id_huesped int not null,
id_habitacion int not null,

foreign key (id_huesped)
references huesped(id_huesped),
foreign key (id_habitacion)
references habitacion(id_habitacion),
check (fecha_fin > fecha_inicio)
);

create table empleado(
id_empleado serial primary key,
nombre varchar(100) not null,
cargo varchar(50) 
check (cargo in ('Administrador' , 'Recepcionista' , 'Gerente')),
telefono varchar(15) unique
);

create table checkin_checkout(
id_check serial primary key,
fecha_checkin timestamp,
fecha_checkout timestamp
check(fecha_checkout is null or fecha_checkout > fecha_checkin),
id_reservacion int UNIQUE not null,
id_empleado int not null,

foreign key (id_reservacion)
references reservacion(id_reservacion),
foreign key (id_empleado)
references empleado(id_empleado)
);

create table servicio(
id_servicio serial primary key,
nombre varchar(100) unique not null,
precio decimal(10,2) check (precio > 0)
);

create table consumo_servicio(
id_consumo serial primary key,
cantidad int check (cantidad > 0),
subtotal decimal(10,2) check (subtotal >= 0),
fecha_consumo date default current_date,
id_servicio int not null,
id_reservacion int not null,

foreign key (id_servicio)
references servicio(id_servicio),
foreign key (id_reservacion)
references reservacion(id_reservacion)
);

create table factura(
id_factura serial primary key,
fecha_factura date default current_date,
total decimal(10,2) check (total >= 0),
metodo_pago varchar(30) 
check (metodo_pago in ('Efectivo' , 'Tarjeta' , 'Transferencia')),
id_reservacion int unique,

foreign key (id_reservacion)
references reservacion(id_reservacion)
);





























