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