--4.1
	--a
		select instructor.id,instructor.name,teaches.course_id
		from instructor natural left outer join teaches;
  --b
			select instructor.id,instructor.name,teaches.course_id
  		from teaches,instructor
  		where teaches.id = instructor.id
  		union
  		select instructor.id,instructor.name, '0' as course_id;
  		from teaches ,instructor
  		where instructor.id not in(select id from teaches);
  --c
  	select teaches.course_id,instructor.name
  	from instructor,teaches
  	where teaches.id = instructor.id;
  	union 
  	select teaches.course_id,'-' as instructor.name
  	from instructor,teaches
  	where teaches.id not in (select id from instructor);
  --d
  	select dept_name,count(*)
  	from department natural left outer join instructor
  	group by dept_name;
 --4.2
 	--a
 		select *
 		from student,takes
 		where takes.ID = student.ID
 		union
 		select *
 		from student,takes
 		where select.ID not in (select ID from takes)
 	--b
 		select *
 		from student,takes
 		where takes.ID = student.ID
 		union
 		select *
 		from student,takes
 		where student.ID not in (select ID from takes)
 		union
 		select *
 		from student,takes
 		where takes.ID not in (select ID from student);
 --4.3


 --4.5
 	create view student_grades as 
 		select id,sum(points*credits)/sum(credits) as GPA
    from grade_points natural right outer join takes natural join course    
    group by id;
  --4.8
  	--a
  		create assertion instructor_class check
  			(not exist (select a.ID,b.course_id
  									from teaches a,section b,time_slot c
  									where a.course_id = b.course_id
										and b.time_slot_id = c.time_slot_id
										and a.ID in (select ID
																 from )))

--4.9
	