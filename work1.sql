--3.1
  --a
    select title
    from course
    where dept_name = 'Comp. Sci.'
    and credits = 3;
  --b
    select distinct s.name,s.id
    from student s,takes,teaches,instructor
    where instructor.name = 'Einstein'
    and instructor.id = teaches.id
    and teaches.course_id = takes.course_id
    and takes.id = s.id;
  --c
    select name,salary
    from instructor
    where salary in (select max(salary)
                     from instructor);
  --d
    --c中已经找出
  --e 
    select count(id),title
    from takes natural join course
    where takes.semester = 'Fall'
    and year = '2009'
    group by title;
  --f
    select max(num)
    from(select count(id) as num,title
         from takes natural join course
         where takes.semester = 'Fall'
         and year = '2009'
         group by title);
  --g
    select title,num
    from(select count(id) as num,title
         from takes natural join course
         where takes.semester = 'Fall'
         and year = '2009'
         group by title)
    where num in (select max(num)
                  from(select count(id) as num,title
                       from takes natural join course
                       where takes.semester = 'Fall'
                       and year = '2009'
                       group by title));
--3.2
  --a
    select sum(points*credits)
    from grade_points natural join takes natural join course
    where takes.id = 12345;
  --b
    select sum(points*credits)/sum(credits)
    from grade_points natural join takes natural join course
    where takes.id = 12345;    
  --c
    select id,sum(points*credits)/sum(credits) as GPA
    from grade_points natural join takes natural join course    
    group by id;
--3.3
  --a
    update instructor
    set salary = salary * 1.1
    where dept_name;
  --b
    delete from course
    where course not in section;
  --c
    insert into instructor
      select id,name,dept_name,10000
      from student
      where tot_cred > 100;
--3.4
  --a
    select distinct count(name)
    from person natural join participated natural join accident
    where accident.date = '2009';
  --b
    insert into accident values ('2016551118','04-28-2018','xtu');
  --c
    delete from car
      where license in (select license
                        from owns
                        where driver_id in (select driver_id
                                            from person
                                            where name = 'John Smitch')
                        and license in (select license
                                        from car
                                        where model = 'Mazda'););
    delete from owns
      where driver_id in (select driver_id
                          from person
                          where name = 'John Smitch')
      and license in (select license
                      from car
                      where model = 'Mazda');
  
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
    select distinct s.name
    from student s,takes t,course c
    where t.id = s.id
    and c.course_id = t.course_id
    and c.dept_name = 'Comp. Sci.';
  --b
    select name,id
    from student
    where name not in(select name
                      from student s,takes t
                      where s.id = t.id
                      and t.year < 2009);
  --c
    select max(salary),dept_name
    from instructor
    group by dept_name;
  --d
    select min(max_salary)
    from(select max(salary) max_salary,dept_name
         from instructor
         group by dept_name);
--3.12
  --a
    insert into course
      values('CS-001','Weekly Seminar',null,0);
  --b
    insert into section
      values('CS-001','1','Fall',2009,null,null,null);
  --c
    insert into takes
      select st.id,se.course_id,se.sec_id,se.semester,se.year,null
      from student st,section se
      where  student.dept_name = 'Comp. Sci.'
      and section.id = 'CS-001';
  --d
    delete from takes
      where student.name = Chavez
      and course_id = 'CS-001';
  --e
    delete from course
      where course_id = 'CS-001';
    --报错违反完整约束条件
  --f
    delete from takes
      where course_id in(select course_id
                         from course
                         where lower(title) like '%database%');
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
    from depositor d
    where not exists((select branch_name
                      from branch
                      where branch_city = 'Brooklyn')
                      except
                      (select branch_name
                       from depositor natural join account));
  --b
    select sum(amount)
    from loan;
  --c
    select branch_name
    from branch
    where assets > some(select assets
                        from branch
                        where branch_city = 'Brooklyn');
--3.16
  --a
    select employee_name
    from works
    where company_name = 'First Bank Corporation';
  --b
    select employee.employee_name,employee.city
    from employee,works,company
    where employee.employee_name = works.employee_name
    and works.company_name = company.company_name
    and company.city = employee.city;
  --c
    with managersmessage(name,city,street) as(
      select distinct employee_name,city,street
      from employee,managers
      where employee.name in (select manager_name from managers))
    select employee.employee_name,managers.manager_name
    from employee,managers,managersmessage
    where employee.employee_name = managers.employee_name
    and managers.manager_name = managersmessage.name
    and employee.city = managersmessage.city
    and employee.street = managersmessage.street;
  --d
    with avg_salary(company_name,salary) as(
      select company_name,avg(salary)
      from works
      group by company_name)
    select works.employee_name
    from works,avg_salary
    where works.company_name = avg_salary.company_name
    and works.salary > avg_salary.salary;
  --e
    select company_name,min(sum_salary)
    from (select company_name,sum(salary) as sum_salary
          from works);
--3.17
  --a
    update works
    set salary = salary * 1.10
    where company_name = 'First Bank Corporation';
  --b
    update works
    set salary = salary * 1.10
    where company_name = 'First Bank Corporation'
    and employee_name in (select manager_name from managers);
  --c
    delete from works
      where company_name = 'Small Bank Corporation';
--3.21
  --a
    select distinct member.name
    from member,book,borrowed
    where book.publisher = 'McGraw-Hill'
    and book.isbn = borrowed.isbn
    and borrowed.memb_no = member.memb_no;
  --b
    select member.name
    from member a 
    where not exists((select isbn 
                      from book
                      where publisher = 'McGraw-Hill' )
                      except(
                      select isbn
                      from borrowed
                      where borrowed.memb_no = a.memb_no));
  --c
    select 
  --d
    select 
      (select count(*) from borrowed)/
      (select count(*) from member);
--3.23
  --
--3.24
    select dept_name
    from (
      select dept_name,sum(salary) as sum_salary
      from instructor
      group by dept_name
    )
    where sum_salary >= avg_salary in (
      select avg(salary) as avg_salary
      from (
        select dept_name,sum(salary) as sum_salary
        from instructor
        group by dept_name  
      )
    );
