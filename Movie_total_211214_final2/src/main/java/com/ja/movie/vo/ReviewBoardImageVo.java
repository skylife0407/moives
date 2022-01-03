package com.ja.movie.vo;

public class ReviewBoardImageVo {
	private int reviewboard_image_no;
	private int reviewboard_no;
	private String reviewboard_image_link;
	private String reviewboard_image_filename;
	
	public ReviewBoardImageVo() {
		super();
	}

	public ReviewBoardImageVo(int reviewboard_image_no, int reviewboard_no, String reviewboard_image_link,
			String reviewboard_image_filename) {
		super();
		this.reviewboard_image_no = reviewboard_image_no;
		this.reviewboard_no = reviewboard_no;
		this.reviewboard_image_link = reviewboard_image_link;
		this.reviewboard_image_filename = reviewboard_image_filename;
	}

	public int getReviewboard_image_no() {
		return reviewboard_image_no;
	}

	public void setReviewboard_image_no(int reviewboard_image_no) {
		this.reviewboard_image_no = reviewboard_image_no;
	}

	public int getReviewboard_no() {
		return reviewboard_no;
	}

	public void setReviewboard_no(int reviewboard_no) {
		this.reviewboard_no = reviewboard_no;
	}

	public String getReviewboard_image_link() {
		return reviewboard_image_link;
	}

	public void setReviewboard_image_link(String reviewboard_image_link) {
		this.reviewboard_image_link = reviewboard_image_link;
	}

	public String getReviewboard_image_filename() {
		return reviewboard_image_filename;
	}

	public void setReviewboard_image_filename(String reviewboard_image_filename) {
		this.reviewboard_image_filename = reviewboard_image_filename;
	}
	
	
	
	
}
