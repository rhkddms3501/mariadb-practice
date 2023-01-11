-- subquery
--
-- 1) select 절 서브쿼리
--

--
-- 2) from 절 서브쿼리
--
select now() as n, sysdate() as s, 3 + 1 as r from dual;

select a.n, a.r
from(select now() as n, sysdate() as s, 3 + 1 as r from dual) a;

--
-- 3) where(having) 절 서브쿼리
--
-- 예제) 현제, Fai Bale이 근무하는 부서에서 근무하는 다른 직원의 사번, 이름을 출력 하세요.
select d.dept_no
from employees e join dept_emp d
	on e.emp_no = d.emp_no
where d.to_date = '9999-01-01'
	and concat(e.first_name, ' ', e.last_name) = 'Fai Bale';
    
select e.emp_no, e.first_name
from employees e join dept_emp d
	on e.emp_no = d.emp_no
where d.to_date = '9999-01-01'
	and d.dept_no = 'd004';    
    
select e.emp_no, e.first_name
from employees e join dept_emp d
	on e.emp_no = d.emp_no
where d.to_date = '9999-01-01'
	and d.dept_no = (
					select d.dept_no
					from employees e join dept_emp d
						on e.emp_no = d.emp_no
					where d.to_date = '9999-01-01'
						and concat(e.first_name, ' ', e.last_name) = 'Fai Bale'
                    );  
                    
-- 3.1) 단일행 연산자: =, >, <, >=, <=, <>, !=
-- 실습문제 1
-- 현재, 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름과 급여를 출력하세요.
select avg(salary)
from salaries
where to_date = '9999-01-01';

select a.first_name, b.salary
from employees a join salaries b
	on a.emp_no = b.emp_no
where b.to_date = '9999-01-01'
	and b.salary < (
					select avg(salary)
					from salaries
					where to_date = '9999-01-01'
					)
order by b.salary desc;

-- 실습문제 2
-- 현재, 가장 적은 평균 급여의 직책과 그 평균 급여를 출력하세요.
-- ex) 출력 : Enginner 20000

-- 1) 직책별 평균 급여
select title, avg(b.salary) as 'avg_salary'
from titles a join salaries b
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by a.title;

-- 2) 직책별 가장 적은 평균 급여
select min(a.avg_salary)
from (
		select title, avg(b.salary) as 'avg_salary'
		from titles a join salaries b
			on a.emp_no = b.emp_no
		where a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
		group by a.title
		) a;

-- 3) solutin 1 (sub-query)
select title, avg(b.salary) as 'avg_salary'
from titles a join salaries b
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by a.title
having avg_salary = (
						select min(a.avg_salary)
						from (
								select title, avg(b.salary) as 'avg_salary'
								from titles a join salaries b
									on a.emp_no = b.emp_no
								where a.to_date = '9999-01-01'
									and b.to_date = '9999-01-01'
								group by a.title
								) a
						);
                        
-- 4) solutin 2 (top-k)
select title, avg(b.salary) as 'avg_salary'
from titles a join salaries b
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by a.title
order by avg_salary asc
limit 0, 1;


-- 3.2) 복수행 연산자: in, not in, 비교연산자any, 비교연산자all
-- any 사용법
-- 1. =any : in
-- 2. >any, >=any : 최소값
-- 3. <any, <=any : 최대값
-- 4. <>any, !=any : not in
--
-- all 사용법
-- 1. =all : (x)
-- 2. >all, >=all : 최대값
-- 3. <all, <=all : 최소값
-- 4. <>all, !=all : 모두 다르다..?
--
-- 실습문제 3:
-- 현재 급여가 5000이상인 직원의 이름과 급여를 출력하세요.
-- ex) 출력 : 짱구 6000
--           짱아 8000

-- solution 1) join
SELECT 
    a.first_name, b.salary
FROM
    employees a JOIN salaries b 
    ON a.emp_no = b.emp_no
WHERE
		b.to_date = '9999-01-01'
	AND b.salary > 50000
ORDER BY b.salary ASC;
--
-- solution 2) sub_query
-- sub-query
select emp_no, salary
from salaries
where to_date = '9999-01-01'
	and salary > 50000;
    
-- in 사용
SELECT a.first_name, b.salary
FROM employees a JOIN salaries b 
    ON a.emp_no = b.emp_no
WHERE b.to_date = '9999-01-01'
	AND (a.emp_no, b.salary) in 
								(
									select emp_no, salary
									from salaries
									where to_date = '9999-01-01'
									and salary > 50000
								)
ORDER BY b.salary ASC;

-- any 사용
SELECT a.first_name, b.salary
FROM employees a JOIN salaries b 
    ON a.emp_no = b.emp_no
WHERE b.to_date = '9999-01-01'
	AND (a.emp_no, b.salary) =any 
								(
									select emp_no, salary
									from salaries
									where to_date = '9999-01-01'
									and salary > 50000
								)
ORDER BY b.salary ASC;
--
-- 실습문제 4: 현재, 각 부서별로 최고 급여를 받고 있는 직원의 이름과 월급을 출력하세요.
-- ex) 출력 : 총무팀 짱구 3000
--           개발팀 철수 4000

select   a.dept_no, max(b.salary)
from     dept_emp a join salaries b
	  on a.emp_no = b.emp_no
where    a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
group by a.dept_no;
    
    
-- solution 1) where절 sub_query(in)
SELECT a.dept_name, c.first_name, d.salary
FROM   departments a, dept_emp b, employees c, salaries d
WHERE  a.dept_no = b.dept_no
   AND b.emp_no = c.emp_no
   AND c.emp_no = d.emp_no
   AND b.to_date = '9999-01-01'
   AND d.to_date = '9999-01-01'
   AND (a.dept_no, d.salary) in (
									SELECT   a.dept_no, max(b.salary)
									FROM     dept_emp a JOIN salaries b
										  ON a.emp_no = b.emp_no
									WHERE    a.to_date = '9999-01-01'
										 AND b.to_date = '9999-01-01'
									GROUP BY a.dept_no
								);

-- solution 2) from절 sub_query join
SELECT a.dept_name, c.first_name, d.salary
FROM   departments a,
	   dept_emp b,
	   employees c,
       salaries d,
       (
			SELECT   a.dept_no, max(b.salary) as max_salary
			FROM     dept_emp a JOIN salaries b
				  ON a.emp_no = b.emp_no
			WHERE    a.to_date = '9999-01-01'
			     AND b.to_date = '9999-01-01'
			GROUP BY a.dept_no
       ) e
WHERE  a.dept_no = b.dept_no
   AND b.emp_no = c.emp_no
   AND c.emp_no = d.emp_no
   AND a.dept_no = e.dept_no
   AND b.to_date = '9999-01-01'
   AND d.to_date = '9999-01-01'
   AND d.salary = e.max_salary;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    