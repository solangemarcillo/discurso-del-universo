--TRIGGER QUE NO PERMITA AÑADIR MAS FALLECIDOS A LAS TUMBAS;
CREATE OR REPLACE FUNCTION TUMBAS() RETURNS TRIGGER
AS 
$TUMBAS$
	DECLARE
		cantidad int;
		ful int;
BEGIN 
select count (*) into cantidad  from fallecido where f_id = new.f_id;
select tumba.f_id into ful from tumba;
	if (cantidad >= ful) then
	RAISE EXCEPTION 'LO SENTIMOS, TODAS LAS TUMBAS ESTAN OCUPADAS';
	END if;
	RETURN new;
END;
$TUMBAS$
LANGUAGE plpgsql;

create trigger TUMBAS before insert
on fallecido for EACH ROW
execute procedure TUMBAS();
--INSERTAMOS DATOS PARA VERIFICAR EN EL TRIGGER

INSERT INTO FALLECIDO VALUES (1,1,'JUAN','CORRALES','MASCULINO','INFARTO',14,'10/06/2021');
