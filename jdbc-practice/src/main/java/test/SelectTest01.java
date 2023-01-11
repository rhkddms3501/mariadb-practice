package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SelectTest01 {
	public static void main(String[] args) {
		search("pat");
	}

	public static void search(String keyword) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			/* 1. JDBC Driver Class 로딩 */
			Class.forName("org.mariadb.jdbc.Driver");

			/* 2. 연결 */
			String url = "jdbc:mariadb://192.168.10.116:3307/employees?charset=utf8";
			// DriverManager.getConnection(url, 계정, 비밀번호);
			conn = DriverManager.getConnection(url, "hr", "hr");

			/* 3. Statement 생성 */
			stmt = conn.createStatement();

			/* 4. SQL 실행 */
			String sql = 
					"select emp_no, first_name, last_name " + 
					"from employees " + 
					"where first_name like '%" + keyword + "%'";

			// ResultSet에 결과데이터 담음.
			rs = stmt.executeQuery(sql);

			/* 5. 결과 처리 */
			while (rs.next()) {
				Long empNo = rs.getLong(1);
				String first_name = rs.getString(2);
				String last_name = rs.getString(3);
				
				System.out.println(empNo + ", " + first_name + " " + last_name);
			}

		} catch (ClassNotFoundException e) {
			System.out.println("1. JDBC Driver Loading Fail: " + e);
		} catch (SQLException e) {
			System.out.println("2. Connection Fail: " + e);
		} finally {
			// 닫을 때는 낮은것 부터 큰거 순으로.
			try {
				if (rs != null) {
					rs.close();
				}
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

	}

}
