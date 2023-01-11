-- 서브쿼리(SUBQUERY) SQL

-- 문제1. ok
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?

-- (salaries 테이블)
select * 
from salaries
where to_date = '9999-01-01'
order by emp_no asc;

-- (평균 급여)
select avg(salary)
from salaries
where to_date = '9999-01-01';

-- Solution (현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명)
select count(emp_no)
from salaries
where to_date = '9999-01-01'
	and salary > (
				select avg(salary)
				from salaries
				where to_date = '9999-01-01'
				);
	

-- 문제2.(x) ok
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 급여를 조회하세요.
-- 단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 

select c.dept_no, a.emp_no, a.first_name, b.salary
from employees a join salaries b join dept_emp c
	on  a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
group by c.dept_no
having (
		select max(salary)
		from salaries
		)
order by b.salary desc;


-- 문제3. ok
-- 현재, 자신의 부서 평균 급여보다 급여 많은 사원의 사번, 이름과 급여를 조회하세요 

-- (현재 부서별 평균 급여)
select a.dept_no, avg(b.salary) as avg_salary
from dept_emp a join salaries b
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by a.dept_no;

-- Solution (현재, 자신의 부서 평균 급여보다 급여 많은 사원의 사번, 이름과 급여)
select a.emp_no, a.first_name, a.last_name, b.salary
from employees a 
	join salaries b 
	join dept_emp c 
    join departments d
    join (
			select a.dept_no, avg(b.salary) as avg_salary
			from dept_emp a join salaries b
				on a.emp_no = b.emp_no
			where a.to_date = '9999-01-01'
				and b.to_date = '9999-01-01'
			group by a.dept_no
		 ) e
	on  a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
    and c.dept_no = d.dept_no
    and d.dept_no = e.dept_no
where b.salary > e.avg_salary
	and c.dept_no = e.dept_no
    and b.to_date = '9999-01-01'
    and c.to_date = '9999-01-01'
order by a.emp_no;


-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.

-- (부서 테이블)
select *
from departments
order by dept_no asc;

-- (현재 매니저 테이블)
select *
from dept_manager
where to_date = '9999-01-01';

-- (현재 메니저 들의 이름)
select a.first_name, a.last_name, b.emp_no
from employees a join dept_manager b
	on a.emp_no = b.emp_no
where b.to_date = '9999-01-01'
order by a.emp_no;


-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select a.empno, a.empfirstname, a.emplastname, b.managerfirstname, b.managerlastname, a.empdept
from (
		select b.emp_no as 'empno', a.dept_name as 'empdept', b.first_name as 'empfirstname', b.last_name as 'emplastname', d.dept_no as 'dept1'
		from departments a join employees b join dept_emp d 
			on a.dept_no = d.dept_no
			and b.emp_no = d.emp_no
			and d.to_date = '9999-01-01'
	 ) a left join (
							select a.dept_no as 'dept2', c.first_name as 'managerfirstname', c.last_name as 'managerlastname'
							from dept_manager a join employees c
								on a.emp_no = c.emp_no
							where a.to_date = '9999-01-01'
						 ) b
	on a.dept1 = b.dept2
order by a.empno asc;


-- 문제5. ok(check)
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 급여를 조회하고 급여순으로 출력하세요.

-- (부서 테이블)
select *
from departments
order by dept_no;

-- (부서별 평균 연봉)
select b.dept_no, avg(a.salary) as avg_salary
from salaries a join dept_emp b
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b. to_date = '9999-01-01'
group by b.dept_no
order by avg_salary desc;

-- (부서 중 가장 높은 평균 연봉)
select max(a.avg_salary)
from (
		select b.dept_no as 'dept', avg(a.salary) as avg_salary
		from salaries a join dept_emp b
			on a.emp_no = b.emp_no
		where a.to_date = '9999-01-01'
			and b. to_date = '9999-01-01'
		group by b.dept_no
		) a;

-- (가장 높은 연봉의 부서)
select b.dept_no
from salaries a join dept_emp b
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b. to_date = '9999-01-01'
group by b.dept_no
having avg(a.salary) = (
							select max(a.avg_salary)
								from (
										select b.dept_no as 'dept', avg(a.salary) as avg_salary
										from salaries a join dept_emp b
											on a.emp_no = b.emp_no
										where a.to_date = '9999-01-01'
											and b. to_date = '9999-01-01'
										group by b.dept_no
										) a
						);
                        
-- Solution (현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 급여를 조회하고 급여순)
select a.emp_no, a.first_name, a.last_name, b.title, c.salary
from employees a join titles b join salaries c join dept_emp d
	on a.emp_no = b.emp_no
    and b.emp_no = c.emp_no
    and c.emp_no = d.emp_no
where b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
    and d.to_date = '9999-01-01'
    and d.dept_no = (
						select b.dept_no
						from salaries a join dept_emp b
							on a.emp_no = b.emp_no
						where a.to_date = '9999-01-01'
							and b. to_date = '9999-01-01'
						group by b.dept_no
						having avg(a.salary) = (
												select max(a.avg_salary)
												from (
														select b.dept_no as 'dept', avg(a.salary) as avg_salary
														from salaries a join dept_emp b
															on a.emp_no = b.emp_no
														where a.to_date = '9999-01-01'
															and b. to_date = '9999-01-01'
														group by b.dept_no
													) a
												)
					)
order by c.salary desc;

        

-- 문제6.
-- 평균 급여가 가장 높은 부서는?
-- 부서이름, 평균급여 

-- (부서)
select *
from departments
order by dept_no asc;

-- (부서별 평균 급여)
select b.dept_no as 'dept', avg(a.salary) as avg_salary
from salaries a join dept_emp b
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by b.dept_no
order by avg_salary desc;

-- (부서별 평균 급여 + 부서 이름)
select b.dept_no as 'dept_no', c.dept_name, avg(a.salary) as avg_salary
from salaries a join dept_emp b join departments c
	on a.emp_no = b.emp_no
    and b.dept_no = c.dept_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by b.dept_no
order by avg_salary desc;

-- (부서 중 가장 높은 평균 급여)
select max(sub2.avg_salary) as 'avg_salary'
from (
		select b.dept_no as 'dept', avg(a.salary) as avg_salary
		from salaries a join dept_emp b
			on a.emp_no = b.emp_no
		where a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
		group by b.dept_no
		) sub2;

-- sulution (평균 급여가 가장 높은 부서를 부서이름, 평균급여 순으로)
select c.dept_name, avg(a.salary) as avg_salary1
from salaries a join dept_emp b join departments c
	on a.emp_no = b.emp_no
    and b.dept_no = c.dept_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by b.dept_no
having avg_salary1 = (
						select max(sub2.avg_salary) as 'avg_salary'
						from (
								select b.dept_no as 'dept', avg(a.salary) as avg_salary
								from salaries a join dept_emp b
									on a.emp_no = b.emp_no
								where a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
								group by b.dept_no
								) sub2
						);

-- 문제7.
-- 평균 급여가 가장 높은 직책?
-- 직책, 평균급여 

-- (직책별 평균 연봉)
select b.title as 'ti', avg(a.salary) as avg_salary
from salaries a join titles b
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by b.title
order by avg_salary desc;

-- (가장 높은 직책의 연봉)
select max(c.avg_salary) as max_avg_salary
from (
		select b.title as 'ti', avg(a.salary) as avg_salary
		from salaries a join titles b
			on a.emp_no = b.emp_no
		where a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
		group by b.title
		) c;

select *
from  (
		select b.title as 'title', avg(a.salary) as 'avg_salary'
		from salaries a join titles b
			on a.emp_no = b.emp_no
		where a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
		group by b.title
		) s1
where s1.avg_salary = (
						select max(s2.avg_salary) as max_avg_salary
						from (
								select b.title as 'ti', avg(a.salary) as avg_salary
								from salaries a join titles b
									on a.emp_no = b.emp_no
								where a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
								group by b.title	
								) s2
				);


-- 문제8.
-- 현재 자신의 매니저보다 높은 급여를 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 매니저 급여순으로 출력합니다.

-- (현재 매니저)
select *
from dept_manager
where to_date = '9999-01-01'
order by emp_no asc;

-- (현재 매니저 연봉)
select a.emp_no, a.dept_no, b.salary
from dept_manager a join salaries b
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
order by a.emp_no asc;

-- (현재 매니저 연봉 + 이름)
select a.dept_no as 'dept2', b.salary, c.first_name, c.last_name
from dept_manager a join salaries b join employees c
	on a.emp_no = b.emp_no
    and b.emp_no = c.emp_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
order by a.emp_no asc;




-- (직원 이름 + 부서 + 부서 번호 + 급여)
select b.emp_no, a.dept_name, b.first_name, b.last_name, c.salary, d.dept_no as 'dept1'
from departments a join employees b join salaries c join dept_emp d 
	on a.dept_no = d.dept_no
    and b.emp_no = d.emp_no
    and c.emp_no = d.emp_no
where c.to_date = '9999-01-01'
	and d.to_date = '9999-01-01'
order by b.emp_no asc;

-- 현재 자신의 매니저보다 높은 급여를 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 매니저 급여순으로 출력합니다.
select a.empdept, a.empfirstname, a.emplastname, a.empsalary, b.managerfirstname, b.managerlastname, b.managersalary
from (
		select b.emp_no as 'empno', a.dept_name as 'empdept', b.first_name as 'empfirstname', b.last_name as 'emplastname', c.salary as 'empsalary', d.dept_no as 'dept1'
		from departments a join employees b join salaries c join dept_emp d 
			on a.dept_no = d.dept_no
			and b.emp_no = d.emp_no
			and c.emp_no = d.emp_no
		where c.to_date = '9999-01-01'
			and d.to_date = '9999-01-01'
	 ) a left join (
							select a.dept_no as 'dept2', b.salary as 'managersalary', c.first_name as 'managerfirstname', c.last_name as 'managerlastname'
							from dept_manager a join salaries b join employees c
								on a.emp_no = b.emp_no
								and b.emp_no = c.emp_no
							where a.to_date = '9999-01-01'
								and b.to_date = '9999-01-01'
						 ) b
	on a.dept1 = b.dept2
where a.empsalary > b.managersalary
order by a.empdept asc;


show processlist;
kill 2;

