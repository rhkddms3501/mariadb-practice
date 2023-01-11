package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class UpdateTest {

	public static void main(String[] args) {
		DeptVo vo = new DeptVo();
		vo.setNo(1L);
		vo.setName("경영지원");
		
		Boolean result = update(vo);
		System.out.println(result ? "성공" : "실패");
	}

	private static boolean update(DeptVo vo) {
		
		Connection conn = null;
		Statement stmt = null;
		boolean result = false;

		try {
			/* 1. JDBC Driver Class 로딩 */
			Class.forName("org.mariadb.jdbc.Driver");

			/* 2. 연결 */
			String url = "jdbc:mariadb://192.168.10.116:3307/webdb?charset=utf8";
			// DriverManager.getConnection(url, 계정, 비밀번호);
			conn = DriverManager.getConnection(url, "webdb", "webdb");

			/* 3. Statement 생성 */
			stmt = conn.createStatement();

			/* 4. SQL 실행 */
			String sql = 
					"update dept " + 
					"set name= '" + vo.getName() + "' " + 
					"where no = " + vo.getNo(); 

			// 인서트는 결과값이 없어서 ResultSet 안씀
			int count = stmt.executeUpdate(sql);

			/* 5. 결과처리 */
			result = count == 1;

		} catch (ClassNotFoundException e) {
			System.out.println("1. JDBC Driver Loading Fail: " + e);
		} catch (SQLException e) {
			System.out.println("2. Connection Fail: " + e);
		} finally {
			// 닫을 때는 낮은것 부터 큰거 순으로.
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("2-1. Connection close Fail: " + e);
			}
		}
		return result;
		
	}
}
