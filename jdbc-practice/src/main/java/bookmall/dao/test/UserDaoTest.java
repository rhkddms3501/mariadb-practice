package bookmall.dao.test;

import java.util.List;

import bookmall.dao.UserDao;
import bookmall.vo.UserVo;

public class UserDaoTest {

	public static void main(String[] args) {
//		testInsert();
		testFindAll();
	}

	private static void testInsert() {
		UserVo vo = null;
		UserDao dao = new UserDao();
		
		vo = new UserVo();
		vo.setName("짱구");
		vo.setEmail("짱구@naver.com");
		vo.setPhone("010-1234-1234");
		vo.setPassword("떡잎방범대");
		dao.insert(vo);
		
		vo = new UserVo();
		vo.setName("홍길동");
		vo.setEmail("길동@naver.com");
		vo.setPhone("010-5678-5678");
		vo.setPassword("아버지를아버지라");
		dao.insert(vo);
	}
	
	private static void testFindAll() {
		List<UserVo> list = new UserDao().findAll();
		for(UserVo vo : list) {
			System.out.println(vo);
		}
	}
}
