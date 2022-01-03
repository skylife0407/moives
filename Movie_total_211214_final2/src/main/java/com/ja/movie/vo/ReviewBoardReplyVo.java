package com.ja.movie.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReviewBoardReplyVo {
	private int reviewboard_reply_no;
	private int reviewboard_no;
	private int member_no;
	private int icon_no;
	private String reviewboard_reply_content;
	//@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd:mm:ss")
	private Date reviewboard_reply_writedate;
	
	public ReviewBoardReplyVo() {
		super();
	}

	public ReviewBoardReplyVo(int reviewboard_reply_no, int reviewboard_no, int member_no, int icon_no,
			String reviewboard_reply_content, Date reviewboard_reply_writedate) {
		super();
		this.reviewboard_reply_no = reviewboard_reply_no;
		this.reviewboard_no = reviewboard_no;
		this.member_no = member_no;
		this.icon_no = icon_no;
		this.reviewboard_reply_content = reviewboard_reply_content;
		this.reviewboard_reply_writedate = reviewboard_reply_writedate;
	}

	public int getReviewboard_reply_no() {
		return reviewboard_reply_no;
	}

	public void setReviewboard_reply_no(int reviewboard_reply_no) {
		this.reviewboard_reply_no = reviewboard_reply_no;
	}

	public int getReviewboard_no() {
		return reviewboard_no;
	}

	public void setReviewboard_no(int reviewboard_no) {
		this.reviewboard_no = reviewboard_no;
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

	public String getReviewboard_reply_content() {
		return reviewboard_reply_content;
	}

	public void setReviewboard_reply_content(String reviewboard_reply_content) {
		this.reviewboard_reply_content = reviewboard_reply_content;
	}

	public Date getReviewboard_reply_writedate() {
		return reviewboard_reply_writedate;
	}

	public void setReviewboard_reply_writedate(Date reviewboard_reply_writedate) {
		this.reviewboard_reply_writedate = reviewboard_reply_writedate;
	}
	
	
}
