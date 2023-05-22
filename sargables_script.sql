--									SEARGABLES SCRIPTS (SEARCH ARGUMENT ABLE)
--Are simple querys with a commun where that no involves a row to row analyzis

--seargable operators: =, >, <, >=, <=, BETWEEN, LIKE, IS NOT NULL
--seargable operators that rarely improve performance: <>, IN, OR, NOT IN, NOT LIKE

--1 PERSON WITH PHONE NUMBERS
SELECT name,last_name1,last_name2,age,ph.phone_number
FROM development.person AS pe JOIN phone_number.phone_number_person AS ph
ON pe.id_phone_number = ph.id_person
WHERE ph.phone_number IS NOT NULL;
--2 PERSON WITH NOT PHONE NUMBERS
SELECT name,last_name1,last_name2,age,ph.phone_number
FROM development.person AS pe JOIN phone_number.phone_number_person AS ph
ON pe.id_phone_number = ph.id_person
WHERE ph.phone_number IS NULL;

--3 VEHICLES WITH INSURANCE POLICY
SELECT *
FROM development.vehicle as ve JOIN development.insurance_policy as ins
ON ve.id_insurance_policy = ins.id
WHERE ins.id >0;

--4 SUPPLIER BY PROVINCE
SELECT *
FROM relation.supplier_purchaseorder AS supur JOIN development.supplier AS su
ON supur.id_supplier = su.id JOIN process.purchase_order AS pur 
ON supur.id_supplier = pur.id
WHERE LOWER(su.province) LIKE 'alajuela';

--5 SUPPLIER BY RANGES OF DATE
SELECT *
FROM relation.supplier_purchaseorder AS supur JOIN development.supplier AS su
ON supur.id_supplier = su.id JOIN process.purchase_order AS pur 
ON supur.id_supplier = pur.id
WHERE pur.date BETWEEN '01/01/2022' AND '31/12/2022';

--6 PAYMENTE AND INVOICE (sub_total smaller than final_cost)
SELECT *
FROM process.payment as pa JOIN process.invoice as inv
ON pa.id = inv.id_payment
WHERE inv.sub_total < inv.final_cost;

--7 RANGES OF INTS
SELECT *
FROM development.supplier AS sup JOIN process.debit_note AS deb
ON sup.id = deb.id_supplier JOIN development.employee AS emp
ON emp.id = deb.id_employee
WHERE sup.zip_code >=50000 AND sup.zip_code<60000;

--8 debit_note, employee and supplier by employee nationality's
SELECT *
FROM development.supplier AS sup JOIN process.debit_note AS deb
ON sup.id = deb.id_supplier JOIN development.employee AS emp
ON emp.id = deb.id_employee
WHERE emp.nationality LIKE 'costarrican';

--9 vehicle, customer, type_of_vehicle by car
SELECT *
FROM development.vehicle AS d_v JOIN development.customer AS d_c 
ON d_c.id = d_v.id_customer JOIN parameterization.type_of_vehicle AS p_t_v
ON p_t_v.id = d_v.id_type_of_vehicle
WHERE p_t_v.name LIKE 'car';

--10 valuation process, by presencial form = TRUE 
SELECT *
FROM process.valuation AS p_v JOIN development.customer AS d_c
ON d_c.id = p_v.id_customer JOIN development.employee AS d_e
ON d_e.id = p_v.id_employee JOIN process.form AS p_f 
ON p_f.id = p_v.id_form JOIN process.deductible AS p_d
ON p_d.id = p_v.id_deductible JOIN process.tax AS p_t 
ON p_t.id = p_v.id_tax
WHERE p_f.in_person = TRUE
ORDER BY p_v.id;