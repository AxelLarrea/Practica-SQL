-- a) Porcentaje de mesas escrutadas.
select cast((select count(v.nromesa)*100/(select count(m.nromesa) from mesa m) from votosxmesa v) as decimal(5)) as porcentaje;

-- b) Cantidad total de votos emitidos agrupados por escuela.
select nombreescuela as escuela,(sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as votos from votosxmesa v join mesa m on v.nromesa=m.nromesa join escuela esc on m.idesc=esc.idesc group by nombreescuela;

-- c) Cantidad total de votos emitidos agrupados por Circuito.
select nombrecirc,(sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as votos from votosxmesa v join mesa m on v.nromesa=m.nromesa join escuela esc on m.idesc=esc.idesc join circuito cir on esc.idcircuito=cir.idcircuito group by nombrecirc;

-- d) Cantidad total de votantes masculinos y femeninos.
select (sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as votos from mesa m join votosxmesa v on v.nromesa=m.nromesa where m.nromesa like 'M%' union
select (sum(v.blancos)+sum(v.nulos)+sum(v.recurridos)+sum(v.impugnados)) as votos from mesa m join votosxmesa v2 on v.nromesa=m.nromesa where m.nromesa like 'F%';

-- e) % de votos obtenidos por una lista xx en el circuito “Suburbio norte”


-- f) Cantidad de votos obtenidos por una lista xx en la escuela “92 Tucumán”


-- g) Cantidad total de votos válidos (sin contar blancos, nulos, recurridos e impugnados).


-- h) % de votos no válidos.


-- i) % total de votos obtenidos por cada lista, respecto de la totalidad de los votos.


-- j) % total de votos obtenidos por cada lista, sólo de los votos válidos, esto sin tener en cuenta votos en blanco, nulos, recurridos e impugnados.


-- k) Cantidad total de votos obtenidos por cada lista


-- l) Lista ganadora por circuito


-- m) Primeras cuatro fuerzas por escuela


-- n)Diferencia en votos y en porcentaje entre las dos primeras fuerzas


-- o) Partidos que hayan ganado una escuela


-- p) Partidos que hayan ganado un circuito


-- q) Partidos que hayan alcanzado al menos el 5% de los votos