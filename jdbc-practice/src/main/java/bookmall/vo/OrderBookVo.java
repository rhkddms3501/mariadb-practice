package bookmall.vo;

public class OrderBookVo {
	private Long no;
	private Long count;
	private Long bookNo;
	private Long ordersNo;
	private String bookTitle;
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public Long getCount() {
		return count;
	}
	public void setCount(Long count) {
		this.count = count;
	}
	public Long getBookNo() {
		return bookNo;
	}
	public void setBookNo(Long bookNo) {
		this.bookNo = bookNo;
	}
	public Long getOrdersNo() {
		return ordersNo;
	}
	public void setOrdersNo(Long ordersNo) {
		this.ordersNo = ordersNo;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	@Override
	public String toString() {
		return "OrderBookVo [no=" + no + ", count=" + count + ", bookNo=" + bookNo + ", ordersNo=" + ordersNo
				+ ", bookTitle=" + bookTitle + "]";
	}
}
