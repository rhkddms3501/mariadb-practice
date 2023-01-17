package bookmall.main;

import java.util.List;

import bookmall.dao.BookDao;
import bookmall.dao.CartDao;
import bookmall.dao.CategoryDao;
import bookmall.dao.OrderBookDao;
import bookmall.dao.OrdersDao;
import bookmall.dao.UserDao;
import bookmall.vo.BookVo;
import bookmall.vo.CartVo;
import bookmall.vo.CategoryVo;
import bookmall.vo.OrderBookVo;
import bookmall.vo.OrdersVo;
import bookmall.vo.UserVo;

public class BookMall {
	public static void main(String[] args) {		
		displayUserInfo();
		
		displayCategoryInfo();
		
		displayBookInfo();
		
		displayCartInfo();
		
		displayOrderInfo();
		
		displayOrderBookInfo();
	}

	private static void displayUserInfo() {
		List<UserVo> list = new UserDao().findAll();
		System.out.println("======================================== 유저 ========================================");
		for(UserVo vo : list) {
//			System.out.println(vo.toString());
			System.out.printf("이름: %s  전화번호: %s  이메일: %s  비밀번호: %s", vo.getName(), vo.getPhone(), vo.getEmail(), vo.getPassword());
			System.out.println();
		}
		System.out.println();
	}

	private static void displayCategoryInfo() {
		List<CategoryVo> list = new CategoryDao().findAll();
		System.out.println("======================================== 카테고리 ========================================");
		for(CategoryVo vo : list) {
//			System.out.println(vo.toString());
			System.out.printf("카테고리: %s", vo.getType());
			System.out.println();
		}
		System.out.println();
	}

	private static void displayBookInfo() {
		List<BookVo> list = new BookDao().findAll();
		System.out.println("======================================== 상품 ========================================");
		for(BookVo vo : list) {
//			System.out.println(vo.toString());
			System.out.printf("도서제목: %s  가격: %d", vo.getTitle(), vo.getPrice());
			System.out.println();
		}
		System.out.println();
	}

	private static void displayCartInfo() {
		List<CartVo> list = new CartDao().findAll(1L);
		System.out.println("======================================== 장바구니 ========================================");
		for(CartVo vo : list) {
//			System.out.println(vo.toString());
			System.out.printf("도서제목: %s  가격: %d  수량: %d", vo.getBookTitle(), vo.getBookPrice(), vo.getCount());
			System.out.println();
		}
		System.out.println();
	}

	private static void displayOrderInfo() {
		List<OrdersVo> list = new OrdersDao().findAll(1L);
		System.out.println("======================================== 주문 ========================================");
		for(OrdersVo vo : list) {
//			System.out.println(vo.toString());
			System.out.printf("주문번호: %d  주문자: %s  이메일: %s  결제금액: %d  배송지: %s", vo.getNo(), vo.getUserName(), vo.getUserEmail(), vo.getPrice(), vo.getAddress());
			System.out.println();
		}
		System.out.println();
	}

	private static void displayOrderBookInfo() {
		List<OrderBookVo> list = new OrderBookDao().findAll(1L);
		System.out.println("======================================== 주문 책 ========================================");
		for(OrderBookVo vo : list) {
//			System.out.println(vo.toString());
			System.out.printf("도서번호: %d  도서제목: %s 수량: %d", vo.getBookNo(), vo.getBookTitle(), vo.getCount());
			System.out.println();
		}
		System.out.println();
	}
}
