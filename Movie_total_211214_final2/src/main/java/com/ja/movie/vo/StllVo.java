package com.ja.movie.vo;

public class StllVo {
	private int stll_no;
	private int movie_no;
	private String stll_url;
	
	public StllVo() {
		super();
	}

	public StllVo(int stll_no, int movie_no, String stll_url) {
		super();
		this.stll_no = stll_no;
		this.movie_no = movie_no;
		this.stll_url = stll_url;
	}

	public int getStll_no() {
		return stll_no;
	}

	public void setStll_no(int stll_no) {
		this.stll_no = stll_no;
	}

	public int getMovie_no() {
		return movie_no;
	}

	public void setMovie_no(int movie_no) {
		this.movie_no = movie_no;
	}

	public String getStll_url() {
		return stll_url;
	}

	public void setStll_url(String stll_url) {
		this.stll_url = stll_url;
	}
	
	
}
