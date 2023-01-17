package bookmall.vo;

public class OrdersVo {
	private Long no;
	private Long price;
	private String address;
	private Long userNo;
	private String userName;
	private String userEmail;
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(Long price) {
		this.price = price;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	@Override
	public String toString() {
		return "OrdersVo [no=" + no + ", price=" + price + ", address=" + address + ", userNo=" + userNo + ", userName="
				+ userName + ", userEmail=" + userEmail + "]";
	}
	
}
