 create table company(
	id integer not null primary key , 
	name varchar(30) not null , 
	address varchar(50),
	phone_number varchar(15),
	owner varchar(30)); 
 
 create table goods(
	code_id integer not null primary key , 
	company_id integer ,
	name varchar(30) not null , 
	price  integer,
	production_date date , 
	Expiration_date  date,
	origin varchar(20),
	type varchar(4) check (type in ('Medi', 'Heal', 'Cosm')),
	foreign key(company_id) references company(id));
	
	
 create table warehouse(
	id integer not null primary key , 
	name varchar(30) not null , 
	address varchar(50),
	phone_number varchar(15),
	owner varchar(30),
 	capacity integer);
	
	
create table store(
	id_warehouse integer not null,
	id_goods integer not null,
	quantity integer,
	foreign key(id_goods) references goods(code_id),
	foreign key(id_warehouse) references warehouse(id),
 	primary key(id_warehouse, id_goods));

create table delivery(
    code integer not null primary key ,
    delivery_status varchar(10) check (delivery_status in ('InProgress', 'Delivered', 'NotProc')),
    scheduled_date date,
    plate_number varchar(30));
 
create table my_order(
    id_goods integer not null,
    delivery_id integer not null,
    id_customer integer not null,
    submission_date date not null,
    order_status varchar(12) check (order_status in ('NPaid', 'PaidNDeli', 'PaidSelfDeli','PaidDeliD')),
    payment_type varchar(6) check (payment_type in ('online', 'cash', 'cheque')),
    Payment_date date,
    quantity integer,
    foreign key(id_goods) references goods(code_id),
    foreign key(delivery_id) references Delivery(code),
    foreign key(id_customer) references customer(code),
    primary key(id_goods, delivery_id, id_customer, submission_date));

create table customer(
    code integer not null primary key ,
    name varchar(30) not null ,
    owner varchar(30) not null ,
    phone_number varchar(15),
    address varchar(50),
    balance integer,
    registration_date date ,
    certificate_number varchar(30));

create table employee(
    employee_id integer not null primary key ,
	first_name varchar(30) not null,
	last_name varchar(30),
	marital_status integer,
	father_name varchar(30),
	mother_name varchar(30),
	national_code varchar(10),
	education varchar(30),
	employment_status varchar(30) check (employment_status in ('Permanent ', 'Temporary', 'Independent')),
	phone_number varchar(15), 
	address varchar(50),
	salary integer, 
	birth_date date, 
	gender bit, 
	role varchar(30),  
	warehouse_id integer,
	foreign key(warehouse_id) references warehouse(id));

insert into company values (1, 'company1', 'poonak sqrt' , '0212345678', 'owner1');
insert into company values (2, 'company2', 'poonak2 sqrt' , '0222345678', 'owner2');

insert into warehouse values (11, 'warehouse11', 'tajrish sqrt' , '02111234567', 'owner11', 11);
insert into warehouse values (22, 'warehouse22', 'tajrish2 sqrt' , '02122234567', 'owner22', 22);


insert into goods values (111, 1, 'goods111', 111000, '2020-01-01', '2021-01-01', 'Iran', 'Medi');
insert into goods values (222, 1, 'goods222', 222000, '2020-02-02', '2022-02-02', 'Germany', 'Heal');
insert into goods values (333, 1, 'goods333', 333000, '2020-03-03', '2023-03-03', 'France', 'Cosm');
insert into goods values (444, 2, 'goods444', 444000, '2020-04-04', '2024-04-04', 'Turkey', 'Heal');
insert into goods values (555, 2, 'goods555', 555000, '2020-05-05', '2025-05-05', 'Russia', 'Cosm');

update goods set origin = 'Iran' where goods.code_id = 222
/*be khatere forien key delete nashod case case bayad ezafe kard
delete from goods where goods.code_id = 555*/

select * from goods

insert into store values (11, 111, 1111);
insert into store values (11, 333, 2222);
insert into store values (22, 444, 3333);

insert into customer values (1111, 'customer1111', 'ownercustomer1111', '02111111345', 'vanak1 sqrt', 11110000, '2020-01-11', 111100001111);
insert into customer values (2222, 'customer2222', 'ownercustomer2222', '02112222345', 'vanak2 sqrt', 22220000, '2020-02-22', 222200002222);

insert into delivery values (11111, 'InProgress', '2020-01-21', '1111100000');
insert into delivery values (22222, 'Delivered', '2020-02-22', '2222200000');
insert into delivery values (33333, 'NotProc', '2020-03-23', '3333300000');


insert into my_order values (333, 11111, 1111, '2020-11-25', 'PaidNDeli', 'online', '2020-11-15', 13);
insert into my_order values (444, 22222, 2222, '2020-11-25', 'PaidSelfDeli', 'cash', '2020-11-15', 13);
insert into my_order values (555, 33333, 2222, '2020-11-25', 'PaidDeliD', 'cheque', '2020-11-15', 13);


insert into employee values (1111111, 'First1111111', 'Last1111111', '1','father1111111','mother1111111','1111111000',
 'bachelor of management', 'Permanent ', '11111110', 'resalat sqrt', 1111111, '1991-01-01', '0', 'manager', 11);
insert into employee values (2222222, 'First2222222', 'Last2222222', '0','father2222222','mother2222222','2222222000',
 'master of industrial', 'Temporary', '22222220', 'resalat2 sqrt', 2222222, '1992-02-02', '1', 'manager', 22);


#1
select * from store join goods on store.id_goods = goods.code_id
select * from store join goods on store.id_goods = goods.code_id join warehouse on  store.id_warehouse = warehouse.id
select * from store join warehouse on  store.id_warehouse = warehouse.id

#2
select * from store join goods on store.id_goods = goods.code_id join company on company.id = goods.company_id

#3
select * from my_order join customer on my_order.id_customer = customer.code
select * from my_order join customer on my_order.id_customer = customer.code  join goods on my_order.id_goods = goods.code_id 

#4
select * from my_order join delivery on my_order.delivery_id = delivery.code 
	join goods on my_order.id_goods = goods.code_id 
	 	where order_status = 'PaidNDeli'

#5
select * from my_order join delivery on my_order.delivery_id = delivery.code  where delivery_status = 'Delivered'

#6
select * from my_order join customer on my_order.id_customer = customer.code where order_status = 'NPaid'

#7
select * from my_order join  store on  my_order.id_goods = store.id_goods join  warehouse on warehouse.id = store.id_warehouse 

#8
select * from employee join warehouse on employee.warehouse_id = warehouse.id

#9	
select * from goods where  (Expiration_date - (SELECT CURRENT_DATE)) < 10


#10	
select name , type , count(*) from goods join my_order on goods.code_id = my_order.id_goods group by goods.type order by count(*) DESC

#11
select name , count(*)from goods join my_order on goods.code_id = my_order.id_goods group by goods.name order by count(*) DESC

#12
select name , count(*)from goods join store on goods.code_id = store.id_goods group by goods.name order by count(*) DESC

#13
select name , count(*)from goods group by goods.name order by count(*) DESC

#14
select origin , count(*)from goods group by goods.origin order by count(*) DESC


#trigger
CREATE OR REPLACE FUNCTION check_price() RETURNS trigger AS $rval$
BEGIN
	IF NEW.price > 10000000 then
		update goods set price = 10000000 where code_id = NEW.code_id;
	END IF;
	RETURN NEW;
END;
$rval$LANGUAGE 'plpgsql';	

create trigger price after insert or update on goods
for each row
EXECUTE PROCEDURE check_price();

insert into goods values (666, 2, 'goods666', 10000020, '2020-05-05', '2025-05-05', 'France', 'Cosm');
select * from goods where code_id = 666


#PROCEDURE
CREATE OR REPLACE PROCEDURE display_message (INOUT msg TEXT)
AS $$
BEGIN
RAISE NOTICE 'Procedure Parameter: %', msg ;
END ;
$$
LANGUAGE plpgsql ;
call display_message('This is my test case');


#my_curser
BEGIN;
DECLARE my_cursor CURSOR WITH HOLD FOR SELECT * FROM goods ORDER BY code_id;
COMMIT;

fetch 111 from my_cursor;
