-- a) Listar todos los empleados
create view lista_emp as (select * from empleado);

select * from lista_emp;

-- b) Listar los empleados de género masculino
select * from empleado where genero='M';

-- c) Listar el mayor sueldo, el menor sueldo, el sueldo promedio de los empleados.
select max(sueldo), min(sueldo), avg(sueldo) from empleado;

-- d) Listar la cantidad de empleados cuyo sueldo supera 20000
select count(*) from empleado where sueldo>20000;

-- e) Listar el promedio de sueldos del departamento ‘COMPUTOS’
select avg(sueldo) from empleado e, trabajapara tr, departamento d where d.nombre='COMPUTOS' and tr.codigo=d.codigo and e.dni=tr.dni;

-- f) Listar cantidad de horas que se trabaja en el departamento ‘PRODUCCION’
select sum(horas) from trabajapara tr, departamento d where d.nombre='PRODUCCION' and tr.codigo=d.codigo;

-- g) Listar los nombres de los empleados que trabajan al menos 25 horas para el departamento ‘DEPOSITO’
select (e.nombre, e.apellido) from empleado e, trabajapara tr, departamento d where d.nombre='DEPOSITO' and tr.codigo=d.codigo and e.dni=tr.dni and tr.horas>=25;