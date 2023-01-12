package hr.main;

import java.util.List;
import java.util.Scanner;

import hr.dao.EmployeeDao;
import hr.vo.EmployeeVo;

public class HRMain01 {

	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		
		while(true) {
			System.out.print("찾고 싶은 이름을 입력하세용 : ");
			String keyword = scanner.nextLine();
			
			if("quit".equals(keyword)) {
				System.out.println("잘가용~");
				break;
			}
			
			List<EmployeeVo> list = new EmployeeDao().findByName(keyword);
			for(EmployeeVo vo : list) {
				System.out.println("사번 : " + vo.getNo() + ", 이름 : " + vo.getFirstName() + " " + vo.getLastName() + ", 입사일 : " + vo.getHireDate());
			}
		}
		scanner.close();
	}
}
