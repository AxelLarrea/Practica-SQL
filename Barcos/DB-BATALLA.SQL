begin work;
set constraints all deferred;

CREATE TABLE "barco" (
	"nombre" character varying(32) NOT NULL,
	"clase" character varying(10) NOT NULL,
	"botado" smallint NOT NULL,
	Constraint "barco_pkey" Primary Key ("nombre")
);


CREATE TABLE "batalla" (
	"nombre" character varying(32) NOT NULL,
	"fecha" date NOT NULL,
	Constraint "batalla_pkey" Primary Key ("nombre")
);


CREATE TABLE "participa" (
	"barco" character varying(32) NOT NULL,
	"batalla" character varying(32) NOT NULL,
	"resultado" character varying(15) NOT NULL,
	Constraint "participa_pkey" Primary Key ("barco", "batalla")
);


CREATE TABLE "clase" (
	"clase" character varying(15) NOT NULL,
	"tipo" character(2) NOT NULL,
	"pais" character varying(15) NOT NULL,
	"caniones" smallint NOT NULL,
	"calibre" smallint NOT NULL,
	"desplazamiento" integer NOT NULL,
	Constraint "clase_pkey" Primary Key ("clase")
);



INSERT INTO barco (nombre, clase, botado) VALUES ('California', 'Tennessee', 1921);
INSERT INTO barco (nombre, clase, botado) VALUES ('Haruna', 'Kongo', 1915);
INSERT INTO barco (nombre, clase, botado) VALUES ('Hiei', 'Kongo', 1914);
INSERT INTO barco (nombre, clase, botado) VALUES ('Iowa', 'Iowa', 1943);
INSERT INTO barco (nombre, clase, botado) VALUES ('Karishima', 'Kongo', 1915);
INSERT INTO barco (nombre, clase, botado) VALUES ('Kongo', 'Kongo', 1913);
INSERT INTO barco (nombre, clase, botado) VALUES ('Missouri', 'Iowa', 1944);
INSERT INTO barco (nombre, clase, botado) VALUES ('Masashi', 'Yamato', 1942);
INSERT INTO barco (nombre, clase, botado) VALUES ('New Jersey', 'Iowa', 1943);
INSERT INTO barco (nombre, clase, botado) VALUES ('North Carolina', 'North Car', 1941);
INSERT INTO barco (nombre, clase, botado) VALUES ('Ramillies', 'Revenge', 1917);
INSERT INTO barco (nombre, clase, botado) VALUES ('Renown', 'Renown', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Repulse', 'Renown', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Resolution', 'Revenge', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Revenge', 'Revenge', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Reyal Oak', 'Revenge', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Royal Sovereign', 'Revenge', 1916);
INSERT INTO barco (nombre, clase, botado) VALUES ('Tennessee', 'Tennessee', 1920);
INSERT INTO barco (nombre, clase, botado) VALUES ('Washington', 'North Car', 1941);
INSERT INTO barco (nombre, clase, botado) VALUES ('Wisconsin', 'Iowa', 1944);
INSERT INTO barco (nombre, clase, botado) VALUES ('Yamato', 'Yamato', 1941);


INSERT INTO batalla (nombre, fecha) VALUES ('Guadalcanal', '1942-11-15');
INSERT INTO batalla (nombre, fecha) VALUES ('Cabo Norte', '1943-12-26');
INSERT INTO batalla (nombre, fecha) VALUES ('Estrecho Surigao', '1944-10-25');
INSERT INTO batalla (nombre, fecha) VALUES ('Atlantico Norte', '1941-05-24');


INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Bismarck', 'Bb', 'Alemania', 8, 15, 42000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Iowa', 'Bb', 'EEUU', 9, 16, 46000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Kongo', 'Bc', 'Japón', 8, 14, 32000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('North Carolina', 'Bb', 'EEUU', 9, 16, 37000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Renown', 'Bc', 'GB', 6, 15, 32000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Revenge', 'Bb', 'GB', 8, 15, 29000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Tennessee', 'Bb', 'EEUU', 12, 14, 32000);
INSERT INTO clase (clase, tipo, pais, caniones, calibre, desplazamiento) VALUES ('Yamato', 'Bb', 'Japón', 9, 18, 65000);



INSERT INTO participa (barco, batalla, resultado) VALUES ('California', 'Estrecho Surigao', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Duke of York', 'Cabo Norte', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Fuso', 'Estrecho Surigao', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Hood', 'Atlantico Norte', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Kirishima', 'Guadalcanal', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Scharnhorst', 'Cabo Norte', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('South Dakota', 'Guadalcanal', 'Dañado');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Tennessee', 'Estrecho Surigao', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Washington', 'Gadalcanal', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('West Virginia', 'Estrecho Surigao', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Yamashiro', 'Estrecho Surigao', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Bismark', 'Atantico Norte', 'Hundido');
INSERT INTO participa (barco, batalla, resultado) VALUES ('King George V', 'Atlantico Norte', 'Intacto');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Prince of Wales', 'Atlantico Norte', 'Dañado');
INSERT INTO participa (barco, batalla, resultado) VALUES ('Rodney', 'Atantico Norte', 'Intacto');

CREATE UNIQUE INDEX "participa_barco_batalla" on "participa" using btree ( "barco" "varchar_ops", "batalla" "varchar_ops" );

GRANT ALL ON  "barco"  TO PUBLIC ;
GRANT ALL ON  "batalla"  TO PUBLIC ;
GRANT ALL ON  "participa"  TO PUBLIC ;
GRANT ALL ON  "clase"  TO PUBLIC ;

commit;
