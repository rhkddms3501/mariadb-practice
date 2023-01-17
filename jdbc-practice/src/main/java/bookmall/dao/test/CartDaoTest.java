package bookmall.dao.test;

import java.util.List;

import bookmall.dao.CartDao;
import bookmall.vo.CartVo;

public class CartDaoTest {
	public static void main(String[] args) {
//		testInsert();
		testFindAll(1L);
	}

	private static void testInsert() {
		CartVo vo = null;
		CartDao dao = new CartDao();
		
		vo = new CartVo();
		vo.setCount(3L);
		vo.setBookNo(1L);
		vo.setUserNo(1L);
		dao.insert(vo);
		
		vo = new CartVo();
		vo.setCount(1L);
		vo.setBookNo(2L);
		vo.setUserNo(1L);
		dao.insert(vo);
	}
	
	private static void testFindAll(Long no) {
		List<CartVo> list = new CartDao().findAll(no);
		for(CartVo vo : list) {
			System.out.println(vo);
		}
	}
}
