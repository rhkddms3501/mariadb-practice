-- outer Join

-- desc emp;
-- insert into dept values(null, '총무');
-- insert into dept values(null, '개발');
-- insert into dept values(null, '영업');
-- insert into dept values(null, '기획');

-- select * from dept;

-- insert into emp values(null, '짱구', 1);
-- insert into emp values(null, '철수', 2);
-- insert into emp values(null, '유리', 3);
-- insert into emp values(null, '맹구', null);

-- select * from emp;

select a.name, b.name
from emp a join dept b
	on a.dept_no = b.no;
    
-- left join
select a.name as '사원', ifnull(b.name, '사장') as '부서'
from emp a left join dept b
	on a.dept_no = b.no;


-- right join
select ifnull(a.name, '-') as '사원', b.name as '부서'
from emp a right join dept b
	on a.dept_no = b.no;    

