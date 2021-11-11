-- a) Porcentaje de mesas escrutadas.
select cast((select count(v.nromesa)*100/(select count(m.nromesa) from mesa m) from votosxmesa v) as decimal(2)) as porcentaje;


-- b) Cantidad total de votos emitidos agrupados por escuela.
/*create view votos1 as(
select nombreescuela as escuela,(sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as votos from votosxmesa v join mesa m on v.nromesa=m.nromesa join escuela esc on m.idesc=esc.idesc group by nombreescuela);*/
select * from votos1;

/*create view votos2 as(
select nombreescuela as escuela, sum(votospartido) as votos from votosmesapartido vmp join mesa m on vmp.nromesa=m.nromesa join escuela esc on m.idesc=esc.idesc group by nombreescuela);*/
select * from votos2;

select v1.escuela, (v1.votos + v2.votos) as votos from votos1 v1, votos2 v2 where v1.escuela=v2.escuela;


-- c) Cantidad total de votos emitidos agrupados por Circuito.
/*create view votoscirc1 as(
select nombrecirc,(sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as votos from votosxmesa v join mesa m on v.nromesa=m.nromesa join escuela esc on m.idesc=esc.idesc join circuito cir on esc.idcircuito=cir.idcircuito group by nombrecirc);*/
select * from votoscirc1;

/*create view votoscirc2 as(
select nombrecirc, sum(votospartido) as votos from votosmesapartido vmp join mesa m on vmp.nromesa=m.nromesa join escuela esc on m.idesc=esc.idesc join circuito cir on esc.idcircuito=cir.idcircuito group by nombrecirc);*/
select * from votoscirc2;

select vc1.nombrecirc, (vc1.votos + vc2.votos) as votos from votoscirc1 vc1, votoscirc2 vc2 where vc1.nombrecirc=vc2.nombrecirc;


-- d) Cantidad total de votantes masculinos y femeninos.
/*create view m1 as (select (sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as masc from mesa m join votosxmesa v on v.nromesa=m.nromesa where m.nromesa like 'M%');
create view f1 as (select (sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as fem from mesa m join votosxmesa v on v.nromesa=m.nromesa where m.nromesa like 'F%');

create view m2 as (select sum(votospartido) as masc from votosmesapartido vmp join mesa m on m.nromesa=vmp.nromesa where m.nromesa like 'M%');
create view f2 as (select sum(votospartido) as fem from votosmesapartido vmp join mesa m on m.nromesa=vmp.nromesa where m.nromesa like 'F%');*/


select (f1.fem + f2.fem) as votos_femeninos, (m1.masc + m2.masc) as votos_masculinos from f1, f2, m1, m2 where f1<>f2 and m1<>m2;


--e) % de votos obtenidos por una lista xx en el circuito “Suburbio norte”
select nombrecirc, (sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as votos from 
votosxmesa v join mesa m on v.nromesa=m.nromesa join escuela esc on m.idesc=esc.idesc join circuito circ on esc.idcircuito=circ.idcircuito group by nombrecirc;

select nombrep, sum(votospartido) as cantidad_votos_total from votosmesapartido vmp join partido p on vmp.nropartido=p.nrop group by nombrep;

create or replace function votosxlista (lista text, _circuito text) returns real as 
$$
declare
	cant1 real;
	stot1 real;
	stot2 real;
	res real;
begin
	cant1 := sum(votospartido) from votosmesapartido vmp join partido p on vmp.nropartido=p.nrop join mesa m on m.nromesa=vmp.nromesa join escuela esc on m.idesc=esc.idesc join circuito circ on esc.idcircuito=circ.idcircuito where nombrep=lista and nombrecirc=_circuito;
	stot1 := * from votos_inv;
	stot2 := * from votos_valid;
	res := (cant1/(stot1 + stot2))*100;
	return res;
end 
$$
language plpgsql;


select votosxlista('PJ', 'SUBURBIO NORTE');

-- f) Cantidad de votos obtenidos por una lista xx en la escuela “92 Tucumán”

create or replace function votosxlistesc (lista text) returns real as 
$$
declare
	cant1 real;
	cant2 real;
	res real;
begin
	cant1 := sum(votospartido) from votosmesapartido vmp join partido p on vmp.nropartido=p.nrop join mesa m on m.nromesa=vmp.nromesa join escuela esc on m.idesc=esc.idesc where nombrep=lista and nombreescuela='92 TUCUMAN';
	cant2 := sum(votospartido) from votosmesapartido vmp join partido p on vmp.nropartido=p.nrop join mesa m on m.nromesa=vmp.nromesa join escuela esc on m.idesc=esc.idesc where nombreescuela='92 TUCUMAN';
	res := (cant1/cant2)*100;
	return res;
end 
$$
language plpgsql;

select votosxlistesc('PJ');


-- g) Cantidad total de votos válidos (sin contar blancos, nulos, recurridos e impugnados).
/*create view votos_valid as (select sum(votospartido) as canti_votos_validos from votosmesapartido vmp);*/

select * from votos_valid;


-- h) % de votos no válidos.
/*create view votos_inv as (select (sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as votos from votosxmesa v);*/

create or replace function porvotosinv () returns real as 
$$
declare
	stot1 real;
	stot2 real;
	res real;
begin
	stot1 := * from votos_inv;
	stot2 := sum(votospartido) as cantidad_votos_total from votosmesapartido vmp;
	res := (stot1/(stot1 + stot2))*100;
	return res;
end 
$$
language plpgsql;
 
select porvotosinv(); 

 
-- i) % total de votos obtenidos por cada lista, respecto de la totalidad de los votos.
select (sum(votospartido)*100/((select * from votos_valid)+(select * from votos_inv))) as porcentaje, nombrep from votosmesapartido vmp join partido p on vmp.nropartido=p.nrop join mesa m on m.nromesa=vmp.nromesa group by nombrep;


-- j) % total de votos obtenidos por cada lista, sólo de los votos válidos, esto sin tener en cuenta votos en blanco, nulos, recurridos e impugnados.
select (sum(votospartido)*100/(select * from votos_valid)) as porcentaje, nombrep from votosmesapartido vmp join partido p on vmp.nropartido=p.nrop join mesa m on m.nromesa=vmp.nromesa group by nombrep;


-- k) Cantidad total de votos obtenidos por cada lista
select sum(votospartido), nombrep from votosmesapartido vmp join partido p on vmp.nropartido=p.nrop join mesa m on m.nromesa=vmp.nromesa group by nombrep;


-- l) Lista ganadora por circuito
create view votxparcir as (select sum(votospartido), nombrep, nombrecirc from votosmesapartido vmp join partido p on vmp.nropartido=p.nrop join mesa m on m.nromesa=vmp.nromesa join escuela esc on m.idesc=esc.idesc join circuito circ on esc.idcircuito=circ.idcircuito group by nombrep, nombrecirc order by nombrecirc);

create or replace function listagan(circuito text) returns text as
$$
declare
	res text;
begin
	res := nombrep from votxparcir where votxparcir.nombrecirc=circuito and votxparcir.sum >= all
		(select votxparcir.sum from votxparcir where votxparcir.nombrecirc=circuito) group by votxparcir.sum, nombrep;
	return res;
end
$$
language plpgsql;

select listagan('CIUDAD NORTE')
select listagan('CIUDAD SUD')
select listagan('COLONIA PERFECCION')
select listagan('SANTA CANDIDA')
select listagan('SUBURBIO NORTE')
select listagan('SUBURBIO SUR')

select * from votxparcir where votxparcir.nombrecirc='SUBURBIO SUR' and votxparcir.sum >= all
	(select votxparcir.sum from votxparcir where votxparcir.nombrecirc='SUBURBIO SUR') group by votxparcir.sum, nombrep, nombrecirc order by nombrecirc;

/*
	CIUDAD NORTE: ACUERDO CIV.SOCIAL
	CIUDAD SUD: ACUERDO CIV.SOCIAL
	COLONIA PERFECCION: PJ
	SANTA CANDIDA: PJ
	SUBURBIO NORTE: PJ
	SUBURBIO SUR:PJ
*/


-- m) Primeras cuatro fuerzas por escuela
-- TIP: Utilizar palabra reservada Limit con un límite de 4, es decir, limit=4 o limit 4.


-- n)Diferencia en votos y en porcentaje entre las dos primeras fuerzas


-- o) Partidos que hayan ganado una escuela


-- p) Partidos que hayan ganado un circuito


-- q) Partidos que hayan alcanzado al menos el 5% de los votos

