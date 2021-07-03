/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     28/06/2021 23:44:38                          */
/*==============================================================*/

/*==============================================================*/
/* Table: CEMENTERIO                                            */
/*==============================================================*/
create table CEMENTERIO (
   FUN_ID               INT4                 not null,
   NOMBRE_CEMENTERIO    CHAR(30)             not null,
   DIRECCION_CEMENTERIO CHAR(50)             not null,
   TELEFONO_CEMENTERIO  NUMERIC(12)          not null,
   EMAIL_CEMENTERIO     CHAR(50)             not null,
   constraint PK_CEMENTERIO primary key (FUN_ID)
);

/*==============================================================*/
/* Table: DETALLEENTIERRO                                       */
/*==============================================================*/
create table DETALLEENTIERRO (
   ID_DEALLEENTIERRO    INT4                 not null,
   F_ID                 INT4                 not null,
   EM_ID                INT4                 null,
   OBSERVACIONES        CHAR(100)            not null,
   FECHA_DETALLEEN      DATE                 not null,
   HORA_DETALLEEN       TIME                 not null,
   constraint PK_DETALLEENTIERRO primary key (ID_DEALLEENTIERRO)
);

/*==============================================================*/
/* Table: DETALLEMANTENIMIENTO                                  */
/*==============================================================*/
create table DETALLEMANTENIMIENTO (
   ID_TUMBA             INT4                 not null,
   ID_MANTENIMIENTO     INT4                 not null,
   EM_ID                INT4                 not null,
   OBSERVACION_DETALLEMANTE CHAR(500)            not null,
   constraint PK_DETALLEMANTENIMIENTO primary key (ID_TUMBA, ID_MANTENIMIENTO)
);

/*==============================================================*/
/* Table: DETALLE_FACTURA                                       */
/*==============================================================*/
create table DETALLE_FACTURA (
   SER_ID               INT4                 not null,
   FAC_ID               INT4                 not null,
   DETALLE_CANTIDADSERVI CHAR(500)            not null,
   constraint PK_DETALLE_FACTURA primary key (SER_ID, FAC_ID)
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   EM_ID                INT4                 not null,
   FUN_ID               INT4                 null,
   TIPO_ID              INT4                 null,
   EM_NOMBRE            TEXT                 not null,
   EM_APELLIDO          TEXT                 not null,
   EM_DIRECCION         TEXT                 not null,
   EM_INGRESOLABORAL    DATE                 not null,
   constraint PK_EMPLEADO primary key (EM_ID)
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   FAC_ID               INT4                 not null,
   FUN_ID               INT4                 not null,
   ID_FAMILIAR          INT4                 null,
   NUMERO_FACTURA       CHAR(20)             not null,
   IVA_FACTURA          DECIMAL              not null,
   FECHA_FACTURA        DATE                 not null,
   SUBTOTAL             MONEY                not null,
   TOTAL                MONEY                not null,
   constraint PK_FACTURA primary key (FAC_ID)
);

/*==============================================================*/
/* Table: FALLECIDO                                             */
/*==============================================================*/
create table FALLECIDO (
   F_ID                 INT4                 not null,
   ID_FAMILIAR          INT4                 null,
   NOMBRE_FALLECIDO     CHAR(50)             not null,
   APELLIDO_FALLECIDO   CHAR(50)             not null,
   SEXO_FALLECIDO       CHAR(10)             not null,
   CAUSA_MUERTE         CHAR(100)            not null,
   F_EDAD               INT4                 not null,
   FECHA_MUERTE         DATE                 not null,
   constraint PK_FALLECIDO primary key (F_ID)
);

/*==============================================================*/
/* Table: FAMILIAR                                              */
/*==============================================================*/
create table FAMILIAR (
   ID_FAMILIAR          INT4                 not null,
   NOMBRE_FAMILIAR      CHAR(50)             not null,
   APELLIDO_FAMILIAR    CHAR(50)             not null,
   DIRECCION_FAMILIAR   CHAR(50)             not null,
   TELEFONO_FAMILIAR    NUMERIC(12)          not null,
   PARENTESCO_FAMILIAR  CHAR(20)             not null,
   constraint PK_FAMILIAR primary key (ID_FAMILIAR)
);

/*==============================================================*/
/* Table: MANTENIMIENTO                                         */
/*==============================================================*/
create table MANTENIMIENTO (
   ID_MANTENIMIENTO     INT4                 not null,
   FECHA_MANTEMIENTO    DATE                 not null,
   SECTOR_MANTENIMENTO  CHAR(50)             not null,
   HORA_MANTENIMIENTO   TIME                 not null,
   constraint PK_MANTENIMIENTO primary key (ID_MANTENIMIENTO)
);

/*==============================================================*/
/* Table: PAQUETEEXEQUIAL                                       */
/*==============================================================*/
create table PAQUETEEXEQUIAL (
   ID_PAQUETESERVICIO   INT4                 not null,
   SER_ID               INT4                 null,
   DESCRIPCION_PAQUETESERVICIO CHAR(500)            not null,
   DESCUENTO_PAQUETE    MONEY                not null,
   PRECIO_PAQUETE       MONEY                not null,
   constraint PK_PAQUETEEXEQUIAL primary key (ID_PAQUETESERVICIO)
);

/*==============================================================*/
/* Table: SECTOR                                                */
/*==============================================================*/
create table SECTOR (
   ID_SECTOR            INT4                 not null,
   DESCRIPCION_SECTOR   CHAR(50)             not null,
   N_MANZANA            CHAR(50)             not null,
   constraint PK_SECTOR primary key (ID_SECTOR)
);

/*==============================================================*/
/* Table: SERVICIO                                              */
/*==============================================================*/
create table SERVICIO (
   SER_ID               INT4                 not null,
   FUN_ID               INT4                 null,
   DESCRIPCION          CHAR(100)            not null,
   PRECIO               MONEY                not null,
   constraint PK_SERVICIO primary key (SER_ID)
);

/*==============================================================*/
/* Table: TIPOEMPLEADO                                          */
/*==============================================================*/
create table TIPOEMPLEADO (
   TIPO_ID              INT4                 not null,
   DESCRIPCION_TIPOEMPLEADO CHAR(50)             not null,
   constraint PK_TIPOEMPLEADO primary key (TIPO_ID)
);

/*==============================================================*/
/* Table: TUMBA                                                 */
/*==============================================================*/
create table TUMBA (
   ID_TUMBA             INT4                 not null,
   F_ID                 INT4                 null,
   ID_SECTOR            INT4                 null,
   DESCRIPCION_TUMBA    CHAR(50)             not null,
   CAPACIDAD_TUMBA      NUMERIC              not null,
   constraint PK_TUMBA primary key (ID_TUMBA)
);

alter table DETALLEENTIERRO
   add constraint FK_DETALLEE_RELATIONS_EMPLEADO foreign key (EM_ID)
      references EMPLEADO (EM_ID)
      on delete restrict on update restrict;

alter table DETALLEENTIERRO
   add constraint FK_DETALLEE_SE_FALLECID foreign key (F_ID)
      references FALLECIDO (F_ID)
      on delete restrict on update restrict;

alter table DETALLEMANTENIMIENTO
   add constraint FK_DETALLEM_RELATIONS_EMPLEADO foreign key (EM_ID)
      references EMPLEADO (EM_ID)
      on delete restrict on update restrict;

alter table DETALLEMANTENIMIENTO
   add constraint FK_DETALLEM_SE_LE_DA_TUMBA foreign key (ID_TUMBA)
      references TUMBA (ID_TUMBA)
      on delete restrict on update restrict;

alter table DETALLEMANTENIMIENTO
   add constraint FK_DETALLEM_SE_LE_DA2_MANTENIM foreign key (ID_MANTENIMIENTO)
      references MANTENIMIENTO (ID_MANTENIMIENTO)
      on delete restrict on update restrict;

alter table DETALLE_FACTURA
   add constraint FK_DETALLE__DETALLE_F_SERVICIO foreign key (SER_ID)
      references SERVICIO (SER_ID)
      on delete restrict on update restrict;

alter table DETALLE_FACTURA
   add constraint FK_DETALLE__DETALLE_F_FACTURA foreign key (FAC_ID)
      references FACTURA (FAC_ID)
      on delete restrict on update restrict;

alter table EMPLEADO
   add constraint FK_EMPLEADO_CONTIENE_TIPOEMPL foreign key (TIPO_ID)
      references TIPOEMPLEADO (TIPO_ID)
      on delete restrict on update restrict;

alter table EMPLEADO
   add constraint FK_EMPLEADO_TIENE_CEMENTER foreign key (FUN_ID)
      references CEMENTERIO (FUN_ID)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_GENERA_CEMENTER foreign key (FUN_ID)
      references CEMENTERIO (FUN_ID)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA___GENERA_FAMILIAR foreign key (ID_FAMILIAR)
      references FAMILIAR (ID_FAMILIAR)
      on delete restrict on update restrict;

alter table FALLECIDO
   add constraint FK_FALLECID_TIENE4_FAMILIAR foreign key (ID_FAMILIAR)
      references FAMILIAR (ID_FAMILIAR)
      on delete restrict on update restrict;

alter table PAQUETEEXEQUIAL
   add constraint FK_PAQUETEE_RELATIONS_SERVICIO foreign key (SER_ID)
      references SERVICIO (SER_ID)
      on delete restrict on update restrict;

alter table SERVICIO
   add constraint FK_SERVICIO_RELATIONS_CEMENTER foreign key (FUN_ID)
      references CEMENTERIO (FUN_ID)
      on delete restrict on update restrict;

alter table TUMBA
   add constraint FK_TUMBA_PERTENECE_FALLECID foreign key (F_ID)
      references FALLECIDO (F_ID)
      on delete restrict on update restrict;

alter table TUMBA
   add constraint FK_TUMBA__TIENE_SECTOR foreign key (ID_SECTOR)
      references SECTOR (ID_SECTOR)
      on delete restrict on update restrict;

/*CEMENTERIO */

INSERT INTO CEMENTERIO VALUES (1,'CIELO AZUL','JOCAY',0987654321,'cieloazul@gmail.com' );


/*TIPOEMPLEADO*/
INSERT INTO TIPOEMPLEADO VALUES(1,'ADMINISTRATIVO');
INSERT INTO TIPOEMPLEADO VALUES(2,'JARDINEROS');
INSERT INTO TIPOEMPLEADO VALUES(3,'SEPULTADORES');
INSERT INTO TIPOEMPLEADO VALUES(4,'GUARDIAS');
INSERT INTO TIPOEMPLEADO VALUES(5,'LIMPIEZA Y CUIDADO DE TUMBAS');
/*EMPLEADO*/
INSERT INTO EMPLEADO VALUES (1,1,1,'JOSE','PEREZ','CUBA','10/05/2021');
INSERT INTO EMPLEADO VALUES (2,1,2,'ANTHONY','MOREIRA','LA BAHIA','1/04/2021');
INSERT INTO EMPLEADO VALUES (3,1,3,'LUIS','VELEZ','JOCAY','08/05/2021');
INSERT INTO EMPLEADO VALUES (4,1,4,'JUAN','ARCENTALES','LA AURORA','09/06/2021');
INSERT INTO EMPLEADO VALUES (5,1,5,'DYLAN','RODRIGUEZ','SAN PEDRO','15/06/2021');


/*FAMILIAR*/
INSERT INTO FAMILIAR VALUES (1, 'PAUL','CORRALES','SAN PEDRO',0987654321,'TIO');
INSERT INTO FAMILIAR VALUES (2, 'KARLA','MORA','LA AURORA',0987654321,'TIA');
INSERT INTO FAMILIAR VALUES (3, 'CORINA','ALAY','JOCAY',0987654321,'HERMANA');
INSERT INTO FAMILIAR VALUES (4, 'ALEJANDRO','ALCIVAR','ELEGOLE',0987654321,'HERMANO');
INSERT INTO FAMILIAR VALUES (5, 'RICKY','RIVADENEIRA','SAN PATRICIO',0987654321,'HERMANO');
INSERT INTO FAMILIAR VALUES (6, 'IRINA','GONZALES','LOS ELECTRICOS',0987654321,'TIA');
INSERT INTO FAMILIAR VALUES (7, 'ELIANA','PARRALES','LOS CEIBOS',0987654321,'ABUELA');
INSERT INTO FAMILIAR VALUES (8, 'SAUL','PEREZ','PROAÑO',0987654321,'ABUELO');
INSERT INTO FAMILIAR VALUES (9, 'FELIPE','CAICEDO','PALMAR',0987654321,'TIO');
INSERT INTO FAMILIAR VALUES (10, 'ROBERTO','CATAGUA','LA PRADERA',0987784321,'PRIMO');


/*FACTURA*/

INSERT INTO FACTURA VALUES (1,1,1,'RE45622',12,'10/6/2021',500,500); 
INSERT INTO FACTURA VALUES (2,1,2,'RE45622',12,'10/6/2021',600,600); 
INSERT INTO FACTURA VALUES (3,1,3,'RE45622',12,'10/6/2021',400,400); 
INSERT INTO FACTURA VALUES (4,1,4,'RE45622',12,'10/6/2021',1000,1000); 
INSERT INTO FACTURA VALUES (5,1,5,'RE45622',12,'10/6/2021',500,500); 
INSERT INTO FACTURA VALUES (6,1,6,'RE45622',12,'10/6/2021',700,700); 
INSERT INTO FACTURA VALUES (7,1,7,'RE45622',12,'10/6/2021',600,600); 
INSERT INTO FACTURA VALUES (8,1,8,'RE45622',12,'10/6/2021',500,500); 


SELECT * FROM FALLECIDO;
/*FALLECIDO*/

INSERT INTO FALLECIDO VALUES (1,1,'JUAN','CORRALES','MASCULINO','INFARTO',14,'10/06/2021');
INSERT INTO FALLECIDO VALUES (2,2,'NICOLE','MORA','FEMENINO','DERRAME CEREBRAL',80,'15/05/2021');
INSERT INTO FALLECIDO VALUES (3,3,'SERGIO','ALAY','MASCULINO','INFARTO',17,'07/06/2021');
INSERT INTO FALLECIDO VALUES (4,4,'JAIME','ALCIVAR','MASCULINO','INFARTO',44,'10/06/2021');
INSERT INTO FALLECIDO VALUES (5,5,'ARTURO','RIVADENEIRA','MASCULINO','INFARTO',05,'10/06/2021');
INSERT INTO FALLECIDO VALUES (6,6,'CAROLINA','GONZALES','FEMENINO','CANCER DE SENO',85,'10/06/2021');
INSERT INTO FALLECIDO VALUES (7,7,'ALEX','PARRALES','MASCULINO','INFARTO',08,'10/06/2021');
INSERT INTO FALLECIDO VALUES (8,8,'NATASHA','PEREZ','FEMENINO','CANCER DE UTERO',40,'10/06/2021');
INSERT INTO FALLECIDO VALUES (9,9,'ABEL','CAICEDO','MASCULINO','INFARTO',15,'12/06/2021');
INSERT INTO FALLECIDO VALUES (10,10,'JHON','VERA','MASCULINO','INFARTO',03,'10/01/2021');
/*SERVCIO*/

INSERT INTO SERVICIO VALUES (1,1,'ACOMPAÑAMIENTO CON MUSICA',200);
INSERT INTO SERVICIO VALUES (2,1,'FLORALES',100);
INSERT INTO SERVICIO VALUES (3,1,'CREMACION',200);
INSERT INTO SERVICIO VALUES (4,1,'CARROZA FUNEBRE',300);
INSERT INTO SERVICIO VALUES (5,1,'REFRIGERACION',200);
INSERT INTO SERVICIO VALUES (6,1,'TRANSPORTE',150);
INSERT INTO SERVICIO VALUES (7,1,'COFRES MORTUORIOS',500);
INSERT INTO SERVICIO VALUES (8,1,'MAQUILLAJES',200);
INSERT INTO SERVICIO VALUES (9,1,'EMBALSAMIENTO',600);


/*PAQUETE EXEQUIAL*/

INSERT INTO PAQUETEEXEQUIAL VALUES (1,1,'BASICO',100,800);
INSERT INTO PAQUETEEXEQUIAL VALUES (2,2,'INTERMEDIO',200,1000);
INSERT INTO PAQUETEEXEQUIAL VALUES (3,3,'COMPLETO',250,1500);
INSERT INTO PAQUETEEXEQUIAL VALUES (4,4,'DIAMANTE',300,2000);

/*DETALLE FACTURA

INSERT INTO DETALLE_FACTURA VALUES (1,1'SE ELEIGIO UN PAQUETE BASICO');
******/
INSERT INTO DETALLE_FACTURA VALUES (2,1,'SE ELEIGIO UN PAQUETE BASICO');
INSERT INTO DETALLE_FACTURA VALUES (2,2,'SE ELEIGIO UN PAQUETE BASICO');
INSERT INTO DETALLE_FACTURA VALUES (2,3,'SE ELEIGIO UN PAQUETE BASICO');
INSERT INTO DETALLE_FACTURA VALUES (2,4,'SE ELEIGIO UN PAQUETE BASICO');

/*SECTOR*/

INSERT INTO SECTOR VALUES (1,'PANTEON','MANZANA 9');
INSERT INTO SECTOR VALUES (2,'NICHO','MANZANA 10');
INSERT INTO SECTOR VALUES (3,'PANTEON','MANZANA 11');
INSERT INTO SECTOR VALUES (4,'FOSA COMUN','MANZANA 12');
INSERT INTO SECTOR VALUES (5,'PANTEON','MANZANA 17');
INSERT INTO SECTOR VALUES (6,'PANTEON','MANZANA 18');
INSERT INTO SECTOR VALUES (7,'PANTEON','MANZANA 7');
INSERT INTO SECTOR VALUES (8,'NICHO','MANZANA 25');
INSERT INTO SECTOR VALUES (9,'PANTEON','MANZANA 11');
INSERT INTO SECTOR VALUES (10,'PANTEON','MANZANA 13');
INSERT INTO SECTOR VALUES (11,'PANTEON','MANZANA 1');
INSERT INTO SECTOR VALUES (12,'NICHO','MANZANA 2');

/*TUMBA*/
INSERT INTO TUMBA VALUES (1,1,1,'TUMBA REMODELADA',4); 
INSERT INTO TUMBA VALUES (2,2,2,'TUMBA REMODELADA',2); 
INSERT INTO TUMBA VALUES (3,3,3,'TUMBA REMODELADA',8); 
INSERT INTO TUMBA VALUES (4,4,4,'TUMBA REMODELADA',20); 

INSERT INTO TUMBA VALUES (5,5,5,'TUMBA REMODELADA',20);
INSERT INTO TUMBA VALUES (6,6,6,'TUMBA REMODELADA',20);
INSERT INTO TUMBA VALUES (7,7,7,'TUMBA REMODELADA',20);
INSERT INTO TUMBA VALUES (8,8,9,'TUMBA REMODELADA',20);

/*DETALLE ENTIERRO*/
INSERT INTO DETALLEENTIERRO VALUES(1,1,3,'CEREMONIA SENCILLA','10/05/2021','12:30:10');
INSERT INTO DETALLEENTIERRO VALUES(2,2,3,'CEREMONIA COMPLETA','14/06/2021','10:50:11');
INSERT INTO DETALLEENTIERRO VALUES(3,3,3,'CEREMONIA COMPLETA','15/04/2021','12:30:10');
INSERT INTO DETALLEENTIERRO VALUES(4,4,3,'CEREMONIA SENCILLA','12/03/2021','12:30:10');
INSERT INTO DETALLEENTIERRO VALUES(5,5,3,'CEREMONIA SENCILLA','11/06/2021','09:20:25');
INSERT INTO DETALLEENTIERRO VALUES(6,6,3,'CEREMONIA COMPLETA','10/02/2021','14:00:00');

/*MANTENIMEINTO*/
INSERT INTO MANTENIMIENTO VALUES(1,'25/05/2021','MANZANA 9','10:00:00');
INSERT INTO MANTENIMIENTO VALUES(2,'28/06/2021','MANZANA 10','11:00:00');
INSERT INTO MANTENIMIENTO VALUES(3,'25/04/2021','MANZANA 11','11:00:00');
INSERT INTO MANTENIMIENTO VALUES(4,'05/06/2021','MANZANA 12','12:00:00');
INSERT INTO MANTENIMIENTO VALUES(5,'01/04/2021','MANZANA 12','13:00:00');

/*DETALLE MANTENIMIENTO*/

INSERT INTO DETALLEMANTENIMIENTO VALUES (1,1,5,'SE PINTO LA VOBEDA EN LA TUMBA CON CRUZ DORADA');
INSERT INTO DETALLEMANTENIMIENTO VALUES (2,2,5,'SE LE REPARO EL CERCADO AL PANTEON');
INSERT INTO DETALLEMANTENIMIENTO VALUES (3,3,5,'CORTE DE MALEZA EN EL NICHO');
INSERT INTO DETALLEMANTENIMIENTO VALUES (4,4,5,'SE HIZO LIMPIEZA A LOS ALREDEDORES ');

/*consulta*/
/*Cuantos cuerpos han sido enterrados y cuales son lo de genero femenino?*/
SELECT
OBSERVACIONES AS OBSERVACION,
SEXO_FALLECIDO AS SEXO_FALLECIDO,
COUNT(SEXO_FALLECIDO)as CANTIDAD
FROM 
PUBLIC.DETALLEENTIERRO
INNER JOIN PUBLIC.FALLECIDO ON FALLECIDO.F_ID = DETALLEENTIERRO.F_ID
WHERE
(SEXO_FALLECIDO like '%F%') OR (SEXO_FALLECIDO like '%M%')
GROUP BY
OBSERVACIONES,SEXO_FALLECIDO
ORDER BY
OBSERVACIONES ASC;

/*Cuantos clientes cuentan con panteón ?*/
SELECT
DESCRIPCION_TUMBA AS DESCRIPCION_TUMBA,
DESCRIPCION_SECTOR AS TIPO_TUMBA,
COUNT(DESCRIPCION_SECTOR)as CLIENTE_CON_PANTEON
FROM
PUBLIC.TUMBA
INNER JOIN PUBLIC.SECTOR ON SECTOR.ID_SECTOR = TUMBA.ID_TUMBA
WHERE
SECTOR.DESCRIPCION_SECTOR = 'PANTEON'
GROUP BY
DESCRIPCION_TUMBA,DESCRIPCION_SECTOR;

/*Cuantos fallecidos son menores de edad ?*/
SELECT
SEXO_FALLECIDO AS SEXO_FALLECIDO,
COUNT(SEXO_FALLECIDO)as FALLECIDOS_MENORES_DE_EDAD
FROM 
PUBLIC.DETALLEENTIERRO
INNER JOIN PUBLIC.FALLECIDO ON FALLECIDO.F_ID = DETALLEENTIERRO.F_ID
WHERE
(SEXO_FALLECIDO like '%F%') OR (SEXO_FALLECIDO like '%M%') OR FALLECIDO.F_EDAD<18
GROUP BY
SEXO_FALLECIDO;

/*MANTENIMIENTOS REALIZADOS POR LOS EMPLEADOS*/
SELECT
EM_NOMBRE AS NOMBRE_EMPLEADO,
EM_APELLIDO AS APELLIADO_EMPLEADO,
OBSERVACION_DETALLEMANTE AS MANTENIMIENTO
FROM DETALLEMANTENIMIENTO
INNER JOIN EMPLEADO ON DETALLEMANTENIMIENTO.ID_MANTENIMIENTO = EMPLEADO.EM_ID