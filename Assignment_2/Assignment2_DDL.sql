CREATE TABLE salesperson(
   salesman_id serial PRIMARY KEY,
   name VARCHAR (80) NOT NULL,
   phone_number VARCHAR (80)
);

CREATE TABLE customer(
   cust_id serial PRIMARY KEY,
   name VARCHAR (80) NOT NULL,
   phone_number VARCHAR (80)
);

CREATE TABLE car(
   car_id serial PRIMARY KEY,
   manufacturer VARCHAR (20),
   model_name VARCHAR (20),
   model_variant VARCHAR (20),
   serial_number VARCHAR (20),
   weight VARCHAR (6),
   engine_cc VARCHAR (3),
   price VARCHAR (15)
);

CREATE TABLE transaction(
   trans_id serial,
   salesman_id integer,
   cust_id integer,
   car_id integer,
   PRIMARY KEY(trans_id, salesman_id, cust_id, car_id),
   status VARCHAR (10),
   trans_timestamp TIMESTAMP NOT NULL,
   CONSTRAINT salesman_id_fkey FOREIGN KEY (salesman_id)
      REFERENCES salesperson (salesman_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
   CONSTRAINT cust_id_fkey FOREIGN KEY (cust_id)
      REFERENCES customer (cust_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
   CONSTRAINT car_id_fkey FOREIGN KEY (car_id)
      REFERENCES car (car_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION	  

);