package com.ja.movie.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class EventBoardReplyVo {

	private int eventboard_reply_no;
	private int eventboard_no;
	private int member_no;
	private String eventboard_reply_content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date eventboard_reply_writedate;
	public EventBoardReplyVo() {
		super();
	}
	public EventBoardReplyVo(int eventboard_reply_no, int eventboard_no, int member_no, String eventboard_reply_content,
			Date eventboard_reply_writedate) {
		super();
		this.eventboard_reply_no = eventboard_reply_no;
		this.eventboard_no = eventboard_no;
		this.member_no = member_no;
		this.eventboard_reply_content = eventboard_reply_content;
		this.eventboard_reply_writedate = eventboard_reply_writedate;
	}
	public int getEventboard_reply_no() {
		return eventboard_reply_no;
	}
	public void setEventboard_reply_no(int eventboard_reply_no) {
		this.eventboard_reply_no = eventboard_reply_no;
	}
	public int getEventboard_no() {
		return eventboard_no;
	}
	public void setEventboard_no(int eventboard_no) {
		this.eventboard_no = eventboard_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getEventboard_reply_content() {
		return eventboard_reply_content;
	}
	public void setEventboard_reply_content(String eventboard_reply_content) {
		this.eventboard_reply_content = eventboard_reply_content;
	}
	public Date getEventboard_reply_writedate() {
		return eventboard_reply_writedate;
	}
	public void setEventboard_reply_writedate(Date eventboard_reply_writedate) {
		this.eventboard_reply_writedate = eventboard_reply_writedate;
	}
	
}
