package bookmall.dao.test;

import java.util.List;

import bookmall.dao.OrdersDao;
import bookmall.vo.OrdersVo;

public class OrdersDaoTest {
	public static void main(String[] args) {
//		testInsert();
		testFindAll(1L);
	}

	private static void testInsert() {
		OrdersVo vo = null;
		OrdersDao dao = new OrdersDao();
		
		vo = new OrdersVo();
		vo.setUserNo(1L);
		vo.setAddress("카스카베시 떡잎마을");
		dao.insert(vo);
	}
	
	private static void testFindAll(Long no) {
		List<OrdersVo> list = new OrdersDao().findAll(1L);
		for(OrdersVo vo : list) {
			System.out.println(vo);
		}
	}
}
