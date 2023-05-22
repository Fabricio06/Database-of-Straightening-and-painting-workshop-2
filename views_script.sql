--								CREATION OF THE VIEWS SCRIP

--NORMAL SQL QUERRY
SELECT *
FROM development.employee;

--CREATE OF THE VIEW 1 (EMPLOYEE WITH THE SALARY AND PHONE NUMBER) (NORMAL VIEW)
CREATE VIEW development.view_employee_1
AS SELECT d_e.id,
    d_e.name,
    d_e.last_name1,
    d_e.gender,
    d_e.age,
    p_p.phone_number,
    d_s.gross_salary,
    d_s.net_salary,
    d_s.currency_type
   	 FROM development.employee d_e
     JOIN development.salary d_s ON d_s.id = d_e.id_salary
     JOIN phone_number.phone_number_person p_p ON p_p.id = d_e.id_phone_number;
--VIEW 1 QUERRY CALL
SELECT *
FROM development.view_employee_1;

--CREATE OF THE VIEW 2 (VEHICLE WITH THE CUSTOMER AND TYPE OF VEHICLE) (VIEW SPECIFYING NAMES FOR SECURITY)
SELECT *
FROM development.vehicle;

CREATE VIEW development.view_vehicle_1 (id_vehicle, trademark, number_passenger,number_wheels,weight, licence_plate, type_vehicle,id_owner,name_owner,last_name1_owner,gender_owner)
AS SELECT d_v.id,d_v.trademark,d_v.number_passenger,d_v.number_of_wheels,d_v.weight,d_v.license_plate,p_t.name,d_c.id,d_c.name,d_c.last_name1,d_c.gender
FROM development.vehicle AS d_v 	
	JOIN development.customer AS d_c  
	ON d_c.id = d_v.id_customer
	JOIN parameterization.type_of_vehicle  AS p_t
	ON p_t.id = d_v.id_type_of_vehicle;

SELECT *
FROM development.view_vehicle_1;

--CREATE VIEW 3 (VEHICLE WITH THE TYPE OF VEHICLE AND INSURANCE COMPANY) (NORMAL VIEW)
SELECT *
FROM development.insurance_policy;

CREATE VIEW development.view_vehicle_2
AS SELECT d_v.id,d_v.trademark,d_v.number_passenger,d_v.number_of_wheels,d_v.weight,d_v.license_plate,p_t.name AS type_vehicle, d_i.id AS id_insurance_policy, d_i.start_date,d_i.expiration_date,d_i.monthly_payment
FROM development.vehicle AS d_v 	
	JOIN development.insurance_policy AS d_i
	ON d_i.id = d_v.id_insurance_policy
	JOIN parameterization.type_of_vehicle  AS p_t
	ON p_t.id = d_v.id_type_of_vehicle;

SELECT *
FROM development.view_vehicle_2;

--CREATE VIEW 4 (VALUATION WITH THE FORM, DEDUCTIBLE AND TAX) (NORMAL VIEW)
SELECT *
FROM process.valuation;

CREATE VIEW process.view_valuation_1
AS SELECT p_v.id AS id_valuation, p_v.retirement_date, p_v.labor_force_cost,p_v.estimated_cost,p_v.cost_of_spares, p_t.percentage AS percentage_tax, p_d.percentage AS percentage_deductible, p_d.tariff,
		  p_d.expiration_date, p_f.id AS id_form, p_f.owner_signature,p_f.policy_owner_signature
FROM process.valuation AS p_v
	JOIN process.deductible AS p_d
	ON p_d.id = p_v.id_deductible
	JOIN process.tax AS p_t
	ON p_t.id = p_v.id_tax
	JOIN process.form AS p_f
	ON p_f.id = p_v.id_form;
	
SELECT *
FROM process.view_valuation_1;


--CREATE 5 VIEW (PAYMENT WITH VALUATION VIEW) (USING OTHER VIEW)
SELECT *
FROM process.payment;

CREATE VIEW process.view_payment_1 
AS SELECT p_p.id,p_p.date,p_p.currency_type,p_p.method_of_payment, p_v_v.id_valuation,p_v_v.retirement_date
FROM process.payment AS p_p
	JOIN process.view_valuation_1 AS p_v_v
	ON p_v_v.id_valuation = p_p.id_valuation;

SELECT *
FROM process.view_payment_1;