--					INTEGRITY OF EACH TABLE ON ALL THE SCHEMAS SCRIPT

--TABLE TYPE_OF_VEHICLE
CREATE OR REPLACE FUNCTION parameterization.integrity_type_of_vehicle() RETURNS TRIGGER 
AS $$
BEGIN
	IF(TG_OP = 'INSERT' )THEN
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
	
	IF(TG_OP = 'UPDATE' )THEN
		IF(NEW = OLD) THEN	
			RAISE EXCEPTION 'Can not send the same name';
			RETURN NULL;
		ELSE
			RAISE NOTICE 'Successful update';
			RETURN NEW;
		END IF;
	END IF;
	IF(TG_OP = 'DELETE' ) THEN
		IF(OLD.id NOT IN(SELECT id FROM parameterization.type_of_vehicle)) THEN
			RAISE EXCEPTION 'invalid id';
			RETURN NULL;
		ElSE	
			RAISE NOTICE 'Successful delete';
			RETURN OLD;
		END IF;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_type_of_vehicle
BEFORE INSERT OR UPDATE OR DELETE
ON parameterization.type_of_vehicle
FOR EACH ROW 
EXECUTE PROCEDURE parameterization.integrity_type_of_vehicle();

--TABLE TYPE OF EMPLOYEE
CREATE OR REPLACE FUNCTION parameterization.integrity_type_of_employee() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	RAISE NOTICE 'Succesfull insert ';
	RETURN NEW;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same name'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	RAISE NOTICE 'Successful delete';
	RETURN OLD;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_type_of_employee
BEFORE INSERT OR UPDATE OR DELETE
ON parameterization.type_of_employee
FOR EACH ROW 
EXECUTE PROCEDURE parameterization.integrity_type_of_employee();

--TABLE PHONE NUMBER PERSON
CREATE OR REPLACE FUNCTION phone_number.integrity_phone_number_person() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	RAISE NOTICE 'Succesfull insert';
	RETURN NEW;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	RAISE NOTICE 'Successful delete';
	RETURN OLD;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER integrity_phone_number_person
BEFORE INSERT OR UPDATE OR DELETE
ON phone_number.phone_number_person
FOR EACH ROW 
EXECUTE PROCEDURE phone_number.integrity_phone_number_person();

--TABLE INSURANCE COMPANY PHONE NUMBER
CREATE OR REPLACE FUNCTION phone_number.integrity_insurance_company_phone_number() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	RAISE NOTICE 'Succesfull insert';
	RETURN NEW;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM phone_number.insurance_company_phone_number)) THEN
		RAISE EXCEPTION 'invalid id';
		RETURN NULL;
 	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_insurance_company_phone_number
BEFORE INSERT OR UPDATE OR DELETE
ON phone_number.insurance_company_phone_number
FOR EACH ROW 
EXECUTE PROCEDURE phone_number.integrity_insurance_company_phone_number();

--TABLE SUPPLIER PHONE NUMBER
CREATE OR REPLACE FUNCTION phone_number.integrity_supplier_phone_number() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	RAISE NOTICE 'Succesfull insert';
	RETURN NEW;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM phone_number.supplier_phone_number))THEN
		RAISE EXCEPTION 'invalid id';
		RETURN NULL;
	ELSE	
		RAISE NOTICE 'Succesfull delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_supplier_phone_number
BEFORE INSERT OR UPDATE OR DELETE
ON phone_number.supplier_phone_number
FOR EACH ROW 
EXECUTE PROCEDURE phone_number.integrity_supplier_phone_number();

--TABLE PERSON
CREATE OR REPLACE FUNCTION development.integrity_person() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.gender != 'female' AND NEW.gender != 'male') THEN
		RAISE EXCEPTION 'invalid gender';
		RETURN NULL;
	ELSIF(LOWER(NEW.month) = 'frebruary' AND NEW.day > 28) THEN
		RAISE EXCEPTION 'invalid day for this month';
		RETURN NULL;
	ELSIF(NEW.day > 31) THEN
		RAISE EXCEPTION 'invalid day';
		RETURN NULL;
-- 	ELSIF(NEW.id_phone_number NOT IN(SELECT id FROM phone_number.phone_number_person))THEN
-- 		RAISE EXCEPTION 'invalid number';
-- 		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM development.person))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_person
BEFORE INSERT OR UPDATE OR DELETE
ON development.person
FOR EACH ROW 
EXECUTE PROCEDURE development.integrity_person();

--TABLE CUSTOMER
CREATE OR REPLACE FUNCTION development.integrity_customer() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.gender != 'female' AND NEW.gender != 'male') THEN
		RAISE EXCEPTION 'invalid gender';
		RETURN NULL;
	ELSIF(LOWER(NEW.month) = 'frebruary' AND NEW.day > 28) THEN
		RAISE EXCEPTION 'invalid day for this month';
		RETURN NULL;
	ELSIF(NEW.day > 31) THEN
		RAISE EXCEPTION 'invalid day';
		RETURN NULL;
-- 	ELSIF(NEW.id_phone_number NOT IN(SELECT id FROM phone_number.phone_number_person))THEN
-- 		RAISE EXCEPTION 'invalid number';
-- 		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM development.customer))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_customer
BEFORE INSERT OR UPDATE OR DELETE
ON development.customer
FOR EACH ROW 
EXECUTE PROCEDURE development.integrity_customer();

--TABLE SALARY
CREATE OR REPLACE FUNCTION development.integrity_salary() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.date < '01\01\1950') THEN
		RAISE EXCEPTION 'invalid date';
		RETURN NULL;
	ELSIF(NEW.gross_salary < NEW.net_salary) THEN
		RAISE EXCEPTION 'Gross salary can not be smaller than net salary';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM development.salary))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_salary
BEFORE INSERT OR UPDATE OR DELETE
ON development.salary
FOR EACH ROW 
EXECUTE PROCEDURE development.integrity_salary();

--TABLE EMPLOYEE
CREATE OR REPLACE FUNCTION development.integrity_employee() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.gender != 'female' AND NEW.gender != 'male') THEN
		RAISE EXCEPTION 'invalid gender';
		RETURN NULL;
	ELSIF(LOWER(NEW.month) = 'frebruary' AND NEW.day > 28) THEN
		RAISE EXCEPTION 'invalid day for this month';
		RETURN NULL;
	ELSIF(NEW.day > 31) THEN
		RAISE EXCEPTION 'invalid day';
		RETURN NULL;
-- 	ELSIF(NEW.id_phone_number NOT IN(SELECT id FROM phone_number.phone_number_person))THEN
-- 		RAISE EXCEPTION 'invalid number';
-- 		RETURN NULL;
	ELSIF(NEW.id_salary NOT IN(SELECT id FROM development.salary)) THEN
		RAISE EXCEPTION 'invalid id_salary';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM development.employee))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_employee
BEFORE INSERT OR UPDATE OR DELETE
ON development.employee
FOR EACH ROW 
EXECUTE PROCEDURE development.integrity_employee();

--TABLE INSURANCE COMPANY
CREATE OR REPLACE FUNCTION development.integrity_insurance_company() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(OLD.id_phone_number NOT IN(SELECT id FROM phone_number.insurance_company_phone_number)) THEN
		RAISE EXCEPTION 'invalid id_phone_number';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM development.insurance_company))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_insurance_company
BEFORE INSERT OR UPDATE OR DELETE
ON development.insurance_company
FOR EACH ROW 
EXECUTE PROCEDURE development.integrity_insurance_company();

--TABLE INSURANCE POLICY
CREATE OR REPLACE FUNCTION development.integrity_insurance_policy() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.expiration_date < '01/01/1950' ) THEN
		RAISE EXCEPTION 'invalid expiration_date';
		RETURN NULL;
	ELSIF(NEW.start_date < '01/01/1950')  THEN
		RAISE EXCEPTION 'invalid expiration_date';
		RETURN NULL;
	ELSIF(NEW.start_date > NEW.expiration_date)THEN
		RAISE EXCEPTION 'invalid expiration_date can not be smaller than start_date';
		RETURN NULL;
	ELSIF(NEW.minimum_payment > NEW.maximum_payment) THEN
		  RAISE EXCEPTION 'invalid minimum_paymen can not be greater than maximum_payment';
		  RETURN NULL;
	ELSIF(NEW.id_insurance_company NOT IN(SELECT id FROM development.insurance_company)) THEN
		RAISE EXCEPTION 'invalid id_insurance_company';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM development.insurance_policy))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_insurance_policy
BEFORE INSERT OR UPDATE OR DELETE
ON development.insurance_policy
FOR EACH ROW 
EXECUTE PROCEDURE development.integrity_insurance_policy();

--TABLE VEHICLE
CREATE OR REPLACE FUNCTION development.integrity_vehicle() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(OLD.id_customer NOT IN(SELECT id FROM development.customer))THEN
		RAISE EXCEPTION 'invalid id_customer';
		RETURN NULL;
	ELSIF(NEW.id_insurance_policy NOT IN(SELECT id FROM development.insurance_policy)) THEN
		RAISE EXCEPTION 'invalid id_insurance_policy';
		RETURN NULL;
	ELSIF(NEW.id_type_of_vehicle NOT IN(SELECT id FROM parameterization.type_of_vehicle))THEN
		RAISE EXCEPTION 'invalid id_type_of_vehicle';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM development.vehicle))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_vehicle
BEFORE INSERT OR UPDATE OR DELETE
ON development.vehicle
FOR EACH ROW 
EXECUTE PROCEDURE development.integrity_vehicle();

--TABLE DEDUCTIBLE
CREATE OR REPLACE FUNCTION process.integrity_deductible() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.expiration_date < '01/01/1950' ) THEN
		RAISE EXCEPTION 'invalid expiration_date';
		RETURN NULL;
	ELSIF(NEW.start_date < '01/01/1950')  THEN
		RAISE EXCEPTION 'invalid expiration_date';
		RETURN NULL;
	ELSIF(NEW.start_date > NEW.expiration_date) THEN
		RAISE EXCEPTION 'invalid expiration_date can not be smaller than start_date';
		RETURN NULL;
	ELSIF(NEW.id_insurance_company NOT IN(SELECT id FROM development.insurance_company))THEN
		RAISE EXCEPTION 'invalid id_insurance_company';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.deductible))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_deductible
BEFORE INSERT OR UPDATE OR DELETE
ON process.deductible
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_deductible();

--TABLE TAX
CREATE OR REPLACE FUNCTION process.integrity_tax() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.percentage > 100 )THEN
		RAISE EXCEPTION 'invalid percentage';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.tax))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_tax
BEFORE INSERT OR UPDATE OR DELETE
ON process.tax
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_tax();

--TABLE FORM
CREATE OR REPLACE FUNCTION process.integrity_form() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.date < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.form))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_form
BEFORE INSERT OR UPDATE OR DELETE
ON process.form
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_form();

--TABLE TASK
CREATE OR REPLACE FUNCTION process.integrity_task() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.date < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date';
		RETURN NULL;
	ELSIF(NEW.id_vehicle NOT IN(SELECT id FROM development.vehicle)) THEN
		RAISE EXCEPTION 'invalid id_vehicle';
		RETURN NULL;
	ELSIF(NEW.id_employee NOT IN(SELECT id FROM development.employee)) THEN
		RAISE EXCEPTION 'invalid id_employee';
		RETURN NULL;
	ELSIF(NEW.id_type_of_employee NOT IN(SELECT id FROM parameterization.type_of_employee)) THEN
		RAISE EXCEPTION 'invalid id_type_of_employee';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.task))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_task
BEFORE INSERT OR UPDATE OR DELETE
ON process.task
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_task();

--TABLE VALUATION
CREATE OR REPLACE FUNCTION process.integrity_valuation() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.retirement_date < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date';
		RETURN NULL;
	ELSIF(NEW.estimated_cost != NEW.labor_force_cost + NEW.cost_of_spares) THEN
		RAISE EXCEPTION 'invalid estimated_cost';
		RETURN NULL;
	ELSIF(NEW.id_customer NOT IN(SELECT id FROM development.customer)) THEN
		RAISE EXCEPTION 'invalid id_customer';
		RETURN NULL;
	ELSIF(NEW.id_employee NOT IN(SELECT id FROM development.employee)) THEN
		RAISE EXCEPTION 'invalid id_employee';
		RETURN NULL;
	ELSIF(NEW.id_form NOT IN(SELECT id FROM process.form)) THEN
		RAISE EXCEPTION 'invalid id_form';
		RETURN NULL;
	ELSIF(NEW.id_deductible NOT IN(SELECT id FROM process.deductible)) THEN
		RAISE EXCEPTION 'invalid id_deductible';
		RETURN NULL;
	ELSIF(NEW.id_tax NOT IN (SELECT id FROM process.tax)) THEN
		RAISE EXCEPTION 'invalid id_tax';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.valuation))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_valuation
BEFORE INSERT OR UPDATE OR DELETE
ON process.valuation
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_valuation();

--TABLE INVOICE
CREATE OR REPLACE FUNCTION process.integrity_invoice() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.date < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date';
		RETURN NULL;
	ELSIF(NEW.final_cost < NEW.sub_total) THEN
		RAISE EXCEPTION 'invalid final_cost can not be smaller than sub_total';
		RETURN NULL;
	ELSIF(NEW.id_customer NOT IN(SELECT id FROM development.customer)) THEN
		RAISE EXCEPTION 'invalid id_customer';
		RETURN NULL;
	ELSIF(NEW.id_payment NOT IN(SELECT id FROM process.payment)) THEN
		RAISE EXCEPTION 'invalid id_payment';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.invoice))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_invoice
BEFORE INSERT OR UPDATE OR DELETE
ON process.invoice
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_invoice();

--TABLE SPARE PART
CREATE OR REPLACE FUNCTION development.integrity_spare_part() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	RAISE NOTICE 'Succesfull insert';
	RETURN NEW;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM development.spare_part))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_spare_part
BEFORE INSERT OR UPDATE OR DELETE
ON development.spare_part
FOR EACH ROW 
EXECUTE PROCEDURE development.integrity_spare_part();

--TABLE ORDER DETAIL TO SPARE PART
CREATE OR REPLACE FUNCTION relation.integrity_orderdetail_sparepart() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.order_detail_id NOT IN(SELECT id FROM process.order_detail)) THEN
		RAISE EXCEPTION 'invalid order_detail_id';
		RETURN NULL;
	ELSIF(NEW.spare_part_id NOT IN(SELECT id FROM development.spare_part)) THEN
		RAISE EXCEPTION 'invalid spare_part_id';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM relation.orderdetail_sparepart))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_orderdetail_sparepart
BEFORE INSERT OR UPDATE OR DELETE
ON relation.orderdetail_sparepart
FOR EACH ROW 
EXECUTE PROCEDURE relation.integrity_orderdetail_sparepart();

--TABLE SUPPLIER
CREATE OR REPLACE FUNCTION development.integrity_supplier() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(OLD.id_phone_number NOT IN(SELECT id FROM phone_number.supplier_phone_number)) THEN
		RAISE EXCEPTION 'invalid id_phone_number';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM development.supplier))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_supplier
BEFORE INSERT OR UPDATE OR DELETE
ON development.supplier
FOR EACH ROW 
EXECUTE PROCEDURE development.integrity_supplier();

--TABLE PURCHASE ORDER
CREATE OR REPLACE FUNCTION process.integrity_purchase_order() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.date < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date';
		RETURN NULL;
	ELSIF(NEW.final_cost < NEW.shipping_cost) THEN
		RAISE EXCEPTION 'invalid final_cost can not be smaller than shipping_cost';
		RETURN NULL;
	ELSIF(NEW.id_employee NOT IN(SELECT id FROM development.employee)) THEN
		RAISE EXCEPTION 'invalid id_employee';
		RETURN NULL;
	ELSIF(NEW.id_order_detail NOT IN(SELECT id FROM process.order_detail)) THEN
		RAISE EXCEPTION 'invalid id_order_detail';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.purchase_order))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_purchase_order
BEFORE INSERT OR UPDATE OR DELETE
ON process.purchase_order
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_purchase_order();

--TABLE SUPPLIER INVOICE
CREATE OR REPLACE FUNCTION process.integrity_supplier_invoice() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.date < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date';
		RETURN NULL;
	ELSIF(NEW.final_cost < NEW.sub_total) THEN
		RAISE EXCEPTION 'invalid final_cost can not be smaller than sub_total';
		RETURN NULL;
	ELSIF(NEW.id_employee NOT IN(SELECT id FROM development.employee)) THEN
		RAISE EXCEPTION 'invalid id_employee';
		RETURN NULL;
	ELSIF(NEW.id_supplier NOT IN(SELECT id FROM development.supplier)) THEN
		RAISE EXCEPTION 'invalid id_supplier';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.supplier_invoice))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_supplier_invoice
BEFORE INSERT OR UPDATE OR DELETE
ON process.supplier_invoice
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_supplier_invoice();

--TABLE CLAIM
CREATE OR REPLACE FUNCTION process.integrity_claim() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.date < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date';
		RETURN NULL;
	ELSIF(NEW.id_supplier_invoice NOT IN(SELECT id FROM process.supplier_invoice) ) THEN
		RAISE EXCEPTION 'invalid id_supplier_invoice';
		RETURN NULL;
	ELSIF(NEW.id_employee NOT IN(SELECT id FROM development.employee)) THEN
		RAISE EXCEPTION 'invalid id_employee';
		RETURN NULL;
	ELSIF(NEW.id_supplier NOT IN(SELECT id FROM development.supplier)) THEN
		RAISE EXCEPTION 'invalid id_supplier';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.claim))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_claim
BEFORE INSERT OR UPDATE OR DELETE
ON process.claim
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_claim();

--TABLE DEBIT NOTE
CREATE OR REPLACE FUNCTION process.integrity_debit_note() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.date_received < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date_received';
		RETURN NULL;
	ELSIF(NEW.date_limit < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date_limit';
		RETURN NULL;
	ELSIF(NEW.date_received > NEW.date_limit) THEN
		RAISE EXCEPTION 'invalid, deadline exceeded';
		RETURN NULL;
	ELSIF(NEW.subtotal > NEW.total) THEN
		RAISE EXCEPTION 'invalid subtotal can not be greater than total';
		RETURN NULL;
	ELSIF(NEW.id_supplier_invoice NOT IN(SELECT id FROM process.supplier_invoice) ) THEN
		RAISE EXCEPTION 'invalid id_supplier_invoice';
		RETURN NULL;
	ELSIF(NEW.id_employee NOT IN(SELECT id FROM development.employee)) THEN
		RAISE EXCEPTION 'invalid id_employee';
		RETURN NULL;
	ELSIF(NEW.id_supplier NOT IN(SELECT id FROM development.supplier)) THEN
		RAISE EXCEPTION 'invalid id_supplier';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.debit_note))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_debit_note
BEFORE INSERT OR UPDATE OR DELETE
ON process.debit_note
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_debit_note();

--TABLE EMPLOYEE TO TYPE OF EMPLOYEE
CREATE OR REPLACE FUNCTION relation.integrity_employee_typeofemployee() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(OLD.id_employee NOT IN(SELECT id FROM development.employee)) THEN
		RAISE EXCEPTION 'invalid id_employee';
		RETURN NULL;
	ELSIF(NEW.id_typeofemployee NOT IN(SELECT id FROM parameterization.type_of_employee)) THEN
		RAISE EXCEPTION 'invalid id_typeofemployee';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM relation.employee_typeofemployee))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_employee_typeofemployee
BEFORE INSERT OR UPDATE OR DELETE
ON relation.employee_typeofemployee
FOR EACH ROW 
EXECUTE PROCEDURE relation.integrity_employee_typeofemployee();

--TABLE SUPPLIER TO PURCHASE ORDER 
SELECT * FROM relation.supplier_purchaseorder;
CREATE OR REPLACE FUNCTION relation.integrity_supplier_purchaseorder() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(OLD.id_supplier NOT IN(SELECT id FROM development.supplier)) THEN
		RAISE EXCEPTION 'invalid id_supplier';
		RETURN NULL;
	ELSIF(NEW.id_purchase_order NOT IN(SELECT id FROM process.purchase_order)) THEN
		RAISE EXCEPTION 'invalid id_purchase_order';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM relation.supplier_purchaseorder))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_supplier_purchaseorder
BEFORE INSERT OR UPDATE OR DELETE
ON relation.supplier_purchaseorder
FOR EACH ROW 
EXECUTE PROCEDURE relation.integrity_supplier_purchaseorder();

--TABLE PAYMENT
CREATE OR REPLACE FUNCTION process.integrity_payment() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(NEW.date < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid date';
		RETURN NULL;
	ELSIF(NEW.expiration_Date < '01/01/1950' )THEN
		RAISE EXCEPTION 'invalid expiration_Date';
		RETURN NULL;
	ELSIF(NEW.id_customer NOT IN(SELECT id FROM development.customer)) THEN
		RAISE EXCEPTION 'invalid id_customer';
		RETURN NULL;
	ELSIF(NEW.id_valuation NOT IN(SELECT id FROM process.valuation)) THEN
		RAISE EXCEPTION 'invalid id_valuation';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.payment))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_payment
BEFORE INSERT OR UPDATE OR DELETE
ON process.payment
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_payment();

--TABLE ORDER DETAIL
CREATE OR REPLACE FUNCTION process.integrity_order_detail() RETURNS TRIGGER 
AS $$
BEGIN
IF(TG_OP = 'INSERT' )THEN
	IF(OLD.id_tax NOT IN(SELECT id FROM process.tax))THEN
		RAISE EXCEPTION 'invalid id_tax';
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Succesfull insert';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'UPDATE' )THEN
	IF(NEW = OLD) THEN	
		RAISE EXCEPTION 'Can not send the same data'; 
		RETURN NULL;
	ELSE
		RAISE NOTICE 'Successful update';
		RETURN NEW;
	END IF;
END IF;
IF(TG_OP = 'DELETE' ) THEN
	IF(OLD.id NOT IN(SELECT id FROM process.order_detail))THEN
		RAISE EXCEPTION 'invalid id';
	ELSE
		RAISE NOTICE 'Successful delete';
		RETURN OLD;
	END IF;
END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER tr_integrity_order_detail
BEFORE INSERT OR UPDATE OR DELETE
ON process.order_detail
FOR EACH ROW 
EXECUTE PROCEDURE process.integrity_order_detail();
