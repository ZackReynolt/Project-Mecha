/* ============================= CREACIÓN DE LAS TABLAS ===================================
   ========================================================================================*/

CREATE TABLE pais (
	codigo		VARCHAR (2)	CONSTRAINT pk_pais		PRIMARY KEY,
	nombre		VARCHAR (20)	CONSTRAINT nn_nombre_pais	NOT NULL,
	num_hab		NUMBER (16)
);

CREATE TABLE piloto (
	dni		VARCHAR (9)	CONSTRAINT pk_piloto		PRIMARY KEY,
	apellido	VARCHAR (10)	CONSTRAINT nn_apellido_piloto	NOT NULL,
	nombre		VARCHAR (10),	
	f_nac		DATE,
	f_ingreso	DATE		CONSTRAINT nn_fech_ingr_piloto	NOT NULL,
	sexo		VARCHAR (1)	CONSTRAINT ck_sex_piloto	CHECK (sexo IN('M','F')),
	rango		VARCHAR (10),
	localidad	VARCHAR (20),
	salario		NUMBER (7,2),
	pais		VARCHAR (2)	CONSTRAINT fk_pais_piloto	REFERENCES pais
);

CREATE TABLE mecha (
	id		VARCHAR (10)	CONSTRAINT pk_mecha		PRIMARY KEY,
	dni		VARCHAR (9)	CONSTRAINT fk_dni_mecha		REFERENCES piloto
);

CREATE TABLE pieza (
	ns		VARCHAR (8)	CONSTRAINT pk_pieza		PRIMARY KEY,
	tipo		VARCHAR (7)	CONSTRAINT ck_tipo_pieza	CHECK (tipo IN ('Cabeza','Brazos','Piernas','Torso','Arma','otros')),		
	nombre		VARCHAR (10),
	descripcion	VARCHAR (200),
	precio		NUMBER	(6)	CONSTRAINT nn_precio_pieza	NOT NULL,
	peso		NUMBER	(4)	CONSTRAINT nn_peso_pieza	NOT NULL,
	energia		NUMBER	(6)	CONSTRAINT nn_energia_pieza	NOT NULL	
);

CREATE TABLE mision (
	num_mision	VARCHAR (3)	CONSTRAINT pk_mision		PRIMARY KEY,
	fecha		DATE		cONSTRAINT nn_fecha_mision	NOT NULL,
	nombre		VARCHAR (20),
	descripcion	VARCHAR (200),	
	estado		VARCHAR (12)	CONSTRAINT ck_estado_mision	CHECK (estado IN ('Completada','Iniciada','Pendiente'))
);

CREATE TABLE mech_pieza (
	id		VARCHAR (10),
	ns		VARCHAR (8),
	CONSTRAINT pk_mech_pieza PRIMARY KEY(id,ns), 
	CONSTRAINT fk_mech_pieza_id FOREIGN KEY (id) REFERENCES mecha,
	CONSTRAINT fk_mech_pieza_ns FOREIGN KEY (ns) REFERENCES pieza
);

CREATE TABLE mech_mision (
	id		VARCHAR (10),
	num_mision	VARCHAR (3),
	CONSTRAINT pk_mech_mision PRIMARY KEY(id,num_mision),
	CONSTRAINT fk_mech_mision_id FOREIGN KEY (id) REFERENCES mecha,
	CONSTRAINT fk_mech_mision_num_mision FOREIGN KEY (num_mision) REFERENCES mision
);

CREATE TABLE pais_mision (
	codigo		VARCHAR(2),
	num_mision	VARCHAR(3),
	CONSTRAINT pk_pais_mision PRIMARY KEY(codigo,num_mision),
	CONSTRAINT fk_pais_mision_codigo FOREIGN KEY (codigo) REFERENCES pais,
	CONSTRAINT fk_pais_mision_num_mision FOREIGN KEY (num_mision) REFERENCES mision
);

/*==================================================================================================
  ==================================================================================================*/


/* ===================================== INSERCIONES ===============================================
   =================================================================================================*/
/* Inserción de Países */
INSERT INTO pais VALUES (
'ES','España','47270000');

INSERT INTO pais VALUES (
'DE','Alemania','81730000');

INSERT INTO pais VALUES (
'JP','Japon','126874000');

INSERT INTO pais VALUES (
'US','Estados Unidos','316668567');

INSERT INTO pais VALUES (
'SE','Suecia','9514406');

INSERT INTO pais VALUES (
'GB','Reino Unido','61284806');

INSERT INTO pais VALUES (
'RU','Rusia','142905200');

INSERT INTO pais VALUES (
'KR','Corea del Sur','49540000');


/* Inserción de Pilotos */
INSERT INTO piloto VALUES (
'26500129N','Ford','James','21-SEP-1989','13-MAR-1995','M','Coronel','Peal de Becerro','14500,49','ES');

INSERT INTO piloto VALUES (
'11111111A','Jensen','Eric','17-05-1990','28-06-2010','M','Brigada','San Francisco','8099,99','US');

INSERT INTO piloto VALUES (
'22222222B','Wakefield','Lorreine','09-08-1991','12-10-2012','F','Soldado','Londres','2509,99','GB');

INSERT INTO piloto VALUES (
'33333333C','Lagunov','Vaska','11-04-1996','4-12-1998','M','Cabo','San Petersburgo','6507,37','RU');

INSERT INTO piloto VALUES (
'44444444D','Sanders','John','11-04-1992','5-10-2012','M','Soldado','Ciudad de Arizona','2507,37','US');

INSERT INTO piloto VALUES (
'55555555E','Seong','Hwan','27-02-1996','5-1-2002','M','Sargento','Seul','3482,36','KR');


/* Inserción de Piezas */
INSERT INTO pieza VALUES (
'UHD-10','Cabeza','TRISTAN',
'Cabeza de la Primera Generación. Modelo de asalto diseñado para el frente de batalla',
60000,188,1150);

INSERT INTO pieza VALUES (
'CR113','Torso','OSTARA','',76000,681,699);

INSERT INTO pieza VALUES (
'10/A','Brazos','UAM','',50000,498,948);

INSERT INTO pieza VALUES (
'UGL-09','Piernas','','Piernas estandar',105000,1018,1075);

INSERT INTO pieza VALUES (
'UFC-11','otros','GLANCE','Sistema FCS',40000,38,1689);

INSERT INTO pieza VALUES (
'UGN-71','otros','ROBUST','Generador de alta corriente',89000,809,-63890);

INSERT INTO pieza VALUES (
'ULB-13','Arma','PLYMOUTH','Espada laser',50000,118,901);

INSERT INTO pieza VALUES (
'KO-2H4','Arma','PODENKA','Rifle de Asalto',30000,762,340);

INSERT INTO pieza VALUES (
'URL-17','Arma','BIKANER','Lanzacohetes para hombro/espalda',50000,1012,48);

INSERT INTO pieza VALUES (
'UHD-22','Cabeza','LANCELOT',
'Reconstrucción de segunda generación del modelo prototípico UHD. Modelo de asalto especial para tiroteos',
108000,211,1046);

INSERT INTO pieza VALUES (
'KT-3N2','Piernas','BARGUZIN','Alta capacidad',90000,2453,998);

INSERT INTO pieza VALUES (
'GNE530','otros','SONNE','Generador de alta corriente de un increíble potencial. Tecnología extinta',
109000,597,-200130);

INSERT INTO pieza VALUES (
'FJ-13','Arma','OHOKAMU','Escudo de Tritanium',90000,517,0);

INSERT INTO pieza VALUES (
'USG-23','Arma','GENEVA','Pistola Gatling de calibre 100mm',40000,646,428);

INSERT INTO pieza VALUES (
'CIWS-8','Arma','NAGPUR','Unidad anti-misiles para el hombro',15000,178,398);

INSERT INTO pieza VALUES (
'HD-19','Cabeza','UNICORN','Cabeza unicornio con modo de combate',136000,418,2102);

INSERT INTO pieza VALUES (
'10/B','Torso','UCR','Torso de oricalco',133000,764,854);

INSERT INTO pieza VALUES (
'UAM-23','Brazos','ANIMAS','',105000,1037,1276);

INSERT INTO pieza VALUES (
'BBDD','otros','PRUEBA','',0,0,0);


/* Inserción de Mechas */
INSERT INTO mecha VALUES (
'WHITEGLYNT','55555555E');

INSERT INTO mecha VALUES (
'NEPHERTEM','44444444D');

INSERT INTO mecha VALUES (
'BLACKSUN','26500129N');

INSERT INTO mecha VALUES (
'M.ANGELO','33333333C');


/* Inserción de las piezas en el Mecha */
/* === MECHA WHITEGLYNT === */
INSERT INTO mech_pieza VALUES (
'WHITEGLYNT','UHD-10');

INSERT INTO mech_pieza VALUES (
'WHITEGLYNT','CR113');

INSERT INTO mech_pieza VALUES (
'WHITEGLYNT','10/A');

INSERT INTO mech_pieza VALUES (
'WHITEGLYNT','UGL-09');

INSERT INTO mech_pieza VALUES (
'WHITEGLYNT','UFC-11');

INSERT INTO mech_pieza VALUES (
'WHITEGLYNT','UGN-71');

INSERT INTO mech_pieza VALUES (
'WHITEGLYNT','ULB-13');

INSERT INTO mech_pieza VALUES (
'WHITEGLYNT','KO-2H4');

INSERT INTO mech_pieza VALUES (
'WHITEGLYNT','URL-17');

/* === MECHA NEFERTEM === */
INSERT INTO mech_pieza VALUES (
'NEPHERTEM','UHD-22');

INSERT INTO mech_pieza VALUES (
'NEPHERTEM','CR113');

INSERT INTO mech_pieza VALUES (
'NEPHERTEM','10/A');

INSERT INTO mech_pieza VALUES (
'NEPHERTEM','KT-3N2');

INSERT INTO mech_pieza VALUES (
'NEPHERTEM','UFC-11');

INSERT INTO mech_pieza VALUES (
'NEPHERTEM','GNE530');

INSERT INTO mech_pieza VALUES (
'NEPHERTEM','ULB-13');

INSERT INTO mech_pieza VALUES (
'NEPHERTEM','FJ-13');

INSERT INTO mech_pieza VALUES (
'NEPHERTEM','USG-23');

INSERT INTO mech_pieza VALUES (
'NEPHERTEM','CIWS-8');

/* === MECHA BLACKSUN === */
INSERT INTO mech_pieza VALUES (
'BLACKSUN','HD-19');

INSERT INTO mech_pieza VALUES (
'BLACKSUN','10/B');

INSERT INTO mech_pieza VALUES (
'BLACKSUN','UAM-23');

INSERT INTO mech_pieza VALUES (
'BLACKSUN','KT-3N2');

INSERT INTO mech_pieza VALUES (
'BLACKSUN','FJ-13');

INSERT INTO mech_pieza VALUES (
'BLACKSUN','CIWS-8');

INSERT INTO mech_pieza VALUES (
'BLACKSUN','KO-2H4');

INSERT INTO mech_pieza VALUES (
'BLACKSUN','URL-17');

INSERT INTO mech_pieza VALUES (
'BLACKSUN','ULB-13');

INSERT INTO mech_pieza VALUES (
'BLACKSUN','GNE530');

/* === MECHA MICHELANGELO === */
INSERT INTO mech_pieza VALUES (
'M.ANGELO','UHD-10');

INSERT INTO mech_pieza VALUES (
'M.ANGELO','CR113');

INSERT INTO mech_pieza VALUES (
'M.ANGELO','10/A');

INSERT INTO mech_pieza VALUES (
'M.ANGELO','UGL-09');

INSERT INTO mech_pieza VALUES (
'M.ANGELO','UGN-71');

INSERT INTO mech_pieza VALUES (
'M.ANGELO','KO-2H4');


/*Inserción de misiones*/
INSERT INTO mision VALUES (
'01A','13-10-2012','Desert-Scarab','Ir al desierto de Arizona y acabar con el escarabajo','Completada');

INSERT INTO mision VALUES (
'05A','08-03-2013','Dr.Ai','Detener la Bomba Arcoiris en Berlin','Pendiente');

INSERT INTO mision VALUES (
'06A','13-05-2013','GB','Detener el ataque de China','Completada');


/*Inserción del pais de la misión*/
INSERT INTO pais_mision VALUES ('US','01A');

INSERT INTO pais_mision VALUES ('ES','05A');

INSERT INTO pais_mision VALUES ('GB','05A');

INSERT INTO pais_mision VALUES ('DE','05A');

INSERT INTO pais_mision VALUES ('GB','06A');

/*Inserción de los mechas en las misiones*/
INSERT INTO mech_mision VALUES ('NEPHERTEM','01A');

INSERT INTO mech_mision VALUEs ('M.ANGELO','01A');

INSERT INTO mech_mision VALUES ('NEPHERTEM','05A'); 

INSERT INTO mech_mision VALUES ('BLACKSUN','06A');

INSERT INTO mech_mision VALUES ('NEPHERTEM','06A');

/*======================================== CONSULTAS ============================================
  ===============================================================================================*/
/*Consultar el nombre, apellido, rango y salario de los pilotos que tengan una unidad mecha*/
SELECT m.id "MECHA",p.nombre,p.apellido,p.rango,p.salario "Euros/mes"
FROM mecha m,piloto p
WHERE m.dni=p.dni;


/*Consultar todas las piezas de la unidad mecha perteneciente al piloto con dni=55555555E*/
SELECT *
FROM mech_pieza
WHERE id=(	SELECT id
		FROM mecha
		WHERE dni='55555555E');


/*Consultar cuánto necesita la empresa al mes para mantener el contrato con los pilotos*/
SELECT SUM(salario) "Total/Mes"
FROM piloto;


/*¿Qué pilotos ingresaron en la empresa durante el 2012 y cuándo es su cumpleaños? 
Muestra el día y el mes en formato DD-MMM*/
SELECT dni, TO_CHAR(f_nac, 'dd-mon')Fecha
FROM piloto
WHERE f_ingreso>'31/12/2011' AND f_ingreso<'01/01/2013';


/*Consultar cuánto ha costado la unidad mecha NEPHERTEM*/
SELECT SUM(p.precio) "Coste Total"
FROM pieza p, mech_pieza x, mecha m
WHERE p.ns=x.ns AND x.id=m.id AND m.id='NEPHERTEM';


	/*Consultar cuánto ha costado la unidad mecha del piloto John Sanders*/
	SELECT SUM(p.precio) "Coste Total"
	FROM pieza p, mech_pieza x, mecha m, piloto pi
	WHERE p.ns=x.ns AND x.id=m.id AND m.dni=pi.dni 
			AND pi.nombre='John' AND pi.apellido='Sanders';

	/*Nota: NEPHERTEM es la unidad mecha de John Sanders, por eso el resultado es el mismo.
	Lo he hecho así para poder comprobar que ambos eran correctos al coincidir*/


/*Consultar el precio de las unidades mecha*/
SELECT mp.id, SUM(p.precio) "Coste"
FROM pieza p, mech_pieza mp
WHERE p.ns=mp.ns
GROUP BY mp.id;


/*Consultar qué unidad mecha es la más cara de toda la empresa*/
SELECT mp.id, SUM(p.precio) "Coste"
FROM pieza p, mech_pieza mp
WHERE p.ns=mp.ns
HAVING SUM(p.precio)=(	SELECT MAX(SUM(p.precio))
			FROM pieza p, mech_pieza mp
			WHERE p.ns=mp.ns
			GROUP BY mp.id)
GROUP BY mp.id;


/*Consultar en qué países se ha llevado a cabo al menos una misión*/
SELECT nombre
FROM pais
WHERE codigo IN(SELECT DISTINCT codigo
		FROM pais_mision);

	/*Otra solución al mismo problema, que además muestra qué misión tuvo lugar en el país*/
	SELECT p.nombre, m.num_mision
	FROM pais p, pais_mision pm, mision m
	WHERE p.codigo=pm.codigo AND pm.num_mision=m.num_mision;


/*Consultar para cada misión, dónde tuvo lugar, los pilotos que la llevaron a cabo y sus respectivas 
unidades mecha. También el estado de la misión.*/
SELECT m.num_mision "MISION", pa.nombre "PAIS", p.dni, p.apellido "PILOTO", me.id "MECHA", m.estado
FROM mision m, pais_mision pm, pais pa,mech_mision mm, mecha me, piloto p
WHERE m.num_mision=pm.num_mision AND pm.codigo=pa.codigo 
	AND m.num_mision=mm.num_mision AND mm.id=me.id AND me.dni=p.dni
ORDER BY m.num_mision;


/*Consultar qué pilotos estuvieron en la misión Desert-Scarab*/
SELECT apellido,nombre
FROM piloto p, mecha m
WHERE p.dni=m.dni AND id IN (	SELECT mm.id
				FROM mech_mision mm, mision m
				WHERE mm.num_mision=m.num_mision AND m.nombre='Desert-Scarab');



/*Consultar qué misiones amenazaron más de un país*/
SELECT m.num_mision,fecha,nombre,COUNT(codigo) "Países amenazados"
FROM mision m, pais_mision pm
WHERE m.num_mision=pm.num_mision
HAVING COUNT(codigo)>1
GROUP BY m.num_mision,fecha,nombre;


/*Consultar cuánta gente está expuesta para cada misión de las que se ha realizado*/
SELECT m.num_mision, SUM(p.num_hab) "Habitantes expuestos"
FROM mision m, pais_mision pm, pais p
WHERE m.num_mision=pm.num_mision AND pm.codigo=p.codigo
GROUP BY m.num_mision;


/*Consultar cuántas personas ha salvado cada piloto. Si una persona ha sido salvada
al mismo tiempo por varios pilotos, contará como persona individual para el recuento
de cada uno. */
SELECT m.dni, SUM(p.num_hab) "Habitantes salvados"
FROM mecha m, mech_mision mm, pais_mision pm, pais p
WHERE m.id=mm.id AND mm.num_mision=pm.num_mision AND pm.codigo=p.codigo
GROUP BY m.dni;


/*Consultar qué pilotos han participado en todas las misiones*/
SELECT p1.dni, p1.nombre, p1.apellido
FROM piloto p1
WHERE NOT EXISTS((	SELECT num_mision
			FROM mision) 
	MINUS 
	(	SELECT m.num_mision
		FROM mech_mision m, mecha me, piloto p
		WHERE m.id=me.id AND me.dni=p.dni AND p.dni=p1.dni));


/*Consultar las unidades mecha que han participado sólo en misiones de EEUU*/
SELECT m.id
FROM mecha m
WHERE NOT EXISTS ((	SELECT pm.num_mision
			FROM pais_mision pm, mech_mision mm
			WHERE pm.num_mision=mm.num_mision AND mm.id=m.id)
	MINUS 
			(SELECT DISTINCT num_mision
			FROM pais_mision
			WHERE codigo='US'));


/*Consultar qué parejas de pilotos han participado en las mismas misiones*/
SELECT p1.nombre,p2.nombre
FROM piloto p1, piloto p2
WHERE NOT EXISTS ((	SELECT m.num_mision
			FROM mision m, mech_mision mm, mecha me
			WHERE mm.num_mision=m.num_mision AND mm.id=me.id AND me.dni=p1.dni)
	MINUS
			(SELECT m.num_mision
			FROM mision m, mech_mision mm, mecha me
			WHERE mm.num_mision=m.num_mision AND mm.id=me.id AND me.dni=p2.dni))
	AND p1.nombre<p2.nombre;


/*Nota: Después de mucho calentarme la cabeza pensando que el resultado podía estar mal, 
he razonado lo siguiente: Hay pilotos que no tienen participación en ninguna misión, 
y esos también coinciden entre ellos. Por eso hay tantos resultados a pesar de haber pocas misiones.*/



/*================== INSERCIONES, ACTUALIZACIONES Y BORRADOS SINCRONIZADOS ======================
  ===============================================================================================*/
/* --- INSERCIONES --- */
/*Añadir para la fecha 1 de noviembre de 2012 la misión 'Rescate Philips', con identificador '02A'
y el resto de valores iguales a la misión '01A'*/
INSERT INTO mision
(SELECT '02A', '01-11-2012', 'Rescate Philips', descripcion, estado
FROM mision
WHERE num_mision='01A');


/*Añadir a la tabla PAIS_MISION el país RUSIA para todas las misiones hechas en 2012 desde Noviembre 
en adelante*/
INSERT INTO pais_mision
(SELECT 'RU', num_mision
FROM mision 
WHERE fecha>='01-11-2012' AND fecha<'01-01-2013');


/*Añadir a la tabla MECH_MISION el mecha 'WHITEGLYNT' para todas las misiones hechas en Rusia*/
INSERT INTO mech_mision
(SELECT 'WHITEGLYNT', pm.num_mision
FROM pais_mision pm
WHERE pm.codigo='RU');


/* --- ACTUALIZACIONES --- */
/*Aumenta en un 4% (debido al aumento del iva) el coste de las piezas del mecha usado 
por el piloto James Ford. Los demás mecha que usen estas piezas, también verán incrementado el valor*/
UPDATE pieza SET precio=precio*1.04
WHERE precio IN (	SELECT precio
			FROM mech_pieza mp, pieza p
			WHERE mp.ns=p.ns AND id=(	SELECT id
							FROM mecha
							WHERE dni='26500129N'));


/*Establece como descripción la descripción de la pieza UHD-22 para todas las piezas que no tengan 
descripción y cuyo coste sea inferior a 50000*/
UPDATE pieza SET descripcion=(	SELECT descripcion 
				FROM pieza
				WHERE ns='UHD-22')
WHERE precio<50000 AND descripcion IS NULL;


/*Debido a la batalla, reduce en un 20% la población de los países en los que ha habido alguna misión*/
UPDATE pais SET num_hab=num_hab*0.8
WHERE nombre IN (SELECT nombre
		FROM pais
		WHERE codigo IN(SELECT DISTINCT codigo
				FROM pais_mision));


/* --- BORRADOS --- */
/*Se han despedido a todos los pilotos que no han realizado una misión desde 2011, elimínalos de la 
base de datos*/
DELETE FROM piloto p
WHERE dni NOT IN(	SELECT DISTINCT m.dni
			FROM mecha m, mech_mision mm, mision mi
			WHERE m.id=mm.id AND mm.num_mision=mi.num_mision AND
			fecha>='01-01-2012');

/*Elimina de la base de datos las piezas que no están siendo usadas por ninguna unidad mecha*/
DELETE FROM pieza p
WHERE ns NOT IN (SELECT DISTINCT ns
		FROM mech_pieza);


/*Elimina los paises en los que no se haya realizado ninguna misión y de los que no proceda ningún
piloto*/
DELETE FROM pais p
WHERE codigo NOT IN (	SELECT DISTINCT pais
			FROM piloto) 
	AND codigo NOT IN (	SELECT DISTINCT codigo
				FROM pais_mision);

