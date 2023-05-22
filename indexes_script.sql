--								CREATION OF THE INDEXES SCRIPT
DROP INDEX IF EXISTS development.nationality_employee_index;
DROP INDEX IF EXISTS development.nationality_customer_index;
DROP INDEX IF EXISTS development.nationality_person_index;
--1 INDEX
CREATE INDEX nationality_employee_index ON development.employee("nationality"); --INDEX WITH THE DEFAULT CONFIGURATION (btree, ASC,NULL LAST)
--1.1 INDEX
CREATE INDEX nationality_customer_index ON development.customer("nationality");
--1.2 INDEX
CREATE INDEX nationality_person_index ON development.person("nationality");
--WITHOUT INDEX (INCLUSIVE: 0.014, EXCLUSIVE: 0.014)
--WITH INDEX (As the database is not very heavy, the system does not use the index)
SELECT *
FROM development.employee
WHERE "nationality" = 'costarrican';

--2 INDEX
CREATE INDEX vehicle_trademark_index ON development.vehicle("trademark");
--3 INDEX
CREATE INDEX invoice_currency_type_index ON process.invoice("currency_type");
--4 INDEX 
CREATE INDEX task_estimated_duration_index ON process.task("estimated_duration");
--5 INDEX WITH DOUBLE COLUMN
CREATE INDEX form_signatures_index ON process.form("owner_signature","policy_owner_signature");

SELECT *
FROM process.form
WHERE "owner_signature" = true AND "policy_owner_signature" = true;