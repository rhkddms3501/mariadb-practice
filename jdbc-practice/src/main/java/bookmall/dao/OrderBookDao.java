package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.OrderBookVo;


public class OrderBookDao {
	public List<OrderBookVo> findAll(Long ordersNo) {
		List<OrderBookVo> result = new ArrayList<>();
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql =
						"select a.no, a.count, a.book_no, a.orders_no, c.title"
						+ " from order_book a join orders b join book c"
						+ " on a.orders_no = b.no"
						+ " and a.book_no = c.no"
						+ " where orders_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, ordersNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrderBookVo vo = new OrderBookVo();
				vo.setNo(rs.getLong(1));
				vo.setCount(rs.getLong(2));
				vo.setBookNo(rs.getLong(3));
				vo.setOrdersNo(rs.getLong(4));
				vo.setBookTitle(rs.getString(5));
				
				result.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				
				if(pstmt != null) {
					pstmt.close();
				}
				
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public void insert(Long userNo, Long ordersNo) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			String sql = " insert into order_book"
					+ " select null, c.count, d.no, b.no"
					+ " from user a join orders b join cart c join book d"
					+ "	on a.no = b.user_no"
					+ "    and b.user_no = c.user_no"
					+ "    and c.book_no = d.no"
					+ " where a.no = ? and b.no = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, userNo);
			pstmt.setLong(2, ordersNo);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.10.116:3307/bookmall?charset=utf8";
			conn = DriverManager.getConnection(url, "bookmall", "bookmall");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:" + e);
		}
		return conn;
	}
}
