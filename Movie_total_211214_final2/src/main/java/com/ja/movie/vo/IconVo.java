package com.ja.movie.vo;

public class IconVo {

	private int icon_no;
	private String icon_link;
	private int icon_price;
	private String icon_name;
	
	
	public IconVo() {
		super();
	}
	public IconVo(int icon_no, String icon_link, int icon_price, String icon_name) {
		super();
		this.icon_no = icon_no;
		this.icon_link = icon_link;
		this.icon_price = icon_price;
		this.icon_name = icon_name;
	}
	
	
	public int getIcon_no() {
		return icon_no;
	}
	public void setIcon_no(int icon_no) {
		this.icon_no = icon_no;
	}
	public String getIcon_link() {
		return icon_link;
	}
	public void setIcon_link(String icon_link) {
		this.icon_link = icon_link;
	}
	public int getIcon_price() {
		return icon_price;
	}
	public void setIcon_price(int icon_price) {
		this.icon_price = icon_price;
	}
	public String getIcon_name() {
		return icon_name;
	}
	public void setIcon_name(String icon_name) {
		this.icon_name = icon_name;
	}

}