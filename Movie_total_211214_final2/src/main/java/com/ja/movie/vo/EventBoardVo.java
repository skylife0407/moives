package com.ja.movie.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class EventBoardVo {

	private int eventboard_no;
	private int member_no;
	private String eventboard_title;
	private String eventboard_content;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date eventboard_startdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date eventboard_enddate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date eventboard_writedate;
	private String eventboard_activity;
	public EventBoardVo() {
		super();
	}
	public EventBoardVo(int eventboard_no, int member_no, String eventboard_title, String eventboard_content,
			Date eventboard_startdate, Date eventboard_enddate, Date eventboard_writedate, String eventboard_activity) {
		super();
		this.eventboard_no = eventboard_no;
		this.member_no = member_no;
		this.eventboard_title = eventboard_title;
		this.eventboard_content = eventboard_content;
		this.eventboard_startdate = eventboard_startdate;
		this.eventboard_enddate = eventboard_enddate;
		this.eventboard_writedate = eventboard_writedate;
		this.eventboard_activity = eventboard_activity;
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
	public String getEventboard_title() {
		return eventboard_title;
	}
	public void setEventboard_title(String eventboard_title) {
		this.eventboard_title = eventboard_title;
	}
	public String getEventboard_content() {
		return eventboard_content;
	}
	public void setEventboard_content(String eventboard_content) {
		this.eventboard_content = eventboard_content;
	}
	public Date getEventboard_startdate() {
		return eventboard_startdate;
	}
	public void setEventboard_startdate(Date eventboard_startdate) {
		this.eventboard_startdate = eventboard_startdate;
	}
	public Date getEventboard_enddate() {
		return eventboard_enddate;
	}
	public void setEventboard_enddate(Date eventboard_enddate) {
		this.eventboard_enddate = eventboard_enddate;
	}
	public Date getEventboard_writedate() {
		return eventboard_writedate;
	}
	public void setEventboard_writedate(Date eventboard_writedate) {
		this.eventboard_writedate = eventboard_writedate;
	}
	public String getEventboard_activity() {
		return eventboard_activity;
	}
	public void setEventboard_activity(String eventboard_activity) {
		this.eventboard_activity = eventboard_activity;
	}
}