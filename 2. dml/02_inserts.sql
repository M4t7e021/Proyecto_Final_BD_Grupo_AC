-- ===============================================================
--  Sistema de Gestión de Hotel
--  Tablas: hotel, tipo_habitacion, habitacion, servicio, empleado
-- ===============================================================
 
-- =============================================================
-- Tabla - hotel
-- =============================================================
insert into hotel (nombre, direccion, telefono) 
values ('Hotel Gran Pacífico',     'Av. La Revolución 450, Colonia San Benito, San Salvador',  '2264-1800');

-- =============================================================
-- Tabla - tipo_habitacion: Simple, Doble, Suite
-- =============================================================
insert into tipo_habitacion (nombre_tipo, precio_noche, capacidad) 
values
('Simple',  65.00, 1),   
('Doble',  110.00, 2),   
('Suite',  220.00, 5); 

-- =============================================================
-- Tabla - hotel: Fue generada con datos en Mockaroo
-- =============================================================

-- =============================================================
-- Tabla - servicio
-- =============================================================
insert into servicio (nombre, precio)
values
('Restaurante', 25.00),
('Lavandería', 12.50),
('Spa', 40.00),
('Alquiler de Salón para Eventos', 150.00),
('Desayuno Buffet', 15.00),
('Servicio a la Habitación', 10.00),
('Transporte Aeropuerto', 30.00),
('Minibar', 25.00),
('Gimnasio', 20.00),
('Sala de Conferencias', 120.00),
('Tour Turístico', 50.00),
('Piscina VIP', 18.00),
('Cena Romántica', 60.00),
('Servicio de Internet Premium', 7.50),
('Estacionamiento', 5.00);
 
-- =============================================================
-- Tabla - empleado
-- =============================================================
insert into empleado (nombre, cargo, telefono)
values
('Eduardo Villalobos', 'Gerente', '7000-1001'),
('Abigail Reyes', 'Administrador', '7000-1002'),
('Jose Ramirez', 'Administrador', '7000-1003'),
('Alejandra Palacios', 'Recepcionista', '7000-1004'),
('Luis Hernandez', 'Recepcionista', '7000-1005'),
('Stefanie Castro', 'Recepcionista', '7000-1006'),
('Christian Torres', 'Recepcionista', '7000-1007'),
('Valeria Castillo', 'Administrador', '7000-1008'),
('Edgar Cardona', 'Administrador', '7000-1009'),
('Elizabeth Arevalo', 'Recepcionista', '7000-1010'),
('Andrea Gonzales', 'Recepcionista', '7000-1011');
 

