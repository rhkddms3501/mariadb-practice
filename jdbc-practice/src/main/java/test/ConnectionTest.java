package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionTest {

	public static void main(String[] args) {
		Connection conn = null;

		try {
			// 1. JDBC Driver Class Loading
			Class.forName("org.mariadb.jdbc.Driver");

			// 2. Connection
			String url = "jdbc:mariadb://192.168.10.116:3307/webdb?charset=utf8";
			// DriverManager.getConnection(url, Id(User), Pw);
			conn = DriverManager.getConnection(url, "webdb", "webdb");

			System.out.println("Connect!!");
		} catch (ClassNotFoundException e) {
			System.out.println("1. JDBC Driver Loading Fail: " + e);
		} catch (SQLException e) {
			System.out.println("2. Connection Fail: " + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("2-1. Connection close Fail: " + e);
			}
		}
	}
}
