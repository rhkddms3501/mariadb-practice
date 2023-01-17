package bookmall.vo;

public class CategoryVo {
	private Long no;
	private String type;
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "CategoryVo [no=" + no + ", type=" + type + "]";
	}
	
}
