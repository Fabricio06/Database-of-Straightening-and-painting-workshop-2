--						CREATION OF DATABASE

CREATE DATABASE project2;


--						CREATION OF USERS

--Administrator creation with the 'Superuser privileges'
CREATE ROLE administrator WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	REPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'xxxxxx';
	
--Normal user creation (Only access to tables and functions)
CREATE ROLE normal_user WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'normal user';
GRANT USAGE ON SCHEMA development TO normal_user;
GRANT USAGE ON SCHEMA parameterization TO normal_user;
GRANT USAGE ON SCHEMA phone_number TO normal_user;
GRANT USAGE ON SCHEMA process TO normal_user;
GRANT USAGE ON SCHEMA relation TO normal_user;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA development TO normal_user;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA parameterization TO normal_user;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA phone_number TO normal_user;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA process TO normal_user;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA relation TO normal_user;
GRANT SELECT ON ALL TABLES IN SCHEMA development TO normal_user;
GRANT SELECT ON ALL TABLES IN SCHEMA parameterization TO normal_user;
GRANT SELECT ON ALL TABLES IN SCHEMA phone_number TO normal_user;
GRANT SELECT ON ALL TABLES IN SCHEMA process TO normal_user;
GRANT SELECT ON ALL TABLES IN SCHEMA relation TO normal_user;

--Backup user with the (only perform database backups)
CREATE ROLE backup_user WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	REPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'xxxxxx';