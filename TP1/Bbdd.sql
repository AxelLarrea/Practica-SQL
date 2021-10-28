--Tabla de empleado
create table empleado(
	dni int,
	apellido varchar(40),
	nombre varchar(40),
	genero char,
	sueldo int,
	primary key(dni)
);


--Agregado de registros/tuplas
insert into empleado(dni,apellido,nombre,genero,sueldo) values(25100000, 'PEREZ', 'PABLO', 'M', 18000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values(29332501,'SLOTOWIAZDA','MARIA','F',35000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values(19302500,'TENEMBAUN','ENRNESTO','M',22500);
insert into empleado(dni,apellido,nombre,genero,sueldo) values(33001321,'RINEIRI','EVANGELINA','F',17000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values(22958543,'DIAZ','XIMENA','F',48000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values(35254310,'PEREZ LINDO','MATIAS','M',29000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values(33387695,'RICCA','JAVIER','M',29700);
insert into empleado(dni,apellido,nombre,genero,sueldo) values(25321542,'SIGNORINI','ESTELA','F',45000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values(27123456,'REZONICO','CONSTANZA','F',31000);
insert into empleado(dni,apellido,nombre,genero,sueldo) values(13334401,'RETAMAR','JOAQUIN','F',35000);


--Tabla departamento
create table departamento(
	codigo int,
	nombre varchar(20),
	primary key(codigo)
);


--Tuplas de departamentos
insert into departamento(codigo,nombre) values (1,'PRODUCCION');
insert into departamento(codigo,nombre) values (2,'COMPUTOS');
insert into departamento(codigo,nombre) values (3,'VENTAS');
insert into departamento(codigo,nombre) values (4,'DEPOSITO');


--Eliminar departamento ventas
delete from departamento where nombre='VENTAS';


--Tabla trabajapara
create table trabajapara (
	dni int,
	codigo int,
	horas int,
	primary key(dni, codigo),
	foreign key(dni) references empleado(dni),
	foreign key(codigo) references departamento(codigo)
);


--Tuplas en trabajapara
insert into trabajapara(dni,codigo,horas) values(25100000,1,15);
insert into trabajapara(dni,codigo,horas) values(29332501,2,30);
insert into trabajapara(dni,codigo,horas) values(19302500,4,45);
insert into trabajapara(dni,codigo,horas) values(33001321,4,20);
insert into trabajapara(dni,codigo,horas) values(22958543,1,25);
insert into trabajapara(dni,codigo,horas) values(35254310,2,30);
insert into trabajapara(dni,codigo,horas) values(33387695,1,50);
insert into trabajapara(dni,codigo,horas) values(25321542,1,15);
insert into trabajapara(dni,codigo,horas) values(25321542,4,25);
insert into trabajapara(dni,codigo,horas) values(27123456,1,12);
insert into trabajapara(dni,codigo,horas) values(13334401,4,28);


--Cambio de genero a Retamar
update empleado set genero='M' where dni=13334401;