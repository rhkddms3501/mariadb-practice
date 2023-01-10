-- inner join

-- 예제1) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력 하세요.
-- equljoin
select a.first_name, b.title
from employees a, titles b
where a.emp_no = b.emp_no     	        -- join 조건 (n-1)
	and b.to_date = '9999-01-01';       -- row 선택 조건


-- 예제2) 현재, 근무하고 잇는 직원의 이름과 직책을 출력하되 여성 엔지니어(Engineer)만 출력하세요.
select a.first_name,a.gender, b.title
from employees a, titles b
where a.emp_no = b.emp_no               -- join 조건 (n-1)
	and b.to_date = '9999-01-01'        -- row 선택 조건 1
    and a.gender = 'f'                  -- row 선택 조건 2
    and b.title = 'Engineer';           -- row 선택 조건 3

        
--
-- ANSI/ISO SQL1999 JOIN 표준 문법
--

-- 1) Natural Join (쓸 일 없다.)
--     조인 대상이 되는 두 테이블에 이름이 같은 공통 컬럼이 있으면 조인 조건을alter
--     명시하지 않고 암묵적으로 조인이 된다.
select a.first_name, b.title
from employees a join titles b on a.emp_no = b.emp_no  -- join 조건 (n-1)
where b.to_date = '9999-01-01';  -- row 선택 조건

select a.first_name, b.title
from employees a natural join titles b  -- join 조건 (n-1)
where b.to_date = '9999-01-01';  -- row 선택 조건


-- 2) Join ~ Using (쓸 일 없다.)
--     natural join의 문제점
select count(*)
from salaries a natural join titles b
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01';

select count(*)
from salaries a join titles b using(emp_no)
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01';


-- 3) Join ~ on (이걸 쓰자!)
-- 예제) 현재, 직책별 평균 연봉을 큰 순서대로 출력 하세요.
select b.title, avg(a.salary) as avg_salary
from salaries a join titles b on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by b.title
order by avg_salary desc;


-- 실습문제 (1)
-- 현재, 직원별 근무 부서를 사번, 직원 이름, 부서명 순으로 출력하세요.
select a.emp_no, concat(a.first_name, ' ', a.last_name) as emp_name, b.dept_name
from employees a join departments b join dept_emp c 
	on a.emp_no = c.emp_no and b.dept_no = c.dept_no
where c.to_date = '9999-01-01'
order by a.emp_no asc;


-- 실습문제 (2)
-- 현재, 지급되고 있는 급여를 사번, 이름, 급여 순으로 출력하세요.
select a.emp_no, concat(a.first_name, ' ', a.last_name) as emp_name, b.salary
from employees a join salaries b 
	on a.emp_no = b.emp_no
where b.to_date = '9999-01-01';


-- 실습문제 (3)
-- 현재, 직책별 평균연봉, 직책 별 직원 수가 100명 이상인 직원 수를 직책, 평균연봉, 직원 수 순으로 출력하세요.
select a.title, avg(b.salary) as avg_salary, count(a.emp_no) as count_emp_no
from titles a join salaries b 
	on a.emp_no = b.emp_no
where a.to_date = '9999-01-01' 
	and b.to_date = '9999-01-01'
group by a.title
having count(a.emp_no) >= 100;


-- 실습문제 (4)
-- 현재, 부서별로 직책이 Engineer 직원들에 대해서만 평균 급여를 부서이름, 평균급여 순으로 출력하세요.
select a.dept_name, avg(c.salary) as avg_salary
from departments a join dept_emp b join salaries c join titles d
	on a. dept_no = b.dept_no
		and b.emp_no = c.emp_no
		and c.emp_no = d.emp_no
where d.title = 'Engineer' 
	and b.to_date = '9999-01-01' 
	and c.to_date = '9999-01-01' 
    and d.to_date = '9999-01-01'
group by a.dept_name
order by avg_salary desc;



        