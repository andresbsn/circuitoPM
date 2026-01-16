--
-- PostgreSQL database dump
--

\restrict cE5iccPJvlXAdS2mBCDXXi27tuerCCsxaHKwJtaCeaUEPvRucu8KAZKBvbXw1l1

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.reservas DROP CONSTRAINT IF EXISTS reservas_tour_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reserva_clientes DROP CONSTRAINT IF EXISTS reserva_clientes_reserva_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reserva_clientes DROP CONSTRAINT IF EXISTS reserva_clientes_cliente_id_fkey;
ALTER TABLE IF EXISTS ONLY public.resenas DROP CONSTRAINT IF EXISTS resenas_usuario_id_fkey;
ALTER TABLE IF EXISTS ONLY public.resenas DROP CONSTRAINT IF EXISTS resenas_destino_id_fkey;
ALTER TABLE IF EXISTS ONLY public.resenas DROP CONSTRAINT IF EXISTS resenas_alojamiento_id_fkey;
ALTER TABLE IF EXISTS ONLY public.resenas DROP CONSTRAINT IF EXISTS resenas_actividad_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pagos DROP CONSTRAINT IF EXISTS pagos_usuario_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pagos DROP CONSTRAINT IF EXISTS pagos_cuota_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pagos DROP CONSTRAINT IF EXISTS pagos_cuenta_corriente_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pagos DROP CONSTRAINT IF EXISTS pagos_cliente_id_fkey;
ALTER TABLE IF EXISTS ONLY public.destinos DROP CONSTRAINT IF EXISTS destinos_categoria_id_fkey;
ALTER TABLE IF EXISTS ONLY public.cuotas DROP CONSTRAINT IF EXISTS cuotas_cuenta_corriente_id_fkey;
ALTER TABLE IF EXISTS ONLY public.cuentas_corrientes DROP CONSTRAINT IF EXISTS cuentas_corrientes_reserva_id_fkey;
ALTER TABLE IF EXISTS ONLY public.cuentas_corrientes DROP CONSTRAINT IF EXISTS cuentas_corrientes_cliente_id_fkey;
ALTER TABLE IF EXISTS ONLY public.alojamientos DROP CONSTRAINT IF EXISTS alojamientos_destino_id_fkey;
ALTER TABLE IF EXISTS ONLY public.actividades DROP CONSTRAINT IF EXISTS actividades_destino_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zones DROP CONSTRAINT IF EXISTS zones_tournament_category_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_teams DROP CONSTRAINT IF EXISTS zone_teams_zone_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_teams DROP CONSTRAINT IF EXISTS zone_teams_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_standings DROP CONSTRAINT IF EXISTS zone_standings_zone_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_standings DROP CONSTRAINT IF EXISTS zone_standings_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_zone_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_winner_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_team_home_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_team_away_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_tournament_category_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_player_dni_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_categories DROP CONSTRAINT IF EXISTS tournament_categories_tournament_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_categories DROP CONSTRAINT IF EXISTS tournament_categories_category_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.teams DROP CONSTRAINT IF EXISTS teams_player2_dni_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.teams DROP CONSTRAINT IF EXISTS teams_player1_dni_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.registrations DROP CONSTRAINT IF EXISTS registrations_tournament_category_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.registrations DROP CONSTRAINT IF EXISTS registrations_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.player_profiles DROP CONSTRAINT IF EXISTS player_profiles_categoria_base_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_winner_team_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_team_home_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_team_away_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_next_match_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_bracket_id_fkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.brackets DROP CONSTRAINT IF EXISTS brackets_tournament_category_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.ventas_cantina DROP CONSTRAINT IF EXISTS ventas_cantina_turno_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.ventas_cantina DROP CONSTRAINT IF EXISTS ventas_cantina_caja_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.turnos DROP CONSTRAINT IF EXISTS turnos_cancha_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.reservas_fijas DROP CONSTRAINT IF EXISTS reservas_fijas_cancha_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.productos DROP CONSTRAINT IF EXISTS productos_proveedor_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.pagos DROP CONSTRAINT IF EXISTS pagos_turno_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.pagos DROP CONSTRAINT IF EXISTS pagos_caja_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.movimientos_proveedor DROP CONSTRAINT IF EXISTS movimientos_proveedor_proveedor_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.movimientos_cuenta DROP CONSTRAINT IF EXISTS movimientos_cuenta_jugador_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.movimientos_cuenta DROP CONSTRAINT IF EXISTS movimientos_cuenta_caja_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.inscripciones DROP CONSTRAINT IF EXISTS inscripciones_torneo_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.inscripciones DROP CONSTRAINT IF EXISTS inscripciones_jugador_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.inscripciones DROP CONSTRAINT IF EXISTS inscripciones_caja_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.gastos DROP CONSTRAINT IF EXISTS gastos_usuario_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.gastos DROP CONSTRAINT IF EXISTS gastos_caja_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.detalle_ventas DROP CONSTRAINT IF EXISTS detalle_ventas_venta_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.detalle_ventas DROP CONSTRAINT IF EXISTS detalle_ventas_producto_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.detalle_venta_cantina DROP CONSTRAINT IF EXISTS detalle_venta_cantina_venta_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.detalle_venta_cantina DROP CONSTRAINT IF EXISTS detalle_venta_cantina_producto_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.detalle_compra DROP CONSTRAINT IF EXISTS detalle_compra_producto_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.detalle_compra DROP CONSTRAINT IF EXISTS detalle_compra_compra_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.compras DROP CONSTRAINT IF EXISTS compras_proveedor_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.cajas DROP CONSTRAINT IF EXISTS cajas_usuario_cierre_id_fkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.cajas DROP CONSTRAINT IF EXISTS cajas_usuario_apertura_id_fkey;
ALTER TABLE IF EXISTS ONLY centro_rehab."User" DROP CONSTRAINT IF EXISTS "User_roleId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Turno" DROP CONSTRAINT IF EXISTS "Turno_profesionalId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Turno" DROP CONSTRAINT IF EXISTS "Turno_pacienteId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Turno" DROP CONSTRAINT IF EXISTS "Turno_ordenKinesiologiaId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Turno" DROP CONSTRAINT IF EXISTS "Turno_especialidadId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Turno" DROP CONSTRAINT IF EXISTS "Turno_cobradoPorId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."TurnoHistorial" DROP CONSTRAINT IF EXISTS "TurnoHistorial_usuarioId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."TurnoHistorial" DROP CONSTRAINT IF EXISTS "TurnoHistorial_turnoId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Seguimiento" DROP CONSTRAINT IF EXISTS "Seguimiento_profesionalId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Seguimiento" DROP CONSTRAINT IF EXISTS "Seguimiento_pacienteId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."PagoMensualGimnasio" DROP CONSTRAINT IF EXISTS "PagoMensualGimnasio_pacienteId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."PagoMensualGimnasio" DROP CONSTRAINT IF EXISTS "PagoMensualGimnasio_cobradoPorId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."PacienteObraSocial" DROP CONSTRAINT IF EXISTS "PacienteObraSocial_pacienteId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."PacienteObraSocial" DROP CONSTRAINT IF EXISTS "PacienteObraSocial_obraSocialId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."OrdenKinesiologia" DROP CONSTRAINT IF EXISTS "OrdenKinesiologia_pacienteId_fkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Auditoria" DROP CONSTRAINT IF EXISTS "Auditoria_usuarioId_fkey";
DROP INDEX IF EXISTS public.pagos_numero_comprobante;
DROP INDEX IF EXISTS public.pagos_fecha_pago;
DROP INDEX IF EXISTS public.pagos_cuota_id;
DROP INDEX IF EXISTS public.pagos_cuenta_corriente_id;
DROP INDEX IF EXISTS public.pagos_cliente_id;
DROP INDEX IF EXISTS public.idx_reservas_tour_id;
DROP INDEX IF EXISTS public.idx_reservas_fecha_reserva;
DROP INDEX IF EXISTS public.idx_reservas_estado;
DROP INDEX IF EXISTS public.idx_reservas_codigo;
DROP INDEX IF EXISTS public.idx_pagos_fecha_pago;
DROP INDEX IF EXISTS public.idx_pagos_cuota_id;
DROP INDEX IF EXISTS public.idx_pagos_cuenta_corriente_id;
DROP INDEX IF EXISTS public.idx_pagos_cliente_id;
DROP INDEX IF EXISTS public.idx_cuotas_fecha_vencimiento;
DROP INDEX IF EXISTS public.idx_cuotas_fecha_pago;
DROP INDEX IF EXISTS public.idx_cuotas_estado;
DROP INDEX IF EXISTS public.idx_cuotas_cuenta_corriente_id;
DROP INDEX IF EXISTS public.idx_cuentas_corrientes_reserva_id;
DROP INDEX IF EXISTS public.idx_cuentas_corrientes_estado;
DROP INDEX IF EXISTS public.idx_cuentas_corrientes_cliente_id;
DROP INDEX IF EXISTS public.idx_clientes_email;
DROP INDEX IF EXISTS public.idx_clientes_dni;
DROP INDEX IF EXISTS public.cuotas_numero_cuota_cuenta_corriente_id;
DROP INDEX IF EXISTS public.cuotas_fecha_vencimiento;
DROP INDEX IF EXISTS public.cuotas_estado;
DROP INDEX IF EXISTS public.cuotas_cuenta_corriente_id;
DROP INDEX IF EXISTS public.cuentas_corrientes_reserva_id;
DROP INDEX IF EXISTS public.cuentas_corrientes_estado;
DROP INDEX IF EXISTS public.cuentas_corrientes_cliente_id;
DROP INDEX IF EXISTS padel_circuit.zone_teams_zone_id_team_id;
DROP INDEX IF EXISTS padel_circuit.zone_standings_zone_id_team_id;
DROP INDEX IF EXISTS padel_circuit.unique_team_pair;
DROP INDEX IF EXISTS padel_circuit.tournament_categories_tournament_id_category_id;
DROP INDEX IF EXISTS padel_circuit.registrations_tournament_category_id_team_id;
DROP INDEX IF EXISTS padel_circuit.idx_tournament_points_tournament_category;
DROP INDEX IF EXISTS padel_circuit.idx_tournament_points_player;
DROP INDEX IF EXISTS centro_rehab."User_email_key";
DROP INDEX IF EXISTS centro_rehab."Turno_profesionalId_startAt_idx";
DROP INDEX IF EXISTS centro_rehab."Turno_pacienteId_startAt_idx";
DROP INDEX IF EXISTS centro_rehab."Turno_especialidadId_startAt_idx";
DROP INDEX IF EXISTS centro_rehab."TurnoHistorial_turnoId_idx";
DROP INDEX IF EXISTS centro_rehab."TurnoHistorial_fecha_idx";
DROP INDEX IF EXISTS centro_rehab."Seguimiento_tipo_idx";
DROP INDEX IF EXISTS centro_rehab."Seguimiento_pacienteId_fecha_idx";
DROP INDEX IF EXISTS centro_rehab."Role_name_key";
DROP INDEX IF EXISTS centro_rehab."PagoMensualGimnasio_yearMonth_idx";
DROP INDEX IF EXISTS centro_rehab."PagoMensualGimnasio_pacienteId_yearMonth_key";
DROP INDEX IF EXISTS centro_rehab."Paciente_telefono_idx";
DROP INDEX IF EXISTS centro_rehab."Paciente_dni_key";
DROP INDEX IF EXISTS centro_rehab."Paciente_dni_idx";
DROP INDEX IF EXISTS centro_rehab."Paciente_apellido_idx";
DROP INDEX IF EXISTS centro_rehab."PacienteObraSocial_pacienteId_key";
DROP INDEX IF EXISTS centro_rehab."OrdenKinesiologia_pacienteId_numero_key";
DROP INDEX IF EXISTS centro_rehab."OrdenKinesiologia_pacienteId_idx";
DROP INDEX IF EXISTS centro_rehab."OrdenKinesiologia_numero_idx";
DROP INDEX IF EXISTS centro_rehab."ObraSocial_nombre_plan_key";
DROP INDEX IF EXISTS centro_rehab."Especialidad_nombre_key";
DROP INDEX IF EXISTS centro_rehab."Auditoria_usuarioId_idx";
DROP INDEX IF EXISTS centro_rehab."Auditoria_entidad_entidadId_idx";
DROP INDEX IF EXISTS centro_rehab."Auditoria_createdAt_idx";
ALTER TABLE IF EXISTS ONLY public.usuarios DROP CONSTRAINT IF EXISTS usuarios_username_key2;
ALTER TABLE IF EXISTS ONLY public.usuarios DROP CONSTRAINT IF EXISTS usuarios_username_key1;
ALTER TABLE IF EXISTS ONLY public.usuarios DROP CONSTRAINT IF EXISTS usuarios_username_key;
ALTER TABLE IF EXISTS ONLY public.usuarios DROP CONSTRAINT IF EXISTS usuarios_pkey;
ALTER TABLE IF EXISTS ONLY public.usuarios DROP CONSTRAINT IF EXISTS usuarios_email_key;
ALTER TABLE IF EXISTS ONLY public.cuentas_corrientes DROP CONSTRAINT IF EXISTS uq_reserva;
ALTER TABLE IF EXISTS ONLY public.reserva_clientes DROP CONSTRAINT IF EXISTS unique_reserva_cliente;
ALTER TABLE IF EXISTS ONLY public.tours DROP CONSTRAINT IF EXISTS tours_pkey;
ALTER TABLE IF EXISTS ONLY public.sequelize_meta DROP CONSTRAINT IF EXISTS sequelize_meta_pkey;
ALTER TABLE IF EXISTS ONLY public.reservas DROP CONSTRAINT IF EXISTS reservas_pkey;
ALTER TABLE IF EXISTS ONLY public.reservas DROP CONSTRAINT IF EXISTS reservas_codigo_key2;
ALTER TABLE IF EXISTS ONLY public.reservas DROP CONSTRAINT IF EXISTS reservas_codigo_key1;
ALTER TABLE IF EXISTS ONLY public.reservas DROP CONSTRAINT IF EXISTS reservas_codigo_key;
ALTER TABLE IF EXISTS ONLY public.reserva_clientes DROP CONSTRAINT IF EXISTS reserva_clientes_pkey;
ALTER TABLE IF EXISTS ONLY public.resenas DROP CONSTRAINT IF EXISTS resenas_pkey;
ALTER TABLE IF EXISTS ONLY public.proveedores DROP CONSTRAINT IF EXISTS proveedores_pkey;
ALTER TABLE IF EXISTS ONLY public.pagos DROP CONSTRAINT IF EXISTS pagos_pkey;
ALTER TABLE IF EXISTS ONLY public.pagos DROP CONSTRAINT IF EXISTS pagos_numero_comprobante_key;
ALTER TABLE IF EXISTS ONLY public.pagos DROP CONSTRAINT IF EXISTS pagos_cuota_id_key;
ALTER TABLE IF EXISTS ONLY public.pagos DROP CONSTRAINT IF EXISTS pagos_correlativo_key;
ALTER TABLE IF EXISTS ONLY public.movimientos_cuenta DROP CONSTRAINT IF EXISTS movimientos_cuenta_pkey;
ALTER TABLE IF EXISTS ONLY public.inscripciones DROP CONSTRAINT IF EXISTS inscripciones_torneo_id_jugador_id_key;
ALTER TABLE IF EXISTS ONLY public.inscripciones DROP CONSTRAINT IF EXISTS inscripciones_pkey;
ALTER TABLE IF EXISTS ONLY public.destinos DROP CONSTRAINT IF EXISTS destinos_pkey;
ALTER TABLE IF EXISTS ONLY public.cuotas DROP CONSTRAINT IF EXISTS cuotas_pkey;
ALTER TABLE IF EXISTS ONLY public.cuentas_corrientes DROP CONSTRAINT IF EXISTS cuentas_corrientes_pkey;
ALTER TABLE IF EXISTS ONLY public.clientes DROP CONSTRAINT IF EXISTS clientes_pkey;
ALTER TABLE IF EXISTS ONLY public.clientes DROP CONSTRAINT IF EXISTS clientes_email_key;
ALTER TABLE IF EXISTS ONLY public.clientes DROP CONSTRAINT IF EXISTS clientes_dni_key;
ALTER TABLE IF EXISTS ONLY public.categorias DROP CONSTRAINT IF EXISTS categorias_pkey;
ALTER TABLE IF EXISTS ONLY public.categorias DROP CONSTRAINT IF EXISTS categorias_nombre_key;
ALTER TABLE IF EXISTS ONLY public.alojamientos DROP CONSTRAINT IF EXISTS alojamientos_pkey;
ALTER TABLE IF EXISTS ONLY public.actividades DROP CONSTRAINT IF EXISTS actividades_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zones DROP CONSTRAINT IF EXISTS zones_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_teams DROP CONSTRAINT IF EXISTS zone_teams_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_standings DROP CONSTRAINT IF EXISTS zone_standings_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.zone_matches DROP CONSTRAINT IF EXISTS zone_matches_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.venues DROP CONSTRAINT IF EXISTS venues_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.users DROP CONSTRAINT IF EXISTS users_dni_key;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournaments DROP CONSTRAINT IF EXISTS tournaments_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_unique;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_points DROP CONSTRAINT IF EXISTS tournament_points_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.tournament_categories DROP CONSTRAINT IF EXISTS tournament_categories_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.teams DROP CONSTRAINT IF EXISTS teams_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.registrations DROP CONSTRAINT IF EXISTS registrations_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.player_profiles DROP CONSTRAINT IF EXISTS player_profiles_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.matches DROP CONSTRAINT IF EXISTS matches_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.categories DROP CONSTRAINT IF EXISTS categories_rank_key;
ALTER TABLE IF EXISTS ONLY padel_circuit.categories DROP CONSTRAINT IF EXISTS categories_pkey;
ALTER TABLE IF EXISTS ONLY padel_circuit.categories DROP CONSTRAINT IF EXISTS categories_name_key;
ALTER TABLE IF EXISTS ONLY padel_circuit.brackets DROP CONSTRAINT IF EXISTS brackets_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.ventas DROP CONSTRAINT IF EXISTS ventas_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.ventas_cantina DROP CONSTRAINT IF EXISTS ventas_cantina_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.usuarios DROP CONSTRAINT IF EXISTS usuarios_username_key;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.usuarios DROP CONSTRAINT IF EXISTS usuarios_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.turnos DROP CONSTRAINT IF EXISTS turnos_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.torneos DROP CONSTRAINT IF EXISTS torneos_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.reservas_fijas DROP CONSTRAINT IF EXISTS reservas_fijas_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.proveedores DROP CONSTRAINT IF EXISTS proveedores_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.productos DROP CONSTRAINT IF EXISTS productos_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.pagos DROP CONSTRAINT IF EXISTS pagos_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.movimientos_proveedor DROP CONSTRAINT IF EXISTS movimientos_proveedor_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.movimientos_cuenta DROP CONSTRAINT IF EXISTS movimientos_cuenta_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.jugadores DROP CONSTRAINT IF EXISTS jugadores_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.inscripciones DROP CONSTRAINT IF EXISTS inscripciones_torneo_id_jugador_id_key;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.inscripciones DROP CONSTRAINT IF EXISTS inscripciones_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.gastos DROP CONSTRAINT IF EXISTS gastos_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.detalle_ventas DROP CONSTRAINT IF EXISTS detalle_ventas_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.detalle_venta_cantina DROP CONSTRAINT IF EXISTS detalle_venta_cantina_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.detalle_compra DROP CONSTRAINT IF EXISTS detalle_compra_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.configuracion DROP CONSTRAINT IF EXISTS configuracion_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.compras DROP CONSTRAINT IF EXISTS compras_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.categorias DROP CONSTRAINT IF EXISTS categorias_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.categorias DROP CONSTRAINT IF EXISTS categorias_descripcion_key;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.canchas DROP CONSTRAINT IF EXISTS canchas_pkey;
ALTER TABLE IF EXISTS ONLY complejo_deportivo.cajas DROP CONSTRAINT IF EXISTS cajas_pkey;
ALTER TABLE IF EXISTS ONLY centro_rehab._prisma_migrations DROP CONSTRAINT IF EXISTS _prisma_migrations_pkey;
ALTER TABLE IF EXISTS ONLY centro_rehab."User" DROP CONSTRAINT IF EXISTS "User_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Turno" DROP CONSTRAINT IF EXISTS "Turno_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."TurnoHistorial" DROP CONSTRAINT IF EXISTS "TurnoHistorial_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Seguimiento" DROP CONSTRAINT IF EXISTS "Seguimiento_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Role" DROP CONSTRAINT IF EXISTS "Role_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."PagoMensualGimnasio" DROP CONSTRAINT IF EXISTS "PagoMensualGimnasio_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Paciente" DROP CONSTRAINT IF EXISTS "Paciente_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."PacienteObraSocial" DROP CONSTRAINT IF EXISTS "PacienteObraSocial_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."OrdenKinesiologia" DROP CONSTRAINT IF EXISTS "OrdenKinesiologia_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."ObraSocial" DROP CONSTRAINT IF EXISTS "ObraSocial_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Especialidad" DROP CONSTRAINT IF EXISTS "Especialidad_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."ConfiguracionCoseguros" DROP CONSTRAINT IF EXISTS "ConfiguracionCoseguros_pkey";
ALTER TABLE IF EXISTS ONLY centro_rehab."Auditoria" DROP CONSTRAINT IF EXISTS "Auditoria_pkey";
ALTER TABLE IF EXISTS public.usuarios ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tours ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.reservas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.reserva_clientes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.resenas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.proveedores ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.pagos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.movimientos_cuenta ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.inscripciones ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.destinos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.cuotas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.cuentas_corrientes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.clientes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.categorias ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.alojamientos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.actividades ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.zones ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.zone_teams ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.zone_standings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.zone_matches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.venues ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.tournaments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.tournament_points ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.tournament_categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.teams ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.registrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.matches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.categories ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS padel_circuit.brackets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.ventas_cantina ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.ventas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.usuarios ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.turnos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.torneos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.reservas_fijas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.proveedores ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.productos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.pagos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.movimientos_proveedor ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.movimientos_cuenta ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.jugadores ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.inscripciones ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.gastos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.detalle_ventas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.detalle_venta_cantina ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.detalle_compra ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.compras ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.categorias ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.canchas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS complejo_deportivo.cajas ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.usuarios_id_seq;
DROP TABLE IF EXISTS public.usuarios;
DROP SEQUENCE IF EXISTS public.tours_id_seq;
DROP TABLE IF EXISTS public.tours;
DROP TABLE IF EXISTS public.sequelize_meta;
DROP SEQUENCE IF EXISTS public.reservas_id_seq;
DROP TABLE IF EXISTS public.reservas;
DROP SEQUENCE IF EXISTS public.reserva_clientes_id_seq;
DROP TABLE IF EXISTS public.reserva_clientes;
DROP SEQUENCE IF EXISTS public.resenas_id_seq;
DROP TABLE IF EXISTS public.resenas;
DROP SEQUENCE IF EXISTS public.proveedores_id_seq;
DROP TABLE IF EXISTS public.proveedores;
DROP SEQUENCE IF EXISTS public.pagos_id_seq;
DROP TABLE IF EXISTS public.pagos;
DROP SEQUENCE IF EXISTS public.movimientos_cuenta_id_seq;
DROP TABLE IF EXISTS public.movimientos_cuenta;
DROP SEQUENCE IF EXISTS public.inscripciones_id_seq;
DROP TABLE IF EXISTS public.inscripciones;
DROP SEQUENCE IF EXISTS public.destinos_id_seq;
DROP TABLE IF EXISTS public.destinos;
DROP SEQUENCE IF EXISTS public.cuotas_id_seq;
DROP TABLE IF EXISTS public.cuotas;
DROP SEQUENCE IF EXISTS public.cuentas_corrientes_id_seq;
DROP TABLE IF EXISTS public.cuentas_corrientes;
DROP SEQUENCE IF EXISTS public.clientes_id_seq;
DROP TABLE IF EXISTS public.clientes;
DROP SEQUENCE IF EXISTS public.categorias_id_seq;
DROP TABLE IF EXISTS public.categorias;
DROP SEQUENCE IF EXISTS public.alojamientos_id_seq;
DROP TABLE IF EXISTS public.alojamientos;
DROP SEQUENCE IF EXISTS public.actividades_id_seq;
DROP TABLE IF EXISTS public.actividades;
DROP SEQUENCE IF EXISTS padel_circuit.zones_id_seq;
DROP TABLE IF EXISTS padel_circuit.zones;
DROP SEQUENCE IF EXISTS padel_circuit.zone_teams_id_seq;
DROP TABLE IF EXISTS padel_circuit.zone_teams;
DROP SEQUENCE IF EXISTS padel_circuit.zone_standings_id_seq;
DROP TABLE IF EXISTS padel_circuit.zone_standings;
DROP SEQUENCE IF EXISTS padel_circuit.zone_matches_id_seq;
DROP TABLE IF EXISTS padel_circuit.zone_matches;
DROP SEQUENCE IF EXISTS padel_circuit.venues_id_seq;
DROP TABLE IF EXISTS padel_circuit.venues;
DROP SEQUENCE IF EXISTS padel_circuit.users_id_seq;
DROP TABLE IF EXISTS padel_circuit.users;
DROP SEQUENCE IF EXISTS padel_circuit.tournaments_id_seq;
DROP TABLE IF EXISTS padel_circuit.tournaments;
DROP SEQUENCE IF EXISTS padel_circuit.tournament_points_id_seq;
DROP TABLE IF EXISTS padel_circuit.tournament_points;
DROP SEQUENCE IF EXISTS padel_circuit.tournament_categories_id_seq;
DROP TABLE IF EXISTS padel_circuit.tournament_categories;
DROP SEQUENCE IF EXISTS padel_circuit.teams_id_seq;
DROP TABLE IF EXISTS padel_circuit.teams;
DROP SEQUENCE IF EXISTS padel_circuit.registrations_id_seq;
DROP TABLE IF EXISTS padel_circuit.registrations;
DROP TABLE IF EXISTS padel_circuit.player_profiles;
DROP SEQUENCE IF EXISTS padel_circuit.matches_id_seq;
DROP TABLE IF EXISTS padel_circuit.matches;
DROP SEQUENCE IF EXISTS padel_circuit.categories_id_seq;
DROP TABLE IF EXISTS padel_circuit.categories;
DROP SEQUENCE IF EXISTS padel_circuit.brackets_id_seq;
DROP TABLE IF EXISTS padel_circuit.brackets;
DROP SEQUENCE IF EXISTS complejo_deportivo.ventas_id_seq;
DROP SEQUENCE IF EXISTS complejo_deportivo.ventas_cantina_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.ventas_cantina;
DROP TABLE IF EXISTS complejo_deportivo.ventas;
DROP SEQUENCE IF EXISTS complejo_deportivo.usuarios_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.usuarios;
DROP SEQUENCE IF EXISTS complejo_deportivo.turnos_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.turnos;
DROP SEQUENCE IF EXISTS complejo_deportivo.torneos_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.torneos;
DROP SEQUENCE IF EXISTS complejo_deportivo.reservas_fijas_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.reservas_fijas;
DROP SEQUENCE IF EXISTS complejo_deportivo.proveedores_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.proveedores;
DROP SEQUENCE IF EXISTS complejo_deportivo.productos_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.productos;
DROP SEQUENCE IF EXISTS complejo_deportivo.pagos_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.pagos;
DROP SEQUENCE IF EXISTS complejo_deportivo.movimientos_proveedor_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.movimientos_proveedor;
DROP SEQUENCE IF EXISTS complejo_deportivo.movimientos_cuenta_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.movimientos_cuenta;
DROP SEQUENCE IF EXISTS complejo_deportivo.jugadores_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.jugadores;
DROP SEQUENCE IF EXISTS complejo_deportivo.inscripciones_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.inscripciones;
DROP SEQUENCE IF EXISTS complejo_deportivo.gastos_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.gastos;
DROP SEQUENCE IF EXISTS complejo_deportivo.detalle_ventas_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.detalle_ventas;
DROP SEQUENCE IF EXISTS complejo_deportivo.detalle_venta_cantina_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.detalle_venta_cantina;
DROP SEQUENCE IF EXISTS complejo_deportivo.detalle_compra_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.detalle_compra;
DROP TABLE IF EXISTS complejo_deportivo.configuracion;
DROP SEQUENCE IF EXISTS complejo_deportivo.compras_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.compras;
DROP SEQUENCE IF EXISTS complejo_deportivo.categorias_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.categorias;
DROP SEQUENCE IF EXISTS complejo_deportivo.canchas_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.canchas;
DROP SEQUENCE IF EXISTS complejo_deportivo.cajas_id_seq;
DROP TABLE IF EXISTS complejo_deportivo.cajas;
DROP TABLE IF EXISTS centro_rehab._prisma_migrations;
DROP TABLE IF EXISTS centro_rehab."User";
DROP TABLE IF EXISTS centro_rehab."TurnoHistorial";
DROP TABLE IF EXISTS centro_rehab."Turno";
DROP TABLE IF EXISTS centro_rehab."Seguimiento";
DROP TABLE IF EXISTS centro_rehab."Role";
DROP TABLE IF EXISTS centro_rehab."PagoMensualGimnasio";
DROP TABLE IF EXISTS centro_rehab."PacienteObraSocial";
DROP TABLE IF EXISTS centro_rehab."Paciente";
DROP TABLE IF EXISTS centro_rehab."OrdenKinesiologia";
DROP TABLE IF EXISTS centro_rehab."ObraSocial";
DROP TABLE IF EXISTS centro_rehab."Especialidad";
DROP TABLE IF EXISTS centro_rehab."ConfiguracionCoseguros";
DROP TABLE IF EXISTS centro_rehab."Auditoria";
DROP TYPE IF EXISTS public.enum_usuarios_status;
DROP TYPE IF EXISTS public.enum_usuarios_role;
DROP TYPE IF EXISTS public.enum_users_status;
DROP TYPE IF EXISTS public.enum_users_role;
DROP TYPE IF EXISTS public.enum_tours_estado;
DROP TYPE IF EXISTS public.enum_reservas_tipo_reserva;
DROP TYPE IF EXISTS public.enum_reservas_metodo_pago;
DROP TYPE IF EXISTS public.enum_reservas_estado_pago;
DROP TYPE IF EXISTS public.enum_reservas_estado;
DROP TYPE IF EXISTS public.enum_pagos_metodo_pago;
DROP TYPE IF EXISTS public.enum_cuotas_estado;
DROP TYPE IF EXISTS public.enum_cuentas_corrientes_estado;
DROP TYPE IF EXISTS public."enum_User_role";
DROP TYPE IF EXISTS padel_circuit.enum_zone_matches_status;
DROP TYPE IF EXISTS padel_circuit.enum_users_role;
DROP TYPE IF EXISTS padel_circuit.enum_tournaments_estado;
DROP TYPE IF EXISTS padel_circuit.enum_tournament_categories_match_format;
DROP TYPE IF EXISTS padel_circuit.enum_teams_estado;
DROP TYPE IF EXISTS padel_circuit.enum_registrations_estado;
DROP TYPE IF EXISTS padel_circuit.enum_matches_status;
DROP TYPE IF EXISTS padel_circuit.enum_matches_next_match_slot;
DROP TYPE IF EXISTS padel_circuit.enum_brackets_status;
DROP TYPE IF EXISTS centro_rehab."TurnoEstado";
DROP TYPE IF EXISTS centro_rehab."SeguimientoTipo";
DROP TYPE IF EXISTS centro_rehab."FormaPago";
DROP TYPE IF EXISTS centro_rehab."CoseguroTipo";
-- *not* dropping schema, since initdb creates it
DROP SCHEMA IF EXISTS padel_circuit;
DROP SCHEMA IF EXISTS complejo_deportivo;
DROP SCHEMA IF EXISTS centro_rehab;
--
-- Name: centro_rehab; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA centro_rehab;


ALTER SCHEMA centro_rehab OWNER TO postgres;

--
-- Name: complejo_deportivo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA complejo_deportivo;


ALTER SCHEMA complejo_deportivo OWNER TO postgres;

--
-- Name: padel_circuit; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA padel_circuit;


ALTER SCHEMA padel_circuit OWNER TO postgres;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: CoseguroTipo; Type: TYPE; Schema: centro_rehab; Owner: postgres
--

CREATE TYPE centro_rehab."CoseguroTipo" AS ENUM (
    'COSEGURO1',
    'COSEGURO2'
);


ALTER TYPE centro_rehab."CoseguroTipo" OWNER TO postgres;

--
-- Name: FormaPago; Type: TYPE; Schema: centro_rehab; Owner: postgres
--

CREATE TYPE centro_rehab."FormaPago" AS ENUM (
    'EFECTIVO',
    'TRANSFERENCIA',
    'DEBITO',
    'CREDITO',
    'OTRO'
);


ALTER TYPE centro_rehab."FormaPago" OWNER TO postgres;

--
-- Name: SeguimientoTipo; Type: TYPE; Schema: centro_rehab; Owner: postgres
--

CREATE TYPE centro_rehab."SeguimientoTipo" AS ENUM (
    'KINESIOLOGIA',
    'GIMNASIO',
    'GENERAL',
    'OTRO'
);


ALTER TYPE centro_rehab."SeguimientoTipo" OWNER TO postgres;

--
-- Name: TurnoEstado; Type: TYPE; Schema: centro_rehab; Owner: postgres
--

CREATE TYPE centro_rehab."TurnoEstado" AS ENUM (
    'RESERVADO',
    'CONFIRMADO',
    'ASISTIO',
    'CANCELADO',
    'AUSENTE'
);


ALTER TYPE centro_rehab."TurnoEstado" OWNER TO postgres;

--
-- Name: enum_brackets_status; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_brackets_status AS ENUM (
    'draft',
    'published'
);


ALTER TYPE padel_circuit.enum_brackets_status OWNER TO postgres;

--
-- Name: enum_matches_next_match_slot; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_matches_next_match_slot AS ENUM (
    'home',
    'away'
);


ALTER TYPE padel_circuit.enum_matches_next_match_slot OWNER TO postgres;

--
-- Name: enum_matches_status; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_matches_status AS ENUM (
    'pending',
    'played',
    'bye'
);


ALTER TYPE padel_circuit.enum_matches_status OWNER TO postgres;

--
-- Name: enum_registrations_estado; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_registrations_estado AS ENUM (
    'inscripto',
    'baja',
    'confirmado'
);


ALTER TYPE padel_circuit.enum_registrations_estado OWNER TO postgres;

--
-- Name: enum_teams_estado; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_teams_estado AS ENUM (
    'activa',
    'inactiva'
);


ALTER TYPE padel_circuit.enum_teams_estado OWNER TO postgres;

--
-- Name: enum_tournament_categories_match_format; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_tournament_categories_match_format AS ENUM (
    'BEST_OF_3_SUPER_TB',
    'BEST_OF_3_FULL'
);


ALTER TYPE padel_circuit.enum_tournament_categories_match_format OWNER TO postgres;

--
-- Name: enum_tournaments_estado; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_tournaments_estado AS ENUM (
    'draft',
    'inscripcion',
    'en_curso',
    'finalizado'
);


ALTER TYPE padel_circuit.enum_tournaments_estado OWNER TO postgres;

--
-- Name: enum_users_role; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_users_role AS ENUM (
    'admin',
    'player'
);


ALTER TYPE padel_circuit.enum_users_role OWNER TO postgres;

--
-- Name: enum_zone_matches_status; Type: TYPE; Schema: padel_circuit; Owner: postgres
--

CREATE TYPE padel_circuit.enum_zone_matches_status AS ENUM (
    'pending',
    'played'
);


ALTER TYPE padel_circuit.enum_zone_matches_status OWNER TO postgres;

--
-- Name: enum_User_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_User_role" AS ENUM (
    'ADMIN',
    'CLIENTE',
    'admin',
    'user',
    'guide',
    'USER',
    'GUIDE'
);


ALTER TYPE public."enum_User_role" OWNER TO postgres;

--
-- Name: enum_cuentas_corrientes_estado; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_cuentas_corrientes_estado AS ENUM (
    'pendiente',
    'en_proceso',
    'pagado',
    'atrasado',
    'cancelado'
);


ALTER TYPE public.enum_cuentas_corrientes_estado OWNER TO postgres;

--
-- Name: enum_cuotas_estado; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_cuotas_estado AS ENUM (
    'pendiente',
    'pagada_parcial',
    'pagada_total',
    'vencida',
    'cancelada'
);


ALTER TYPE public.enum_cuotas_estado OWNER TO postgres;

--
-- Name: enum_pagos_metodo_pago; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_pagos_metodo_pago AS ENUM (
    'efectivo',
    'transferencia',
    'tarjeta_credito',
    'tarjeta_debito',
    'deposito',
    'cheque',
    'echq',
    'otro'
);


ALTER TYPE public.enum_pagos_metodo_pago OWNER TO postgres;

--
-- Name: enum_reservas_estado; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_reservas_estado AS ENUM (
    'pendiente',
    'confirmada',
    'cancelada',
    'completada'
);


ALTER TYPE public.enum_reservas_estado OWNER TO postgres;

--
-- Name: enum_reservas_estado_pago; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_reservas_estado_pago AS ENUM (
    'pendiente',
    'parcial',
    'completo'
);


ALTER TYPE public.enum_reservas_estado_pago OWNER TO postgres;

--
-- Name: enum_reservas_metodo_pago; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_reservas_metodo_pago AS ENUM (
    'efectivo',
    'transferencia',
    'tarjeta_credito',
    'otro'
);


ALTER TYPE public.enum_reservas_metodo_pago OWNER TO postgres;

--
-- Name: enum_reservas_tipo_reserva; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_reservas_tipo_reserva AS ENUM (
    'alojamiento',
    'actividad'
);


ALTER TYPE public.enum_reservas_tipo_reserva OWNER TO postgres;

--
-- Name: enum_tours_estado; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tours_estado AS ENUM (
    'disponible',
    'completo',
    'cancelado',
    'finalizado'
);


ALTER TYPE public.enum_tours_estado OWNER TO postgres;

--
-- Name: enum_users_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_role AS ENUM (
    'ADMIN',
    'CLIENTE',
    'admin',
    'user',
    'guide'
);


ALTER TYPE public.enum_users_role OWNER TO postgres;

--
-- Name: enum_users_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_status AS ENUM (
    'active',
    'inactive',
    'suspended'
);


ALTER TYPE public.enum_users_status OWNER TO postgres;

--
-- Name: enum_usuarios_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_usuarios_role AS ENUM (
    'ADMIN',
    'USER',
    'GUIDE'
);


ALTER TYPE public.enum_usuarios_role OWNER TO postgres;

--
-- Name: enum_usuarios_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_usuarios_status AS ENUM (
    'active',
    'inactive',
    'suspended'
);


ALTER TYPE public.enum_usuarios_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Auditoria; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."Auditoria" (
    id text NOT NULL,
    accion text NOT NULL,
    entidad text NOT NULL,
    "entidadId" text,
    "usuarioId" text,
    datos jsonb,
    ip text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE centro_rehab."Auditoria" OWNER TO postgres;

--
-- Name: ConfiguracionCoseguros; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."ConfiguracionCoseguros" (
    id text NOT NULL,
    coseguro1 integer DEFAULT 0 NOT NULL,
    coseguro2 integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE centro_rehab."ConfiguracionCoseguros" OWNER TO postgres;

--
-- Name: Especialidad; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."Especialidad" (
    id text NOT NULL,
    nombre text NOT NULL,
    "duracionTurnoMin" integer DEFAULT 30 NOT NULL,
    activa boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE centro_rehab."Especialidad" OWNER TO postgres;

--
-- Name: ObraSocial; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."ObraSocial" (
    id text NOT NULL,
    nombre text NOT NULL,
    plan text,
    observaciones text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "coseguroTipo" centro_rehab."CoseguroTipo"
);


ALTER TABLE centro_rehab."ObraSocial" OWNER TO postgres;

--
-- Name: OrdenKinesiologia; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."OrdenKinesiologia" (
    id text NOT NULL,
    "pacienteId" text NOT NULL,
    numero integer NOT NULL,
    "cantidadSesiones" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE centro_rehab."OrdenKinesiologia" OWNER TO postgres;

--
-- Name: Paciente; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."Paciente" (
    id text NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    dni text NOT NULL,
    "fechaNacimiento" timestamp(3) without time zone NOT NULL,
    telefono text NOT NULL,
    email text,
    direccion text NOT NULL,
    "contactoEmergencia" text NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE centro_rehab."Paciente" OWNER TO postgres;

--
-- Name: PacienteObraSocial; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."PacienteObraSocial" (
    id text NOT NULL,
    "pacienteId" text NOT NULL,
    "obraSocialId" text NOT NULL,
    "numeroAfiliado" text NOT NULL,
    observaciones text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE centro_rehab."PacienteObraSocial" OWNER TO postgres;

--
-- Name: PagoMensualGimnasio; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."PagoMensualGimnasio" (
    id text NOT NULL,
    "pacienteId" text NOT NULL,
    "yearMonth" text NOT NULL,
    importe integer DEFAULT 0 NOT NULL,
    cobrado boolean DEFAULT false NOT NULL,
    "cobradoAt" timestamp(3) without time zone,
    "cobradoPorId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "formaPago" centro_rehab."FormaPago"
);


ALTER TABLE centro_rehab."PagoMensualGimnasio" OWNER TO postgres;

--
-- Name: Role; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."Role" (
    id text NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE centro_rehab."Role" OWNER TO postgres;

--
-- Name: Seguimiento; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."Seguimiento" (
    id text NOT NULL,
    "pacienteId" text NOT NULL,
    "profesionalId" text NOT NULL,
    fecha timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    tipo centro_rehab."SeguimientoTipo" NOT NULL,
    texto text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE centro_rehab."Seguimiento" OWNER TO postgres;

--
-- Name: Turno; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."Turno" (
    id text NOT NULL,
    "pacienteId" text NOT NULL,
    "especialidadId" text NOT NULL,
    "profesionalId" text,
    "startAt" timestamp(3) without time zone NOT NULL,
    "endAt" timestamp(3) without time zone NOT NULL,
    estado centro_rehab."TurnoEstado" DEFAULT 'RESERVADO'::centro_rehab."TurnoEstado" NOT NULL,
    notas text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    cobrado boolean DEFAULT false NOT NULL,
    "cobradoAt" timestamp(3) without time zone,
    "cobradoPorId" text,
    "importeCoseguro" integer DEFAULT 0 NOT NULL,
    "ordenKinesiologiaId" text,
    "sesionNro" integer
);


ALTER TABLE centro_rehab."Turno" OWNER TO postgres;

--
-- Name: TurnoHistorial; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."TurnoHistorial" (
    id text NOT NULL,
    "turnoId" text NOT NULL,
    "estadoAnterior" centro_rehab."TurnoEstado",
    "estadoNuevo" centro_rehab."TurnoEstado" NOT NULL,
    "usuarioId" text NOT NULL,
    fecha timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE centro_rehab."TurnoHistorial" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab."User" (
    id text NOT NULL,
    email text NOT NULL,
    "passwordHash" text NOT NULL,
    nombre text NOT NULL,
    "roleId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE centro_rehab."User" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: centro_rehab; Owner: postgres
--

CREATE TABLE centro_rehab._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE centro_rehab._prisma_migrations OWNER TO postgres;

--
-- Name: cajas; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.cajas (
    id integer NOT NULL,
    fecha_apertura timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_cierre timestamp without time zone,
    saldo_inicial numeric(10,2) DEFAULT 0,
    saldo_final numeric(10,2),
    estado character varying(20) DEFAULT 'abierta'::character varying,
    usuario_apertura_id integer,
    usuario_cierre_id integer,
    observaciones text
);


ALTER TABLE complejo_deportivo.cajas OWNER TO postgres;

--
-- Name: cajas_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.cajas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.cajas_id_seq OWNER TO postgres;

--
-- Name: cajas_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.cajas_id_seq OWNED BY complejo_deportivo.cajas.id;


--
-- Name: canchas; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.canchas (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo character varying(50) NOT NULL
);


ALTER TABLE complejo_deportivo.canchas OWNER TO postgres;

--
-- Name: canchas_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.canchas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.canchas_id_seq OWNER TO postgres;

--
-- Name: canchas_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.canchas_id_seq OWNED BY complejo_deportivo.canchas.id;


--
-- Name: categorias; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.categorias (
    id integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE complejo_deportivo.categorias OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.categorias_id_seq OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.categorias_id_seq OWNED BY complejo_deportivo.categorias.id;


--
-- Name: compras; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.compras (
    id integer NOT NULL,
    proveedor_id integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total numeric(10,2) DEFAULT 0,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying,
    observaciones text
);


ALTER TABLE complejo_deportivo.compras OWNER TO postgres;

--
-- Name: compras_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.compras_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.compras_id_seq OWNER TO postgres;

--
-- Name: compras_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.compras_id_seq OWNED BY complejo_deportivo.compras.id;


--
-- Name: configuracion; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.configuracion (
    clave character varying(50) NOT NULL,
    valor character varying(255) NOT NULL
);


ALTER TABLE complejo_deportivo.configuracion OWNER TO postgres;

--
-- Name: detalle_compra; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.detalle_compra (
    id integer NOT NULL,
    compra_id integer,
    producto_id integer,
    cantidad integer NOT NULL,
    costo_unitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL
);


ALTER TABLE complejo_deportivo.detalle_compra OWNER TO postgres;

--
-- Name: detalle_compra_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.detalle_compra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.detalle_compra_id_seq OWNER TO postgres;

--
-- Name: detalle_compra_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.detalle_compra_id_seq OWNED BY complejo_deportivo.detalle_compra.id;


--
-- Name: detalle_venta_cantina; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.detalle_venta_cantina (
    id integer NOT NULL,
    venta_id integer NOT NULL,
    producto_id integer NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2) NOT NULL
);


ALTER TABLE complejo_deportivo.detalle_venta_cantina OWNER TO postgres;

--
-- Name: detalle_venta_cantina_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.detalle_venta_cantina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.detalle_venta_cantina_id_seq OWNER TO postgres;

--
-- Name: detalle_venta_cantina_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.detalle_venta_cantina_id_seq OWNED BY complejo_deportivo.detalle_venta_cantina.id;


--
-- Name: detalle_ventas; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.detalle_ventas (
    id integer NOT NULL,
    venta_id integer,
    producto_id integer,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL
);


ALTER TABLE complejo_deportivo.detalle_ventas OWNER TO postgres;

--
-- Name: detalle_ventas_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.detalle_ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.detalle_ventas_id_seq OWNER TO postgres;

--
-- Name: detalle_ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.detalle_ventas_id_seq OWNED BY complejo_deportivo.detalle_ventas.id;


--
-- Name: gastos; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.gastos (
    id integer NOT NULL,
    descripcion text NOT NULL,
    monto numeric(10,2) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    caja_id integer,
    usuario_id integer
);


ALTER TABLE complejo_deportivo.gastos OWNER TO postgres;

--
-- Name: gastos_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.gastos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.gastos_id_seq OWNER TO postgres;

--
-- Name: gastos_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.gastos_id_seq OWNED BY complejo_deportivo.gastos.id;


--
-- Name: inscripciones; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.inscripciones (
    id integer NOT NULL,
    torneo_id integer NOT NULL,
    jugador_id integer NOT NULL,
    fecha_inscripcion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    pagado boolean DEFAULT false,
    monto_abonado numeric(10,2) DEFAULT 0,
    fecha_pago timestamp without time zone,
    metodo_pago character varying(50),
    caja_id integer
);


ALTER TABLE complejo_deportivo.inscripciones OWNER TO postgres;

--
-- Name: inscripciones_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.inscripciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.inscripciones_id_seq OWNER TO postgres;

--
-- Name: inscripciones_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.inscripciones_id_seq OWNED BY complejo_deportivo.inscripciones.id;


--
-- Name: jugadores; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.jugadores (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    telefono character varying(50),
    email character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    categoria_id integer
);


ALTER TABLE complejo_deportivo.jugadores OWNER TO postgres;

--
-- Name: jugadores_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.jugadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.jugadores_id_seq OWNER TO postgres;

--
-- Name: jugadores_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.jugadores_id_seq OWNED BY complejo_deportivo.jugadores.id;


--
-- Name: movimientos_cuenta; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.movimientos_cuenta (
    id integer NOT NULL,
    jugador_id integer,
    tipo character varying(10) NOT NULL,
    monto numeric(10,2) NOT NULL,
    descripcion text,
    referencia_id integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    caja_id integer,
    CONSTRAINT movimientos_cuenta_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['DEBE'::character varying, 'HABER'::character varying])::text[])))
);


ALTER TABLE complejo_deportivo.movimientos_cuenta OWNER TO postgres;

--
-- Name: movimientos_cuenta_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.movimientos_cuenta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.movimientos_cuenta_id_seq OWNER TO postgres;

--
-- Name: movimientos_cuenta_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.movimientos_cuenta_id_seq OWNED BY complejo_deportivo.movimientos_cuenta.id;


--
-- Name: movimientos_proveedor; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.movimientos_proveedor (
    id integer NOT NULL,
    proveedor_id integer,
    tipo character varying(10) NOT NULL,
    monto numeric(10,2) NOT NULL,
    descripcion text,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT movimientos_proveedor_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['DEBE'::character varying, 'HABER'::character varying])::text[])))
);


ALTER TABLE complejo_deportivo.movimientos_proveedor OWNER TO postgres;

--
-- Name: movimientos_proveedor_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.movimientos_proveedor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.movimientos_proveedor_id_seq OWNER TO postgres;

--
-- Name: movimientos_proveedor_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.movimientos_proveedor_id_seq OWNED BY complejo_deportivo.movimientos_proveedor.id;


--
-- Name: pagos; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.pagos (
    id integer NOT NULL,
    turno_id integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    metodo character varying(50) NOT NULL,
    fecha_pago timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    caja_id integer
);


ALTER TABLE complejo_deportivo.pagos OWNER TO postgres;

--
-- Name: pagos_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.pagos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.pagos_id_seq OWNER TO postgres;

--
-- Name: pagos_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.pagos_id_seq OWNED BY complejo_deportivo.pagos.id;


--
-- Name: productos; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.productos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    categoria character varying(50),
    precio numeric(10,2) NOT NULL,
    stock integer DEFAULT 0,
    stock_minimo integer DEFAULT 0,
    precio_venta numeric(10,2),
    costo numeric(10,2),
    proveedor_id integer,
    estado character varying(20) DEFAULT 'ACTIVO'::character varying,
    codigo_barra character varying(100)
);


ALTER TABLE complejo_deportivo.productos OWNER TO postgres;

--
-- Name: productos_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.productos_id_seq OWNER TO postgres;

--
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.productos_id_seq OWNED BY complejo_deportivo.productos.id;


--
-- Name: proveedores; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.proveedores (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    contacto character varying(100),
    telefono character varying(50),
    email character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE complejo_deportivo.proveedores OWNER TO postgres;

--
-- Name: proveedores_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.proveedores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.proveedores_id_seq OWNER TO postgres;

--
-- Name: proveedores_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.proveedores_id_seq OWNED BY complejo_deportivo.proveedores.id;


--
-- Name: reservas_fijas; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.reservas_fijas (
    id integer NOT NULL,
    cancha_id integer NOT NULL,
    dia_semana integer NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    cliente_nombre character varying(100) NOT NULL,
    cliente_telefono character varying(50),
    monto_total numeric(10,2) DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reservas_fijas_dia_semana_check CHECK (((dia_semana >= 0) AND (dia_semana <= 6)))
);


ALTER TABLE complejo_deportivo.reservas_fijas OWNER TO postgres;

--
-- Name: reservas_fijas_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.reservas_fijas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.reservas_fijas_id_seq OWNER TO postgres;

--
-- Name: reservas_fijas_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.reservas_fijas_id_seq OWNED BY complejo_deportivo.reservas_fijas.id;


--
-- Name: torneos; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.torneos (
    id integer NOT NULL,
    descripcion character varying(255) NOT NULL,
    fecha_inicio date NOT NULL,
    costo_inscripcion numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE complejo_deportivo.torneos OWNER TO postgres;

--
-- Name: torneos_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.torneos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.torneos_id_seq OWNER TO postgres;

--
-- Name: torneos_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.torneos_id_seq OWNED BY complejo_deportivo.torneos.id;


--
-- Name: turnos; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.turnos (
    id integer NOT NULL,
    cancha_id integer NOT NULL,
    fecha date NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    cliente_nombre character varying(100) NOT NULL,
    cliente_telefono character varying(50),
    estado character varying(20) DEFAULT 'reservado'::character varying,
    pagado boolean DEFAULT false,
    monto_total numeric(10,2) DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT turnos_estado_check CHECK (((estado)::text = ANY ((ARRAY['reservado'::character varying, 'confirmado'::character varying, 'cancelado'::character varying, 'jugado'::character varying])::text[])))
);


ALTER TABLE complejo_deportivo.turnos OWNER TO postgres;

--
-- Name: turnos_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.turnos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.turnos_id_seq OWNER TO postgres;

--
-- Name: turnos_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.turnos_id_seq OWNED BY complejo_deportivo.turnos.id;


--
-- Name: usuarios; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.usuarios (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    nombre character varying(100) NOT NULL,
    rol character varying(20) DEFAULT 'user'::character varying
);


ALTER TABLE complejo_deportivo.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.usuarios_id_seq OWNED BY complejo_deportivo.usuarios.id;


--
-- Name: ventas; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.ventas (
    id integer NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total numeric(10,2) NOT NULL
);


ALTER TABLE complejo_deportivo.ventas OWNER TO postgres;

--
-- Name: ventas_cantina; Type: TABLE; Schema: complejo_deportivo; Owner: postgres
--

CREATE TABLE complejo_deportivo.ventas_cantina (
    id integer NOT NULL,
    turno_id integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total numeric(10,2) NOT NULL,
    metodo_pago character varying(50),
    caja_id integer
);


ALTER TABLE complejo_deportivo.ventas_cantina OWNER TO postgres;

--
-- Name: ventas_cantina_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.ventas_cantina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.ventas_cantina_id_seq OWNER TO postgres;

--
-- Name: ventas_cantina_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.ventas_cantina_id_seq OWNED BY complejo_deportivo.ventas_cantina.id;


--
-- Name: ventas_id_seq; Type: SEQUENCE; Schema: complejo_deportivo; Owner: postgres
--

CREATE SEQUENCE complejo_deportivo.ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE complejo_deportivo.ventas_id_seq OWNER TO postgres;

--
-- Name: ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: complejo_deportivo; Owner: postgres
--

ALTER SEQUENCE complejo_deportivo.ventas_id_seq OWNED BY complejo_deportivo.ventas.id;


--
-- Name: brackets; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.brackets (
    id integer NOT NULL,
    tournament_category_id integer NOT NULL,
    status padel_circuit.enum_brackets_status DEFAULT 'draft'::padel_circuit.enum_brackets_status,
    generado_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.brackets OWNER TO postgres;

--
-- Name: brackets_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.brackets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.brackets_id_seq OWNER TO postgres;

--
-- Name: brackets_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.brackets_id_seq OWNED BY padel_circuit.brackets.id;


--
-- Name: categories; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.categories (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    rank integer NOT NULL,
    active boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.categories_id_seq OWNED BY padel_circuit.categories.id;


--
-- Name: matches; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.matches (
    id integer NOT NULL,
    bracket_id integer NOT NULL,
    round_number integer NOT NULL,
    round_name character varying(50) NOT NULL,
    match_number integer NOT NULL,
    team_home_id integer,
    team_away_id integer,
    winner_team_id integer,
    score_json jsonb,
    status padel_circuit.enum_matches_status DEFAULT 'pending'::padel_circuit.enum_matches_status,
    next_match_id integer,
    next_match_slot padel_circuit.enum_matches_next_match_slot,
    scheduled_at timestamp with time zone,
    home_source_zone_id integer,
    home_source_position integer,
    away_source_zone_id integer,
    away_source_position integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    venue character varying(200)
);


ALTER TABLE padel_circuit.matches OWNER TO postgres;

--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.matches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.matches_id_seq OWNER TO postgres;

--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.matches_id_seq OWNED BY padel_circuit.matches.id;


--
-- Name: player_profiles; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.player_profiles (
    dni character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    telefono character varying(20),
    categoria_base_id integer NOT NULL,
    activo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.player_profiles OWNER TO postgres;

--
-- Name: registrations; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.registrations (
    id integer NOT NULL,
    tournament_category_id integer NOT NULL,
    team_id integer NOT NULL,
    estado padel_circuit.enum_registrations_estado DEFAULT 'inscripto'::padel_circuit.enum_registrations_estado,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.registrations OWNER TO postgres;

--
-- Name: registrations_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.registrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.registrations_id_seq OWNER TO postgres;

--
-- Name: registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.registrations_id_seq OWNED BY padel_circuit.registrations.id;


--
-- Name: teams; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.teams (
    id integer NOT NULL,
    player1_dni character varying(20) NOT NULL,
    player2_dni character varying(20) NOT NULL,
    estado padel_circuit.enum_teams_estado DEFAULT 'activa'::padel_circuit.enum_teams_estado,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.teams OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.teams_id_seq OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.teams_id_seq OWNED BY padel_circuit.teams.id;


--
-- Name: tournament_categories; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.tournament_categories (
    id integer NOT NULL,
    tournament_id integer NOT NULL,
    category_id integer NOT NULL,
    cupo integer,
    inscripcion_abierta boolean DEFAULT true,
    match_format padel_circuit.enum_tournament_categories_match_format DEFAULT 'BEST_OF_3_SUPER_TB'::padel_circuit.enum_tournament_categories_match_format,
    super_tiebreak_points integer DEFAULT 10,
    tiebreak_in_sets boolean DEFAULT true,
    win_points integer DEFAULT 2,
    loss_points integer DEFAULT 0,
    zone_size integer,
    qualifiers_per_zone integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    estado character varying(50) DEFAULT 'draft'::character varying
);


ALTER TABLE padel_circuit.tournament_categories OWNER TO postgres;

--
-- Name: tournament_categories_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.tournament_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.tournament_categories_id_seq OWNER TO postgres;

--
-- Name: tournament_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.tournament_categories_id_seq OWNED BY padel_circuit.tournament_categories.id;


--
-- Name: tournament_points; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.tournament_points (
    id integer NOT NULL,
    tournament_category_id integer NOT NULL,
    player_dni character varying(20) NOT NULL,
    team_id integer NOT NULL,
    points integer DEFAULT 0 NOT NULL,
    "position" character varying(50) NOT NULL,
    awarded_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE padel_circuit.tournament_points OWNER TO postgres;

--
-- Name: tournament_points_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.tournament_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.tournament_points_id_seq OWNER TO postgres;

--
-- Name: tournament_points_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.tournament_points_id_seq OWNED BY padel_circuit.tournament_points.id;


--
-- Name: tournaments; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.tournaments (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    fecha_inicio timestamp with time zone,
    fecha_fin timestamp with time zone,
    estado padel_circuit.enum_tournaments_estado DEFAULT 'draft'::padel_circuit.enum_tournaments_estado,
    descripcion text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    double_points boolean DEFAULT false NOT NULL
);


ALTER TABLE padel_circuit.tournaments OWNER TO postgres;

--
-- Name: tournaments_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.tournaments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.tournaments_id_seq OWNER TO postgres;

--
-- Name: tournaments_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.tournaments_id_seq OWNED BY padel_circuit.tournaments.id;


--
-- Name: users; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.users (
    id integer NOT NULL,
    dni character varying(20) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role padel_circuit.enum_users_role DEFAULT 'player'::padel_circuit.enum_users_role NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.users_id_seq OWNED BY padel_circuit.users.id;


--
-- Name: venues; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.venues (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    address character varying(300),
    courts_count integer DEFAULT 1,
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE padel_circuit.venues OWNER TO postgres;

--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.venues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.venues_id_seq OWNER TO postgres;

--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.venues_id_seq OWNED BY padel_circuit.venues.id;


--
-- Name: zone_matches; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.zone_matches (
    id integer NOT NULL,
    zone_id integer NOT NULL,
    round_number integer NOT NULL,
    match_number integer NOT NULL,
    team_home_id integer NOT NULL,
    team_away_id integer NOT NULL,
    status padel_circuit.enum_zone_matches_status DEFAULT 'pending'::padel_circuit.enum_zone_matches_status,
    score_json jsonb,
    winner_team_id integer,
    played_at timestamp with time zone,
    scheduled_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    venue character varying(200)
);


ALTER TABLE padel_circuit.zone_matches OWNER TO postgres;

--
-- Name: zone_matches_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.zone_matches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.zone_matches_id_seq OWNER TO postgres;

--
-- Name: zone_matches_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.zone_matches_id_seq OWNED BY padel_circuit.zone_matches.id;


--
-- Name: zone_standings; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.zone_standings (
    id integer NOT NULL,
    zone_id integer NOT NULL,
    team_id integer NOT NULL,
    played integer DEFAULT 0,
    wins integer DEFAULT 0,
    losses integer DEFAULT 0,
    points integer DEFAULT 0,
    sets_for integer DEFAULT 0,
    sets_against integer DEFAULT 0,
    sets_diff integer DEFAULT 0,
    games_for integer DEFAULT 0,
    games_against integer DEFAULT 0,
    games_diff integer DEFAULT 0,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.zone_standings OWNER TO postgres;

--
-- Name: zone_standings_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.zone_standings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.zone_standings_id_seq OWNER TO postgres;

--
-- Name: zone_standings_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.zone_standings_id_seq OWNED BY padel_circuit.zone_standings.id;


--
-- Name: zone_teams; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.zone_teams (
    id integer NOT NULL,
    zone_id integer NOT NULL,
    team_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.zone_teams OWNER TO postgres;

--
-- Name: zone_teams_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.zone_teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.zone_teams_id_seq OWNER TO postgres;

--
-- Name: zone_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.zone_teams_id_seq OWNED BY padel_circuit.zone_teams.id;


--
-- Name: zones; Type: TABLE; Schema: padel_circuit; Owner: postgres
--

CREATE TABLE padel_circuit.zones (
    id integer NOT NULL,
    tournament_category_id integer NOT NULL,
    name character varying(50) NOT NULL,
    order_index integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE padel_circuit.zones OWNER TO postgres;

--
-- Name: zones_id_seq; Type: SEQUENCE; Schema: padel_circuit; Owner: postgres
--

CREATE SEQUENCE padel_circuit.zones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE padel_circuit.zones_id_seq OWNER TO postgres;

--
-- Name: zones_id_seq; Type: SEQUENCE OWNED BY; Schema: padel_circuit; Owner: postgres
--

ALTER SEQUENCE padel_circuit.zones_id_seq OWNED BY padel_circuit.zones.id;


--
-- Name: actividades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actividades (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    destino_id integer NOT NULL,
    duracion_horas numeric(5,2),
    precio numeric(10,2),
    capacidad_maxima integer,
    fecha_hora_inicio timestamp with time zone,
    activo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.actividades OWNER TO postgres;

--
-- Name: actividades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actividades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actividades_id_seq OWNER TO postgres;

--
-- Name: actividades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actividades_id_seq OWNED BY public.actividades.id;


--
-- Name: alojamientos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alojamientos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    destino_id integer NOT NULL,
    tipo character varying(50),
    direccion character varying(255),
    telefono character varying(20),
    email character varying(100),
    precio_noche numeric(10,2),
    capacidad_personas integer,
    activo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.alojamientos OWNER TO postgres;

--
-- Name: alojamientos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alojamientos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alojamientos_id_seq OWNER TO postgres;

--
-- Name: alojamientos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alojamientos_id_seq OWNED BY public.alojamientos.id;


--
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_id_seq OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;


--
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    apellido character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    telefono character varying(20),
    direccion character varying(255),
    dni character varying(20) NOT NULL,
    fecha_nacimiento date,
    activo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_seq OWNER TO postgres;

--
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- Name: cuentas_corrientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuentas_corrientes (
    id integer NOT NULL,
    reserva_id integer NOT NULL,
    cliente_id integer NOT NULL,
    monto_total numeric(12,2) NOT NULL,
    saldo_pendiente numeric(12,2) DEFAULT 0 NOT NULL,
    cantidad_cuotas integer NOT NULL,
    estado character varying(20) DEFAULT 'pendiente'::character varying NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone,
    deleted_at timestamp with time zone,
    CONSTRAINT cuentas_corrientes_estado_check CHECK (((estado)::text = ANY ((ARRAY['pendiente'::character varying, 'en_proceso'::character varying, 'pagado'::character varying, 'atrasado'::character varying, 'cancelado'::character varying])::text[])))
);


ALTER TABLE public.cuentas_corrientes OWNER TO postgres;

--
-- Name: cuentas_corrientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuentas_corrientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuentas_corrientes_id_seq OWNER TO postgres;

--
-- Name: cuentas_corrientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuentas_corrientes_id_seq OWNED BY public.cuentas_corrientes.id;


--
-- Name: cuotas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuotas (
    id integer NOT NULL,
    cuenta_corriente_id integer NOT NULL,
    numero_cuota integer NOT NULL,
    monto numeric(12,2) NOT NULL,
    fecha_vencimiento date NOT NULL,
    fecha_pago timestamp with time zone,
    monto_pagado numeric(12,2) DEFAULT 0,
    estado public.enum_cuotas_estado DEFAULT 'pendiente'::public.enum_cuotas_estado NOT NULL,
    metodo_pago character varying(255),
    observaciones text,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    fecha_actualizacion timestamp with time zone
);


ALTER TABLE public.cuotas OWNER TO postgres;

--
-- Name: cuotas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuotas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuotas_id_seq OWNER TO postgres;

--
-- Name: cuotas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuotas_id_seq OWNED BY public.cuotas.id;


--
-- Name: destinos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.destinos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    ubicacion character varying(255) NOT NULL,
    categoria_id integer,
    imagen_url character varying(255),
    precio_promedio numeric(10,2),
    activo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.destinos OWNER TO postgres;

--
-- Name: destinos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.destinos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.destinos_id_seq OWNER TO postgres;

--
-- Name: destinos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.destinos_id_seq OWNED BY public.destinos.id;


--
-- Name: inscripciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscripciones (
    id integer NOT NULL,
    torneo_id integer NOT NULL,
    jugador_id integer NOT NULL,
    fecha_inscripcion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    pagado boolean DEFAULT false,
    monto_abonado numeric(10,2) DEFAULT 0,
    fecha_pago timestamp without time zone,
    metodo_pago character varying(50)
);


ALTER TABLE public.inscripciones OWNER TO postgres;

--
-- Name: inscripciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inscripciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inscripciones_id_seq OWNER TO postgres;

--
-- Name: inscripciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscripciones_id_seq OWNED BY public.inscripciones.id;


--
-- Name: movimientos_cuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movimientos_cuenta (
    id integer NOT NULL,
    jugador_id integer,
    tipo character varying(10) NOT NULL,
    monto numeric(10,2) NOT NULL,
    descripcion text,
    referencia_id integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT movimientos_cuenta_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['DEBE'::character varying, 'HABER'::character varying])::text[])))
);


ALTER TABLE public.movimientos_cuenta OWNER TO postgres;

--
-- Name: movimientos_cuenta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movimientos_cuenta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movimientos_cuenta_id_seq OWNER TO postgres;

--
-- Name: movimientos_cuenta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movimientos_cuenta_id_seq OWNED BY public.movimientos_cuenta.id;


--
-- Name: pagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagos (
    id integer NOT NULL,
    correlativo integer NOT NULL,
    numero_comprobante character varying(20) NOT NULL,
    cuenta_corriente_id integer NOT NULL,
    cuota_id integer NOT NULL,
    cliente_id integer NOT NULL,
    usuario_id integer,
    monto numeric(12,2) NOT NULL,
    metodo_pago public.enum_pagos_metodo_pago NOT NULL,
    fecha_pago timestamp with time zone NOT NULL,
    observaciones text,
    extra jsonb,
    fecha_creacion timestamp with time zone NOT NULL,
    fecha_actualizacion timestamp with time zone
);


ALTER TABLE public.pagos OWNER TO postgres;

--
-- Name: pagos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_id_seq OWNER TO postgres;

--
-- Name: pagos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagos_id_seq OWNED BY public.pagos.id;


--
-- Name: proveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedores (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    contacto character varying(100),
    telefono character varying(50),
    email character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.proveedores OWNER TO postgres;

--
-- Name: proveedores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proveedores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proveedores_id_seq OWNER TO postgres;

--
-- Name: proveedores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proveedores_id_seq OWNED BY public.proveedores.id;


--
-- Name: resenas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resenas (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    destino_id integer,
    alojamiento_id integer,
    actividad_id integer,
    calificacion integer NOT NULL,
    comentario text,
    fecha_creacion timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.resenas OWNER TO postgres;

--
-- Name: resenas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resenas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resenas_id_seq OWNER TO postgres;

--
-- Name: resenas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resenas_id_seq OWNED BY public.resenas.id;


--
-- Name: reserva_clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reserva_clientes (
    id integer NOT NULL,
    reserva_id integer NOT NULL,
    cliente_id integer NOT NULL,
    tipo_cliente character varying(255) DEFAULT 'titular'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.reserva_clientes OWNER TO postgres;

--
-- Name: COLUMN reserva_clientes.tipo_cliente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reserva_clientes.tipo_cliente IS 'Tipo de cliente en la reserva (ej: titular, acompañante)';


--
-- Name: reserva_clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reserva_clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reserva_clientes_id_seq OWNER TO postgres;

--
-- Name: reserva_clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reserva_clientes_id_seq OWNED BY public.reserva_clientes.id;


--
-- Name: reservas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservas (
    id integer NOT NULL,
    codigo character varying(255) NOT NULL,
    tour_id integer,
    fecha_reserva date NOT NULL,
    cantidad_personas integer DEFAULT 1 NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    estado public.enum_reservas_estado DEFAULT 'pendiente'::public.enum_reservas_estado NOT NULL,
    notas text,
    activo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    referencia character varying(255),
    descripcion text,
    tour_nombre character varying(255),
    tour_destino character varying(255),
    tour_descripcion text,
    fecha_inicio date,
    fecha_fin date,
    moneda_precio_unitario character varying(3) DEFAULT 'ARS'::character varying NOT NULL
);


ALTER TABLE public.reservas OWNER TO postgres;

--
-- Name: COLUMN reservas.tour_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reservas.tour_id IS 'Opcional: ID del tour asociado a la reserva';


--
-- Name: COLUMN reservas.referencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reservas.referencia IS 'Código o referencia de la reserva';


--
-- Name: COLUMN reservas.descripcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reservas.descripcion IS 'Detalles adicionales del viaje';


--
-- Name: COLUMN reservas.tour_nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reservas.tour_nombre IS 'Nombre del tour personalizado';


--
-- Name: COLUMN reservas.tour_destino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reservas.tour_destino IS 'Destino del tour personalizado';


--
-- Name: COLUMN reservas.tour_descripcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reservas.tour_descripcion IS 'Descripción detallada del tour personalizado';


--
-- Name: COLUMN reservas.fecha_inicio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reservas.fecha_inicio IS 'Fecha de inicio del tour personalizado';


--
-- Name: COLUMN reservas.fecha_fin; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reservas.fecha_fin IS 'Fecha de finalización del tour personalizado';


--
-- Name: reservas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservas_id_seq OWNER TO postgres;

--
-- Name: reservas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservas_id_seq OWNED BY public.reservas.id;


--
-- Name: sequelize_meta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sequelize_meta (
    name character varying(255) NOT NULL
);


ALTER TABLE public.sequelize_meta OWNER TO postgres;

--
-- Name: tours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tours (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion text DEFAULT ''::text,
    destino character varying(255) NOT NULL,
    fecha_inicio timestamp with time zone,
    fecha_fin timestamp with time zone,
    precio numeric(10,2) DEFAULT 0,
    cupo_maximo integer DEFAULT 10,
    cupos_disponibles integer DEFAULT 10 NOT NULL,
    estado public.enum_tours_estado DEFAULT 'disponible'::public.enum_tours_estado,
    imagen_url character varying(255),
    activo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.tours OWNER TO postgres;

--
-- Name: tours_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tours_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tours_id_seq OWNER TO postgres;

--
-- Name: tours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tours_id_seq OWNED BY public.tours.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role public.enum_usuarios_role DEFAULT 'USER'::public.enum_usuarios_role NOT NULL,
    active boolean DEFAULT true,
    last_login timestamp with time zone,
    reset_password_token character varying(255),
    reset_password_expire timestamp with time zone,
    email_verified boolean DEFAULT false,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: cajas id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.cajas ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.cajas_id_seq'::regclass);


--
-- Name: canchas id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.canchas ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.canchas_id_seq'::regclass);


--
-- Name: categorias id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.categorias ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.categorias_id_seq'::regclass);


--
-- Name: compras id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.compras ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.compras_id_seq'::regclass);


--
-- Name: detalle_compra id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_compra ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.detalle_compra_id_seq'::regclass);


--
-- Name: detalle_venta_cantina id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_venta_cantina ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.detalle_venta_cantina_id_seq'::regclass);


--
-- Name: detalle_ventas id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_ventas ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.detalle_ventas_id_seq'::regclass);


--
-- Name: gastos id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.gastos ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.gastos_id_seq'::regclass);


--
-- Name: inscripciones id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.inscripciones ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.inscripciones_id_seq'::regclass);


--
-- Name: jugadores id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.jugadores ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.jugadores_id_seq'::regclass);


--
-- Name: movimientos_cuenta id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.movimientos_cuenta ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.movimientos_cuenta_id_seq'::regclass);


--
-- Name: movimientos_proveedor id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.movimientos_proveedor ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.movimientos_proveedor_id_seq'::regclass);


--
-- Name: pagos id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.pagos ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.pagos_id_seq'::regclass);


--
-- Name: productos id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.productos ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.productos_id_seq'::regclass);


--
-- Name: proveedores id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.proveedores ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.proveedores_id_seq'::regclass);


--
-- Name: reservas_fijas id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.reservas_fijas ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.reservas_fijas_id_seq'::regclass);


--
-- Name: torneos id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.torneos ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.torneos_id_seq'::regclass);


--
-- Name: turnos id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.turnos ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.turnos_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.usuarios ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.usuarios_id_seq'::regclass);


--
-- Name: ventas id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.ventas ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.ventas_id_seq'::regclass);


--
-- Name: ventas_cantina id; Type: DEFAULT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.ventas_cantina ALTER COLUMN id SET DEFAULT nextval('complejo_deportivo.ventas_cantina_id_seq'::regclass);


--
-- Name: brackets id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.brackets ALTER COLUMN id SET DEFAULT nextval('padel_circuit.brackets_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.categories ALTER COLUMN id SET DEFAULT nextval('padel_circuit.categories_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches ALTER COLUMN id SET DEFAULT nextval('padel_circuit.matches_id_seq'::regclass);


--
-- Name: registrations id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.registrations ALTER COLUMN id SET DEFAULT nextval('padel_circuit.registrations_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.teams ALTER COLUMN id SET DEFAULT nextval('padel_circuit.teams_id_seq'::regclass);


--
-- Name: tournament_categories id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_categories ALTER COLUMN id SET DEFAULT nextval('padel_circuit.tournament_categories_id_seq'::regclass);


--
-- Name: tournament_points id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points ALTER COLUMN id SET DEFAULT nextval('padel_circuit.tournament_points_id_seq'::regclass);


--
-- Name: tournaments id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournaments ALTER COLUMN id SET DEFAULT nextval('padel_circuit.tournaments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.users ALTER COLUMN id SET DEFAULT nextval('padel_circuit.users_id_seq'::regclass);


--
-- Name: venues id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.venues ALTER COLUMN id SET DEFAULT nextval('padel_circuit.venues_id_seq'::regclass);


--
-- Name: zone_matches id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches ALTER COLUMN id SET DEFAULT nextval('padel_circuit.zone_matches_id_seq'::regclass);


--
-- Name: zone_standings id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_standings ALTER COLUMN id SET DEFAULT nextval('padel_circuit.zone_standings_id_seq'::regclass);


--
-- Name: zone_teams id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_teams ALTER COLUMN id SET DEFAULT nextval('padel_circuit.zone_teams_id_seq'::regclass);


--
-- Name: zones id; Type: DEFAULT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zones ALTER COLUMN id SET DEFAULT nextval('padel_circuit.zones_id_seq'::regclass);


--
-- Name: actividades id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividades ALTER COLUMN id SET DEFAULT nextval('public.actividades_id_seq'::regclass);


--
-- Name: alojamientos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alojamientos ALTER COLUMN id SET DEFAULT nextval('public.alojamientos_id_seq'::regclass);


--
-- Name: categorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- Name: cuentas_corrientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas_corrientes ALTER COLUMN id SET DEFAULT nextval('public.cuentas_corrientes_id_seq'::regclass);


--
-- Name: cuotas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuotas ALTER COLUMN id SET DEFAULT nextval('public.cuotas_id_seq'::regclass);


--
-- Name: destinos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destinos ALTER COLUMN id SET DEFAULT nextval('public.destinos_id_seq'::regclass);


--
-- Name: inscripciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones ALTER COLUMN id SET DEFAULT nextval('public.inscripciones_id_seq'::regclass);


--
-- Name: movimientos_cuenta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_cuenta ALTER COLUMN id SET DEFAULT nextval('public.movimientos_cuenta_id_seq'::regclass);


--
-- Name: pagos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos ALTER COLUMN id SET DEFAULT nextval('public.pagos_id_seq'::regclass);


--
-- Name: proveedores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores ALTER COLUMN id SET DEFAULT nextval('public.proveedores_id_seq'::regclass);


--
-- Name: resenas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas ALTER COLUMN id SET DEFAULT nextval('public.resenas_id_seq'::regclass);


--
-- Name: reserva_clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva_clientes ALTER COLUMN id SET DEFAULT nextval('public.reserva_clientes_id_seq'::regclass);


--
-- Name: reservas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas ALTER COLUMN id SET DEFAULT nextval('public.reservas_id_seq'::regclass);


--
-- Name: tours id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tours ALTER COLUMN id SET DEFAULT nextval('public.tours_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: Auditoria; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--



--
-- Data for Name: ConfiguracionCoseguros; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab."ConfiguracionCoseguros" (id, coseguro1, coseguro2, "createdAt", "updatedAt") VALUES ('default', 3000, 5000, '2026-01-11 15:38:51.299', '2026-01-11 15:39:00.351');


--
-- Data for Name: Especialidad; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab."Especialidad" (id, nombre, "duracionTurnoMin", activa, "createdAt", "updatedAt") VALUES ('cmk32k3fw0005tmygvekcqxdl', 'Kinesiología', 30, true, '2026-01-06 20:55:52.173', '2026-01-08 13:34:46.739');
INSERT INTO centro_rehab."Especialidad" (id, nombre, "duracionTurnoMin", activa, "createdAt", "updatedAt") VALUES ('cmk32k3g00006tmygj76yxs56', 'Gimnasio', 60, true, '2026-01-06 20:55:52.176', '2026-01-11 16:47:58.304');


--
-- Data for Name: ObraSocial; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojx10007tmwwfzarne5j', 'OSDE', '210', NULL, '2026-01-08 13:34:46.741', '2026-01-08 13:34:46.741', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojx40008tmwwbfge8r38', 'OSDE', '310', NULL, '2026-01-08 13:34:46.745', '2026-01-08 13:34:46.745', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojx50009tmwwfnrz8uyu', 'OSDE', '410', NULL, '2026-01-08 13:34:46.746', '2026-01-08 13:34:46.746', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojx6000atmww6ep1aolv', 'Swiss Medical', 'SMG20', NULL, '2026-01-08 13:34:46.746', '2026-01-08 13:34:46.746', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojx7000btmwwijcxfmg7', 'Swiss Medical', 'SMG30', NULL, '2026-01-08 13:34:46.747', '2026-01-08 13:34:46.747', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojx7000ctmww21l72v7g', 'Swiss Medical', 'SMG40', NULL, '2026-01-08 13:34:46.748', '2026-01-08 13:34:46.748', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojx9000dtmww8rzl670i', 'Galeno', '220', NULL, '2026-01-08 13:34:46.749', '2026-01-08 13:34:46.749', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojx9000etmwwqzsslp3o', 'Galeno', '330', NULL, '2026-01-08 13:34:46.75', '2026-01-08 13:34:46.75', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxa000ftmww92t31xcx', 'Galeno', '440', NULL, '2026-01-08 13:34:46.75', '2026-01-08 13:34:46.75', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxb000gtmww6b57evrt', 'Medicus', 'Azul', NULL, '2026-01-08 13:34:46.751', '2026-01-08 13:34:46.751', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxb000htmww4kio3o10', 'Medicus', 'Celeste', NULL, '2026-01-08 13:34:46.752', '2026-01-08 13:34:46.752', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxc000itmwwi49owjwc', 'Medicus', 'Plata', NULL, '2026-01-08 13:34:46.752', '2026-01-08 13:34:46.752', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxc000jtmwwtdboqvja', 'Medicus', 'Oro', NULL, '2026-01-08 13:34:46.753', '2026-01-08 13:34:46.753', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxd000ktmww2j90ebz2', 'Sancor Salud', '1000', NULL, '2026-01-08 13:34:46.753', '2026-01-08 13:34:46.753', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxe000ltmwwelrnoqhl', 'Sancor Salud', '2000', NULL, '2026-01-08 13:34:46.754', '2026-01-08 13:34:46.754', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxe000mtmwwxax6ne3n', 'Sancor Salud', '3000', NULL, '2026-01-08 13:34:46.755', '2026-01-08 13:34:46.755', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxf000ntmwwm3c9v188', 'Sancor Salud', '4000', NULL, '2026-01-08 13:34:46.755', '2026-01-08 13:34:46.755', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxg000otmww7tcjyzod', 'OMINT', 'Classic', NULL, '2026-01-08 13:34:46.756', '2026-01-08 13:34:46.756', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxg000ptmww7wbr0ug0', 'OMINT', 'Premium', NULL, '2026-01-08 13:34:46.757', '2026-01-08 13:34:46.757', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxk000ttmwwi3ecd2we', 'OSECAC', 'General', NULL, '2026-01-08 13:34:46.76', '2026-01-08 13:34:46.76', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxk000utmwwlfee0ofq', 'PAMI', 'General', NULL, '2026-01-08 13:34:46.761', '2026-01-08 13:34:46.761', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxl000vtmww15t6mvl4', 'IOMA', 'General', NULL, '2026-01-08 13:34:46.761', '2026-01-08 13:34:46.761', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxm000wtmww0x33bqm5', 'OSPE', 'General', NULL, '2026-01-08 13:34:46.762', '2026-01-08 13:34:46.762', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxm000xtmwwszy6zuub', 'OSDEPYM', 'General', NULL, '2026-01-08 13:34:46.763', '2026-01-08 13:34:46.763', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxn000ytmww2dun1tac', 'OSPECON', 'General', NULL, '2026-01-08 13:34:46.764', '2026-01-08 13:34:46.764', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxo000ztmww8cte1nnx', 'OSPRERA', 'General', NULL, '2026-01-08 13:34:46.764', '2026-01-08 13:34:46.764', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxo0010tmwwh64pv3w6', 'OSPIP', 'General', NULL, '2026-01-08 13:34:46.765', '2026-01-08 13:34:46.765', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxp0011tmww0snj5tv6', 'OSUTHGRA', 'General', NULL, '2026-01-08 13:34:46.765', '2026-01-08 13:34:46.765', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxp0012tmww0or6ez4b', 'OSPLAD', 'General', NULL, '2026-01-08 13:34:46.766', '2026-01-08 13:34:46.766', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxq0013tmwwyv6mwt52', 'OSDOP', 'General', NULL, '2026-01-08 13:34:46.766', '2026-01-08 13:34:46.766', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxr0014tmww8ms9ys8t', 'OSMATA', 'General', NULL, '2026-01-08 13:34:46.767', '2026-01-08 13:34:46.767', NULL);
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxi000rtmww932pwe3t', 'Accord Salud', '310', NULL, '2026-01-08 13:34:46.759', '2026-01-11 15:54:56.009', 'COSEGURO1');
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxj000stmww0z4e5ypc', 'Accord Salud', '410', NULL, '2026-01-08 13:34:46.759', '2026-01-11 15:55:01.261', 'COSEGURO1');
INSERT INTO centro_rehab."ObraSocial" (id, nombre, plan, observaciones, "createdAt", "updatedAt", "coseguroTipo") VALUES ('cmk5hojxh000qtmwwyuhbhmmp', 'Accord Salud', '210', NULL, '2026-01-08 13:34:46.757', '2026-01-11 15:55:07.933', 'COSEGURO1');


--
-- Data for Name: OrdenKinesiologia; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--



--
-- Data for Name: Paciente; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab."Paciente" (id, nombre, apellido, dni, "fechaNacimiento", telefono, email, direccion, "contactoEmergencia", activo, "createdAt", "updatedAt") VALUES ('cmk4jrlpr0000tm60bli8g03d', 'santiago', 'burgues', '36666', '1994-04-10 00:00:00', '36666', NULL, 'dire', 'no es', true, '2026-01-07 21:45:22.094', '2026-01-11 15:55:30.131');
INSERT INTO centro_rehab."Paciente" (id, nombre, apellido, dni, "fechaNacimiento", telefono, email, direccion, "contactoEmergencia", activo, "createdAt", "updatedAt") VALUES ('cmk9yuoe60000tmq8mv192ts5', 'Maxi', 'Perez', '3570266', '1995-06-08 00:00:00', '3407458963', NULL, 'san martin 914', '340746666', true, '2026-01-11 16:46:30.654', '2026-01-11 16:46:30.654');
INSERT INTO centro_rehab."Paciente" (id, nombre, apellido, dni, "fechaNacimiento", telefono, email, direccion, "contactoEmergencia", activo, "createdAt", "updatedAt") VALUES ('cmk32uim90000tmfgiareaga2', 'Andres', 'Burgues', '35702164', '1991-08-17 00:00:00', '03407406148', 'andresburgues@gmai.com', 'Rivadavia', '333', true, '2026-01-06 21:03:58.401', '2026-01-13 02:51:02.936');


--
-- Data for Name: PacienteObraSocial; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab."PacienteObraSocial" (id, "pacienteId", "obraSocialId", "numeroAfiliado", observaciones, "createdAt", "updatedAt") VALUES ('cmk9x12vn0001tmhoqp9o811k', 'cmk4jrlpr0000tm60bli8g03d', 'cmk5hojxi000rtmww932pwe3t', '5896666', NULL, '2026-01-11 15:55:30.131', '2026-01-11 15:55:30.131');
INSERT INTO centro_rehab."PacienteObraSocial" (id, "pacienteId", "obraSocialId", "numeroAfiliado", observaciones, "createdAt", "updatedAt") VALUES ('cmk9yuoe70002tmq8ngwuffzl', 'cmk9yuoe60000tmq8mv192ts5', 'cmk5hojx10007tmwwfzarne5j', '6985666', NULL, '2026-01-11 16:46:30.654', '2026-01-11 16:46:30.654');


--
-- Data for Name: PagoMensualGimnasio; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab."PagoMensualGimnasio" (id, "pacienteId", "yearMonth", importe, cobrado, "cobradoAt", "cobradoPorId", "createdAt", "updatedAt", "formaPago") VALUES ('cmka1q7e90001tmjg2or22wuy', 'cmk4jrlpr0000tm60bli8g03d', '2026-02', 30000, true, '2026-01-13 02:37:49.445', 'cmk32k3fs0004tmyg9wfsiitw', '2026-01-11 18:07:00.849', '2026-01-13 02:37:49.448', NULL);
INSERT INTO centro_rehab."PagoMensualGimnasio" (id, "pacienteId", "yearMonth", importe, cobrado, "cobradoAt", "cobradoPorId", "createdAt", "updatedAt", "formaPago") VALUES ('cmkbzx5d40001tmigtigeop4t', 'cmk32uim90000tmfgiareaga2', '2026-01', 20000, true, '2026-01-13 00:00:00', 'cmk32k3fs0004tmyg9wfsiitw', '2026-01-13 02:51:57.928', '2026-01-13 02:52:22.251', NULL);


--
-- Data for Name: Role; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab."Role" (id, name, "createdAt", "updatedAt") VALUES ('cmk32k3c70000tmygupxigbb9', 'admin', '2026-01-06 20:55:52.04', '2026-01-06 20:55:52.04');
INSERT INTO centro_rehab."Role" (id, name, "createdAt", "updatedAt") VALUES ('cmk32k3cx0001tmygkeedet09', 'recepcion', '2026-01-06 20:55:52.065', '2026-01-06 20:55:52.065');
INSERT INTO centro_rehab."Role" (id, name, "createdAt", "updatedAt") VALUES ('cmk32k3d00002tmyg2oa7i2j7', 'profesional', '2026-01-06 20:55:52.068', '2026-01-06 20:55:52.068');


--
-- Data for Name: Seguimiento; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--



--
-- Data for Name: Turno; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk4kijs10007tm50yvwwoev2', 'cmk32uim90000tmfgiareaga2', 'cmk32k3fw0005tmygvekcqxdl', NULL, '2026-01-12 10:00:00', '2026-01-12 10:30:00', 'RESERVADO', NULL, '2026-01-07 22:06:19.297', '2026-01-07 22:06:19.297', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk4kijsj000btm50iafdw51w', 'cmk32uim90000tmfgiareaga2', 'cmk32k3fw0005tmygvekcqxdl', NULL, '2026-01-14 10:00:00', '2026-01-14 10:30:00', 'RESERVADO', NULL, '2026-01-07 22:06:19.315', '2026-01-07 22:06:19.315', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk4kijsq000dtm5041vy4bia', 'cmk32uim90000tmfgiareaga2', 'cmk32k3fw0005tmygvekcqxdl', NULL, '2026-01-15 10:00:00', '2026-01-15 10:30:00', 'RESERVADO', NULL, '2026-01-07 22:06:19.323', '2026-01-07 22:06:19.323', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk4kijsx000ftm50qxwpmoa2', 'cmk32uim90000tmfgiareaga2', 'cmk32k3fw0005tmygvekcqxdl', NULL, '2026-01-16 10:00:00', '2026-01-16 10:30:00', 'RESERVADO', NULL, '2026-01-07 22:06:19.33', '2026-01-07 22:06:19.33', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmkbzx5d70003tmigpldf0lql', 'cmk32uim90000tmfgiareaga2', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-01-05 14:00:00', '2026-01-05 15:00:00', 'CONFIRMADO', NULL, '2026-01-13 02:51:57.931', '2026-01-13 02:52:22.263', true, '2026-01-13 00:00:00', 'cmk32k3fs0004tmyg9wfsiitw', 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmkbzx5de0005tmig558re635', 'cmk32uim90000tmfgiareaga2', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-01-07 14:00:00', '2026-01-07 15:00:00', 'CONFIRMADO', NULL, '2026-01-13 02:51:57.939', '2026-01-13 02:52:22.263', true, '2026-01-13 00:00:00', 'cmk32k3fs0004tmyg9wfsiitw', 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmkbzx5di0007tmig2wkvo3is', 'cmk32uim90000tmfgiareaga2', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-01-12 14:00:00', '2026-01-12 15:00:00', 'CONFIRMADO', NULL, '2026-01-13 02:51:57.943', '2026-01-13 02:52:22.263', true, '2026-01-13 00:00:00', 'cmk32k3fs0004tmyg9wfsiitw', 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk4kejhw0003tm50cklw3g5o', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3fw0005tmygvekcqxdl', NULL, '2026-01-08 16:00:00', '2026-01-08 16:30:00', 'ASISTIO', NULL, '2026-01-07 22:03:12.308', '2026-01-08 02:16:53.224', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk4kf7dh0005tm50y3o5nqo4', 'cmk32uim90000tmfgiareaga2', 'cmk32k3fw0005tmygvekcqxdl', NULL, '2026-01-09 09:00:00', '2026-01-09 09:30:00', 'RESERVADO', NULL, '2026-01-07 22:03:43.253', '2026-01-08 02:17:22.283', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmkbzx5dm0009tmig80vi5g6g', 'cmk32uim90000tmfgiareaga2', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-01-14 14:00:00', '2026-01-14 15:00:00', 'CONFIRMADO', NULL, '2026-01-13 02:51:57.947', '2026-01-13 02:52:22.263', true, '2026-01-13 00:00:00', 'cmk32k3fs0004tmyg9wfsiitw', 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmkbzx5dq000btmigncnxn71u', 'cmk32uim90000tmfgiareaga2', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-01-19 14:00:00', '2026-01-19 15:00:00', 'CONFIRMADO', NULL, '2026-01-13 02:51:57.95', '2026-01-13 02:52:22.263', true, '2026-01-13 00:00:00', 'cmk32k3fs0004tmyg9wfsiitw', 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk4kdrqd0001tm50kzbaxko8', 'cmk32uim90000tmfgiareaga2', 'cmk32k3fw0005tmygvekcqxdl', NULL, '2026-01-08 14:00:00', '2026-01-08 14:30:00', 'RESERVADO', NULL, '2026-01-07 22:02:36.325', '2026-01-08 02:17:29.217', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk9x1jsn0003tmhov9crqwqy', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3fw0005tmygvekcqxdl', NULL, '2026-01-12 14:00:00', '2026-01-12 14:30:00', 'RESERVADO', NULL, '2026-01-11 15:55:52.056', '2026-01-11 15:56:11.34', true, '2026-01-11 15:56:11.338', 'cmk32k3fs0004tmyg9wfsiitw', 3000, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk9yxczm0004tmq8v0iyxh4z', 'cmk9yuoe60000tmq8mv192ts5', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-03 11:00:00', '2026-02-03 12:00:00', 'RESERVADO', NULL, '2026-01-11 16:48:35.842', '2026-01-11 16:48:35.842', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk9yxczt0006tmq8ku66bgga', 'cmk9yuoe60000tmq8mv192ts5', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-05 11:00:00', '2026-02-05 12:00:00', 'RESERVADO', NULL, '2026-01-11 16:48:35.849', '2026-01-11 16:48:35.849', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk9yxczy0008tmq8wbf0ay2f', 'cmk9yuoe60000tmq8mv192ts5', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-10 11:00:00', '2026-02-10 12:00:00', 'RESERVADO', NULL, '2026-01-11 16:48:35.854', '2026-01-11 16:48:35.854', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk9yxd04000atmq8tzs3hcir', 'cmk9yuoe60000tmq8mv192ts5', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-12 11:00:00', '2026-02-12 12:00:00', 'RESERVADO', NULL, '2026-01-11 16:48:35.86', '2026-01-11 16:48:35.86', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk9yxd0a000ctmq8pa2ckkmg', 'cmk9yuoe60000tmq8mv192ts5', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-17 11:00:00', '2026-02-17 12:00:00', 'RESERVADO', NULL, '2026-01-11 16:48:35.867', '2026-01-11 16:48:35.867', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk9yxd0g000etmq8ic9k88y2', 'cmk9yuoe60000tmq8mv192ts5', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-19 11:00:00', '2026-02-19 12:00:00', 'RESERVADO', NULL, '2026-01-11 16:48:35.873', '2026-01-11 16:48:35.873', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk9yxd13000gtmq8tkr1tx6h', 'cmk9yuoe60000tmq8mv192ts5', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-24 11:00:00', '2026-02-24 12:00:00', 'RESERVADO', NULL, '2026-01-11 16:48:35.895', '2026-01-11 16:48:35.895', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk9yxd19000itmq889yu10xf', 'cmk9yuoe60000tmq8mv192ts5', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-26 11:00:00', '2026-02-26 12:00:00', 'RESERVADO', NULL, '2026-01-11 16:48:35.901', '2026-01-11 16:48:35.901', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7eh0003tmjgrw917iir', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-02 13:00:00', '2026-02-02 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.857', '2026-01-11 18:07:00.857', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7ep0005tmjg21bwuhpg', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-04 13:00:00', '2026-02-04 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.865', '2026-01-11 18:07:00.865', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7ew0007tmjg4kcm0wjb', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-06 13:00:00', '2026-02-06 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.872', '2026-01-11 18:07:00.872', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7f20009tmjgzyygyi2m', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-09 13:00:00', '2026-02-09 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.878', '2026-01-11 18:07:00.878', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7f7000btmjgo1d7mtzz', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-11 13:00:00', '2026-02-11 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.883', '2026-01-11 18:07:00.883', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7fe000dtmjgs7dda15t', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-13 13:00:00', '2026-02-13 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.89', '2026-01-11 18:07:00.89', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7fl000ftmjg5la0jbei', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-16 13:00:00', '2026-02-16 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.897', '2026-01-11 18:07:00.897', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7fr000htmjg0a74ms4u', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-18 13:00:00', '2026-02-18 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.903', '2026-01-11 18:07:00.903', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7fx000jtmjg2mvyxisy', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-20 13:00:00', '2026-02-20 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.909', '2026-01-11 18:07:00.909', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7g2000ltmjgnzjy5t6h', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-23 13:00:00', '2026-02-23 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.914', '2026-01-11 18:07:00.914', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7g7000ntmjg2hpqqnxl', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-25 13:00:00', '2026-02-25 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.919', '2026-01-11 18:07:00.919', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmka1q7gc000ptmjgwhxh1phq', 'cmk4jrlpr0000tm60bli8g03d', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-02-27 13:00:00', '2026-02-27 14:00:00', 'CONFIRMADO', NULL, '2026-01-11 18:07:00.925', '2026-01-11 18:07:00.925', false, NULL, NULL, 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmkbzx5dv000dtmigbjvtvwq5', 'cmk32uim90000tmfgiareaga2', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-01-21 14:00:00', '2026-01-21 15:00:00', 'CONFIRMADO', NULL, '2026-01-13 02:51:57.955', '2026-01-13 02:52:22.263', true, '2026-01-13 00:00:00', 'cmk32k3fs0004tmyg9wfsiitw', 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmkbzx5dz000ftmigf3k2noqd', 'cmk32uim90000tmfgiareaga2', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-01-26 14:00:00', '2026-01-26 15:00:00', 'CONFIRMADO', NULL, '2026-01-13 02:51:57.959', '2026-01-13 02:52:22.263', true, '2026-01-13 00:00:00', 'cmk32k3fs0004tmyg9wfsiitw', 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmkbzx5e3000htmig1u1i0nps', 'cmk32uim90000tmfgiareaga2', 'cmk32k3g00006tmygj76yxs56', NULL, '2026-01-28 14:00:00', '2026-01-28 15:00:00', 'CONFIRMADO', NULL, '2026-01-13 02:51:57.963', '2026-01-13 02:52:22.263', true, '2026-01-13 00:00:00', 'cmk32k3fs0004tmyg9wfsiitw', 0, NULL, NULL);
INSERT INTO centro_rehab."Turno" (id, "pacienteId", "especialidadId", "profesionalId", "startAt", "endAt", estado, notas, "createdAt", "updatedAt", cobrado, "cobradoAt", "cobradoPorId", "importeCoseguro", "ordenKinesiologiaId", "sesionNro") VALUES ('cmk4kijsc0009tm50c8a9isad', 'cmk32uim90000tmfgiareaga2', 'cmk32k3fw0005tmygvekcqxdl', NULL, '2026-01-13 10:00:00', '2026-01-13 10:30:00', 'ASISTIO', NULL, '2026-01-07 22:06:19.308', '2026-01-13 03:01:16.466', false, NULL, NULL, 0, NULL, NULL);


--
-- Data for Name: TurnoHistorial; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--



--
-- Data for Name: User; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab."User" (id, email, "passwordHash", nombre, "roleId", "createdAt", "updatedAt") VALUES ('cmk32lefh0001tm88ihecy89v', 'recepcion@centro.com', '$2a$10$iIKJfhPfKTwABpynHqumnO3/4iqx/VzQj7aNA.jyfRcn7dgjDrnkm', 'Recepcion', 'cmk32k3cx0001tmygkeedet09', '2026-01-06 20:56:53.07', '2026-01-06 20:56:53.07');
INSERT INTO centro_rehab."User" (id, email, "passwordHash", nombre, "roleId", "createdAt", "updatedAt") VALUES ('cmk32lkey0001tmb4ul82pemn', 'prof@centro.com', '$2a$10$1SWBMvE5rBc8FtxyDyJ4xOKs4eSX12ahlBr/PvPejn3YUOWUTIUFK', 'Profesional', 'cmk32k3d00002tmyg2oa7i2j7', '2026-01-06 20:57:00.826', '2026-01-06 20:57:00.826');
INSERT INTO centro_rehab."User" (id, email, "passwordHash", nombre, "roleId", "createdAt", "updatedAt") VALUES ('cmk32k3fs0004tmyg9wfsiitw', 'admin@centro.com', '$2a$10$8B9lDGaLqpljAzDR8Fli7.asSrcAmSVHURX1Q1lLXT1FU9H.1G74u', 'Administrador', 'cmk32k3c70000tmygupxigbb9', '2026-01-06 20:55:52.168', '2026-01-08 13:34:46.728');


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: centro_rehab; Owner: postgres
--

INSERT INTO centro_rehab._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('93ac250e-0b61-41d9-8cf6-5ffb1d7b240b', '42ca0dbab0387e7bd2e7fc46320ce80afe9df66a80131d670cf1d95889c44aff', '2026-01-06 13:23:51.377523-03', '20260106135316', NULL, NULL, '2026-01-06 13:23:51.325348-03', 1);
INSERT INTO centro_rehab._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('283b2bf3-5da7-47f6-a981-2b05c8cca557', '9ac5141a75de8e4445bcbb2cfb8a2d7fed2577b67eff540d2572b6bc6a2e1464', '2026-01-11 02:04:36.429578-03', '20260111050436_coseguros_y_cobros', NULL, NULL, '2026-01-11 02:04:36.413625-03', 1);
INSERT INTO centro_rehab._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('58ec7135-1f01-4adf-8fa4-fe31b3553fa4', '7ff3c1f05ea1a2cb63f09c69d5ec0e03d977793b96dc8aad0190d00c3d21f65d', '2026-01-11 14:24:33.569655-03', '20260111172433_pagos_gimnasio_mensual', NULL, NULL, '2026-01-11 14:24:33.547992-03', 1);
INSERT INTO centro_rehab._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('2996d355-cc45-4091-a728-d36133c1d369', '9c3d9ed4c362373fd434e52c70a44608041cb4e3789742ba1ee4d90289006b4b', '2026-01-11 15:32:59.902899-03', '20260111183259_ordenes_kinesiologia', NULL, NULL, '2026-01-11 15:32:59.879523-03', 1);
INSERT INTO centro_rehab._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('0295ede8-eabc-4a54-bbca-e8e37feebf38', 'b7e66eabec19058f401d6d2901c027d1cdd20d6a85c454061ac683216707cb03', '2026-01-12 23:46:02.483104-03', '20260113024602_pago_gimnasio_forma_pago', NULL, NULL, '2026-01-12 23:46:02.475506-03', 1);
INSERT INTO centro_rehab._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('89b46f59-f73c-4ca9-b284-2c6b37225def', '0a673661ab93e07d60e942dc86adbc4ec5208d33c1bc5f2d5d43a63d9fa900cd', '2026-01-13 13:40:34.405825-03', '20260113164034_mejoras_modelo_v2', NULL, NULL, '2026-01-13 13:40:34.352882-03', 1);
INSERT INTO centro_rehab._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) VALUES ('8a1aa681-d3ff-4bd9-bed1-53887ea8dbc1', '2a96c5a968d2095cc300c4a9c650df426e904d76ed9aa125b7d43db5baba7d59', '2026-01-14 11:30:22.188051-03', '20260114143022_auditoria', NULL, NULL, '2026-01-14 11:30:22.133278-03', 1);


--
-- Data for Name: cajas; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.cajas (id, fecha_apertura, fecha_cierre, saldo_inicial, saldo_final, estado, usuario_apertura_id, usuario_cierre_id, observaciones) VALUES (1, '2026-01-12 21:36:15.21987', '2026-01-12 22:15:55.527313', 5000.00, 17000.00, 'cerrada', 3, 3, NULL);


--
-- Data for Name: canchas; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.canchas (id, nombre, tipo) VALUES (1, 'Cancha Padel 1', 'PADEL');
INSERT INTO complejo_deportivo.canchas (id, nombre, tipo) VALUES (2, 'Cancha Padel 2', 'PADEL');
INSERT INTO complejo_deportivo.canchas (id, nombre, tipo) VALUES (3, 'Cancha Futbol 5', 'FUTBOL');
INSERT INTO complejo_deportivo.canchas (id, nombre, tipo) VALUES (5, 'cancha 2', 'FUTBOL');


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.categorias (id, descripcion) VALUES (1, 'Primera');
INSERT INTO complejo_deportivo.categorias (id, descripcion) VALUES (2, 'Segunda');
INSERT INTO complejo_deportivo.categorias (id, descripcion) VALUES (3, 'Tercera');
INSERT INTO complejo_deportivo.categorias (id, descripcion) VALUES (4, 'Cuarta');
INSERT INTO complejo_deportivo.categorias (id, descripcion) VALUES (5, 'Quinta');
INSERT INTO complejo_deportivo.categorias (id, descripcion) VALUES (6, 'Sexta');
INSERT INTO complejo_deportivo.categorias (id, descripcion) VALUES (7, 'Septima');
INSERT INTO complejo_deportivo.categorias (id, descripcion) VALUES (8, 'Octava');


--
-- Data for Name: compras; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.compras (id, proveedor_id, fecha, total, estado, observaciones) VALUES (1, 1, '2026-01-12 22:12:49.93407', 2500.00, 'RECIBIDO', '');


--
-- Data for Name: configuracion; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.configuracion (clave, valor) VALUES ('PRECIO_PADEL', '24000');
INSERT INTO complejo_deportivo.configuracion (clave, valor) VALUES ('PRECIO_FUTBOL', '25000');
INSERT INTO complejo_deportivo.configuracion (clave, valor) VALUES ('DURACION_PADEL', '90');
INSERT INTO complejo_deportivo.configuracion (clave, valor) VALUES ('DURACION_FUTBOL', '60');
INSERT INTO complejo_deportivo.configuracion (clave, valor) VALUES ('HORARIO_APERTURA', '13:00');
INSERT INTO complejo_deportivo.configuracion (clave, valor) VALUES ('HORARIO_CIERRE', '00:00');


--
-- Data for Name: detalle_compra; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.detalle_compra (id, compra_id, producto_id, cantidad, costo_unitario, subtotal) VALUES (1, 1, 1, 1, 2500.00, 2500.00);


--
-- Data for Name: detalle_venta_cantina; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (1, 1, 1, 1, 3500.00, 3500.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (2, 2, 2, 1, 100.00, 100.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (3, 2, 1, 2, 3500.00, 7000.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (4, 3, 2, 2, 100.00, 200.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (5, 3, 1, 1, 3500.00, 3500.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (6, 4, 1, 2, 3500.00, 7000.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (7, 5, 6, 1, 2000.00, 2000.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (8, 5, 7, 1, 6000.00, 6000.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (9, 6, 6, 1, 2000.00, 2000.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (10, 6, 3, 1, 1500.00, 1500.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (11, 7, 11, 1, 800.00, 800.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (12, 7, 6, 1, 2000.00, 2000.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (13, 8, 8, 1, 4500.00, 4500.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (14, 8, 1, 1, 3500.00, 3500.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (15, 9, 9, 1, 2500.00, 2500.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (16, 9, 12, 1, 2200.00, 2200.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (17, 10, 6, 1, 2000.00, 2000.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (18, 10, 3, 1, 1500.00, 1500.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (19, 11, 3, 1, 1500.00, 1500.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (20, 11, 6, 1, 2000.00, 2000.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (21, 12, 12, 1, 2200.00, 2200.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (22, 12, 3, 1, 1500.00, 1500.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (23, 13, 11, 1, 800.00, 800.00);
INSERT INTO complejo_deportivo.detalle_venta_cantina (id, venta_id, producto_id, cantidad, precio_unitario, subtotal) VALUES (24, 13, 13, 1, 1200.00, 1200.00);


--
-- Data for Name: detalle_ventas; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.detalle_ventas (id, venta_id, producto_id, cantidad, precio_unitario) VALUES (1, 1, 2, 5, 100.00);
INSERT INTO complejo_deportivo.detalle_ventas (id, venta_id, producto_id, cantidad, precio_unitario) VALUES (2, 2, 1, 2, 3500.00);
INSERT INTO complejo_deportivo.detalle_ventas (id, venta_id, producto_id, cantidad, precio_unitario) VALUES (3, 3, 2, 3, 100.00);
INSERT INTO complejo_deportivo.detalle_ventas (id, venta_id, producto_id, cantidad, precio_unitario) VALUES (4, 4, 1, 1, 3500.00);
INSERT INTO complejo_deportivo.detalle_ventas (id, venta_id, producto_id, cantidad, precio_unitario) VALUES (5, 4, 2, 1, 100.00);


--
-- Data for Name: gastos; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.gastos (id, descripcion, monto, fecha, caja_id, usuario_id) VALUES (1, 'limpieza', 12000.00, '2026-01-12 21:36:41.069589', 1, 3);


--
-- Data for Name: inscripciones; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.inscripciones (id, torneo_id, jugador_id, fecha_inscripcion, pagado, monto_abonado, fecha_pago, metodo_pago, caja_id) VALUES (1, 1, 1, '2026-01-03 18:01:39.494634', true, 20000.00, '2026-01-03 18:01:42.778113', 'efectivo', NULL);


--
-- Data for Name: jugadores; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.jugadores (id, nombre, telefono, email, created_at, categoria_id) VALUES (2, 'santiago', '347955', '', '2025-12-17 14:58:02.593363', NULL);
INSERT INTO complejo_deportivo.jugadores (id, nombre, telefono, email, created_at, categoria_id) VALUES (3, 'maxi', '354499', '', '2025-12-17 14:58:14.242132', NULL);
INSERT INTO complejo_deportivo.jugadores (id, nombre, telefono, email, created_at, categoria_id) VALUES (1, 'andres burgues', '34707406154', '', '2025-12-17 14:57:50.690508', 1);
INSERT INTO complejo_deportivo.jugadores (id, nombre, telefono, email, created_at, categoria_id) VALUES (4, 'juan perez', '4242', '', '2025-12-19 09:05:00.132778', NULL);


--
-- Data for Name: movimientos_cuenta; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.movimientos_cuenta (id, jugador_id, tipo, monto, descripcion, referencia_id, fecha, caja_id) VALUES (1, 3, 'DEBE', 2500.00, 'turno padel', NULL, '2025-12-19 09:11:06.203518', NULL);
INSERT INTO complejo_deportivo.movimientos_cuenta (id, jugador_id, tipo, monto, descripcion, referencia_id, fecha, caja_id) VALUES (2, 3, 'DEBE', 2800.00, 'Compra en Cantina (Venta #7)', 7, '2025-12-19 09:11:24.920274', NULL);
INSERT INTO complejo_deportivo.movimientos_cuenta (id, jugador_id, tipo, monto, descripcion, referencia_id, fecha, caja_id) VALUES (3, 3, 'HABER', 2500.00, 'efectivo', NULL, '2025-12-19 09:11:58.674825', NULL);
INSERT INTO complejo_deportivo.movimientos_cuenta (id, jugador_id, tipo, monto, descripcion, referencia_id, fecha, caja_id) VALUES (4, 2, 'DEBE', 4700.00, 'Compra en Cantina (Venta #9)', 9, '2025-12-19 10:35:38.423975', NULL);
INSERT INTO complejo_deportivo.movimientos_cuenta (id, jugador_id, tipo, monto, descripcion, referencia_id, fecha, caja_id) VALUES (5, 4, 'DEBE', 3500.00, 'Compra en Cantina (Venta #10)', 10, '2025-12-20 17:24:48.974937', NULL);
INSERT INTO complejo_deportivo.movimientos_cuenta (id, jugador_id, tipo, monto, descripcion, referencia_id, fecha, caja_id) VALUES (6, 4, 'DEBE', 3700.00, 'Compra en Cantina (Venta #12)', 12, '2025-12-20 17:35:29.833838', NULL);
INSERT INTO complejo_deportivo.movimientos_cuenta (id, jugador_id, tipo, monto, descripcion, referencia_id, fecha, caja_id) VALUES (7, 4, 'DEBE', 2000.00, 'Compra en Cantina (Venta #13)', 13, '2025-12-20 17:49:08.237303', NULL);


--
-- Data for Name: movimientos_proveedor; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.movimientos_proveedor (id, proveedor_id, tipo, monto, descripcion, fecha) VALUES (1, 1, 'DEBE', 750000.00, 'factura n°5423', '2025-12-19 10:35:17.039304');
INSERT INTO complejo_deportivo.movimientos_proveedor (id, proveedor_id, tipo, monto, descripcion, fecha) VALUES (2, 1, 'DEBE', 2500.00, 'Compra #1', '2026-01-12 22:12:49.93407');


--
-- Data for Name: pagos; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (1, 1, 120000.00, 'efectivo', '2025-11-30 20:31:54.850213', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (2, 2, 12000.00, 'efectivo', '2025-12-01 17:49:37.696359', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (3, 2, 6000.00, 'transferencia', '2025-12-01 17:49:49.468829', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (4, 2, 6000.00, 'efectivo', '2025-12-01 17:49:55.927251', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (5, 2, 0.00, 'efectivo', '2025-12-01 17:50:00.260998', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (6, 13, 12000.00, 'efectivo', '2025-12-16 17:18:35.686591', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (7, 14, 6000.00, 'transferencia', '2025-12-17 11:02:48.536235', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (9, 17, 24000.00, 'qr', '2025-12-20 18:12:10.981832', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (10, 18, 10000.00, 'efectivo', '2025-12-20 18:14:34.4579', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (11, 42, 24000.00, 'efectivo', '2025-12-24 15:35:30.635139', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (12, 6, 24000.00, 'efectivo', '2025-12-24 15:38:58.464384', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (13, 5, 12000.00, 'efectivo', '2025-12-24 15:39:56.487535', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (14, 5, 12000.00, 'transferencia', '2025-12-24 15:44:19.997302', NULL);
INSERT INTO complejo_deportivo.pagos (id, turno_id, monto, metodo, fecha_pago, caja_id) VALUES (15, 7, 24000.00, 'transferencia', '2026-01-12 21:52:06.941767', 1);


--
-- Data for Name: productos; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (11, 'Alfajor Chocolate', 'snack', 800.00, 38, NULL, 800.00, NULL, NULL, 'INACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (6, 'Cerveza Quilmes 473ml', 'bebida', 2000.00, 35, NULL, 2000.00, NULL, NULL, 'ACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (13, 'Chocolate Block 38g', 'snack', 1200.00, 24, 0, 1200.00, NULL, NULL, 'INACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (1, 'coca cola 1.5', 'bebida', 3500.00, 5, 0, 3500.00, 2500.00, NULL, 'ACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (2, 'Producto Test 1764364979743', 'Test', 100.00, 38, 0, 100.00, NULL, NULL, 'ACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (5, 'Gatorade 500ml', 'bebida', 1800.00, 30, 0, 1800.00, NULL, NULL, 'ACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (10, 'Tostado Jamón y Queso', 'comida', 3500.00, 15, 0, 3500.00, NULL, NULL, 'ACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (7, 'Pizza Muzzarella', 'comida', 6000.00, 9, 0, 6000.00, NULL, NULL, 'ACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (8, 'Hamburguesa Completa', 'comida', 4500.00, 19, 0, 4500.00, NULL, NULL, 'ACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (9, 'Super Pancho', 'comida', 2500.00, 29, 0, 2500.00, NULL, NULL, 'ACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (12, 'Papas Lays 145g', 'snack', 2200.00, 18, 0, 2200.00, NULL, NULL, 'ACTIVO', NULL);
INSERT INTO complejo_deportivo.productos (id, nombre, categoria, precio, stock, stock_minimo, precio_venta, costo, proveedor_id, estado, codigo_barra) VALUES (3, 'Coca Cola 500ml', 'bebida', 1500.00, 46, 0, 1500.00, NULL, NULL, 'ACTIVO', NULL);


--
-- Data for Name: proveedores; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.proveedores (id, nombre, contacto, telefono, email, created_at) VALUES (1, 'un proveedor', '', '', '', '2025-12-19 10:09:23.745312');


--
-- Data for Name: reservas_fijas; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.reservas_fijas (id, cancha_id, dia_semana, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, monto_total, created_at) VALUES (1, 3, 2, '17:00:00', '18:00:00', 'andres', '2222', 25000.00, '2025-12-01 18:13:37.435465');
INSERT INTO complejo_deportivo.reservas_fijas (id, cancha_id, dia_semana, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, monto_total, created_at) VALUES (2, 1, 4, '16:00:00', '17:30:00', 'pedro', '1111', 24000.00, '2025-12-10 21:38:23.197097');
INSERT INTO complejo_deportivo.reservas_fijas (id, cancha_id, dia_semana, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, monto_total, created_at) VALUES (3, 1, 6, '17:00:00', '18:00:00', 'maxi', '', 24000.00, '2025-12-12 20:47:02.472013');
INSERT INTO complejo_deportivo.reservas_fijas (id, cancha_id, dia_semana, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, monto_total, created_at) VALUES (5, 1, 2, '17:30:00', '19:00:00', 'maxi', '354499', 24000.00, '2025-12-22 22:41:54.854667');
INSERT INTO complejo_deportivo.reservas_fijas (id, cancha_id, dia_semana, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, monto_total, created_at) VALUES (6, 2, 2, '17:30:00', '19:00:00', 'andres burgues', '34707406154', 24000.00, '2025-12-22 22:43:09.129508');
INSERT INTO complejo_deportivo.reservas_fijas (id, cancha_id, dia_semana, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, monto_total, created_at) VALUES (7, 1, 2, '19:00:00', '20:30:00', 'santiago', '347955', 24000.00, '2026-01-12 21:51:58.6185');


--
-- Data for Name: torneos; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.torneos (id, descripcion, fecha_inicio, costo_inscripcion, created_at) VALUES (1, '1', '2026-01-03', 20000.00, '2026-01-03 18:01:32.757616');


--
-- Data for Name: turnos; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (1, 1, '2025-12-01', '19:00:00', '20:30:00', 'andres', '3407406148', 'reservado', true, 24000.00, '2025-11-30 20:31:10.773919');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (50, 1, '2026-01-06', '17:30:00', '19:00:00', 'andres burgues', '34707406154', 'cancelado', false, 24000.00, '2025-12-22 22:47:26.308739');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (2, 2, '2025-12-01', '20:00:00', '21:30:00', 'andres burgues', '345555', 'reservado', true, 24000.00, '2025-12-01 17:49:23.760608');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (4, 1, '2025-12-02', '17:30:00', '19:00:00', 'andres', '35555', 'reservado', false, 24000.00, '2025-12-01 17:53:13.098619');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (7, 3, '2025-12-16', '17:00:00', '18:00:00', 'andres', '2222', 'reservado', false, 25000.00, '2025-12-01 18:14:06.90321');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (3, 1, '2025-12-02', '16:00:00', '17:30:00', 'maxi', '34444', 'cancelado', false, 240000.00, '2025-12-01 17:52:56.098858');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (8, 1, '2025-12-02', '16:00:00', '17:30:00', 'soledad', '35555', 'reservado', false, 23999.00, '2025-12-01 18:43:04.283861');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (9, 1, '2025-12-03', '20:00:00', '21:30:00', 'marcelo', '3444', 'reservado', false, 24000.00, '2025-12-02 18:54:51.286707');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (10, 1, '2025-12-03', '14:00:00', '15:30:00', 'lucio', '3332555', 'reservado', false, 20000.00, '2025-12-02 23:31:35.837671');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (11, 1, '2025-12-11', '19:00:00', '20:30:00', 'andres burgues', '34075555', 'reservado', false, 24000.00, '2025-12-10 21:37:14.966479');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (12, 2, '2025-12-11', '20:30:00', '22:00:00', 'maxi', '555555', 'reservado', false, 24000.00, '2025-12-10 21:37:47.734194');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (13, 1, '2025-12-16', '13:00:00', '14:30:00', 'andres', '3407406148', 'reservado', false, 24000.00, '2025-12-16 16:49:31.424771');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (14, 1, '2025-12-16', '20:30:00', '22:00:00', 'juan', '34071655', 'reservado', false, 24000.00, '2025-12-16 16:49:46.917309');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (15, 2, '2025-12-16', '13:00:00', '14:30:00', 'maxi', '33322', 'reservado', false, 24000.00, '2025-12-16 16:59:32.159085');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (16, 1, '2025-12-17', '16:00:00', '17:30:00', 'andres burgues', '34707406154', 'reservado', false, 24000.00, '2025-12-17 14:58:22.93232');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (17, 1, '2025-12-20', '19:00:00', '20:30:00', 'andres burgues', '34707406154', 'reservado', true, 24000.00, '2025-12-20 18:10:11.570781');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (18, 3, '2025-12-20', '20:00:00', '21:00:00', 'maxi', '354499', 'reservado', false, 25000.00, '2025-12-20 18:14:28.57793');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (42, 2, '2026-01-13', '14:30:00', '16:00:00', 'un fijo', '555', 'reservado', true, 24000.00, '2025-12-22 22:38:06.362614');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (19, 1, '2025-12-22', '17:30:00', '19:00:00', 'and', '', 'cancelado', false, 24000.00, '2025-12-22 11:29:30.557332');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (20, 1, '2025-12-22', '16:00:00', '17:30:00', 'ma', '', 'cancelado', false, 24000.00, '2025-12-22 11:35:04.680681');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (21, 2, '2025-12-23', '14:30:00', '16:00:00', 'un fijo', '555', 'cancelado', false, 24000.00, '2025-12-22 21:55:13.773315');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (22, 1, '2025-12-30', '14:30:00', '16:00:00', 'andres burgues', '34707406154', 'cancelado', false, 24000.00, '2025-12-22 21:59:00.386784');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (24, 1, '2025-12-30', '13:00:00', '14:30:00', 'andres burgues', '34707406154', 'cancelado', false, 24000.00, '2025-12-22 22:09:05.066078');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (25, 1, '2025-12-30', '13:00:00', '14:30:00', 'maxi', '354499', 'reservado', false, 24000.00, '2025-12-22 22:09:17.664733');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (26, 2, '2025-12-30', '14:30:00', '16:00:00', 'un fijo', '555', 'reservado', false, 24000.00, '2025-12-22 22:19:08.371941');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (27, 1, '2025-12-30', '16:00:00', '17:30:00', 'andres burgues', '34707406154', 'cancelado', false, 24000.00, '2025-12-22 22:19:36.259049');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (28, 1, '2025-12-30', '16:00:00', '17:30:00', 'ma', '', 'cancelado', false, 24000.00, '2025-12-22 22:19:43.641362');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (29, 1, '2025-12-30', '16:00:00', '17:30:00', 'andres burgues', '34707406154', 'reservado', false, 24000.00, '2025-12-22 22:19:52.55915');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (30, 1, '2025-12-30', '17:30:00', '19:00:00', 'andres burgues', '34707406154', 'cancelado', false, 24000.00, '2025-12-22 22:20:09.941221');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (32, 1, '2025-12-30', '17:30:00', '19:00:00', 'sa', '', 'reservado', false, 24000.00, '2025-12-22 22:20:25.542527');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (31, 2, '2025-12-30', '17:30:00', '19:00:00', 'maxi', '354499', 'cancelado', false, 24000.00, '2025-12-22 22:20:17.28487');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (33, 2, '2025-12-30', '17:30:00', '19:00:00', 'andres burgues', '34707406154', 'reservado', false, 24000.00, '2025-12-22 22:25:49.836728');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (34, 1, '2025-12-30', '19:00:00', '20:30:00', 'maxi', '', 'cancelado', false, 24000.00, '2025-12-22 22:29:27.968427');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (36, 1, '2025-12-30', '20:30:00', '22:00:00', 'maxi', '354499', 'cancelado', false, 24000.00, '2025-12-22 22:30:02.820674');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (37, 1, '2025-12-30', '20:30:00', '22:00:00', 'andres burgues', '34707406154', 'reservado', false, 24000.00, '2025-12-22 22:30:12.061299');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (35, 1, '2025-12-30', '19:00:00', '20:30:00', 'andres burgues', '34707406154', 'cancelado', false, 24000.00, '2025-12-22 22:29:38.070111');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (23, 1, '2025-12-30', '14:30:00', '16:00:00', 'maxi', '354499', 'cancelado', false, 24000.00, '2025-12-22 21:59:08.020468');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (38, 2, '2025-12-30', '19:00:00', '20:30:00', 'santiago', '347955', 'reservado', false, 24000.00, '2025-12-22 22:34:15.946556');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (39, 1, '2025-12-30', '14:30:00', '16:00:00', 'andres burgues', '34707406154', 'reservado', false, 24000.00, '2025-12-22 22:34:20.133111');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (40, 2, '2026-01-06', '14:30:00', '16:00:00', 'un fijo', '555', 'cancelado', false, 24000.00, '2025-12-22 22:34:33.537253');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (41, 2, '2026-01-06', '14:30:00', '16:00:00', 'maxi', '354499', 'reservado', false, 24000.00, '2025-12-22 22:34:47.210755');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (43, 1, '2026-01-20', '13:00:00', '14:30:00', 'ma', '', 'reservado', false, 24000.00, '2025-12-22 22:41:47.475719');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (44, 1, '2026-01-20', '17:30:00', '19:00:00', 'maxi', '354499', 'reservado', false, 24000.00, '2025-12-22 22:41:59.353738');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (45, 1, '2025-12-23', '17:30:00', '19:00:00', 'maxi', '354499', 'reservado', false, 24000.00, '2025-12-22 22:42:10.71705');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (46, 2, '2025-12-23', '17:30:00', '19:00:00', 'andres burgues', '34707406154', 'reservado', false, 24000.00, '2025-12-22 22:43:12.795651');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (47, 2, '2026-01-06', '17:30:00', '19:00:00', 'andres burgues', '34707406154', 'cancelado', false, 24000.00, '2025-12-22 22:46:34.320193');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (48, 2, '2026-01-06', '17:30:00', '19:00:00', 'maxi', '354499', 'confirmado', false, 24000.00, '2025-12-22 22:46:40.254562');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (49, 1, '2026-01-06', '17:30:00', '19:00:00', 'maxi', '354499', 'cancelado', false, 24000.00, '2025-12-22 22:47:21.823902');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (6, 2, '2025-12-02', '20:00:00', '21:30:00', 'pedro', '3555', 'reservado', true, 24000.00, '2025-12-01 17:57:18.995808');
INSERT INTO complejo_deportivo.turnos (id, cancha_id, fecha, hora_inicio, hora_fin, cliente_nombre, cliente_telefono, estado, pagado, monto_total, created_at) VALUES (5, 2, '2025-12-02', '16:00:00', '17:30:00', 'juan', '3555', 'cancelado', true, 24000.00, '2025-12-01 17:56:27.035469');


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.usuarios (id, username, password, nombre, rol) VALUES (1, 'admin', '$2b$10$JzTSfO2RM6kZo7QrACnUqOoaShDa1HrC9NzUGVoTzhHaf17c1ywwi', 'Administrador', 'admin');
INSERT INTO complejo_deportivo.usuarios (id, username, password, nombre, rol) VALUES (2, 'damian', '$2b$10$dN3asQSWbdyr5IWQZ7CG6uZSD/cbIq54hrH5OxL5tSAtHpEb82VeS', 'Damian Gorostiza', 'user');
INSERT INTO complejo_deportivo.usuarios (id, username, password, nombre, rol) VALUES (3, 'maxi', '$2b$10$jzRUG.YvIiUVTxi4oPhvv.XhSXJa37pZvqsYLJoRMMly/uyVcLL8a', 'Maximiliano Crescimbeni', 'admin');


--
-- Data for Name: ventas; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.ventas (id, fecha, total) VALUES (1, '2025-11-28 18:22:59.820135', 500.00);
INSERT INTO complejo_deportivo.ventas (id, fecha, total) VALUES (2, '2025-11-30 19:52:56.949635', 7000.00);
INSERT INTO complejo_deportivo.ventas (id, fecha, total) VALUES (3, '2025-11-30 20:09:33.482224', 300.00);
INSERT INTO complejo_deportivo.ventas (id, fecha, total) VALUES (4, '2025-11-30 20:09:46.182185', 3600.00);


--
-- Data for Name: ventas_cantina; Type: TABLE DATA; Schema: complejo_deportivo; Owner: postgres
--

INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (1, NULL, '2025-11-30 20:13:29.981611', 3500.00, NULL, NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (2, NULL, '2025-12-02 18:22:07.446324', 7100.00, NULL, NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (3, NULL, '2025-12-02 18:31:14.320929', 3700.00, 'efectivo', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (4, NULL, '2025-12-02 18:37:11.458778', 7000.00, 'transferencia', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (5, NULL, '2025-12-02 19:00:14.496521', 8000.00, 'transferencia', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (6, NULL, '2025-12-18 11:52:07.22532', 3500.00, 'efectivo', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (7, NULL, '2025-12-19 09:11:24.920274', 2800.00, 'cuenta_corriente', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (8, NULL, '2025-12-19 10:35:31.201031', 8000.00, 'qr', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (9, NULL, '2025-12-19 10:35:38.423975', 4700.00, 'cuenta_corriente', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (10, NULL, '2025-12-20 17:24:48.974937', 3500.00, 'cuenta_corriente', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (11, NULL, '2025-12-20 17:35:23.95283', 3500.00, 'efectivo', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (12, NULL, '2025-12-20 17:35:29.833838', 3700.00, 'cuenta_corriente', NULL);
INSERT INTO complejo_deportivo.ventas_cantina (id, turno_id, fecha, total, metodo_pago, caja_id) VALUES (13, NULL, '2025-12-20 17:49:08.237303', 2000.00, 'cuenta_corriente', NULL);


--
-- Data for Name: brackets; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.brackets (id, tournament_category_id, status, generado_at, created_at, updated_at) VALUES (6, 2, 'published', '2026-01-15 01:37:52.766-03', '2026-01-15 01:37:52.768-03', '2026-01-15 01:37:52.768-03');


--
-- Data for Name: categories; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (1, '1ra', 1, true, '2026-01-14 00:36:15.202-03', '2026-01-14 00:36:15.202-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (2, '2da', 2, true, '2026-01-14 00:36:15.225-03', '2026-01-14 00:36:15.225-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (3, '3ra', 3, true, '2026-01-14 00:36:15.23-03', '2026-01-14 00:36:15.23-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (4, '4ta', 4, true, '2026-01-14 00:36:15.234-03', '2026-01-14 00:36:15.234-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (5, '5ta', 5, true, '2026-01-14 00:36:15.238-03', '2026-01-14 00:36:15.238-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (6, '6ta', 6, true, '2026-01-14 00:36:15.241-03', '2026-01-14 00:36:15.241-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (7, '7ma', 7, true, '2026-01-14 00:36:15.244-03', '2026-01-14 00:36:15.244-03');
INSERT INTO padel_circuit.categories (id, name, rank, active, created_at, updated_at) VALUES (8, '8va', 8, true, '2026-01-14 00:36:15.248-03', '2026-01-14 00:36:15.248-03');


--
-- Data for Name: matches; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.matches (id, bracket_id, round_number, round_name, match_number, team_home_id, team_away_id, winner_team_id, score_json, status, next_match_id, next_match_slot, scheduled_at, home_source_zone_id, home_source_position, away_source_zone_id, away_source_position, created_at, updated_at, venue) VALUES (3, 6, 2, 'Final', 1, NULL, NULL, NULL, NULL, 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-15 01:37:52.794-03', '2026-01-15 01:37:52.794-03', NULL);
INSERT INTO padel_circuit.matches (id, bracket_id, round_number, round_name, match_number, team_home_id, team_away_id, winner_team_id, score_json, status, next_match_id, next_match_slot, scheduled_at, home_source_zone_id, home_source_position, away_source_zone_id, away_source_position, created_at, updated_at, venue) VALUES (1, 6, 1, 'Semifinal', 1, 1, NULL, NULL, NULL, 'pending', 3, 'home', NULL, 3, 1, 4, 2, '2026-01-15 01:37:52.783-03', '2026-01-15 01:37:52.797-03', NULL);
INSERT INTO padel_circuit.matches (id, bracket_id, round_number, round_name, match_number, team_home_id, team_away_id, winner_team_id, score_json, status, next_match_id, next_match_slot, scheduled_at, home_source_zone_id, home_source_position, away_source_zone_id, away_source_position, created_at, updated_at, venue) VALUES (2, 6, 1, 'Semifinal', 2, 5, 2, NULL, NULL, 'pending', 3, 'away', NULL, 4, 1, 3, 2, '2026-01-15 01:37:52.79-03', '2026-01-15 01:37:52.802-03', NULL);


--
-- Data for Name: player_profiles; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000001', 'Juan', 'Pérez', '1234567890', 4, true, '2026-01-15 00:12:00.58-03', '2026-01-15 00:12:00.58-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000002', 'María', 'González', '1234567891', 4, true, '2026-01-15 00:12:00.589-03', '2026-01-15 00:12:00.589-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000003', 'Carlos', 'Rodríguez', '1234567892', 4, true, '2026-01-15 00:12:00.594-03', '2026-01-15 00:12:00.594-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000004', 'Ana', 'Martínez', '1234567893', 4, true, '2026-01-15 00:12:00.6-03', '2026-01-15 00:12:00.6-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000005', 'Luis', 'López', '1234567894', 4, true, '2026-01-15 00:12:00.606-03', '2026-01-15 00:12:00.606-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000006', 'Laura', 'Fernández', '1234567895', 4, true, '2026-01-15 00:12:00.61-03', '2026-01-15 00:12:00.61-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000007', 'Diego', 'Sánchez', '1234567896', 4, true, '2026-01-15 00:12:00.614-03', '2026-01-15 00:12:00.614-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000008', 'Sofía', 'Ramírez', '1234567897', 4, true, '2026-01-15 00:12:00.62-03', '2026-01-15 00:12:00.62-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000009', 'Martín', 'Torres', '1234567898', 4, true, '2026-01-15 00:12:00.625-03', '2026-01-15 00:12:00.625-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000010', 'Valentina', 'Flores', '1234567899', 4, true, '2026-01-15 00:12:00.629-03', '2026-01-15 00:12:00.629-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000011', 'Facundo', 'Díaz', '1234567800', 4, true, '2026-01-15 00:12:00.632-03', '2026-01-15 00:12:00.632-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000012', 'Camila', 'Romero', '1234567801', 4, true, '2026-01-15 00:12:00.637-03', '2026-01-15 00:12:00.637-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000013', 'Jugador4ta', 'Test1', '1150006000', 4, true, '2026-01-15 01:22:31.471124-03', '2026-01-15 01:22:31.471124-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000014', 'Jugador4ta', 'Test2', '1150016001', 4, true, '2026-01-15 01:22:31.498739-03', '2026-01-15 01:22:31.498739-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000015', 'Jugador4ta', 'Test3', '1150026002', 4, true, '2026-01-15 01:22:31.500832-03', '2026-01-15 01:22:31.500832-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000016', 'Jugador4ta', 'Test4', '1150036003', 4, true, '2026-01-15 01:22:31.502845-03', '2026-01-15 01:22:31.502845-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000017', 'Jugador4ta', 'Test5', '1150046004', 4, true, '2026-01-15 01:22:31.50455-03', '2026-01-15 01:22:31.50455-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000018', 'Jugador4ta', 'Test6', '1150056005', 4, true, '2026-01-15 01:22:31.506417-03', '2026-01-15 01:22:31.506417-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000019', 'Jugador4ta', 'Test7', '1150066006', 4, true, '2026-01-15 01:22:31.508246-03', '2026-01-15 01:22:31.508246-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000020', 'Jugador4ta', 'Test8', '1150076007', 4, true, '2026-01-15 01:22:31.510043-03', '2026-01-15 01:22:31.510043-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000021', 'Jugador4ta', 'Test9', '1150086008', 4, true, '2026-01-15 01:22:31.511599-03', '2026-01-15 01:22:31.511599-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000022', 'Jugador4ta', 'Test10', '1150096009', 4, true, '2026-01-15 01:22:31.513623-03', '2026-01-15 01:22:31.513623-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000023', 'Jugador4ta', 'Test11', '1150106010', 4, true, '2026-01-15 01:22:31.515212-03', '2026-01-15 01:22:31.515212-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000024', 'Jugador4ta', 'Test12', '1150116011', 4, true, '2026-01-15 01:22:31.516841-03', '2026-01-15 01:22:31.516841-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000025', 'Jugador4ta', 'Test13', '1150126012', 4, true, '2026-01-15 01:22:31.518429-03', '2026-01-15 01:22:31.518429-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000026', 'Jugador4ta', 'Test14', '1150136013', 4, true, '2026-01-15 01:22:31.519647-03', '2026-01-15 01:22:31.519647-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000027', 'Jugador4ta', 'Test15', '1150146014', 4, true, '2026-01-15 01:22:31.521178-03', '2026-01-15 01:22:31.521178-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000028', 'Jugador4ta', 'Test16', '1150156015', 4, true, '2026-01-15 01:22:31.522823-03', '2026-01-15 01:22:31.522823-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000029', 'Jugador4ta', 'Test17', '1150166016', 4, true, '2026-01-15 01:22:31.524708-03', '2026-01-15 01:22:31.524708-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000030', 'Jugador4ta', 'Test18', '1150176017', 4, true, '2026-01-15 01:22:31.526476-03', '2026-01-15 01:22:31.526476-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000031', 'Jugador4ta', 'Test19', '1150186018', 4, true, '2026-01-15 01:22:31.527878-03', '2026-01-15 01:22:31.527878-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000032', 'Jugador4ta', 'Test20', '1150196019', 4, true, '2026-01-15 01:22:31.529159-03', '2026-01-15 01:22:31.529159-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000033', 'Jugador4ta', 'Test21', '1150206020', 4, true, '2026-01-15 01:22:31.530404-03', '2026-01-15 01:22:31.530404-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000034', 'Jugador4ta', 'Test22', '1150216021', 4, true, '2026-01-15 01:22:31.531517-03', '2026-01-15 01:22:31.531517-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000035', 'Jugador4ta', 'Test23', '1150226022', 4, true, '2026-01-15 01:22:31.532795-03', '2026-01-15 01:22:31.532795-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000036', 'Jugador4ta', 'Test24', '1150236023', 4, true, '2026-01-15 01:22:31.534151-03', '2026-01-15 01:22:31.534151-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000037', 'Jugador4ta', 'Test25', '1150246024', 4, true, '2026-01-15 01:22:31.535402-03', '2026-01-15 01:22:31.535402-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000038', 'Jugador4ta', 'Test26', '1150256025', 4, true, '2026-01-15 01:22:31.536754-03', '2026-01-15 01:22:31.536754-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000039', 'Jugador4ta', 'Test27', '1150266026', 4, true, '2026-01-15 01:22:31.538627-03', '2026-01-15 01:22:31.538627-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000040', 'Jugador4ta', 'Test28', '1150276027', 4, true, '2026-01-15 01:22:31.539917-03', '2026-01-15 01:22:31.539917-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000041', 'Jugador4ta', 'Test29', '1150286028', 4, true, '2026-01-15 01:22:31.541069-03', '2026-01-15 01:22:31.541069-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000042', 'Jugador4ta', 'Test30', '1150296029', 4, true, '2026-01-15 01:22:31.542185-03', '2026-01-15 01:22:31.542185-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000043', 'Jugador4ta', 'Test31', '1150306030', 4, true, '2026-01-15 01:22:31.543217-03', '2026-01-15 01:22:31.543217-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000044', 'Jugador4ta', 'Test32', '1150316031', 4, true, '2026-01-15 01:22:31.544486-03', '2026-01-15 01:22:31.544486-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000045', 'Jugador4ta', 'Test33', '1150326032', 4, true, '2026-01-15 01:22:31.545538-03', '2026-01-15 01:22:31.545538-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000046', 'Jugador4ta', 'Test34', '1150336033', 4, true, '2026-01-15 01:22:31.546469-03', '2026-01-15 01:22:31.546469-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000047', 'Jugador4ta', 'Test35', '1150346034', 4, true, '2026-01-15 01:22:31.54744-03', '2026-01-15 01:22:31.54744-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000048', 'Jugador4ta', 'Test36', '1150356035', 4, true, '2026-01-15 01:22:31.548604-03', '2026-01-15 01:22:31.548604-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000049', 'Jugador4ta', 'Test37', '1150366036', 4, true, '2026-01-15 01:22:31.549702-03', '2026-01-15 01:22:31.549702-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000050', 'Jugador4ta', 'Test38', '1150376037', 4, true, '2026-01-15 01:22:31.551325-03', '2026-01-15 01:22:31.551325-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000051', 'Jugador4ta', 'Test39', '1150386038', 4, true, '2026-01-15 01:22:31.553025-03', '2026-01-15 01:22:31.553025-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000052', 'Jugador4ta', 'Test40', '1150396039', 4, true, '2026-01-15 01:22:31.55449-03', '2026-01-15 01:22:31.55449-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000053', 'Jugador4ta', 'Test41', '1150406040', 4, true, '2026-01-15 01:22:31.555591-03', '2026-01-15 01:22:31.555591-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000054', 'Jugador4ta', 'Test42', '1150416041', 4, true, '2026-01-15 01:22:31.556612-03', '2026-01-15 01:22:31.556612-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000055', 'Jugador4ta', 'Test43', '1150426042', 4, true, '2026-01-15 01:22:31.557749-03', '2026-01-15 01:22:31.557749-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000056', 'Jugador4ta', 'Test44', '1150436043', 4, true, '2026-01-15 01:22:31.55888-03', '2026-01-15 01:22:31.55888-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000057', 'Jugador4ta', 'Test45', '1150446044', 4, true, '2026-01-15 01:22:31.55991-03', '2026-01-15 01:22:31.55991-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000058', 'Jugador4ta', 'Test46', '1150456045', 4, true, '2026-01-15 01:22:31.560952-03', '2026-01-15 01:22:31.560952-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000059', 'Jugador4ta', 'Test47', '1150466046', 4, true, '2026-01-15 01:22:31.562068-03', '2026-01-15 01:22:31.562068-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000060', 'Jugador4ta', 'Test48', '1150476047', 4, true, '2026-01-15 01:22:31.563316-03', '2026-01-15 01:22:31.563316-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000061', 'Jugador5ta', 'Test1', '1170008000', 5, true, '2026-01-15 01:22:31.564951-03', '2026-01-15 01:22:31.564951-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000062', 'Jugador5ta', 'Test2', '1170018001', 5, true, '2026-01-15 01:22:31.566681-03', '2026-01-15 01:22:31.566681-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000063', 'Jugador5ta', 'Test3', '1170028002', 5, true, '2026-01-15 01:22:31.56796-03', '2026-01-15 01:22:31.56796-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000064', 'Jugador5ta', 'Test4', '1170038003', 5, true, '2026-01-15 01:22:31.569197-03', '2026-01-15 01:22:31.569197-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000065', 'Jugador5ta', 'Test5', '1170048004', 5, true, '2026-01-15 01:22:31.570259-03', '2026-01-15 01:22:31.570259-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000066', 'Jugador5ta', 'Test6', '1170058005', 5, true, '2026-01-15 01:22:31.571356-03', '2026-01-15 01:22:31.571356-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000067', 'Jugador5ta', 'Test7', '1170068006', 5, true, '2026-01-15 01:22:31.572568-03', '2026-01-15 01:22:31.572568-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000068', 'Jugador5ta', 'Test8', '1170078007', 5, true, '2026-01-15 01:22:31.573565-03', '2026-01-15 01:22:31.573565-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000069', 'Jugador5ta', 'Test9', '1170088008', 5, true, '2026-01-15 01:22:31.574459-03', '2026-01-15 01:22:31.574459-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000070', 'Jugador5ta', 'Test10', '1170098009', 5, true, '2026-01-15 01:22:31.575371-03', '2026-01-15 01:22:31.575371-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000071', 'Jugador5ta', 'Test11', '1170108010', 5, true, '2026-01-15 01:22:31.576426-03', '2026-01-15 01:22:31.576426-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000072', 'Jugador5ta', 'Test12', '1170118011', 5, true, '2026-01-15 01:22:31.577576-03', '2026-01-15 01:22:31.577576-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000073', 'Jugador5ta', 'Test13', '1170128012', 5, true, '2026-01-15 01:22:31.578935-03', '2026-01-15 01:22:31.578935-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000074', 'Jugador5ta', 'Test14', '1170138013', 5, true, '2026-01-15 01:22:31.579993-03', '2026-01-15 01:22:31.579993-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000075', 'Jugador5ta', 'Test15', '1170148014', 5, true, '2026-01-15 01:22:31.581197-03', '2026-01-15 01:22:31.581197-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000076', 'Jugador5ta', 'Test16', '1170158015', 5, true, '2026-01-15 01:22:31.582307-03', '2026-01-15 01:22:31.582307-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000077', 'Jugador5ta', 'Test17', '1170168016', 5, true, '2026-01-15 01:22:31.583999-03', '2026-01-15 01:22:31.583999-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000078', 'Jugador5ta', 'Test18', '1170178017', 5, true, '2026-01-15 01:22:31.585244-03', '2026-01-15 01:22:31.585244-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000079', 'Jugador5ta', 'Test19', '1170188018', 5, true, '2026-01-15 01:22:31.586423-03', '2026-01-15 01:22:31.586423-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000080', 'Jugador5ta', 'Test20', '1170198019', 5, true, '2026-01-15 01:22:31.587517-03', '2026-01-15 01:22:31.587517-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000081', 'Jugador5ta', 'Test21', '1170208020', 5, true, '2026-01-15 01:22:31.588472-03', '2026-01-15 01:22:31.588472-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000082', 'Jugador5ta', 'Test22', '1170218021', 5, true, '2026-01-15 01:22:31.589386-03', '2026-01-15 01:22:31.589386-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000083', 'Jugador5ta', 'Test23', '1170228022', 5, true, '2026-01-15 01:22:31.590447-03', '2026-01-15 01:22:31.590447-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000084', 'Jugador5ta', 'Test24', '1170238023', 5, true, '2026-01-15 01:22:31.591648-03', '2026-01-15 01:22:31.591648-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000085', 'Jugador5ta', 'Test25', '1170248024', 5, true, '2026-01-15 01:22:31.592873-03', '2026-01-15 01:22:31.592873-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000086', 'Jugador5ta', 'Test26', '1170258025', 5, true, '2026-01-15 01:22:31.593822-03', '2026-01-15 01:22:31.593822-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000087', 'Jugador5ta', 'Test27', '1170268026', 5, true, '2026-01-15 01:22:31.595199-03', '2026-01-15 01:22:31.595199-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000088', 'Jugador5ta', 'Test28', '1170278027', 5, true, '2026-01-15 01:22:31.596269-03', '2026-01-15 01:22:31.596269-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000089', 'Jugador5ta', 'Test29', '1170288028', 5, true, '2026-01-15 01:22:31.597336-03', '2026-01-15 01:22:31.597336-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000090', 'Jugador5ta', 'Test30', '1170298029', 5, true, '2026-01-15 01:22:31.598914-03', '2026-01-15 01:22:31.598914-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000091', 'Jugador5ta', 'Test31', '1170308030', 5, true, '2026-01-15 01:22:31.600161-03', '2026-01-15 01:22:31.600161-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000092', 'Jugador5ta', 'Test32', '1170318031', 5, true, '2026-01-15 01:22:31.601559-03', '2026-01-15 01:22:31.601559-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000093', 'Jugador5ta', 'Test33', '1170328032', 5, true, '2026-01-15 01:22:31.602535-03', '2026-01-15 01:22:31.602535-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000094', 'Jugador5ta', 'Test34', '1170338033', 5, true, '2026-01-15 01:22:31.603492-03', '2026-01-15 01:22:31.603492-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000095', 'Jugador5ta', 'Test35', '1170348034', 5, true, '2026-01-15 01:22:31.604403-03', '2026-01-15 01:22:31.604403-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000096', 'Jugador5ta', 'Test36', '1170358035', 5, true, '2026-01-15 01:22:31.605297-03', '2026-01-15 01:22:31.605297-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000097', 'Jugador5ta', 'Test37', '1170368036', 5, true, '2026-01-15 01:22:31.606315-03', '2026-01-15 01:22:31.606315-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000098', 'Jugador5ta', 'Test38', '1170378037', 5, true, '2026-01-15 01:22:31.607256-03', '2026-01-15 01:22:31.607256-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000099', 'Jugador5ta', 'Test39', '1170388038', 5, true, '2026-01-15 01:22:31.608256-03', '2026-01-15 01:22:31.608256-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000100', 'Jugador5ta', 'Test40', '1170398039', 5, true, '2026-01-15 01:22:31.609209-03', '2026-01-15 01:22:31.609209-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000101', 'Jugador5ta', 'Test41', '1170408040', 5, true, '2026-01-15 01:22:31.610554-03', '2026-01-15 01:22:31.610554-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000102', 'Jugador5ta', 'Test42', '1170418041', 5, true, '2026-01-15 01:22:31.61172-03', '2026-01-15 01:22:31.61172-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000103', 'Jugador5ta', 'Test43', '1170428042', 5, true, '2026-01-15 01:22:31.612511-03', '2026-01-15 01:22:31.612511-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000104', 'Jugador5ta', 'Test44', '1170438043', 5, true, '2026-01-15 01:22:31.613246-03', '2026-01-15 01:22:31.613246-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000105', 'Jugador5ta', 'Test45', '1170448044', 5, true, '2026-01-15 01:22:31.614297-03', '2026-01-15 01:22:31.614297-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000106', 'Jugador5ta', 'Test46', '1170458045', 5, true, '2026-01-15 01:22:31.615455-03', '2026-01-15 01:22:31.615455-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000107', 'Jugador5ta', 'Test47', '1170468046', 5, true, '2026-01-15 01:22:31.616849-03', '2026-01-15 01:22:31.616849-03');
INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at) VALUES ('30000108', 'Jugador5ta', 'Test48', '1170478047', 5, true, '2026-01-15 01:22:31.618399-03', '2026-01-15 01:22:31.618399-03');


--
-- Data for Name: registrations; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (1, 1, 5, 'confirmado', '2026-01-15 00:26:02.08-03', '2026-01-15 00:26:02.08-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (2, 1, 4, 'confirmado', '2026-01-15 00:26:05.76-03', '2026-01-15 00:26:05.76-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (3, 1, 2, 'confirmado', '2026-01-15 00:26:14.424-03', '2026-01-15 00:26:14.424-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (4, 1, 1, 'confirmado', '2026-01-15 00:26:18.744-03', '2026-01-15 00:26:18.744-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (5, 3, 6, 'confirmado', '2026-01-15 01:28:30.376-03', '2026-01-15 01:28:30.376-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (6, 3, 8, 'confirmado', '2026-01-15 01:28:38.065-03', '2026-01-15 01:28:38.065-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (7, 3, 7, 'confirmado', '2026-01-15 01:28:45.189-03', '2026-01-15 01:28:45.189-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (8, 3, 14, 'confirmado', '2026-01-15 01:28:54.791-03', '2026-01-15 01:28:54.791-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (9, 3, 13, 'confirmado', '2026-01-15 01:28:58.316-03', '2026-01-15 01:28:58.316-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (10, 3, 15, 'confirmado', '2026-01-15 01:29:01.792-03', '2026-01-15 01:29:01.792-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (11, 3, 18, 'confirmado', '2026-01-15 01:29:05.778-03', '2026-01-15 01:29:05.778-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (12, 3, 16, 'confirmado', '2026-01-15 01:29:10.296-03', '2026-01-15 01:29:10.296-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (13, 3, 11, 'confirmado', '2026-01-15 01:29:14.972-03', '2026-01-15 01:29:14.972-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (14, 4, 4, 'confirmado', '2026-01-15 20:44:32.582-03', '2026-01-15 20:44:32.582-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (15, 4, 5, 'confirmado', '2026-01-15 20:45:05.198-03', '2026-01-15 20:45:05.198-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (16, 5, 7, 'confirmado', '2026-01-15 20:48:51.69-03', '2026-01-15 20:48:51.69-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (17, 5, 14, 'confirmado', '2026-01-15 20:48:55.469-03', '2026-01-15 20:48:55.469-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (18, 5, 11, 'confirmado', '2026-01-15 20:49:02.023-03', '2026-01-15 20:49:02.023-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (19, 5, 15, 'confirmado', '2026-01-15 20:49:05.73-03', '2026-01-15 20:49:05.73-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (20, 5, 16, 'confirmado', '2026-01-15 20:49:12.97-03', '2026-01-15 20:49:12.97-03');
INSERT INTO padel_circuit.registrations (id, tournament_category_id, team_id, estado, created_at, updated_at) VALUES (21, 5, 17, 'confirmado', '2026-01-15 20:49:24.319-03', '2026-01-15 20:49:24.319-03');


--
-- Data for Name: teams; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (1, '30000001', '30000002', 'activa', '2026-01-15 00:23:18.726-03', '2026-01-15 00:23:18.726-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (2, '30000003', '30000004', 'activa', '2026-01-15 00:23:31.409-03', '2026-01-15 00:23:31.409-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (3, '30000005', '30000006', 'activa', '2026-01-15 00:23:46.412-03', '2026-01-15 00:23:46.412-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (4, '30000007', '30000008', 'activa', '2026-01-15 00:23:58.519-03', '2026-01-15 00:23:58.519-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (5, '30000009', '30000010', 'activa', '2026-01-15 00:24:08.332-03', '2026-01-15 00:24:08.332-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (6, '30000061', '30000062', 'activa', '2026-01-15 01:25:18.559-03', '2026-01-15 01:25:18.559-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (7, '30000063', '30000064', 'activa', '2026-01-15 01:25:32.814-03', '2026-01-15 01:25:32.814-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (8, '30000065', '30000066', 'activa', '2026-01-15 01:25:42.333-03', '2026-01-15 01:25:42.333-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (9, '30000067', '30000068', 'activa', '2026-01-15 01:25:52.794-03', '2026-01-15 01:25:52.794-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (10, '30000069', '30000070', 'activa', '2026-01-15 01:26:02.857-03', '2026-01-15 01:26:02.857-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (11, '30000070', '30000071', 'activa', '2026-01-15 01:26:14.26-03', '2026-01-15 01:26:14.26-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (12, '30000072', '30000073', 'activa', '2026-01-15 01:26:40.46-03', '2026-01-15 01:26:40.46-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (13, '30000074', '30000075', 'activa', '2026-01-15 01:26:48.619-03', '2026-01-15 01:26:48.619-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (14, '30000076', '30000077', 'activa', '2026-01-15 01:27:20.755-03', '2026-01-15 01:27:20.755-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (15, '30000078', '30000079', 'activa', '2026-01-15 01:27:29.379-03', '2026-01-15 01:27:29.379-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (16, '30000080', '30000081', 'activa', '2026-01-15 01:27:39.107-03', '2026-01-15 01:27:39.107-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (17, '30000082', '30000083', 'activa', '2026-01-15 01:27:46.581-03', '2026-01-15 01:27:46.581-03');
INSERT INTO padel_circuit.teams (id, player1_dni, player2_dni, estado, created_at, updated_at) VALUES (18, '30000084', '30000085', 'activa', '2026-01-15 01:27:57.798-03', '2026-01-15 01:27:57.798-03');


--
-- Data for Name: tournament_categories; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (1, 5, 4, 12, true, 'BEST_OF_3_FULL', 10, true, 2, 0, 3, 2, '2026-01-15 00:08:42.151-03', '2026-01-15 00:26:25.558-03', 'zonas_generadas');
INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (3, 5, 5, 12, true, 'BEST_OF_3_FULL', 10, true, 2, 0, 3, 2, '2026-01-15 01:28:19.747-03', '2026-01-15 01:29:25.576-03', 'zonas_generadas');
INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (2, 7, 4, 12, true, 'BEST_OF_3_SUPER_TB', 10, true, 2, 0, NULL, NULL, '2026-01-15 00:46:57.88-03', '2026-01-15 01:37:52.805-03', 'playoffs_generados');
INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (4, 8, 4, 13, true, 'BEST_OF_3_FULL', 10, true, 2, 0, NULL, NULL, '2026-01-15 20:44:22.473-03', '2026-01-15 20:44:22.473-03', 'draft');
INSERT INTO padel_circuit.tournament_categories (id, tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points, zone_size, qualifiers_per_zone, created_at, updated_at, estado) VALUES (5, 9, 5, 8, true, 'BEST_OF_3_SUPER_TB', 10, true, 2, 0, NULL, NULL, '2026-01-15 20:48:44.652-03', '2026-01-15 20:48:44.652-03', 'draft');


--
-- Data for Name: tournament_points; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--



--
-- Data for Name: tournaments; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.tournaments (id, nombre, fecha_inicio, fecha_fin, estado, descripcion, created_at, updated_at, double_points) VALUES (5, 'primer', '2026-01-15 21:00:00-03', '2026-01-17 21:00:00-03', 'draft', 'primer', '2026-01-14 23:56:06.579-03', '2026-01-14 23:56:06.579-03', false);
INSERT INTO padel_circuit.tournaments (id, nombre, fecha_inicio, fecha_fin, estado, descripcion, created_at, updated_at, double_points) VALUES (7, 'segundo torneo', '2026-01-22 21:00:00-03', '2026-01-17 21:00:00-03', 'draft', 'segundo ', '2026-01-15 00:46:38.877-03', '2026-01-15 00:46:38.877-03', false);
INSERT INTO padel_circuit.tournaments (id, nombre, fecha_inicio, fecha_fin, estado, descripcion, created_at, updated_at, double_points) VALUES (8, 'tercer', '2026-01-22 21:00:00-03', '2026-01-24 21:00:00-03', 'draft', '', '2026-01-15 20:44:04.801-03', '2026-01-15 20:44:04.801-03', false);
INSERT INTO padel_circuit.tournaments (id, nombre, fecha_inicio, fecha_fin, estado, descripcion, created_at, updated_at, double_points) VALUES (9, 'cuER', '2026-01-29 21:00:00-03', '2026-01-24 21:00:00-03', 'draft', '', '2026-01-15 20:48:34.499-03', '2026-01-15 20:48:34.499-03', false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (1, 'admin', '$2a$10$edNCEVls0CA6JBuNZVNDPuN5K4FAWvvU23QMMYWl3AQW51xGDfJ8q', 'admin', '2026-01-14 00:36:15.346-03', '2026-01-14 00:36:15.346-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (2, '30000001', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.558-03', '2026-01-15 00:12:00.558-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (3, '30000002', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.587-03', '2026-01-15 00:12:00.587-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (4, '30000003', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.592-03', '2026-01-15 00:12:00.592-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (5, '30000004', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.598-03', '2026-01-15 00:12:00.598-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (6, '30000005', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.603-03', '2026-01-15 00:12:00.603-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (7, '30000006', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.609-03', '2026-01-15 00:12:00.609-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (8, '30000007', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.613-03', '2026-01-15 00:12:00.613-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (9, '30000008', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.618-03', '2026-01-15 00:12:00.618-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (10, '30000009', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.623-03', '2026-01-15 00:12:00.623-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (11, '30000010', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.627-03', '2026-01-15 00:12:00.627-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (12, '30000011', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.631-03', '2026-01-15 00:12:00.631-03');
INSERT INTO padel_circuit.users (id, dni, password_hash, role, created_at, updated_at) VALUES (13, '30000012', '$2a$10$h6zu5d3mYqCi0xcZRUErt.l2ImNiBPko.FwkDuy5XiuoOIrKSK9BS', 'player', '2026-01-15 00:12:00.636-03', '2026-01-15 00:12:00.636-03');


--
-- Data for Name: venues; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.venues (id, name, address, courts_count, active, created_at, updated_at) VALUES (1, 'Club Deportivo Central', 'Av. Principal 123', 4, true, '2026-01-15 03:36:08.584488', '2026-01-15 03:36:08.584488');
INSERT INTO padel_circuit.venues (id, name, address, courts_count, active, created_at, updated_at) VALUES (2, 'Complejo Padel Norte', 'Calle Norte 456', 6, true, '2026-01-15 03:36:08.584488', '2026-01-15 03:36:08.584488');
INSERT INTO padel_circuit.venues (id, name, address, courts_count, active, created_at, updated_at) VALUES (3, 'Centro Deportivo Sur', 'Av. Sur 789', 3, true, '2026-01-15 03:36:08.584488', '2026-01-15 03:36:08.584488');


--
-- Data for Name: zone_matches; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (2, 2, 1, 1, 2, 4, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 00:26:25.548-03', '2026-01-15 00:26:25.548-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (1, 1, 1, 1, 1, 5, 'pending', NULL, NULL, NULL, '2026-01-19 17:30:00-03', '2026-01-15 00:26:25.523-03', '2026-01-15 00:32:20.207-03', 'de');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (3, 3, 1, 1, 1, 4, 'played', '{"sets": [{"away": 3, "home": 6}, {"away": 3, "home": 6}], "format": "BEST_OF_3_SUPER_TB"}', 1, '2026-01-15 01:12:38.717-03', '2026-01-16 16:00:00-03', '2026-01-15 00:47:50.827-03', '2026-01-15 01:12:38.718-03', 'Centro Deportivo Sur');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (4, 3, 1, 2, 2, 2, 'played', '{"sets": [{"away": 2, "home": 6}, {"away": 4, "home": 6}], "format": "BEST_OF_3_SUPER_TB"}', 2, '2026-01-15 01:12:57.098-03', NULL, '2026-01-15 00:47:50.832-03', '2026-01-15 01:12:57.099-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (6, 3, 2, 4, 4, 4, 'played', '{"sets": [{"away": 2, "home": 6}, {"away": 5, "home": 7}], "format": "BEST_OF_3_SUPER_TB"}', 4, '2026-01-15 01:13:07.117-03', NULL, '2026-01-15 00:47:50.839-03', '2026-01-15 01:13:07.118-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (5, 3, 2, 3, 1, 2, 'played', '{"sets": [{"away": 6, "home": 7}, {"away": 6, "home": 7}], "format": "BEST_OF_3_SUPER_TB"}', 1, '2026-01-15 01:13:15.967-03', NULL, '2026-01-15 00:47:50.835-03', '2026-01-15 01:13:15.967-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (7, 5, 1, 1, 11, 13, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.516-03', '2026-01-15 01:29:25.516-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (8, 5, 2, 2, 8, 11, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.52-03', '2026-01-15 01:29:25.52-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (9, 5, 3, 3, 8, 13, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.522-03', '2026-01-15 01:29:25.522-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (10, 6, 1, 1, 15, 18, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.537-03', '2026-01-15 01:29:25.537-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (11, 6, 2, 2, 7, 15, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.54-03', '2026-01-15 01:29:25.54-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (12, 6, 3, 3, 7, 18, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.543-03', '2026-01-15 01:29:25.543-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (13, 7, 1, 1, 14, 16, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.556-03', '2026-01-15 01:29:25.556-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (14, 7, 2, 2, 6, 14, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.559-03', '2026-01-15 01:29:25.559-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (15, 7, 3, 3, 6, 16, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 01:29:25.562-03', '2026-01-15 01:29:25.562-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (19, 9, 2, 4, 15, 15, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 20:49:54.276-03', '2026-01-15 20:49:54.276-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (20, 10, 1, 1, 14, 11, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 20:49:54.297-03', '2026-01-15 20:49:54.297-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (21, 10, 1, 2, 7, 7, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 20:49:54.301-03', '2026-01-15 20:49:54.301-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (22, 10, 2, 3, 14, 7, 'pending', NULL, NULL, NULL, NULL, '2026-01-15 20:49:54.304-03', '2026-01-15 20:49:54.304-03', NULL);
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (16, 9, 1, 1, 17, 15, 'pending', NULL, NULL, NULL, '2026-01-17 22:55:00-03', '2026-01-15 20:49:54.243-03', '2026-01-15 20:54:00.624-03', 'Centro Deportivo Sur');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (17, 9, 1, 2, 16, 16, 'pending', NULL, NULL, NULL, '2026-01-24 12:58:00-03', '2026-01-15 20:49:54.268-03', '2026-01-16 08:54:09.798-03', 'Centro Deportivo Sur');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (18, 9, 2, 3, 17, 16, 'pending', NULL, NULL, NULL, '2026-01-24 13:59:00-03', '2026-01-15 20:49:54.272-03', '2026-01-16 08:54:35.139-03', 'Centro Deportivo Sur');
INSERT INTO padel_circuit.zone_matches (id, zone_id, round_number, match_number, team_home_id, team_away_id, status, score_json, winner_team_id, played_at, scheduled_at, created_at, updated_at, venue) VALUES (23, 10, 2, 4, 11, 11, 'pending', NULL, NULL, NULL, '2026-01-24 13:06:00-03', '2026-01-15 20:49:54.306-03', '2026-01-16 09:02:50.712-03', 'Centro Deportivo Sur');


--
-- Data for Name: zone_standings; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:26:25.532-03', '2026-01-15 00:26:25.532-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (2, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:26:25.543-03', '2026-01-15 00:26:25.543-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (3, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:26:25.551-03', '2026-01-15 00:26:25.551-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (4, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:26:25.554-03', '2026-01-15 00:26:25.554-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (8, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 00:47:50.846-03', '2026-01-15 00:47:50.846-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (5, 3, 1, 1, 1, 0, 2, 2, 0, 2, 12, 6, 6, '2026-01-15 00:47:50.805-03', '2026-01-15 01:13:15.983-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (6, 3, 2, 2, 1, 1, 2, 2, 2, 0, 18, 18, 0, '2026-01-15 00:47:50.814-03', '2026-01-15 01:13:15.985-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (7, 3, 4, 3, 1, 2, 2, 2, 4, -2, 26, 32, -6, '2026-01-15 00:47:50.822-03', '2026-01-15 01:13:15.989-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (9, 5, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.525-03', '2026-01-15 01:29:25.525-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (10, 5, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.529-03', '2026-01-15 01:29:25.529-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (11, 5, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.532-03', '2026-01-15 01:29:25.532-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (12, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.546-03', '2026-01-15 01:29:25.546-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (13, 6, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.549-03', '2026-01-15 01:29:25.549-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (14, 6, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.551-03', '2026-01-15 01:29:25.551-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (15, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.566-03', '2026-01-15 01:29:25.566-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (16, 7, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.569-03', '2026-01-15 01:29:25.569-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (17, 7, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 01:29:25.571-03', '2026-01-15 01:29:25.571-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (18, 8, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:44:56.479-03', '2026-01-15 20:44:56.479-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (19, 9, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.194-03', '2026-01-15 20:49:54.194-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (20, 9, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.23-03', '2026-01-15 20:49:54.23-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (21, 9, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.239-03', '2026-01-15 20:49:54.239-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (22, 10, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.285-03', '2026-01-15 20:49:54.285-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (23, 10, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.29-03', '2026-01-15 20:49:54.29-03');
INSERT INTO padel_circuit.zone_standings (id, zone_id, team_id, played, wins, losses, points, sets_for, sets_against, sets_diff, games_for, games_against, games_diff, created_at, updated_at) VALUES (24, 10, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2026-01-15 20:49:54.295-03', '2026-01-15 20:49:54.295-03');


--
-- Data for Name: zone_teams; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (1, 1, 5, '2026-01-15 00:26:25.5-03', '2026-01-15 00:26:25.5-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (2, 2, 2, '2026-01-15 00:26:25.508-03', '2026-01-15 00:26:25.508-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (3, 1, 1, '2026-01-15 00:26:25.512-03', '2026-01-15 00:26:25.512-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (4, 2, 4, '2026-01-15 00:26:25.515-03', '2026-01-15 00:26:25.515-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (5, 3, 1, '2026-01-15 00:47:50.797-03', '2026-01-15 00:47:50.797-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (6, 3, 2, '2026-01-15 00:47:50.811-03', '2026-01-15 00:47:50.811-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (7, 3, 4, '2026-01-15 00:47:50.818-03', '2026-01-15 00:47:50.818-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (8, 4, 5, '2026-01-15 00:47:50.844-03', '2026-01-15 00:47:50.844-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (9, 5, 8, '2026-01-15 01:29:25.49-03', '2026-01-15 01:29:25.49-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (10, 6, 15, '2026-01-15 01:29:25.493-03', '2026-01-15 01:29:25.493-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (11, 7, 16, '2026-01-15 01:29:25.496-03', '2026-01-15 01:29:25.496-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (12, 5, 11, '2026-01-15 01:29:25.498-03', '2026-01-15 01:29:25.498-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (13, 6, 7, '2026-01-15 01:29:25.5-03', '2026-01-15 01:29:25.5-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (14, 7, 14, '2026-01-15 01:29:25.502-03', '2026-01-15 01:29:25.502-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (15, 5, 13, '2026-01-15 01:29:25.504-03', '2026-01-15 01:29:25.504-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (16, 6, 18, '2026-01-15 01:29:25.506-03', '2026-01-15 01:29:25.506-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (17, 7, 6, '2026-01-15 01:29:25.509-03', '2026-01-15 01:29:25.509-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (18, 8, 4, '2026-01-15 20:44:56.473-03', '2026-01-15 20:44:56.473-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (19, 9, 17, '2026-01-15 20:49:54.181-03', '2026-01-15 20:49:54.181-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (20, 9, 16, '2026-01-15 20:49:54.226-03', '2026-01-15 20:49:54.226-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (21, 9, 15, '2026-01-15 20:49:54.234-03', '2026-01-15 20:49:54.234-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (22, 10, 14, '2026-01-15 20:49:54.282-03', '2026-01-15 20:49:54.282-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (23, 10, 7, '2026-01-15 20:49:54.288-03', '2026-01-15 20:49:54.288-03');
INSERT INTO padel_circuit.zone_teams (id, zone_id, team_id, created_at, updated_at) VALUES (24, 10, 11, '2026-01-15 20:49:54.293-03', '2026-01-15 20:49:54.293-03');


--
-- Data for Name: zones; Type: TABLE DATA; Schema: padel_circuit; Owner: postgres
--

INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (1, 1, 'Zona A', 0, '2026-01-15 00:26:25.489-03', '2026-01-15 00:26:25.489-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (2, 1, 'Zona B', 1, '2026-01-15 00:26:25.497-03', '2026-01-15 00:26:25.497-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (3, 2, 'A', 0, '2026-01-15 00:47:50.792-03', '2026-01-15 00:47:50.792-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (4, 2, 'B', 1, '2026-01-15 00:47:50.842-03', '2026-01-15 00:47:50.842-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (5, 3, 'Zona A', 0, '2026-01-15 01:29:25.481-03', '2026-01-15 01:29:25.481-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (6, 3, 'Zona B', 1, '2026-01-15 01:29:25.485-03', '2026-01-15 01:29:25.485-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (7, 3, 'Zona C', 2, '2026-01-15 01:29:25.487-03', '2026-01-15 01:29:25.487-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (8, 4, 'A', 0, '2026-01-15 20:44:56.47-03', '2026-01-15 20:44:56.47-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (9, 5, 'A', 0, '2026-01-15 20:49:54.174-03', '2026-01-15 20:49:54.174-03');
INSERT INTO padel_circuit.zones (id, tournament_category_id, name, order_index, created_at, updated_at) VALUES (10, 5, 'B', 1, '2026-01-15 20:49:54.279-03', '2026-01-15 20:49:54.279-03');


--
-- Data for Name: actividades; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: alojamientos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.clientes (id, nombre, apellido, email, telefono, direccion, dni, fecha_nacimiento, activo, created_at, updated_at, deleted_at) VALUES (1, 'ANDRES', 'BURGUES', 'andresburgues@gmail.com', '03407406148', 'Rivadavia
691', '35702164', NULL, true, '2025-11-01 14:56:22.526-03', '2025-11-01 14:56:22.526-03', NULL);
INSERT INTO public.clientes (id, nombre, apellido, email, telefono, direccion, dni, fecha_nacimiento, activo, created_at, updated_at, deleted_at) VALUES (2, 'SANTIAGO', 'BURGUES', 'santi@gmail.com', '', '', '35888466', NULL, true, '2026-01-05 22:20:46.666-03', '2026-01-05 22:20:46.666-03', NULL);
INSERT INTO public.clientes (id, nombre, apellido, email, telefono, direccion, dni, fecha_nacimiento, activo, created_at, updated_at, deleted_at) VALUES (4, 'ADRIAN', 'LUCIANI', 'dni-33255555-6888@placeholder.local', NULL, NULL, '33255555', NULL, true, '2026-01-10 11:22:51.376-03', '2026-01-10 11:22:51.376-03', NULL);
INSERT INTO public.clientes (id, nombre, apellido, email, telefono, direccion, dni, fecha_nacimiento, activo, created_at, updated_at, deleted_at) VALUES (3, 'PEDRO', 'MARTINEZ', 'pedro@gmail.com', '3407412563', '', '23666654', NULL, true, '2026-01-05 22:21:07.926-03', '2026-01-10 15:02:37.263-03', NULL);


--
-- Data for Name: cuentas_corrientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cuentas_corrientes (id, reserva_id, cliente_id, monto_total, saldo_pendiente, cantidad_cuotas, estado, fecha_creacion, fecha_actualizacion, deleted_at) VALUES (2, 7, 1, 700000.00, 450000.00, 1, 'en_proceso', '2026-01-10 11:56:34.568-03', '2026-01-10 12:19:53.941-03', NULL);
INSERT INTO public.cuentas_corrientes (id, reserva_id, cliente_id, monto_total, saldo_pendiente, cantidad_cuotas, estado, fecha_creacion, fecha_actualizacion, deleted_at) VALUES (1, 6, 1, 2400000.00, 2000000.00, 6, 'en_proceso', '2026-01-10 11:22:51.385-03', '2026-01-10 12:21:42.792-03', NULL);
INSERT INTO public.cuentas_corrientes (id, reserva_id, cliente_id, monto_total, saldo_pendiente, cantidad_cuotas, estado, fecha_creacion, fecha_actualizacion, deleted_at) VALUES (3, 8, 3, 600.00, 0.00, 1, 'pagado', '2026-01-10 15:03:53.769-03', '2026-01-10 15:04:13.408-03', NULL);


--
-- Data for Name: cuotas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cuotas (id, cuenta_corriente_id, numero_cuota, monto, fecha_vencimiento, fecha_pago, monto_pagado, estado, metodo_pago, observaciones, fecha_creacion, fecha_actualizacion) VALUES (2, 1, 2, 400000.00, '2026-03-10', NULL, 0.00, 'pendiente', NULL, NULL, '2026-01-10 11:22:51.418-03', '2026-01-10 11:22:51.418-03');
INSERT INTO public.cuotas (id, cuenta_corriente_id, numero_cuota, monto, fecha_vencimiento, fecha_pago, monto_pagado, estado, metodo_pago, observaciones, fecha_creacion, fecha_actualizacion) VALUES (3, 1, 3, 400000.00, '2026-04-10', NULL, 0.00, 'pendiente', NULL, NULL, '2026-01-10 11:22:51.418-03', '2026-01-10 11:22:51.418-03');
INSERT INTO public.cuotas (id, cuenta_corriente_id, numero_cuota, monto, fecha_vencimiento, fecha_pago, monto_pagado, estado, metodo_pago, observaciones, fecha_creacion, fecha_actualizacion) VALUES (4, 1, 4, 400000.00, '2026-05-10', NULL, 0.00, 'pendiente', NULL, NULL, '2026-01-10 11:22:51.418-03', '2026-01-10 11:22:51.418-03');
INSERT INTO public.cuotas (id, cuenta_corriente_id, numero_cuota, monto, fecha_vencimiento, fecha_pago, monto_pagado, estado, metodo_pago, observaciones, fecha_creacion, fecha_actualizacion) VALUES (5, 1, 5, 400000.00, '2026-06-10', NULL, 0.00, 'pendiente', NULL, NULL, '2026-01-10 11:22:51.418-03', '2026-01-10 11:22:51.418-03');
INSERT INTO public.cuotas (id, cuenta_corriente_id, numero_cuota, monto, fecha_vencimiento, fecha_pago, monto_pagado, estado, metodo_pago, observaciones, fecha_creacion, fecha_actualizacion) VALUES (6, 1, 6, 400000.00, '2026-07-10', NULL, 0.00, 'pendiente', NULL, NULL, '2026-01-10 11:22:51.418-03', '2026-01-10 11:22:51.418-03');
INSERT INTO public.cuotas (id, cuenta_corriente_id, numero_cuota, monto, fecha_vencimiento, fecha_pago, monto_pagado, estado, metodo_pago, observaciones, fecha_creacion, fecha_actualizacion) VALUES (7, 2, 1, 700000.00, '2026-02-10', '2026-01-10 12:19:53.905-03', 0.00, 'pagada_parcial', 'transferencia', NULL, '2026-01-10 11:56:34.578-03', '2026-01-10 12:19:53.914-03');
INSERT INTO public.cuotas (id, cuenta_corriente_id, numero_cuota, monto, fecha_vencimiento, fecha_pago, monto_pagado, estado, metodo_pago, observaciones, fecha_creacion, fecha_actualizacion) VALUES (1, 1, 1, 400000.00, '2026-02-10', '2026-01-10 12:21:42.785-03', 0.00, 'pagada_parcial', 'transferencia', NULL, '2026-01-10 11:22:51.418-03', '2026-01-10 12:21:42.787-03');
INSERT INTO public.cuotas (id, cuenta_corriente_id, numero_cuota, monto, fecha_vencimiento, fecha_pago, monto_pagado, estado, metodo_pago, observaciones, fecha_creacion, fecha_actualizacion) VALUES (8, 3, 1, 600.00, '2026-02-10', '2026-01-10 15:04:13.401-03', 600.00, 'pagada_total', 'efectivo', NULL, '2026-01-10 15:03:53.776-03', '2026-01-10 15:04:13.404-03');


--
-- Data for Name: destinos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: inscripciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: movimientos_cuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: pagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pagos (id, correlativo, numero_comprobante, cuenta_corriente_id, cuota_id, cliente_id, usuario_id, monto, metodo_pago, fecha_pago, observaciones, extra, fecha_creacion, fecha_actualizacion) VALUES (1, 1, 'REC-000001', 2, 7, 1, 1, 250000.00, 'transferencia', '2026-01-10 12:19:53.95-03', NULL, NULL, '2026-01-10 12:19:53.95-03', NULL);
INSERT INTO public.pagos (id, correlativo, numero_comprobante, cuenta_corriente_id, cuota_id, cliente_id, usuario_id, monto, metodo_pago, fecha_pago, observaciones, extra, fecha_creacion, fecha_actualizacion) VALUES (2, 2, 'REC-000002', 1, 1, 1, 1, 400000.00, 'transferencia', '2026-01-10 12:21:42.796-03', NULL, NULL, '2026-01-10 12:21:42.796-03', NULL);
INSERT INTO public.pagos (id, correlativo, numero_comprobante, cuenta_corriente_id, cuota_id, cliente_id, usuario_id, monto, metodo_pago, fecha_pago, observaciones, extra, fecha_creacion, fecha_actualizacion) VALUES (3, 3, 'REC-000003', 3, 8, 3, 1, 600.00, 'efectivo', '2026-01-10 15:04:13.432-03', NULL, NULL, '2026-01-10 15:04:13.432-03', NULL);


--
-- Data for Name: proveedores; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: resenas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: reserva_clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reserva_clientes (id, reserva_id, cliente_id, tipo_cliente, created_at, updated_at) VALUES (2, 6, 1, 'titular', '2026-01-10 11:22:51.354-03', '2026-01-10 11:22:51.354-03');
INSERT INTO public.reserva_clientes (id, reserva_id, cliente_id, tipo_cliente, created_at, updated_at) VALUES (3, 6, 4, 'titular', '2026-01-10 11:22:51.381-03', '2026-01-10 11:22:51.381-03');
INSERT INTO public.reserva_clientes (id, reserva_id, cliente_id, tipo_cliente, created_at, updated_at) VALUES (4, 7, 1, 'titular', '2026-01-10 11:56:34.544-03', '2026-01-10 11:56:34.544-03');
INSERT INTO public.reserva_clientes (id, reserva_id, cliente_id, tipo_cliente, created_at, updated_at) VALUES (5, 8, 3, 'titular', '2026-01-10 15:03:53.749-03', '2026-01-10 15:03:53.749-03');


--
-- Data for Name: reservas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reservas (id, codigo, tour_id, fecha_reserva, cantidad_personas, precio_unitario, estado, notas, activo, created_at, updated_at, deleted_at, referencia, descripcion, tour_nombre, tour_destino, tour_descripcion, fecha_inicio, fecha_fin, moneda_precio_unitario) VALUES (6, 'RES-1768054971330', NULL, '2026-01-10', 2, 1200000.00, 'pendiente', NULL, true, '2026-01-10 11:22:51.33-03', '2026-01-10 11:22:51.331-03', NULL, NULL, NULL, 'bariloche economy', 'bariloche', 'viaje de 5 noches', '2026-01-15', '2026-01-21', 'ARS');
INSERT INTO public.reservas (id, codigo, tour_id, fecha_reserva, cantidad_personas, precio_unitario, estado, notas, activo, created_at, updated_at, deleted_at, referencia, descripcion, tour_nombre, tour_destino, tour_descripcion, fecha_inicio, fecha_fin, moneda_precio_unitario) VALUES (7, 'RES-1768056994489', NULL, '2026-01-10', 1, 700000.00, 'pendiente', NULL, true, '2026-01-10 11:56:34.49-03', '2026-01-10 11:56:34.496-03', NULL, '125635', NULL, 'santiago del estero en avion', 'santiago del estero', 'viaje unico', '2026-01-16', '2026-01-23', 'ARS');
INSERT INTO public.reservas (id, codigo, tour_id, fecha_reserva, cantidad_personas, precio_unitario, estado, notas, activo, created_at, updated_at, deleted_at, referencia, descripcion, tour_nombre, tour_destino, tour_descripcion, fecha_inicio, fecha_fin, moneda_precio_unitario) VALUES (8, 'RES-1768068233722', NULL, '2026-01-10', 1, 600.00, 'pendiente', NULL, true, '2026-01-10 15:03:53.723-03', '2026-01-10 15:03:53.726-03', NULL, '9877777', NULL, 'calafate baja temporada', 'calafate', '4 noches en avion', '2026-02-18', '2026-02-22', 'USD');


--
-- Data for Name: sequelize_meta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sequelize_meta (name) VALUES ('20231025235000-create-tours.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20231025235100-create-reservas.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20251101154856-create-reservas.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20231025235200-add-cliente-id-to-reservas.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20231112235000-add-payment-fields-to-reservas.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20251107130000-create-cuentas-corrientes.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20251107130100-create-cuotas.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20251118000000-update-reservas-table.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20251120000000-create-reserva-clientes.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20250106000000-add-tour-fields-to-reservas.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20260109000000-create-pagos.js');
INSERT INTO public.sequelize_meta (name) VALUES ('20260113000000-add-performance-indexes.js');


--
-- Data for Name: tours; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tours (id, nombre, descripcion, destino, fecha_inicio, fecha_fin, precio, cupo_maximo, cupos_disponibles, estado, imagen_url, activo, created_at, updated_at, deleted_at) VALUES (3, 'Tour economy interanitonal', '', 'Mexico, Cancun', NULL, NULL, 0.00, 4, 4, 'disponible', NULL, true, '2025-11-01 12:13:17.069-03', '2025-11-01 12:13:17.069-03', NULL);
INSERT INTO public.tours (id, nombre, descripcion, destino, fecha_inicio, fecha_fin, precio, cupo_maximo, cupos_disponibles, estado, imagen_url, activo, created_at, updated_at, deleted_at) VALUES (2, 'Pablo', '', 'Cancun', NULL, NULL, 0.00, 10, 10, 'disponible', NULL, false, '2025-11-01 12:10:11.742-03', '2025-11-01 12:12:58.894-03', NULL);
INSERT INTO public.tours (id, nombre, descripcion, destino, fecha_inicio, fecha_fin, precio, cupo_maximo, cupos_disponibles, estado, imagen_url, activo, created_at, updated_at, deleted_at) VALUES (1, 'Tour economy interanitonal', '', 'Mexico, Cancun', NULL, NULL, 0.00, 10, 10, 'disponible', NULL, false, '2025-11-01 12:08:42.276-03', '2025-11-01 12:13:00.377-03', NULL);


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios (id, username, email, password, role, active, last_login, reset_password_token, reset_password_expire, email_verified, created_at, updated_at, deleted_at) VALUES (2, 'gustavo', 'gustavo@gmail.com', '$2a$10$FslPx/mv5ni97gD/gX8HKeyNAd3FUm0U.tadQoBOQB/JCZH14eW4G', 'ADMIN', true, NULL, NULL, NULL, false, '2026-01-11 01:03:37.33-03', '2026-01-11 01:03:37.33-03', NULL);
INSERT INTO public.usuarios (id, username, email, password, role, active, last_login, reset_password_token, reset_password_expire, email_verified, created_at, updated_at, deleted_at) VALUES (3, 'delfina', 'delfina@gmail.com', '$2a$10$ZTUmNC6yEKlMqY7Re9eixuufDy/l7hIJbIofBOgT.x3ja8zuO3bbm', 'USER', true, NULL, NULL, NULL, false, '2026-01-11 01:04:05.68-03', '2026-01-11 01:04:05.68-03', NULL);
INSERT INTO public.usuarios (id, username, email, password, role, active, last_login, reset_password_token, reset_password_expire, email_verified, created_at, updated_at, deleted_at) VALUES (1, 'andres', 'andres@gmail.com', '$2a$10$PV19LA6RMGy8RwNih56hN.gntuOOpEf5IJ3pFm1TmXTgKP99135T.', 'ADMIN', true, '2026-01-16 08:00:55.234-03', NULL, NULL, true, '2025-11-01 00:00:00-03', '2026-01-16 08:00:55.234-03', NULL);


--
-- Name: cajas_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.cajas_id_seq', 1, true);


--
-- Name: canchas_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.canchas_id_seq', 5, true);


--
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.categorias_id_seq', 8, true);


--
-- Name: compras_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.compras_id_seq', 1, true);


--
-- Name: detalle_compra_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.detalle_compra_id_seq', 1, true);


--
-- Name: detalle_venta_cantina_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.detalle_venta_cantina_id_seq', 24, true);


--
-- Name: detalle_ventas_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.detalle_ventas_id_seq', 5, true);


--
-- Name: gastos_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.gastos_id_seq', 1, true);


--
-- Name: inscripciones_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.inscripciones_id_seq', 1, true);


--
-- Name: jugadores_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.jugadores_id_seq', 4, true);


--
-- Name: movimientos_cuenta_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.movimientos_cuenta_id_seq', 7, true);


--
-- Name: movimientos_proveedor_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.movimientos_proveedor_id_seq', 2, true);


--
-- Name: pagos_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.pagos_id_seq', 15, true);


--
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.productos_id_seq', 14, true);


--
-- Name: proveedores_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.proveedores_id_seq', 1, true);


--
-- Name: reservas_fijas_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.reservas_fijas_id_seq', 7, true);


--
-- Name: torneos_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.torneos_id_seq', 1, true);


--
-- Name: turnos_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.turnos_id_seq', 50, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.usuarios_id_seq', 3, true);


--
-- Name: ventas_cantina_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.ventas_cantina_id_seq', 13, true);


--
-- Name: ventas_id_seq; Type: SEQUENCE SET; Schema: complejo_deportivo; Owner: postgres
--

SELECT pg_catalog.setval('complejo_deportivo.ventas_id_seq', 4, true);


--
-- Name: brackets_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.brackets_id_seq', 6, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.categories_id_seq', 8, true);


--
-- Name: matches_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.matches_id_seq', 1, false);


--
-- Name: registrations_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.registrations_id_seq', 21, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.teams_id_seq', 18, true);


--
-- Name: tournament_categories_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.tournament_categories_id_seq', 5, true);


--
-- Name: tournament_points_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.tournament_points_id_seq', 1, false);


--
-- Name: tournaments_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.tournaments_id_seq', 9, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.users_id_seq', 13, true);


--
-- Name: venues_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.venues_id_seq', 3, true);


--
-- Name: zone_matches_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.zone_matches_id_seq', 23, true);


--
-- Name: zone_standings_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.zone_standings_id_seq', 24, true);


--
-- Name: zone_teams_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.zone_teams_id_seq', 24, true);


--
-- Name: zones_id_seq; Type: SEQUENCE SET; Schema: padel_circuit; Owner: postgres
--

SELECT pg_catalog.setval('padel_circuit.zones_id_seq', 10, true);


--
-- Name: actividades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actividades_id_seq', 1, false);


--
-- Name: alojamientos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alojamientos_id_seq', 1, false);


--
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 1, false);


--
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_seq', 4, true);


--
-- Name: cuentas_corrientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuentas_corrientes_id_seq', 3, true);


--
-- Name: cuotas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuotas_id_seq', 8, true);


--
-- Name: destinos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.destinos_id_seq', 1, false);


--
-- Name: inscripciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscripciones_id_seq', 1, false);


--
-- Name: movimientos_cuenta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movimientos_cuenta_id_seq', 1, false);


--
-- Name: pagos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagos_id_seq', 3, true);


--
-- Name: proveedores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proveedores_id_seq', 1, false);


--
-- Name: resenas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resenas_id_seq', 1, false);


--
-- Name: reserva_clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reserva_clientes_id_seq', 5, true);


--
-- Name: reservas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservas_id_seq', 8, true);


--
-- Name: tours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tours_id_seq', 3, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 3, true);


--
-- Name: Auditoria Auditoria_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Auditoria"
    ADD CONSTRAINT "Auditoria_pkey" PRIMARY KEY (id);


--
-- Name: ConfiguracionCoseguros ConfiguracionCoseguros_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."ConfiguracionCoseguros"
    ADD CONSTRAINT "ConfiguracionCoseguros_pkey" PRIMARY KEY (id);


--
-- Name: Especialidad Especialidad_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Especialidad"
    ADD CONSTRAINT "Especialidad_pkey" PRIMARY KEY (id);


--
-- Name: ObraSocial ObraSocial_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."ObraSocial"
    ADD CONSTRAINT "ObraSocial_pkey" PRIMARY KEY (id);


--
-- Name: OrdenKinesiologia OrdenKinesiologia_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."OrdenKinesiologia"
    ADD CONSTRAINT "OrdenKinesiologia_pkey" PRIMARY KEY (id);


--
-- Name: PacienteObraSocial PacienteObraSocial_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."PacienteObraSocial"
    ADD CONSTRAINT "PacienteObraSocial_pkey" PRIMARY KEY (id);


--
-- Name: Paciente Paciente_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Paciente"
    ADD CONSTRAINT "Paciente_pkey" PRIMARY KEY (id);


--
-- Name: PagoMensualGimnasio PagoMensualGimnasio_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."PagoMensualGimnasio"
    ADD CONSTRAINT "PagoMensualGimnasio_pkey" PRIMARY KEY (id);


--
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);


--
-- Name: Seguimiento Seguimiento_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Seguimiento"
    ADD CONSTRAINT "Seguimiento_pkey" PRIMARY KEY (id);


--
-- Name: TurnoHistorial TurnoHistorial_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."TurnoHistorial"
    ADD CONSTRAINT "TurnoHistorial_pkey" PRIMARY KEY (id);


--
-- Name: Turno Turno_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Turno"
    ADD CONSTRAINT "Turno_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: cajas cajas_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.cajas
    ADD CONSTRAINT cajas_pkey PRIMARY KEY (id);


--
-- Name: canchas canchas_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.canchas
    ADD CONSTRAINT canchas_pkey PRIMARY KEY (id);


--
-- Name: categorias categorias_descripcion_key; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.categorias
    ADD CONSTRAINT categorias_descripcion_key UNIQUE (descripcion);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: compras compras_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.compras
    ADD CONSTRAINT compras_pkey PRIMARY KEY (id);


--
-- Name: configuracion configuracion_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.configuracion
    ADD CONSTRAINT configuracion_pkey PRIMARY KEY (clave);


--
-- Name: detalle_compra detalle_compra_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_compra
    ADD CONSTRAINT detalle_compra_pkey PRIMARY KEY (id);


--
-- Name: detalle_venta_cantina detalle_venta_cantina_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_venta_cantina
    ADD CONSTRAINT detalle_venta_cantina_pkey PRIMARY KEY (id);


--
-- Name: detalle_ventas detalle_ventas_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_ventas
    ADD CONSTRAINT detalle_ventas_pkey PRIMARY KEY (id);


--
-- Name: gastos gastos_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.gastos
    ADD CONSTRAINT gastos_pkey PRIMARY KEY (id);


--
-- Name: inscripciones inscripciones_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.inscripciones
    ADD CONSTRAINT inscripciones_pkey PRIMARY KEY (id);


--
-- Name: inscripciones inscripciones_torneo_id_jugador_id_key; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.inscripciones
    ADD CONSTRAINT inscripciones_torneo_id_jugador_id_key UNIQUE (torneo_id, jugador_id);


--
-- Name: jugadores jugadores_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.jugadores
    ADD CONSTRAINT jugadores_pkey PRIMARY KEY (id);


--
-- Name: movimientos_cuenta movimientos_cuenta_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.movimientos_cuenta
    ADD CONSTRAINT movimientos_cuenta_pkey PRIMARY KEY (id);


--
-- Name: movimientos_proveedor movimientos_proveedor_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.movimientos_proveedor
    ADD CONSTRAINT movimientos_proveedor_pkey PRIMARY KEY (id);


--
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id);


--
-- Name: reservas_fijas reservas_fijas_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.reservas_fijas
    ADD CONSTRAINT reservas_fijas_pkey PRIMARY KEY (id);


--
-- Name: torneos torneos_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.torneos
    ADD CONSTRAINT torneos_pkey PRIMARY KEY (id);


--
-- Name: turnos turnos_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.turnos
    ADD CONSTRAINT turnos_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_username_key; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);


--
-- Name: ventas_cantina ventas_cantina_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.ventas_cantina
    ADD CONSTRAINT ventas_cantina_pkey PRIMARY KEY (id);


--
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id);


--
-- Name: brackets brackets_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.brackets
    ADD CONSTRAINT brackets_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_rank_key; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.categories
    ADD CONSTRAINT categories_rank_key UNIQUE (rank);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: player_profiles player_profiles_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.player_profiles
    ADD CONSTRAINT player_profiles_pkey PRIMARY KEY (dni);


--
-- Name: registrations registrations_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.registrations
    ADD CONSTRAINT registrations_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: tournament_categories tournament_categories_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_categories
    ADD CONSTRAINT tournament_categories_pkey PRIMARY KEY (id);


--
-- Name: tournament_points tournament_points_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_pkey PRIMARY KEY (id);


--
-- Name: tournament_points tournament_points_unique; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_unique UNIQUE (tournament_category_id, player_dni);


--
-- Name: tournaments tournaments_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournaments
    ADD CONSTRAINT tournaments_pkey PRIMARY KEY (id);


--
-- Name: users users_dni_key; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.users
    ADD CONSTRAINT users_dni_key UNIQUE (dni);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: venues venues_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: zone_matches zone_matches_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_pkey PRIMARY KEY (id);


--
-- Name: zone_standings zone_standings_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_standings
    ADD CONSTRAINT zone_standings_pkey PRIMARY KEY (id);


--
-- Name: zone_teams zone_teams_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_teams
    ADD CONSTRAINT zone_teams_pkey PRIMARY KEY (id);


--
-- Name: zones zones_pkey; Type: CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (id);


--
-- Name: actividades actividades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividades
    ADD CONSTRAINT actividades_pkey PRIMARY KEY (id);


--
-- Name: alojamientos alojamientos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alojamientos
    ADD CONSTRAINT alojamientos_pkey PRIMARY KEY (id);


--
-- Name: categorias categorias_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_key UNIQUE (nombre);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: clientes clientes_dni_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_dni_key UNIQUE (dni);


--
-- Name: clientes clientes_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_email_key UNIQUE (email);


--
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- Name: cuentas_corrientes cuentas_corrientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas_corrientes
    ADD CONSTRAINT cuentas_corrientes_pkey PRIMARY KEY (id);


--
-- Name: cuotas cuotas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuotas
    ADD CONSTRAINT cuotas_pkey PRIMARY KEY (id);


--
-- Name: destinos destinos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destinos
    ADD CONSTRAINT destinos_pkey PRIMARY KEY (id);


--
-- Name: inscripciones inscripciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_pkey PRIMARY KEY (id);


--
-- Name: inscripciones inscripciones_torneo_id_jugador_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscripciones
    ADD CONSTRAINT inscripciones_torneo_id_jugador_id_key UNIQUE (torneo_id, jugador_id);


--
-- Name: movimientos_cuenta movimientos_cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movimientos_cuenta
    ADD CONSTRAINT movimientos_cuenta_pkey PRIMARY KEY (id);


--
-- Name: pagos pagos_correlativo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_correlativo_key UNIQUE (correlativo);


--
-- Name: pagos pagos_cuota_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_cuota_id_key UNIQUE (cuota_id);


--
-- Name: pagos pagos_numero_comprobante_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_numero_comprobante_key UNIQUE (numero_comprobante);


--
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id);


--
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id);


--
-- Name: resenas resenas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas
    ADD CONSTRAINT resenas_pkey PRIMARY KEY (id);


--
-- Name: reserva_clientes reserva_clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva_clientes
    ADD CONSTRAINT reserva_clientes_pkey PRIMARY KEY (id);


--
-- Name: reservas reservas_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_codigo_key UNIQUE (codigo);


--
-- Name: reservas reservas_codigo_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_codigo_key1 UNIQUE (codigo);


--
-- Name: reservas reservas_codigo_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_codigo_key2 UNIQUE (codigo);


--
-- Name: reservas reservas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_pkey PRIMARY KEY (id);


--
-- Name: sequelize_meta sequelize_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sequelize_meta
    ADD CONSTRAINT sequelize_meta_pkey PRIMARY KEY (name);


--
-- Name: tours tours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_pkey PRIMARY KEY (id);


--
-- Name: reserva_clientes unique_reserva_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva_clientes
    ADD CONSTRAINT unique_reserva_cliente UNIQUE (reserva_id, cliente_id);


--
-- Name: cuentas_corrientes uq_reserva; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas_corrientes
    ADD CONSTRAINT uq_reserva UNIQUE (reserva_id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);


--
-- Name: usuarios usuarios_username_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_username_key1 UNIQUE (username);


--
-- Name: usuarios usuarios_username_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_username_key2 UNIQUE (username);


--
-- Name: Auditoria_createdAt_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Auditoria_createdAt_idx" ON centro_rehab."Auditoria" USING btree ("createdAt");


--
-- Name: Auditoria_entidad_entidadId_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Auditoria_entidad_entidadId_idx" ON centro_rehab."Auditoria" USING btree (entidad, "entidadId");


--
-- Name: Auditoria_usuarioId_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Auditoria_usuarioId_idx" ON centro_rehab."Auditoria" USING btree ("usuarioId");


--
-- Name: Especialidad_nombre_key; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE UNIQUE INDEX "Especialidad_nombre_key" ON centro_rehab."Especialidad" USING btree (nombre);


--
-- Name: ObraSocial_nombre_plan_key; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE UNIQUE INDEX "ObraSocial_nombre_plan_key" ON centro_rehab."ObraSocial" USING btree (nombre, plan);


--
-- Name: OrdenKinesiologia_numero_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "OrdenKinesiologia_numero_idx" ON centro_rehab."OrdenKinesiologia" USING btree (numero);


--
-- Name: OrdenKinesiologia_pacienteId_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "OrdenKinesiologia_pacienteId_idx" ON centro_rehab."OrdenKinesiologia" USING btree ("pacienteId");


--
-- Name: OrdenKinesiologia_pacienteId_numero_key; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE UNIQUE INDEX "OrdenKinesiologia_pacienteId_numero_key" ON centro_rehab."OrdenKinesiologia" USING btree ("pacienteId", numero);


--
-- Name: PacienteObraSocial_pacienteId_key; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE UNIQUE INDEX "PacienteObraSocial_pacienteId_key" ON centro_rehab."PacienteObraSocial" USING btree ("pacienteId");


--
-- Name: Paciente_apellido_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Paciente_apellido_idx" ON centro_rehab."Paciente" USING btree (apellido);


--
-- Name: Paciente_dni_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Paciente_dni_idx" ON centro_rehab."Paciente" USING btree (dni);


--
-- Name: Paciente_dni_key; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE UNIQUE INDEX "Paciente_dni_key" ON centro_rehab."Paciente" USING btree (dni);


--
-- Name: Paciente_telefono_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Paciente_telefono_idx" ON centro_rehab."Paciente" USING btree (telefono);


--
-- Name: PagoMensualGimnasio_pacienteId_yearMonth_key; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE UNIQUE INDEX "PagoMensualGimnasio_pacienteId_yearMonth_key" ON centro_rehab."PagoMensualGimnasio" USING btree ("pacienteId", "yearMonth");


--
-- Name: PagoMensualGimnasio_yearMonth_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "PagoMensualGimnasio_yearMonth_idx" ON centro_rehab."PagoMensualGimnasio" USING btree ("yearMonth");


--
-- Name: Role_name_key; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE UNIQUE INDEX "Role_name_key" ON centro_rehab."Role" USING btree (name);


--
-- Name: Seguimiento_pacienteId_fecha_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Seguimiento_pacienteId_fecha_idx" ON centro_rehab."Seguimiento" USING btree ("pacienteId", fecha);


--
-- Name: Seguimiento_tipo_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Seguimiento_tipo_idx" ON centro_rehab."Seguimiento" USING btree (tipo);


--
-- Name: TurnoHistorial_fecha_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "TurnoHistorial_fecha_idx" ON centro_rehab."TurnoHistorial" USING btree (fecha);


--
-- Name: TurnoHistorial_turnoId_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "TurnoHistorial_turnoId_idx" ON centro_rehab."TurnoHistorial" USING btree ("turnoId");


--
-- Name: Turno_especialidadId_startAt_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Turno_especialidadId_startAt_idx" ON centro_rehab."Turno" USING btree ("especialidadId", "startAt");


--
-- Name: Turno_pacienteId_startAt_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Turno_pacienteId_startAt_idx" ON centro_rehab."Turno" USING btree ("pacienteId", "startAt");


--
-- Name: Turno_profesionalId_startAt_idx; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE INDEX "Turno_profesionalId_startAt_idx" ON centro_rehab."Turno" USING btree ("profesionalId", "startAt");


--
-- Name: User_email_key; Type: INDEX; Schema: centro_rehab; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON centro_rehab."User" USING btree (email);


--
-- Name: idx_tournament_points_player; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE INDEX idx_tournament_points_player ON padel_circuit.tournament_points USING btree (player_dni);


--
-- Name: idx_tournament_points_tournament_category; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE INDEX idx_tournament_points_tournament_category ON padel_circuit.tournament_points USING btree (tournament_category_id);


--
-- Name: registrations_tournament_category_id_team_id; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX registrations_tournament_category_id_team_id ON padel_circuit.registrations USING btree (tournament_category_id, team_id);


--
-- Name: tournament_categories_tournament_id_category_id; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX tournament_categories_tournament_id_category_id ON padel_circuit.tournament_categories USING btree (tournament_id, category_id);


--
-- Name: unique_team_pair; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX unique_team_pair ON padel_circuit.teams USING btree (LEAST(player1_dni, player2_dni), GREATEST(player1_dni, player2_dni));


--
-- Name: zone_standings_zone_id_team_id; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX zone_standings_zone_id_team_id ON padel_circuit.zone_standings USING btree (zone_id, team_id);


--
-- Name: zone_teams_zone_id_team_id; Type: INDEX; Schema: padel_circuit; Owner: postgres
--

CREATE UNIQUE INDEX zone_teams_zone_id_team_id ON padel_circuit.zone_teams USING btree (zone_id, team_id);


--
-- Name: cuentas_corrientes_cliente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cuentas_corrientes_cliente_id ON public.cuentas_corrientes USING btree (cliente_id);


--
-- Name: cuentas_corrientes_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cuentas_corrientes_estado ON public.cuentas_corrientes USING btree (estado);


--
-- Name: cuentas_corrientes_reserva_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cuentas_corrientes_reserva_id ON public.cuentas_corrientes USING btree (reserva_id);


--
-- Name: cuotas_cuenta_corriente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cuotas_cuenta_corriente_id ON public.cuotas USING btree (cuenta_corriente_id);


--
-- Name: cuotas_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cuotas_estado ON public.cuotas USING btree (estado);


--
-- Name: cuotas_fecha_vencimiento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cuotas_fecha_vencimiento ON public.cuotas USING btree (fecha_vencimiento);


--
-- Name: cuotas_numero_cuota_cuenta_corriente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cuotas_numero_cuota_cuenta_corriente_id ON public.cuotas USING btree (numero_cuota, cuenta_corriente_id);


--
-- Name: idx_clientes_dni; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clientes_dni ON public.clientes USING btree (dni);


--
-- Name: idx_clientes_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_clientes_email ON public.clientes USING btree (email);


--
-- Name: idx_cuentas_corrientes_cliente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cuentas_corrientes_cliente_id ON public.cuentas_corrientes USING btree (cliente_id);


--
-- Name: idx_cuentas_corrientes_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cuentas_corrientes_estado ON public.cuentas_corrientes USING btree (estado);


--
-- Name: idx_cuentas_corrientes_reserva_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cuentas_corrientes_reserva_id ON public.cuentas_corrientes USING btree (reserva_id);


--
-- Name: idx_cuotas_cuenta_corriente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cuotas_cuenta_corriente_id ON public.cuotas USING btree (cuenta_corriente_id);


--
-- Name: idx_cuotas_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cuotas_estado ON public.cuotas USING btree (estado);


--
-- Name: idx_cuotas_fecha_pago; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cuotas_fecha_pago ON public.cuotas USING btree (fecha_pago);


--
-- Name: idx_cuotas_fecha_vencimiento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cuotas_fecha_vencimiento ON public.cuotas USING btree (fecha_vencimiento);


--
-- Name: idx_pagos_cliente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pagos_cliente_id ON public.pagos USING btree (cliente_id);


--
-- Name: idx_pagos_cuenta_corriente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pagos_cuenta_corriente_id ON public.pagos USING btree (cuenta_corriente_id);


--
-- Name: idx_pagos_cuota_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pagos_cuota_id ON public.pagos USING btree (cuota_id);


--
-- Name: idx_pagos_fecha_pago; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pagos_fecha_pago ON public.pagos USING btree (fecha_pago);


--
-- Name: idx_reservas_codigo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_reservas_codigo ON public.reservas USING btree (codigo);


--
-- Name: idx_reservas_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservas_estado ON public.reservas USING btree (estado);


--
-- Name: idx_reservas_fecha_reserva; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservas_fecha_reserva ON public.reservas USING btree (fecha_reserva);


--
-- Name: idx_reservas_tour_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservas_tour_id ON public.reservas USING btree (tour_id);


--
-- Name: pagos_cliente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pagos_cliente_id ON public.pagos USING btree (cliente_id);


--
-- Name: pagos_cuenta_corriente_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pagos_cuenta_corriente_id ON public.pagos USING btree (cuenta_corriente_id);


--
-- Name: pagos_cuota_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pagos_cuota_id ON public.pagos USING btree (cuota_id);


--
-- Name: pagos_fecha_pago; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pagos_fecha_pago ON public.pagos USING btree (fecha_pago);


--
-- Name: pagos_numero_comprobante; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pagos_numero_comprobante ON public.pagos USING btree (numero_comprobante);


--
-- Name: Auditoria Auditoria_usuarioId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Auditoria"
    ADD CONSTRAINT "Auditoria_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES centro_rehab."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: OrdenKinesiologia OrdenKinesiologia_pacienteId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."OrdenKinesiologia"
    ADD CONSTRAINT "OrdenKinesiologia_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES centro_rehab."Paciente"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PacienteObraSocial PacienteObraSocial_obraSocialId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."PacienteObraSocial"
    ADD CONSTRAINT "PacienteObraSocial_obraSocialId_fkey" FOREIGN KEY ("obraSocialId") REFERENCES centro_rehab."ObraSocial"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PacienteObraSocial PacienteObraSocial_pacienteId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."PacienteObraSocial"
    ADD CONSTRAINT "PacienteObraSocial_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES centro_rehab."Paciente"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PagoMensualGimnasio PagoMensualGimnasio_cobradoPorId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."PagoMensualGimnasio"
    ADD CONSTRAINT "PagoMensualGimnasio_cobradoPorId_fkey" FOREIGN KEY ("cobradoPorId") REFERENCES centro_rehab."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PagoMensualGimnasio PagoMensualGimnasio_pacienteId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."PagoMensualGimnasio"
    ADD CONSTRAINT "PagoMensualGimnasio_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES centro_rehab."Paciente"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Seguimiento Seguimiento_pacienteId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Seguimiento"
    ADD CONSTRAINT "Seguimiento_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES centro_rehab."Paciente"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Seguimiento Seguimiento_profesionalId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Seguimiento"
    ADD CONSTRAINT "Seguimiento_profesionalId_fkey" FOREIGN KEY ("profesionalId") REFERENCES centro_rehab."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: TurnoHistorial TurnoHistorial_turnoId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."TurnoHistorial"
    ADD CONSTRAINT "TurnoHistorial_turnoId_fkey" FOREIGN KEY ("turnoId") REFERENCES centro_rehab."Turno"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TurnoHistorial TurnoHistorial_usuarioId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."TurnoHistorial"
    ADD CONSTRAINT "TurnoHistorial_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES centro_rehab."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Turno Turno_cobradoPorId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Turno"
    ADD CONSTRAINT "Turno_cobradoPorId_fkey" FOREIGN KEY ("cobradoPorId") REFERENCES centro_rehab."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Turno Turno_especialidadId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Turno"
    ADD CONSTRAINT "Turno_especialidadId_fkey" FOREIGN KEY ("especialidadId") REFERENCES centro_rehab."Especialidad"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Turno Turno_ordenKinesiologiaId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Turno"
    ADD CONSTRAINT "Turno_ordenKinesiologiaId_fkey" FOREIGN KEY ("ordenKinesiologiaId") REFERENCES centro_rehab."OrdenKinesiologia"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Turno Turno_pacienteId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Turno"
    ADD CONSTRAINT "Turno_pacienteId_fkey" FOREIGN KEY ("pacienteId") REFERENCES centro_rehab."Paciente"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Turno Turno_profesionalId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."Turno"
    ADD CONSTRAINT "Turno_profesionalId_fkey" FOREIGN KEY ("profesionalId") REFERENCES centro_rehab."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: User User_roleId_fkey; Type: FK CONSTRAINT; Schema: centro_rehab; Owner: postgres
--

ALTER TABLE ONLY centro_rehab."User"
    ADD CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES centro_rehab."Role"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cajas cajas_usuario_apertura_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.cajas
    ADD CONSTRAINT cajas_usuario_apertura_id_fkey FOREIGN KEY (usuario_apertura_id) REFERENCES complejo_deportivo.usuarios(id);


--
-- Name: cajas cajas_usuario_cierre_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.cajas
    ADD CONSTRAINT cajas_usuario_cierre_id_fkey FOREIGN KEY (usuario_cierre_id) REFERENCES complejo_deportivo.usuarios(id);


--
-- Name: compras compras_proveedor_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.compras
    ADD CONSTRAINT compras_proveedor_id_fkey FOREIGN KEY (proveedor_id) REFERENCES complejo_deportivo.proveedores(id);


--
-- Name: detalle_compra detalle_compra_compra_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_compra
    ADD CONSTRAINT detalle_compra_compra_id_fkey FOREIGN KEY (compra_id) REFERENCES complejo_deportivo.compras(id) ON DELETE CASCADE;


--
-- Name: detalle_compra detalle_compra_producto_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_compra
    ADD CONSTRAINT detalle_compra_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES complejo_deportivo.productos(id);


--
-- Name: detalle_venta_cantina detalle_venta_cantina_producto_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_venta_cantina
    ADD CONSTRAINT detalle_venta_cantina_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES complejo_deportivo.productos(id);


--
-- Name: detalle_venta_cantina detalle_venta_cantina_venta_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_venta_cantina
    ADD CONSTRAINT detalle_venta_cantina_venta_id_fkey FOREIGN KEY (venta_id) REFERENCES complejo_deportivo.ventas_cantina(id);


--
-- Name: detalle_ventas detalle_ventas_producto_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_ventas
    ADD CONSTRAINT detalle_ventas_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES complejo_deportivo.productos(id);


--
-- Name: detalle_ventas detalle_ventas_venta_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.detalle_ventas
    ADD CONSTRAINT detalle_ventas_venta_id_fkey FOREIGN KEY (venta_id) REFERENCES complejo_deportivo.ventas(id) ON DELETE CASCADE;


--
-- Name: gastos gastos_caja_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.gastos
    ADD CONSTRAINT gastos_caja_id_fkey FOREIGN KEY (caja_id) REFERENCES complejo_deportivo.cajas(id);


--
-- Name: gastos gastos_usuario_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.gastos
    ADD CONSTRAINT gastos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES complejo_deportivo.usuarios(id);


--
-- Name: inscripciones inscripciones_caja_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.inscripciones
    ADD CONSTRAINT inscripciones_caja_id_fkey FOREIGN KEY (caja_id) REFERENCES complejo_deportivo.cajas(id);


--
-- Name: inscripciones inscripciones_jugador_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.inscripciones
    ADD CONSTRAINT inscripciones_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES complejo_deportivo.jugadores(id);


--
-- Name: inscripciones inscripciones_torneo_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.inscripciones
    ADD CONSTRAINT inscripciones_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES complejo_deportivo.torneos(id);


--
-- Name: movimientos_cuenta movimientos_cuenta_caja_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.movimientos_cuenta
    ADD CONSTRAINT movimientos_cuenta_caja_id_fkey FOREIGN KEY (caja_id) REFERENCES complejo_deportivo.cajas(id);


--
-- Name: movimientos_cuenta movimientos_cuenta_jugador_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.movimientos_cuenta
    ADD CONSTRAINT movimientos_cuenta_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES complejo_deportivo.jugadores(id) ON DELETE CASCADE;


--
-- Name: movimientos_proveedor movimientos_proveedor_proveedor_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.movimientos_proveedor
    ADD CONSTRAINT movimientos_proveedor_proveedor_id_fkey FOREIGN KEY (proveedor_id) REFERENCES complejo_deportivo.proveedores(id) ON DELETE CASCADE;


--
-- Name: pagos pagos_caja_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.pagos
    ADD CONSTRAINT pagos_caja_id_fkey FOREIGN KEY (caja_id) REFERENCES complejo_deportivo.cajas(id);


--
-- Name: pagos pagos_turno_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.pagos
    ADD CONSTRAINT pagos_turno_id_fkey FOREIGN KEY (turno_id) REFERENCES complejo_deportivo.turnos(id);


--
-- Name: productos productos_proveedor_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.productos
    ADD CONSTRAINT productos_proveedor_id_fkey FOREIGN KEY (proveedor_id) REFERENCES complejo_deportivo.proveedores(id) ON DELETE SET NULL;


--
-- Name: reservas_fijas reservas_fijas_cancha_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.reservas_fijas
    ADD CONSTRAINT reservas_fijas_cancha_id_fkey FOREIGN KEY (cancha_id) REFERENCES complejo_deportivo.canchas(id);


--
-- Name: turnos turnos_cancha_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.turnos
    ADD CONSTRAINT turnos_cancha_id_fkey FOREIGN KEY (cancha_id) REFERENCES complejo_deportivo.canchas(id);


--
-- Name: ventas_cantina ventas_cantina_caja_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.ventas_cantina
    ADD CONSTRAINT ventas_cantina_caja_id_fkey FOREIGN KEY (caja_id) REFERENCES complejo_deportivo.cajas(id);


--
-- Name: ventas_cantina ventas_cantina_turno_id_fkey; Type: FK CONSTRAINT; Schema: complejo_deportivo; Owner: postgres
--

ALTER TABLE ONLY complejo_deportivo.ventas_cantina
    ADD CONSTRAINT ventas_cantina_turno_id_fkey FOREIGN KEY (turno_id) REFERENCES complejo_deportivo.turnos(id);


--
-- Name: brackets brackets_tournament_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.brackets
    ADD CONSTRAINT brackets_tournament_category_id_fkey FOREIGN KEY (tournament_category_id) REFERENCES padel_circuit.tournament_categories(id) ON UPDATE CASCADE;


--
-- Name: matches matches_bracket_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_bracket_id_fkey FOREIGN KEY (bracket_id) REFERENCES padel_circuit.brackets(id) ON UPDATE CASCADE;


--
-- Name: matches matches_next_match_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_next_match_id_fkey FOREIGN KEY (next_match_id) REFERENCES padel_circuit.matches(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: matches matches_team_away_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_team_away_id_fkey FOREIGN KEY (team_away_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: matches matches_team_home_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_team_home_id_fkey FOREIGN KEY (team_home_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: matches matches_winner_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.matches
    ADD CONSTRAINT matches_winner_team_id_fkey FOREIGN KEY (winner_team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: player_profiles player_profiles_categoria_base_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.player_profiles
    ADD CONSTRAINT player_profiles_categoria_base_id_fkey FOREIGN KEY (categoria_base_id) REFERENCES padel_circuit.categories(id) ON UPDATE CASCADE;


--
-- Name: registrations registrations_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.registrations
    ADD CONSTRAINT registrations_team_id_fkey FOREIGN KEY (team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: registrations registrations_tournament_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.registrations
    ADD CONSTRAINT registrations_tournament_category_id_fkey FOREIGN KEY (tournament_category_id) REFERENCES padel_circuit.tournament_categories(id) ON UPDATE CASCADE;


--
-- Name: teams teams_player1_dni_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.teams
    ADD CONSTRAINT teams_player1_dni_fkey FOREIGN KEY (player1_dni) REFERENCES padel_circuit.player_profiles(dni) ON UPDATE CASCADE;


--
-- Name: teams teams_player2_dni_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.teams
    ADD CONSTRAINT teams_player2_dni_fkey FOREIGN KEY (player2_dni) REFERENCES padel_circuit.player_profiles(dni) ON UPDATE CASCADE;


--
-- Name: tournament_categories tournament_categories_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_categories
    ADD CONSTRAINT tournament_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES padel_circuit.categories(id) ON UPDATE CASCADE;


--
-- Name: tournament_categories tournament_categories_tournament_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_categories
    ADD CONSTRAINT tournament_categories_tournament_id_fkey FOREIGN KEY (tournament_id) REFERENCES padel_circuit.tournaments(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tournament_points tournament_points_player_dni_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_player_dni_fkey FOREIGN KEY (player_dni) REFERENCES padel_circuit.player_profiles(dni) ON DELETE CASCADE;


--
-- Name: tournament_points tournament_points_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_team_id_fkey FOREIGN KEY (team_id) REFERENCES padel_circuit.teams(id) ON DELETE CASCADE;


--
-- Name: tournament_points tournament_points_tournament_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.tournament_points
    ADD CONSTRAINT tournament_points_tournament_category_id_fkey FOREIGN KEY (tournament_category_id) REFERENCES padel_circuit.tournament_categories(id) ON DELETE CASCADE;


--
-- Name: zone_matches zone_matches_team_away_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_team_away_id_fkey FOREIGN KEY (team_away_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: zone_matches zone_matches_team_home_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_team_home_id_fkey FOREIGN KEY (team_home_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: zone_matches zone_matches_winner_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_winner_team_id_fkey FOREIGN KEY (winner_team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: zone_matches zone_matches_zone_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_matches
    ADD CONSTRAINT zone_matches_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES padel_circuit.zones(id) ON UPDATE CASCADE;


--
-- Name: zone_standings zone_standings_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_standings
    ADD CONSTRAINT zone_standings_team_id_fkey FOREIGN KEY (team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: zone_standings zone_standings_zone_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_standings
    ADD CONSTRAINT zone_standings_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES padel_circuit.zones(id) ON UPDATE CASCADE;


--
-- Name: zone_teams zone_teams_team_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_teams
    ADD CONSTRAINT zone_teams_team_id_fkey FOREIGN KEY (team_id) REFERENCES padel_circuit.teams(id) ON UPDATE CASCADE;


--
-- Name: zone_teams zone_teams_zone_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zone_teams
    ADD CONSTRAINT zone_teams_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES padel_circuit.zones(id) ON UPDATE CASCADE;


--
-- Name: zones zones_tournament_category_id_fkey; Type: FK CONSTRAINT; Schema: padel_circuit; Owner: postgres
--

ALTER TABLE ONLY padel_circuit.zones
    ADD CONSTRAINT zones_tournament_category_id_fkey FOREIGN KEY (tournament_category_id) REFERENCES padel_circuit.tournament_categories(id) ON UPDATE CASCADE;


--
-- Name: actividades actividades_destino_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actividades
    ADD CONSTRAINT actividades_destino_id_fkey FOREIGN KEY (destino_id) REFERENCES public.destinos(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alojamientos alojamientos_destino_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alojamientos
    ADD CONSTRAINT alojamientos_destino_id_fkey FOREIGN KEY (destino_id) REFERENCES public.destinos(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cuentas_corrientes cuentas_corrientes_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas_corrientes
    ADD CONSTRAINT cuentas_corrientes_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cuentas_corrientes cuentas_corrientes_reserva_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuentas_corrientes
    ADD CONSTRAINT cuentas_corrientes_reserva_id_fkey FOREIGN KEY (reserva_id) REFERENCES public.reservas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cuotas cuotas_cuenta_corriente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuotas
    ADD CONSTRAINT cuotas_cuenta_corriente_id_fkey FOREIGN KEY (cuenta_corriente_id) REFERENCES public.cuentas_corrientes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: destinos destinos_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destinos
    ADD CONSTRAINT destinos_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: pagos pagos_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pagos pagos_cuenta_corriente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_cuenta_corriente_id_fkey FOREIGN KEY (cuenta_corriente_id) REFERENCES public.cuentas_corrientes(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pagos pagos_cuota_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_cuota_id_fkey FOREIGN KEY (cuota_id) REFERENCES public.cuotas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pagos pagos_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: resenas resenas_actividad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas
    ADD CONSTRAINT resenas_actividad_id_fkey FOREIGN KEY (actividad_id) REFERENCES public.actividades(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: resenas resenas_alojamiento_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas
    ADD CONSTRAINT resenas_alojamiento_id_fkey FOREIGN KEY (alojamiento_id) REFERENCES public.alojamientos(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: resenas resenas_destino_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas
    ADD CONSTRAINT resenas_destino_id_fkey FOREIGN KEY (destino_id) REFERENCES public.destinos(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: resenas resenas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resenas
    ADD CONSTRAINT resenas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON UPDATE CASCADE;


--
-- Name: reserva_clientes reserva_clientes_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva_clientes
    ADD CONSTRAINT reserva_clientes_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reserva_clientes reserva_clientes_reserva_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva_clientes
    ADD CONSTRAINT reserva_clientes_reserva_id_fkey FOREIGN KEY (reserva_id) REFERENCES public.reservas(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reservas reservas_tour_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservas
    ADD CONSTRAINT reservas_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict cE5iccPJvlXAdS2mBCDXXi27tuerCCsxaHKwJtaCeaUEPvRucu8KAZKBvbXw1l1

