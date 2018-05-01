

--3.5
	--a
		select *,elt(Interval(score,0,40,60,80),'F','C','B','A') as level --此处用到了我在网上找的elt和interval函数
		from marks;
	--b
		select elt(Interval(score,0,40,60,80),'F','C','B','A') as level,count(*)
		from marks;
		group by level;
--3.6
		select dept_name
		from department
		where lower(dept_name) like '%sci%';
--3.7
		--r1,r2不都为空时
--3.8
	--a
		select customer_name
		from depositor
		where account_number not in(select account_number
															  from borrower natural join loan
																where loan.amount <> 0);
	--b
		select customer_name
		from customer
		where customer_street in (select customer_street
															from customer
															where customer_name = 'Smith')
		and customer_city in (select customer_city
													from customer
													where customer_name = 'Smith');
	--c
		select branch_name
		from account
		where account_number in (select account_number
														 from account natural join depositor natural join customer
														 where customer_street = 'Harrison');
--3.9
	--a
		select employee_name,city 
		from employee natural join works
		where company_name = 'First Bank Corporation';
	--b
		select employee_name,city,street
		from employee natural join works
		where salary > 10000
		and company_name = 'First Bank Corporation';
	--c
		select employee_name
		from employee natural join managers
		where manager_name <> 'First Bank Corporation';
	--d
		select employee_name
		from employee natural join works
		where salary > (select max(salary)
										from works
										where company_name = 'Small Bank Corporation');
	--e
		select company_name,city
		from company
		where company_name = 'Small Bank Corporation';
	--f
		select company_name,max(employee_count)
		from (select count(employee) as employee_count,company_name
					from works);
	--g
		select company_name
		from works
		where salary > (select avg(salary)
										from works);
--3.10
	--a
		update employee
			set city = 'Newtown'
			where employee_name = 'Jones';
		update employee
			set street = null
			where employee_name = 'Jones';
	--b
		update works
			set salary = case
				when salary >100000 then salary * 1.03
				else salary * 1.10;
--3.11
	--a


--3.13
		create table person (
			driver_id  varchar(20),
			name  varchar(20) not null,
			address  varchar(1111),
			primary key (driver_id));

		create table car(
			license  varchar(20),
			model  varchar(20),
			year  varchar(20),
			primary key (license));

		create table accident(
			report_number  varchar(20),
			date  varchar(20),
			location  varchar(1111),
			primary key (report_number));

		create table owns(
			driver_id  varchar(20),
			license  varchar(20),
			primary key (driver_id),
			foregin key (driver_id) references person,
			foregin key (license) references car);

		create table participated(
			report_number varchar(20),
			license  varchar(20),
			driver_id varchar(20),
			damage_amount numeric(8,2)
			primary key (report_number,license),
			foregin key (report_number) references accident,
			foregin key (license) references car);
--3.14
	--a
		select count(*)
		from accident natural join participated
		where license in (select license
											from car natural join owns natural join person
											where name = 'John Smith');
	--b
		update participated
			set damage_amount = 3000
			where report_number = 'AR2197'
			and license = 'AABB2000';
--3.15
	--a 
		select customer_name
		from 
