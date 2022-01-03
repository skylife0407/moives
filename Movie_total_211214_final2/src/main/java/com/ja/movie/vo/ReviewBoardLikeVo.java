package com.ja.movie.vo;

public class ReviewBoardLikeVo {
	private int reviewboard_Like_no;
	private int reviewboard_no;
	private int member_no;
	
	public ReviewBoardLikeVo() {
		super();
	}

	public ReviewBoardLikeVo(int reviewboard_Like_no, int reviewboard_no, int member_no) {
		super();
		this.reviewboard_Like_no = reviewboard_Like_no;
		this.reviewboard_no = reviewboard_no;
		this.member_no = member_no;
	}

	public int getReviewboard_Like_no() {
		return reviewboard_Like_no;
	}

	public void setReviewboard_Like_no(int reviewboard_Like_no) {
		this.reviewboard_Like_no = reviewboard_Like_no;
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
		
	
}
