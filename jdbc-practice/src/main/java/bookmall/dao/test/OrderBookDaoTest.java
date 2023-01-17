package bookmall.dao.test;

import java.util.List;

import bookmall.dao.OrderBookDao;
import bookmall.vo.OrderBookVo;


public class OrderBookDaoTest {
	public static void main(String[] args) {
//		testInsert();
		testFindAll(1L);
	}

	private static void testInsert() {
		OrderBookVo vo = null;
		OrderBookDao dao = new OrderBookDao();
		
		vo = new OrderBookVo();
		dao.insert(1L, 1L);
	}
	
	private static void testFindAll(Long ordersNo) {
		List<OrderBookVo> list = new OrderBookDao().findAll(ordersNo);
		for(OrderBookVo vo : list) {
			System.out.println(vo);
		}
	}
}
