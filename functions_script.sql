--					CREATION OF THE FUNCTIONS SELECT,INSERT,DELETE FOR EACH TABLE SCRIPT

--DELETE, UPDATE AND INSERT FUNCTIONS FOR PARAMETERIZATION TABLES

CREATE OR REPLACE FUNCTION parameterization.delete_type_of_employee(id_e int)
RETURNS VOID AS
$$
DELETE FROM parameterization.type_of_employee
WHERE id = id_e;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION parameterization.update_type_of_employee(id_e int, id_n int, name_e varchar)
RETURNS VOID AS
$$
UPDATE parameterization.type_of_employee
SET id = id_n, name = name_e
WHERE id = id_e;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION parameterization.insert_type_of_employee(id_e int, name_e varchar)
RETURNS VOID AS
$$
INSERT INTO parameterization.type_of_employee(id, name)
VALUES (id_e, name_e);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION parameterization.insert_type_of_vehicle(id_v int, name_v varchar)
RETURNS VOID AS
$$
INSERT INTO parameterization.type_of_vehicle(id, name)
VALUES (id_v, name_v);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION parameterization.delete_type_of_vehicle(id_v int)
RETURNS VOID AS
$$
DELETE FROM parameterization.type_of_vehicle
WHERE id = id_v;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION parameterization.update_type_of_vehicle(id_v int, id_n int, name_e varchar)
RETURNS VOID AS
$$
DELETE FROM development.vehicle
WHERE id_type_of_vehicle = id_v;
UPDATE parameterization.type_of_vehicle
SET id = id_n, name = name_e
WHERE id = id_v;
$$
LANGUAGE sql;

--INSERT, DELETE, UPDATE FUNCTIONS FOR DEVELOPMENT TABLES

CREATE OR REPLACE FUNCTION development.delete_customer(id_c int)
RETURNS VOID AS
$$
BEGIN
DELETE FROM process.task
WHERE id IN
(
	SELECT ts.id
	FROM process.task AS ts, development.vehicle AS v
	WHERE v.id = ts.id_vehicle

);
DELETE FROM development.vehicle 
WHERE id IN
(
	SELECT v.id
	FROM development.vehicle AS v, development.customer AS cus
	WHERE cus.id = v.id_customer AND cus.id = id_c

);
DELETE FROM process.invoice
WHERE id IN
(
	SELECT inv.id
	FROM process.invoice AS inv, process.payment AS pay
	WHERE pay.id = inv.id_payment

);
DELETE FROM process.payment
WHERE id IN
(
	SELECT pay.id
	FROM process.payment AS pay, process.valuation AS val
	WHERE val.id = pay.id_valuation

);
DELETE FROM process.valuation
WHERE id IN
(
	SELECT val.id
	FROM process.valuation AS val, development.customer AS cus
	WHERE cus.id = val.id_customer AND cus.id = id_c

);

DELETE FROM development.customer 
WHERE id = id_c;

END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION development.update_customer(id_c int, name_c varchar, name2_c varchar,
													  name3_c varchar, genderc varchar, nation varchar,
													  yearc int, monthc varchar, dayc int,
													  id_phone int, numv int)
RETURNS VOID AS 
$$
UPDATE development.customer
SET name = name_c, last_name1 = name2_c, last_name2 = name3_c,
gender = genderc, nationality = nation, year = yearc, month = monthc,
day = dayc, id_phone_number = id_phone, number_of_visits = numv
WHERE id = id_c;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.insert_customer(namec varchar, lastnamec varchar,
													  lastname2 varchar, gender varchar, nation varchar,
													  year int, month varchar, day int, id_phone int,
													  numv int)
RETURNS VOID AS
$$
INSERT INTO development.customer(name, last_name1, last_name2,
								gender,nationality, year, "month", "day",
								id_phone_number, number_of_visits)
VALUES(namec, lastnamec, lastname2, gender, nation, year, month, day, id_phone, numv)
	 
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION development.delete_employee(id_em int)
RETURNS VOID AS
$$
BEGIN
DELETE FROM process.valuation
WHERE id IN
(
	SELECT val.id
	FROM process.valuation AS val, development.employee AS em
	WHERE em.id = val.id_employee

);
DELETE FROM relation.supplier_purchaseorder
WHERE id_purchase_order IN
(
	SELECT po.id
	FROM relation.supplier_purchaseorder AS spo, process.purchase_order AS po
	WHERE po.id = spo.id_purchase_order

); 
DELETE FROM process.purchase_order
WHERE id IN
(
	SELECT po.id
	FROM process.purchase_order AS po, development.employee AS em
	WHERE em.id = po.id_employee

);
DELETE FROM process.claim
WHERE id IN
(
	SELECT cl.id
	FROM process.claim AS cl, process.supplier_invoice AS si
	WHERE si.id = cl.id_supplier_invoice

);
DELETE FROM process.debit_note
WHERE id IN
(
	SELECT dn.id
	FROM process.debit_note AS dn, process.supplier_invoice AS si
	WHERE si.id = dn.id_supplier_invoice

);
DELETE FROM process.supplier_invoice
WHERE id IN
(
	SELECT si.id
	FROM process.supplier_invoice AS si, development.employee AS em
	WHERE em.id = si.id_employee

);
DELETE FROM relation.employee_typeofemployee
WHERE id_employee IN
(
	SELECT te.id_employee
	FROM relation.employee_typeofemployee AS te, development.employee AS em
	WHERE em.id = te.id_employee

);


DELETE FROM development.employee 
WHERE id = id_em;

END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION development.update_employee(id_e int, name_e varchar, name2_e varchar,
													  name3_e varchar, gendere varchar, nation varchar,
													  yeare int, monthe varchar, daye int,
													  id_phone int, wt varchar, sal int)
RETURNS VOID AS 
$$
UPDATE development.employee
SET name = name_e, last_name1 = name2_e, last_name2 = name3_e,
gender = gendere, nationality = nation, year = yeare, month = monthe,
day = daye, id_phone_number = id_phone, agreed_working_time = wt, id_salary = sal
WHERE id = id_e;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.insert_employee(namee varchar, lastnamee varchar, lastnamee2 varchar, gendere varchar, natione varchar, yeare int, 
monthe varchar, daye int, id_phone int, wkt varchar, sal int)
RETURNS VOID AS
$$
INSERT INTO development.employee(name, last_name1, last_name2,
								gender,nationality, year, "month", "day",
								id_phone_number, agreed_working_time, id_salary)
VALUES(namee, lastnamee, lastnamee2, gendere, natione, yeare, monthe, daye, id_phone, wkt, sal)
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION development.delete_insurance_company(id_ic int)
RETURNS VOID AS
$$
DELETE FROM development.vehicle
WHERE id IN 
(
	SELECT v.id
	FROM development.vehicle AS v, development.insurance_policy AS ip
	WHERE ip.id = v.id_insurance_policy




);
DELETE FROM development.insurance_policy
WHERE id IN
(
	SELECT ip.id
	FROM development.insurance_policy AS ip, development.insurance_company AS ic
	WHERE ic.id = ip.id_insurance_company


);
DELETE FROM process.deductible
WHERE id IN 
(
	SELECT d.id
	FROM process.deductible AS d, development.insurance_company AS ic
	WHERE ic.id = d.id_insurance_company


);
DELETE FROM development.insurance_company
WHERE id = id_ic;

$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.update_insurance_company(id_ic int, nameic varchar, districtic varchar,
															   cantonic varchar, provinceic varchar, zip_codeic int,
															   id_phoneic int, websiteic varchar, emailic varchar)
RETURNS VOID AS
$$
UPDATE development.insurance_company
SET name = nameic, district = districtic, canton = cantonic,
province = provinceic, zip_code = zip_codeic, website = websiteic,
email = emailic
WHERE id = id_ic

$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.insert_insurance_company(nameic varchar, districtic varchar,
															   cantonic varchar, provinceic varchar, zip_codeic int,
															   id_phoneic int, websiteic varchar, emailic varchar)
RETURNS VOID AS
$$
INSERT INTO development.insurance_company(name, district, canton, province, zip_code,
										  id_phone_number, website, email)
VALUES(nameic, districtic, cantonic, provinceic, zip_codeic,
		id_phoneic, websiteic, emailic)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.delete_insurance_policy(id_ip int)
RETURNS VOID AS
$$
DELETE FROM development.insurance_policy
WHERE id = id_ip;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.update_insurance_policy(id_ip integer, expd date, minp integer, maxp integer, monthp integer, startd date, id_ic integer)
RETURNS VOID AS
$$
UPDATE development.insurance_policy
SET expiration_date = expd, minimum_payment = minp, maximum_payment = maxp,
monthly_payment = monthp, start_date = startd, id_insurance_company = id_ic
WHERE id = id_ip;

$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.insert_insurance_policy(expd date, minp int, maxp int, monthp int,
															  startd date, id_ic int)
RETURNS VOID AS
$$
INSERT INTO development.insurance_policy(expiration_date, minimum_payment,maximum_payment,
										monthly_payment,start_date,id_insurance_company)
VALUES (expd, minp, maxp, monthp, startd, id_ic)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.delete_person(id_p int)
RETURNS VOID AS
$$
DELETE FROM development.person
WHERE id = id_p;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.update_person(id_p int, namep varchar, lastnp varchar,
													lastnp2 varchar, gen varchar, nation varchar,
													yearp int, monthp varchar, dayp int, id_phone int)
RETURNS VOID AS
$$
UPDATE development.person
SET name = namep, last_name1 = lastnp, last_name2 = lastnp2, gender = gen,
nationality = nation, year = yearp, month = monthp, day = dayp,id_phone_number = id_phone
WHERE id = id_p;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.insert_person(namep varchar, lastnp varchar, lastnp2 varchar, 
													genp varchar, nation varchar, yearp int, monthp varchar,
													dayp int, id_phone int)
RETURNS VOID AS
$$
INSERT INTO development.person(name, last_name1, last_name2, gender, nationality, year, month, day,
							  id_phone_number)
VALUES(namep, lastnp, lastnp2, genp, nation, yearp, monthp, dayp, id_phone);

$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.delete_salary(id_s int)
RETURNS VOID AS
$$
DELETE FROM development.employee
WHERE id IN 
(
	SELECT e.id
	FROM development.employee AS e, development.salary AS s
	WHERE s.id = e.id_salary AND s.id = id_s

);
DELETE FROM development.salary
WHERE id = id_s;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.update_salary(id_s int, dates date, gs numeric,
													ns numeric, rate_pay varchar, typec varchar)
RETURNS VOID AS
$$
UPDATE development.salary
SET date = dates, gross_salary = gs, net_salary = ns, rate_of_payment = rate_pay, currency_type = typec
WHERE id = id_s;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.insert_salary(dates date, gs numeric, ns numeric,
													rate_pay varchar, currency_t varchar)
RETURNS VOID AS
$$
INSERT INTO development.salary(date, gross_salary, net_salary, rate_of_payment,currency_type)
VALUES(dates, gs, ns, rate_pay, currency_t);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.delete_spare_part(id_sp int)
RETURNS VOID AS
$$
DELETE FROM development.spare_part
WHERE id = id_sp;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.update_spare_part(id_sp int, namesp varchar,
														mprice int, trade varchar,
														sizesp varchar, newis boolean)
RETURNS VOID AS
$$
UPDATE development.spare_part
SET name = namesp, market_price = mprice, trademark = trade, size = sizesp,is_new = newis
WHERE id = id_sp;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.insert_spare_part(namesp varchar, mprice int,
														trade varchar, sizesp varchar, newis boolean)
RETURNS VOID AS
$$
INSERT INTO development.spare_part(name, market_price, trademark,size, is_new)
VALUES(namesp, mprice, trade, sizesp, newis)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.delete_supplier(id_sup int)
RETURNS VOID AS
$$
DELETE FROM development.supplier
WHERE id = id_sup;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.update_supplier(id_sup int, namesup varchar,
													  provincesup varchar, cantonsup varchar,
													  districtsup varchar, zip_codesup int,
													  web_sitesup varchar, emailsup varchar, id_phone int)
RETURNS VOID AS
$$
UPDATE development.supplier
SET name = namesup, province = provincesup, canton = cantonsup, district = districtsup, zip_code = zip_codesup,
web_site = web_sitesup, email = emailsup, id_phone_number = id_phone 
WHERE id = id_sup;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.insert_supplier(namesup varchar, provincesup varchar, cantonsup varchar, districtsup varchar, zip_codesup integer, web_sitesup varchar, emailsup varchar, id_phone integer)
RETURNS VOID AS
$$
INSERT INTO development.supplier(name, province,canton,district,zip_code,web_site,email,id_phone_number)
VALUES(namesup, provincesup, cantonsup, districtsup, zip_codesup, web_sitesup, emailsup, id_phone);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.delete_vehicle(id_v int)
RETURNS VOID AS
$$
DELETE FROM development.vehicle
WHERE id = id_v;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.update_vehicle(id_v integer, exo boolean, trade varchar, passenger numeric, wheels numeric, weigthv varchar, license_platev varchar, cus integer, ip integer, tv integer)
RETURNS VOID AS
$$
UPDATE development.vehicle
SET is_exorated = exo, trademark = trade, number_passenger = passenger, number_of_wheels = wheels,
weight = weigthv, license_plate = license_platev, id_customer = cus, id_insurance_policy = ip, id_type_of_vehicle = tv
WHERE id = id_v;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION development.insert_vehicle(exo boolean, trade varchar, passenger numeric, wheels numeric, weightv varchar, license_platev varchar, cus integer, ip integer, tv integer)
RETURNS VOID AS
$$
INSERT INTO development.vehicle(is_exorated, trademark,number_passenger,number_of_wheels,
							   weight, license_plate,id_customer,id_insurance_policy, id_type_of_vehicle)
VALUES(exo, trade, passenger, wheels, weightv, license_platev, cus, ip, tv);
$$
LANGUAGE sql;


--INSERT, DELETE, UPDATE FUNCTIONS FOR PROCESS TABLES

CREATE OR REPLACE FUNCTION process.delete_claim(id_claim int)
RETURNS VOID AS
$$
DELETE FROM process.claim
WHERE id = id_claim;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_claim(id_claim int, dateclaim date, 
											   reasonclaim varchar, esignature boolean,
											   requestclaim varchar, resolution varchar,
											   consequencesc varchar, employeeid int, invoicesup int, sup int)
RETURNS VOID AS
$$
UPDATE process.claim
SET date = dateclaim, reason = reasonclaim, employee_signature = esignature, request = requestclaim,
resolution_deadline = resolution, consequences = consequencesc, id_employee = employeeid, id_supplier_invoice = invoicesup, id_supplier = sup
WHERE id = id_claim;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_claim(dateclaim date, reasonclaim varchar, esignature boolean, requestclaim varchar, resolution varchar, consequencesc varchar, employeeid integer, invoicesup integer, sup integer)
RETURNS VOID AS
$$
INSERT INTO process.claim(date, reason, employee_signature, request, resolution_deadline, consequences, id_employee, id_supplier_invoice, id_supplier)
VALUES(dateclaim, reasonclaim, esignature, requestclaim, resolution, consequencesc, employeeid, invoicesup, sup)
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION process.delete_debit_note(id_dn int)
RETURNS VOID AS
$$
DELETE FROM process.debit_note
WHERE id = id_dn;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_debit_note(id_dn int, recieved_date date,
													limitdate date, subtotaldn int, totaldn int, 
													descrip varchar, employeeid int, supplierid int, sinvoice int)
RETURNS VOID AS
$$
UPDATE process.debit_note
SET date_received = recieved_date, date_limit = limitdate, subtotal = subtotaldn, total = totaldn,
description = descrip, id_employee = employeeid, id_supplier = supplierid, id_supplier_invoice = sinvoice
WHERE id = id_dn;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_debit_note(recieved_date date,
													limitdate date, subtotaldn int, totaldn int, 
													descrip varchar, employeeid int, supplierid int, sinvoice int)
RETURNS VOID AS
$$
INSERT INTO process.debit_note(date_received,date_limit,subtotal,total,description,id_employee,id_supplier,id_supplier_invoice)
VALUES(recieved_date, limitdate, subtotaldn, totaldn, descrip, employeeid, supplierid, sinvoice)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.delete_deductible(id_deduc int)
RETURNS VOID AS
$$
DELETE FROM process.deductible
WHERE id = id_deduc;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_deductible(id_deduc int, percen numeric, tar int,
													startd date, expdate date, ratepay varchar, idic int)
RETURNS VOID AS
$$
UPDATE process.deductible
SET percentage = percen, tariff = tar, start_date = startd, expiration_date = expdate,
rate_of_payment = ratepay, id_insurance_company = idic
WHERE id = id_deduc;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_deductible(percentaged numeric, tarif numeric,
													startd date, expd date, ratepay varchar, idic int)
RETURNS VOID AS
$$
INSERT INTO process.deductible(percentage,tariff,start_date,expiration_date,rate_of_payment,id_insurance_company)
VALUES(percentaged, tarif, startd, expd, ratepay, idic);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.delete_form(id_form int)
RETURNS VOID AS 
$$
DELETE FROM process.form
WHERE id = id_form;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_form(id_form int, ownersig boolean,
											  policyownersig boolean, datef date,
											  person boolean, valityf varchar)
RETURNS VOID AS
$$
UPDATE process.form
SET owner_signature = ownersig, policy_owner_signature = policyownersig, date = datef,
in_person = person, vality = valityf
WHERE id = id_form;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_form(ownersig boolean, policyownersig boolean, datef date, person boolean, valityf varchar)
RETURNS VOID AS
$$
INSERT INTO process.form(owner_signature,policy_owner_signature,date,in_person,vality)
VALUES(ownersig,policyownersig,datef,person,valityf);
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION process.delete_invoice(id_invoice int)
RETURNS VOID AS
$$
DELETE FROM process.invoice
WHERE id = id_invoice;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_invoice(id_invoice int, datei date,
												 subtotali int, totali int,
												 typec varchar, descp varchar,
												 idc int, payid int)
RETURNS VOID AS
$$
UPDATE process.invoice
SET date = datei, sub_total = subtotali, final_cost = totali, currency_type = typec,
description = descp, id_customer = idc, id_payment = payid
WHERE id = id_invoice;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_invoice(datei date, subtoali int, totali int, 
												typec varchar, descp varchar, idc int, payid int)
RETURNS VOID AS
$$
INSERT INTO process.invoice(date,sub_total,final_cost,currency_type,description,id_customer,id_payment)
VALUES(datei, subtoali, totali, typec, descp, idc, payid);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.delete_order_detail(id_order int)
RETURNS VOID AS
$$
DELETE FROM relation.supplier_purchaseorder
WHERE id_purchase_order IN
(
	 SELECT rsp.id_purchase_order
	FROM relation.supplier_purchaseorder AS rsp, process.purchase_order AS po
	WHERE po.id = rsp.id_purchase_order

);

DELETE FROM process.purchase_order
WHERE id IN
(
	SELECT po.id
	FROM process.purchase_order AS po, process.order_detail AS od
	WHERE od.id = po.id_order_detail
);
DELETE FROM relation.orderdetail_sparepart
WHERE order_detail_id IN 
(
	SELECT osp.order_detail_id
	FROM relation.orderdetail_sparepart AS osp, process.order_detail AS od
	WHERE od.id = osp.order_detail_id

);
DELETE FROM process.order_detail
WHERE id = id_order;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_order_detail(id_order int, tax int, quant int,
													  unitp int, descp varchar, pertax numeric)
RETURNS VOID AS
$$
UPDATE process.order_detail
SET id_tax = tax, quantity = quant, 
unit_price = unitp, description = descp, tax_percentage = pertax
WHERE id = id_order;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_order_detail(tax int, quant int,
													  unitp int, descp varchar, pertax numeric)
RETURNS VOID AS
$$
INSERT INTO process.order_detail(id_tax,quantity,unit_price,description,tax_percentage)
VALUES(tax, quant, unitp, descp, pertax);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.delete_payment(id_pay int)
RETURNS VOID AS
$$
DELETE FROM process.invoice
WHERE id IN
(
	SELECT i.id
	FROM process.invoice AS i, process.payment AS pay
	WHERE pay.id = i.id_payment

);
DELETE FROM process.payment
WHERE id = id_pay;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_payment(id_pay int, datepay date, expdate date, 
												 methodpay varchar, ctype varchar, descp varchar,
												 idc int, idv int)
RETURNS VOID AS
$$
UPDATE process.payment
SET date = datepay, expiration_date = expdate, method_of_payment = methodpay, currency_type = ctype, 
description = descp, id_customer = idc, id_valuation = idv
WHERE id = id_pay;
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION process.insert_payment(datepay date, expdate date, 
												 methodpay varchar, ctype varchar, descp varchar,
												 idc int, idv int)
RETURNS VOID AS
$$
INSERT INTO process.payment(date,expiration_date,method_of_payment,currency_type,description,id_customer,id_valuation)
VALUES(datepay,expdate, methodpay, ctype, descp, idc, idv)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.delete_purchase_order(id_po int)
RETURNS VOID AS
$$
DELETE FROM process.purchase_order
WHERE id = id_po;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_purchase_order(id_po int, datepo date, statuspo numeric,
														terms int, costship int, finalcostpo int, id_od int, ide int)
RETURNS VOID AS
$$
UPDATE process.purchase_order
SET date = datepo, status = statuspo, payment_terms = terms, shipping_cost = costship, final_cost = finalcostpo, 
id_order_detail = id_od, id_employee = ide
WHERE id = id_po;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_purchase_order(datepo date, statuspo numeric,
														terms varchar, costship int, finalcostpo int, id_od int, ide int)
RETURNS VOID AS
$$
INSERT INTO process.purchase_order(date,status,payment_terms,shipping_cost,final_cost,id_order_detail,id_employee)
VALUES(datepo, statuspo,terms,costship, finalcostpo, id_od, ide)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.delete_supplier_invoice(id_si int)
RETURNS VOID AS
$$
DELETE FROM process.claim
WHERE id IN 
(
	SELECT cl.id
	FROM process.claim AS cl, process.supplier_invoice AS si
	WHERE si.id = cl.id_supplier_invoice

);
DELETE FROM process.debit_note
WHERE id IN
(
	SELECT dbn.id
	FROM process.debit_note AS dbn, process.supplier_invoice AS si
	WHERE si.id = dbn.id_supplier_invoice

);
DELETE FROM process.supplier_invoice
WHERE id = id_si;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_supplier_invoice(id_si int, datesi date, sub_totalsi int,
														  final_costsi int, currency_typesi varchar,
														  descpsi varchar, idsup int, ide int)
RETURNS VOID AS
$$
UPDATE process.supplier_invoice
SET date = datesi, sub_total = sub_totalsi, final_cost = final_costsi, currency_type = currency_typesi, 
description = descpsi, id_supplier = idsup, id_employee = ide
WHERE id = id_si;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_supplier_invoice(datesi date, sub_totalsi int,
														  final_costsi int, currency_typesi varchar,
														  descpsi varchar, idsup int, ide int)
RETURNS VOID AS
$$
INSERT INTO process.supplier_invoice(date,sub_total,final_cost,currency_type,description,id_supplier,id_employee)
VALUES(datesi, sub_totalsi,final_costsi, currency_typesi, descpsi, idsup, ide);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.delete_task(id_task int)
RETURNS VOID AS
$$
DELETE FROM process.task
WHERE id = id_task;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_task(id_task int, datetask date, statustask numeric,
											  descptask varchar, durationtask varchar, idv int,
											  ide int, idte int)
RETURNS VOID AS
$$
UPDATE process.task
SET date = datetask, status = statustask, description = descptask, estimated_duration = durationtask, 
id_vehicle = idv, id_employee = ide, id_type_of_employee = idte
WHERE id = id_task;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_task(datetask date, statustask numeric,
											  descptask varchar, durationtask varchar, idv int,
											  ide int, idte int)
RETURNS VOID AS
$$
INSERT INTO process.task(date, status, description,estimated_duration,id_vehicle,id_employee,id_type_of_employee)
VALUES(datetask, statustask, descptask, durationtask, idv, ide, idte);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.delete_tax(id_tax int)
RETURNS VOID AS
$$
DELETE FROM process.purchase_order
WHERE id IN
(
	SELECT po.id
	FROM process.purchase_order AS po, process.order_detail AS od
	WHERE od.id = po.id_order_detail

);
DELETE FROM process.order_detail
WHERE id IN 
(
	SELECT od.id
	FROM process.order_detail AS od, process.tax AS tax
	WHERE tax.id = od.id_tax

);
DELETE FROM process.tax
WHERE id = id_tax;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_tax(id_tax int, pertax numeric)
RETURNS VOID AS
$$
UPDATE process.tax
SET percentage = pertax
WHERE id = id_tax;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_tax(pertax numeric)
RETURNS VOID AS
$$
INSERT INTO process.tax(percentage)
VALUES(pertax);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.delete_valuation(id_valuation int)
RETURNS VOID AS
$$
DELETE FROM process.payment
WHERE id IN
(
	SELECT pay.id
	FROM process.payment AS pay, process.valuation AS val
	WHERE val.id = pay.id_valuation

);
DELETE FROM process.valuation
WHERE id = id_valuation;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.update_valuation(id_val int, retirval date, laborval int,
												   estival int, costval int, idcus int, ide int,
												   idf int, iddec int, idtax int)
RETURNS VOID AS
$$
UPDATE process.valuation
SET retirement_date = retirval, labor_force_cost = laborval, estimated_cost = estival, 
cost_of_spares = costval, id_customer = idcus, id_employee = ide, id_form = idf, id_deductible = iddec,
id_tax = idtax
WHERE id = id_val;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION process.insert_valuation(retirval date, laborval int,
												   estival int, costval int, idcus int, ide int,
												   idf int, iddec int, idtax int)
RETURNS VOID AS
$$
INSERT INTO process.valuation(retirement_date,labor_force_cost,estimated_cost,cost_of_spares,id_customer,id_employee,id_form,id_deductible,id_tax)
VALUES(retirval,laborval, estival, costval, idcus, ide, idf, iddec,idtax)
$$
LANGUAGE sql;


--DELETE, UPDATE, AND INSERT FUNCTIONS FOR RELATION TABLES

CREATE OR REPLACE FUNCTION relation.delete_employee_typeofemployee(id_em int, id_te int)
RETURNS VOID AS
$$
DELETE FROM relation.employee_typeofemployee
WHERE id_employee = id_em AND id_typeofemployee = id_te;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION relation.update_employee_typeofemployee(id_em int, id_te int, id_em2 int, id_te2 int)
RETURNS VOID AS
$$
UPDATE relation.employee_typeofemployee
SET id_employee = id_em, id_typeofemployee = id_te
WHERE id_employee = id_em AND id_typeofemployee = id_te;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION relation.insert_employee_typeofemployee(id_em int, id_te int)
RETURNS VOID AS
$$
INSERT INTO relation.employee_typeofemployee(id_employee, id_typeofemployee)
VALUES(id_em, id_te);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION relation.delete_orderdetail_sparepart(id_od int, id_sp int)
RETURNS VOID AS
$$
DELETE FROM relation.orderdetail_sparepart
WHERE order_detail_id = id_od AND spare_part_id = id_sp;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION relation.update_orderdetail_sparepart(id_od int, id_sp int, id_od2 int, id_sp2 int) 
RETURNS VOID AS
$$
UPDATE relation.orderdetail_sparepart
SET order_detail_id = id_od2, spare_part_id = id_sp2
WHERE order_detail_id = id_od AND spare_part_id = id_sp;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION relation.insert_orderdetail_sparepart(id_od int, id_sp int) 
RETURNS VOID AS
$$
INSERT INTO relation.orderdetail_sparepart(order_detail_id,spare_part_id)
VALUES(id_od,id_sp);
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION relation.delete_supplier_purchaseorder(id_sup int, id_po int)
RETURNS VOID AS
$$
DELETE FROM relation.supplier_purchaseorder
WHERE id_supplier = id_sup AND id_purchase_order = id_po;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION relation.update_supplier_purchaseorder(id_sup int, id_po int, id_sup2 int, id_po2 int) 
RETURNS VOID AS
$$
UPDATE relation.supplier_purchaseorder
SET id_supplier = id_sup2, id_purchase_order = id_po2
WHERE id_supplier = id_sup AND id_purchase_order = id_po;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION relation.insert_supplier_purchaseorder(id_sup int, id_po int) 
RETURNS VOID AS
$$
INSERT INTO relation.supplier_purchaseorder(id_supplier,id_purchase_order)
VALUES(id_sup,id_po);
$$
LANGUAGE sql;

--DELETE, UPDATE, AND INSERT FUNCTIONS FOR PHONE_NUMBER TABLES

CREATE OR REPLACE FUNCTION phone_number.delete_insurance_company_phone_number(id_icpn int)
RETURNS VOID AS
$$
DELETE FROM process.task
WHERE id IN 
(
	SELECT task.id
	FROM process.task AS task, development.vehicle AS v
	WHERE v.id = task.id_vehicle

);
DELETE FROM development.vehicle
WHERE id IN
(
	SELECT v.id
	FROM development.vehicle AS v, development.insurance_policy AS ip
	WHERE ip.id = v.id_insurance_policy

);
DELETE FROM development.insurance_policy
WHERE id IN
(
	SELECT ip.id
	FROM development.insurance_policy AS ip, development.insurance_company AS ic
	WHERE ic.id = ip.id_insurance_company

);
DELETE FROM process.valuation
WHERE id IN
(
	SELECT val.id
	FROM process.valuation AS val, process.deductible AS deduc
	WHERE deduc.id = val.id_deductible

);
DELETE FROM process.deductible
WHERE id IN
(
	SELECT deduc.id
	FROM process.deductible AS deduc, development.insurance_company AS ic
	WHERE ic.id = deduc.id_insurance_company

);
DELETE FROM development.insurance_company
WHERE id IN
(
	SELECT ic.id
	FROM development.insurance_company AS ic, phone_number.insurance_company_phone_number AS icpn
	WHERE icpn.id = ic.id_phone_number

);
DELETE FROM phone_number.insurance_company_phone_number
WHERE id = id_icpn;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION phone_number.update_insurance_company_phone_number(id_icp int, id_ic int, num int)
RETURNS VOID AS
$$
UPDATE phone_number.insurance_company_phone_number
SET id_company = id_ic, phone_number = num
WHERE id = id_icp;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION phone_number.insert_insurance_company_phone_number(id_ic int, num int)
RETURNS VOID AS
$$
INSERT INTO phone_number.insurance_company_phone_number(id_company,phone_number)
VALUES(id_ic, num)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION phone_number.delete_phone_number_person(id_phone int)
RETURNS VOID AS
$$
DELETE FROM relation.employee_typeofemployee
WHERE id_employee IN
(
	SELECT ete.id_employee
	FROM relation.employee_typeofemployee AS ete, development.employee AS em
	WHERE em.id = ete.id_employee


);
DELETE FROM process.supplier_invoice
WHERE id IN
(
	SELECT si.id
	FROM process.supplier_invoice AS si, development.employee AS em
	WHERE em.id = si.id_employee


);
DELETE FROM development.person
WHERE id IN
(
 	SELECT pe.id
	FROM development.person AS pe, phone_number.phone_number_person AS pp
	WHERE pp.id = pe.id_phone_number

);
DELETE FROM phone_number.phone_number_person
WHERE id = id_phone;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION phone_number.update_phone_number_person(idp int, id_p int, num int)
RETURNS VOID AS
$$
UPDATE phone_number.phone_number_person
SET id_person = id_p, phone_number = num
WHERE id = idp;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION phone_number.insert_phone_number_person(id_p int, num int)
RETURNS VOID AS
$$
INSERT INTO phone_number.phone_number_person(id_person,phone_number)
VALUES(id_p, num)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION phone_number.delete_supplier_phone_number(id_supp int)
RETURNS VOID AS
$$
DELETE FROM development.supplier
WHERE id IN
(
	SELECT sup.id
	FROM development.supplier AS sup, phone_number.supplier_phone_number AS supp
	WHERE supp.id = sup.id_phone_number

);
DELETE FROM phone_number.supplier_phone_number
WHERE id = id_supp;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION phone_number.update_supplier_phone_number(idsup int, id_sup int, num int)
RETURNS VOID AS
$$
UPDATE phone_number.supplier_phone_number
SET id_supplier = id_sup, phone_number = num
WHERE id = idsup;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION phone_number.insert_supplier_phone_number(id_sup int, num int)
RETURNS VOID AS
$$
INSERT INTO phone_number.supplier_phone_number(id_supplier,phone_number)
VALUES(id_sup, num)
$$
LANGUAGE sql;