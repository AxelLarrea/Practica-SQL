--a) Los nombres y los países de las clases que llevaban cañones de al menos 16 pulgadas de calibre.
select clase, pais from clase where calibre>=16;

--b) Hallar los barcos botados antes de 1921.
select * from barco where botado<1921;

--c) Hallar los barcos hundidos en la batalla del Atlántico Norte.
select barco from participa where batalla='Atlantico Norte' and resultado='Hundido';

--d) El tratado de Washington de 1921 prohibió los barcos de más de 35000 toneladas. Listar los barcos que violaron el tratado de Washington.
select * from barco join clase on barco.clase=clase.clase where desplazamiento>35000;

--e) Listar el nombre, el desplazamiento y el número de cañones de los barcos que participaron de la batalla de Guadalcanal.
select nombre, desplazamiento, caniones from (barco join clase on barco.clase=clase.clase) join participa on barco.nombre=participa.barco where batalla='Guadalcanal';

--f) Hallar los países que tuvieron tanto cruceros como acorazados.
select pais from clase where tipo='Bc' intersect select pais from clase where tipo='Bb';

--g) Hallar los barcos que, siendo dañados en alguna batalla, participaron posteriormente de alguna otra.
select barco from participa where resultado='Dañado' intersect select barco from participa where resultado='Intacto' or resultado='Hundido' or resultado='Dañado';

--h) ¿La base de datos presentada como ejemplo se encuentra en estado consistente? De no ser así, indique alguna inconsistencia que haya encontrado.
-- Rta: No, puesto que hay ciertos errores en los datos, por ejemplo, en la tabla 'participa', en el campo 'batalla' hay una tupla que contiene el valor 'Gadalcanal' 
-- en vez de 'Guadalcanal', lo que afectaría en alguna consulta a realizar.