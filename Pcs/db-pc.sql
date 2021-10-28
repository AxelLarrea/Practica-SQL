
begin work;
set constraints all deferred;

CREATE TABLE "pc" (
	"cod" smallint NOT NULL,
	"veloc" smallint NOT NULL,
	"ram" smallint NOT NULL,
	"hd" smallint NOT NULL,
	"precio" smallint NOT NULL,
	Constraint "pc_pkey" Primary Key ("cod")
);


CREATE TABLE "laptop" (
	"cod" smallint NOT NULL,
	"veloc" smallint NOT NULL,
	"ram" smallint NOT NULL,
	"pantalla" smallint NOT NULL,
	"precio" smallint NOT NULL,
	"hd" decimal(4,2) NOT NULL,
	Constraint "laptop_pkey" Primary Key ("cod")
);


CREATE TABLE "impresora" (
	"cod" smallint NOT NULL,
	"color" boolean NOT NULL,
	"tipo" character(8) NOT NULL,
	"precio" smallint NOT NULL,
	Constraint "impresora_pkey" Primary Key ("cod")
);


CREATE TABLE "producto" (
	"fabricante" character(1) NOT NULL,
	"cod" smallint NOT NULL,
	"tipo" character(8) NOT NULL,
	Constraint "producto_pkey" Primary Key ("cod")
);


INSERT INTO impresora (cod, color, tipo, precio) VALUES (3001, true, 'Ink-jet ', 275);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3002, true, 'Ink-jet ', 269);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3003, true, 'Laser   ', 829);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3004, false, 'Laser   ', 879);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3005, false, 'Ink-jet ', 180);
INSERT INTO impresora (cod, color, tipo, precio) VALUES (3006, true, 'Impacto ', 470);


INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2001, 100, 20, 110, 95, 1.10);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2002, 117, 12, 75, 113, 0.75);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2003, 117, 32, 100, 104, 1.00);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2004, 133, 16, 110, 112, 1.10);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2005, 133, 16, 100, 113, 1.00);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2006, 120, 8, 81, 121, 0.81);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2007, 150, 16, 135, 121, 1.35);
INSERT INTO laptop (cod, veloc, ram, pantalla, precio, hd) VALUES (2008, 120, 16, 110, 121, 1.10);



INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1001, 133, 16, 16, 6);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1002, 120, 16, 16, 6);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1003, 166, 24, 25, 6);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1004, 166, 32, 25, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1005, 166, 16, 20, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1006, 200, 32, 31, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1007, 200, 32, 32, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1008, 180, 32, 20, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1009, 200, 32, 25, 8);
INSERT INTO pc (cod, veloc, ram, hd, precio) VALUES (1010, 160, 16, 12, 8);


INSERT INTO producto (fabricante, cod, tipo) VALUES ('A', 1001, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('A', 1002, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('A', 1003, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('B', 1004, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('B', 1006, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('B', 3002, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('B', 3004, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('C', 1005, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('C', 1007, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 1008, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 1009, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 1010, 'Pc      ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 2001, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 2002, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 2003, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 3001, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('D', 3003, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('E', 2004, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('E', 2008, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('F', 2005, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('G', 2006, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('G', 2007, 'Laptop  ');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('H', 3005, 'Impresor');
INSERT INTO producto (fabricante, cod, tipo) VALUES ('I', 3006, 'Impresor');


GRANT ALL ON  "pc"  TO PUBLIC ;
GRANT ALL ON  "laptop"  TO PUBLIC ;
GRANT ALL ON  "impresora"  TO PUBLIC ;
GRANT ALL ON  "producto"  TO PUBLIC ;


commit;
