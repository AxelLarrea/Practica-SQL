--a) ¿Qué modelos de PC tienen una velocidad de al menos 150?
select fabricante, veloc, ram, hd, precio from pc join producto on pc.cod=producto.cod where veloc>=150;

--b) ¿Qué fabricantes hacen laptops con un disco duro de al menos un gigabyte?
select fabricante from laptop join producto on laptop.cod=producto.cod where hd>=1.00;

--c) Hallar el número de modelo y el precio de todos los productos (de cualquier tipo) hechos por el fabricante B.-
select p.cod, precio from (producto as p join pc on p.cod=pc.cod) where p.fabricante='B' union
select p.cod, precio from (producto as p join laptop as l on p.cod=l.cod) where p.fabricante='B' union
select p.cod, precio from (producto as p join impresora as i on p.cod=i.cod) where p.fabricante='B';

--d) Hallar el número de modelo de todas las impresoras color.
select cod from impresora where color=true;

--e) Hallar los fabricantes que venden laptops pero no PCs.
select fabricante from producto where tipo='Laptop' except select fabricante from producto where tipo='Pc';

--f) Hallar aquellos tamaños de discos que ocurren en dos o más PCs.
select pc1.hd from pc pc1 join pc pc2 on pc1.hd=pc2.hd where pc1.cod<>pc2.cod group by pc1.hd;

--g) Hallar pares de modelos de PC tales que ambos posean la misma velocidad y RAM. Un par debe ser listado una sola vez: (i,j) pero no (j,i)
select pc.cod, pc1.cod cod2 from pc, pc pc1 where pc.veloc=pc1.veloc and pc.ram=pc1.ram and pc.cod<>pc1.cod and pc.cod<pc1.cod;

--h) Hallar aquellos fabricantes que ofrezcan computadoras (sean PC o laptop) con velocidades de al menos 133.
(select fabricante from (producto p join pc on p.cod=pc.cod) where veloc>=133 union
select fabricante from (producto p join laptop l on p.cod=l.cod) where veloc>=133) order by fabricante;

--i) Hallar los fabricantes de la computadora (PC o laptop) con la máxima velocidad disponible.
(select fabricante from (producto p join pc on p.cod=pc.cod) where veloc >= all (select veloc from pc) union
select fabricante from (producto p join laptop l on p.cod=l.cod) where veloc >= all (select veloc from laptop)) order by fabricante;