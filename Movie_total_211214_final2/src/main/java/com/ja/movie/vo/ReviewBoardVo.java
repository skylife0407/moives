package com.ja.movie.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ReviewBoardVo {
	private int reviewboard_no;
	private int member_no;
	private int icon_no;
	private String reviewboard_title;
	private String reviewboard_content;
	private int reviewboard_readcount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date reviewboard_writedate;
	private String reviewboard_activity;
	private int reviewboard_score;
	
	public ReviewBoardVo() {
		super();
	}

	public ReviewBoardVo(int reviewboard_no, int member_no, int icon_no, String reviewboard_title,
			String reviewboard_content, int reviewboard_readcount, Date reviewboard_writedate,
			String reviewboard_activity, int reviewboard_score) {
		super();
		this.reviewboard_no = reviewboard_no;
		this.member_no = member_no;
		this.icon_no = icon_no;
		this.reviewboard_title = reviewboard_title;
		this.reviewboard_content = reviewboard_content;
		this.reviewboard_readcount = reviewboard_readcount;
		this.reviewboard_writedate = reviewboard_writedate;
		this.reviewboard_activity = reviewboard_activity;
		this.reviewboard_score = reviewboard_score;
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

	public String getReviewboard_title() {
		return reviewboard_title;
	}

	public void setReviewboard_title(String reviewboard_title) {
		this.reviewboard_title = reviewboard_title;
	}

	public String getReviewboard_content() {
		return reviewboard_content;
	}

	public void setReviewboard_content(String reviewboard_content) {
		this.reviewboard_content = reviewboard_content;
	}

	public int getReviewboard_readcount() {
		return reviewboard_readcount;
	}

	public void setReviewboard_readcount(int reviewboard_readcount) {
		this.reviewboard_readcount = reviewboard_readcount;
	}

	public Date getReviewboard_writedate() {
		return reviewboard_writedate;
	}

	public void setReviewboard_writedate(Date reviewboard_writedate) {
		this.reviewboard_writedate = reviewboard_writedate;
	}

	public String getReviewboard_activity() {
		return reviewboard_activity;
	}

	public void setReviewboard_activity(String reviewboard_activity) {
		this.reviewboard_activity = reviewboard_activity;
	}

	public int getReviewboard_score() {
		return reviewboard_score;
	}

	public void setReviewboard_score(int reviewboard_score) {
		this.reviewboard_score = reviewboard_score;
	}
	
	
}
