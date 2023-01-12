package hr.main;

import java.util.List;
import java.util.Scanner;

import hr.dao.EmployeeDao;
import hr.vo.EmployeeVo;

public class HRMain02 {

	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		
			
			System.out.print("찾고 싶은 급여의 범위 \"min\" ~ \"max\" 를 입력해주세용 : ");
		
			int minSalary = scanner.nextInt();
			int maxSalary = scanner.nextInt();
			
			
			List<EmployeeVo> list = new EmployeeDao().findBySalary(minSalary, maxSalary);
			for(EmployeeVo vo : list) {
				System.out.println("사번 : " + vo.getNo() + ", 이름 : " + vo.getFirstName() + " " + vo.getLastName() + ", 입사일 : " + vo.getHireDate());
			}
		scanner.close();
	}
}
