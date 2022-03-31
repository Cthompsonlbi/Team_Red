-- Create a customer data table
CREATE TABLE IF NOT EXISTS public.customer_table
(
    customerid INT NOT NULL,
    prodtaken INT,
    age FLOAT,
    citytier INT,
    occupation VARCHAR(20),
    gender VARCHAR(8),
    numberofpersonvisiting INT,
    preferredpropertystar FLOAT,
    maritalstatus VARCHAR(12),
    numberoftrips FLOAT,
    passport INT,
    owncar INT,
    numberofchildrenvisiting FLOAT,
    designation VARCHAR(20),
    monthlyincome FLOAT,
    CONSTRAINT customer_table_pkey PRIMARY KEY (customerid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.customer_table
    OWNER to postgres;


-- Create a marketing data table
CREATE TABLE IF NOT EXISTS public.marketing_data2
(
    customerid INT NOT NULL,
    typeofcontact VARCHAR(20),
    durationofpitch FLOAT,
    numberoffollowups FLOAT,
    productpitched VARCHAR(20),
    pitchsatisfactionscore INT,
    CONSTRAINT marketing_data2_pkey PRIMARY KEY (customerid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.marketing_data2
    OWNER to postgres;


-- Merge the two tables
SELECT
	cu.customerid,
    cu.prodtaken,
    cu.age,
    cu.citytier,
    cu.occupation,
    cu.gender,
    cu.numberofpersonvisiting,
    cu.preferredpropertystar,
    cu.maritalstatus,
    cu.numberoftrips,
    cu.passport,
    cu.owncar,
    cu.numberofchildrenvisiting,
    cu.designation,
    cu.monthlyincome,
	mt.typeofcontact,
    mt.durationofpitch,
    mt.numberoffollowups,
    mt.productpitched,
    mt.pitchsatisfactionscore
	
INTO cust_marketing_table
FROM customer_table AS cu
LEFT JOIN marketing_data2 AS mt
    ON mt.CustomerID = cu.CustomerID;
	
-- Table Selection
SELECT * FROM customer_table;
SELECT * FROM marketing_data2;
SELECT * FROM cust_marketing_table;

DROP TABLE customer_table;
DROP TABLE marketing_data2;
DROP TABLE cust_marketing_table;