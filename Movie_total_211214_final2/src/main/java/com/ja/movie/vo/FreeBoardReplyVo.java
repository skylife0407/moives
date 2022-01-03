package com.ja.movie.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class FreeBoardReplyVo {
	private int freeboard_reply_no;
	private int freeboard_no;
	private int member_no;
	private int icon_no;
	private String freeboard_reply_content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date freeboard_reply_writedate;
	
	public FreeBoardReplyVo() {
		super();
	}

	public FreeBoardReplyVo(int freeboard_reply_no, int freeboard_no, int member_no, int icon_no,
			String freeboard_reply_content, Date freeboard_reply_writedate) {
		super();
		this.freeboard_reply_no = freeboard_reply_no;
		this.freeboard_no = freeboard_no;
		this.member_no = member_no;
		this.icon_no = icon_no;
		this.freeboard_reply_content = freeboard_reply_content;
		this.freeboard_reply_writedate = freeboard_reply_writedate;
	}

	public int getFreeboard_reply_no() {
		return freeboard_reply_no;
	}

	public void setFreeboard_reply_no(int freeboard_reply_no) {
		this.freeboard_reply_no = freeboard_reply_no;
	}

	public int getFreeboard_no() {
		return freeboard_no;
	}

	public void setFreeboard_no(int freeboard_no) {
		this.freeboard_no = freeboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getIcon_no() {
		return icon_no;
	}

	public void setIcon_no(int icon_no) {
		this.icon_no = icon_no;
	}

	public String getFreeboard_reply_content() {
		return freeboard_reply_content;
	}

	public void setFreeboard_reply_content(String freeboard_reply_content) {
		this.freeboard_reply_content = freeboard_reply_content;
	}

	public Date getFreeboard_reply_writedate() {
		return freeboard_reply_writedate;
	}

	public void setFreeboard_reply_writedate(Date freeboard_reply_writedate) {
		this.freeboard_reply_writedate = freeboard_reply_writedate;
	}
	
	
	
}
