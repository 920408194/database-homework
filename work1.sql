

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
