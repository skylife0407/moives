package com.ja.movie.vo;

public class EventBoardLikeVo {
	private int eventboard_like_no;
	private int eventboard_no;
	private int member_no;
	public EventBoardLikeVo() {
		super();
	}
	public EventBoardLikeVo(int eventboard_like_no, int eventboard_no, int member_no) {
		super();
		this.eventboard_like_no = eventboard_like_no;
		this.eventboard_no = eventboard_no;
		this.member_no = member_no;
	}
	public int getEventboard_like_no() {
		return eventboard_like_no;
	}
	public void setEventboard_like_no(int eventboard_like_no) {
		this.eventboard_like_no = eventboard_like_no;
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
}