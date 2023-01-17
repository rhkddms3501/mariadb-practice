package bookmall.dao.test;

import java.util.List;

import bookmall.dao.CategoryDao;
import bookmall.vo.CategoryVo;


public class CategoryDaoTest {

	public static void main(String[] args) {
//		testInsert();
		testFindAll();
	}

	private static void testInsert() {
		CategoryVo vo = null;
		CategoryDao dao = new CategoryDao();
		
		vo = new CategoryVo();
		vo.setType("만화책");
		dao.insert(vo);
		
		vo = new CategoryVo();
		vo.setType("고전소설");
		dao.insert(vo);
		
		vo = new CategoryVo();
		vo.setType("시");
		dao.insert(vo);
	}
	
	private static void testFindAll() {
		List<CategoryVo> list = new CategoryDao().findAll();
		for(CategoryVo vo : list) {
			System.out.println(vo);
		}
	}
}
