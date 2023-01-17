package bookmall.vo;

public class CartVo {
	private Long no;
	private Long count;
	private Long bookNo;
	private Long userNo;
	private String bookTitle;
	private Long bookPrice;
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
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public Long getBookPrice() {
		return bookPrice;
	}
	public void setBookPrice(Long bookPrice) {
		this.bookPrice = bookPrice;
	}
	@Override
	public String toString() {
		return "CartVo [no=" + no + ", count=" + count + ", bookNo=" + bookNo + ", userNo=" + userNo + ", bookTitle="
				+ bookTitle + ", bookPrice=" + bookPrice + "]";
	}
	
}
