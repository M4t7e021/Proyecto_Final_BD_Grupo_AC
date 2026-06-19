--  Sistema de Gestión de Hotel
--  Tablas: hotel, tipo_habitacion, habitacion, servicio, empleado
-- ===============================================================

-- =============================================================
-- Tabla - hotel
-- =============================================================
INSERT INTO hotel (nombre, direccion, telefono)
VALUES ('Hotel Gran Pacífico', 'Av. La Revolución 450, Colonia San Benito, San Salvador', '2264-1800');

-- =============================================================
-- Tabla - tipo_habitacion  (id_tipo: 1=Simple, 2=Doble, 3=Suite)
-- =============================================================
INSERT INTO tipo_habitacion (nombre_tipo, precio_noche, capacidad)
VALUES
('Simple', 65.00,  1),
('Doble',  110.00, 2),
('Suite',  220.00, 5);

-- =============================================================
-- Tabla - habitacion  (id_hotel=1, pisos 1-3, variedad de tipos)
-- =============================================================
INSERT INTO habitacion (numero, piso, estado, id_hotel, id_tipo)
VALUES
('H-111', 1, 'Ocupada',        1, 1), 
('H-112', 1, 'Ocupada',        1, 2), 
('H-113', 1, 'Disponible',     1, 1),  
('H-114', 2, 'Ocupada',        1, 3),  
('H-115', 2, 'Disponible',     1, 2),  
('H-116', 2, 'Ocupada',        1, 3),  
('H-117', 3, 'Mantenimiento',  1, 1),  
('H-118', 3, 'Disponible',     1, 2),  
('H-119', 3, 'Disponible',     1, 3),  
('H-120', 1, 'Disponible',     1, 2);  

-- =============================================================
-- Tabla - huesped  (6 huéspedes)
-- =============================================================
INSERT INTO huesped (nombre, apellido, dui, telefono, correo)
VALUES
('Carlos',    'Mendoza',   '045216783', '7110-2201', 'carlos.mendoza@gmail.com'),
('Sofía',     'Rivas',     '023987451', '7220-3312', 'sofia.rivas@hotmail.com'),
('Andrés',    'Fuentes',   '067123405', '7330-4423', 'andres.fuentes@gmail.com'),
('Valentina', 'Morales',   '018456239', '7440-5534', 'valentina.morales@yahoo.com'),
('Diego',     'Gutiérrez', '052341897', '7550-6645', 'diego.gutierrez@gmail.com'),
('Mariana',   'Escobar',   '039674122', '7660-7756', 'mariana.escobar@hotmail.com');

-- =============================================================
-- Tabla - reservacion
-- id_huesped 1-6 / id_habitacion según estado arriba
-- Estados variados: Finalizada, Cancelada, Activa
-- =============================================================
INSERT INTO reservacion (fecha_reserva, fecha_inicio, fecha_fin, estado, id_huesped, id_habitacion)
VALUES
('2025-05-01', '2025-05-05', '2025-05-08', 'Finalizada', 1, 7),  -- Carlos    → hab 101 Simple
('2025-05-03', '2025-05-10', '2025-05-14', 'Finalizada', 2, 8),  -- Sofía     → hab 102 Doble
('2025-05-06', '2025-05-12', '2025-05-15', 'Cancelada',  3, 9),  -- Andrés    → hab 103 Simple
('2025-05-08', '2025-05-20', '2025-05-23', 'Finalizada', 4, 10),  -- Valentina → hab 201 Suite
('2025-05-10', '2025-06-01', '2025-06-05', 'Activa',     5, 15),  -- Diego     → hab 203 Suite
('2025-05-12', '2025-06-03', '2025-06-07', 'Activa',     6, 7);  -- Mariana   → hab 102 Doble

-- =============================================================
-- Tabla - checkin_checkout
-- Cancelada (id_reservacion=3) NO tiene checkin
-- Activas (id 5,6) tienen checkin pero checkout NULL
-- =============================================================
INSERT INTO checkin_checkout (fecha_checkin, fecha_checkout, id_reservacion, id_empleado)
VALUES
('2025-05-05 14:00:00', '2025-05-08 11:00:00', 1, 4),   -- Carlos   
('2025-05-10 15:30:00', '2025-05-14 10:00:00', 2, 5),   -- Sofía     
('2025-05-20 13:00:00', '2025-05-23 12:00:00', 4, 6),   -- Valentina 
('2025-06-01 14:30:00', NULL,                  5, 7),   -- Diego (en hotel)
('2025-06-03 16:00:00', NULL,                  6, 10);  -- Mariana (en hotel)

-- =============================================================
-- Tabla - consumo_servicio
-- Cancelada (id=3) sin consumos
-- Activas (id 5,6) pueden consumir durante su estadía
-- Referencia servicios: 1=Restaurante, 2=Lavandería, 3=Spa,
--   5=Desayuno Buffet, 6=Serv.Habitación, 7=Transporte,
--   8=Minibar, 9=Gimnasio, 13=Cena Romántica, 14=Internet
-- =============================================================
INSERT INTO consumo_servicio (cantidad, subtotal, fecha_consumo, id_reservacion, id_servicio)
VALUES
-- Carlos (reservacion 1)
(2, 50.00, '2025-05-06', 1, 1),   -- 2x Restaurante   $25.00
(3, 45.00, '2025-05-07', 1, 5),   -- 3x Desayuno Buf  $15.00

-- Sofía (reservacion 2)
(1, 40.00, '2025-05-11', 2, 3),   -- 1x Spa           $40.00
(2, 20.00, '2025-05-12', 2, 6),   -- 2x Serv.Hab      $10.00

-- Valentina (reservacion 4)
(1, 12.50, '2025-05-21', 4, 2),   -- 1x Lavandería    $12.50
(3, 75.00, '2025-05-22', 4, 8),   -- 3x Minibar       $25.00

-- Diego (reservacion 5, activa)
(2, 40.00, '2025-06-02', 5, 9),   -- 2x Gimnasio      $20.00
(1,  7.50, '2025-06-02', 5, 14),  -- 1x Internet      $7.50

-- Mariana (reservacion 6, activa)
(1, 60.00, '2025-06-04', 6, 13),  -- 1x Cena Romántic $60.00
(1, 30.00, '2025-06-04', 6, 7);   -- 1x Transporte    $30.00

-- =============================================================
-- Tabla - factura
-- Solo reservaciones Finalizadas: id 1, 2, 4
-- Total = (precio_noche × noches) + suma de consumos
-- =============================================================
INSERT INTO factura (fecha_factura, total, metodo_pago, id_reservacion)
VALUES
('2025-05-08', 290.00, 'Efectivo',      1),  
('2025-05-14', 500.00, 'Tarjeta',       2),  
('2025-05-23', 417.50, 'Transferencia', 4);  

-- =============================================================
-- Tabla - servicio
-- =============================================================
INSERT INTO servicio (nombre, precio)
VALUES
('Restaurante',                  25.00),
('Lavandería',                   12.50),
('Spa',                          40.00),
('Alquiler de Salón para Eventos',150.00),
('Desayuno Buffet',              15.00),
('Servicio a la Habitación',     10.00),
('Transporte Aeropuerto',        30.00),
('Minibar',                      25.00),
('Gimnasio',                     20.00),
('Sala de Conferencias',        120.00),
('Tour Turístico',               50.00),
('Piscina VIP',                  18.00),
('Cena Romántica',               60.00),
('Servicio de Internet Premium',  7.50),
('Estacionamiento',               5.00);

-- =============================================================
-- Tabla - empleado
-- =============================================================
INSERT INTO empleado (nombre, cargo, telefono)
VALUES
('Eduardo Villalobos', 'Gerente',        '7000-1001'),
('Abigail Reyes',      'Administrador',  '7000-1002'),
('Jose Ramirez',       'Administrador',  '7000-1003'),
('Alejandra Palacios', 'Recepcionista',  '7000-1004'),
('Luis Hernandez',     'Recepcionista',  '7000-1005'),
('Stefanie Castro',    'Recepcionista',  '7000-1006'),
('Christian Torres',   'Recepcionista',  '7000-1007'),
('Valeria Castillo',   'Administrador',  '7000-1008'),
('Edgar Cardona',      'Administrador',  '7000-1009'),
('Elizabeth Arevalo',  'Recepcionista',  '7000-1010'),
('Andrea Gonzales',    'Recepcionista',  '7000-1011');
