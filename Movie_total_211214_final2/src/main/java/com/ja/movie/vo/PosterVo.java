package com.ja.movie.vo;

public class PosterVo {
	private int poster_no;
	private int movie_no;
	private String poster_url;
	
	public PosterVo() {
		super();
	}
	public PosterVo(int poster_no, int movie_no, String poster_url) {
		super();
		this.poster_no = poster_no;
		this.movie_no = movie_no;
		this.poster_url = poster_url;
	}
	public int getPoster_no() {
		return poster_no;
	}
	public void setPoster_no(int poster_no) {
		this.poster_no = poster_no;
	}
	public int getMovie_no() {
		return movie_no;
	}
	public void setMovie_no(int movie_no) {
		this.movie_no = movie_no;
	}
	public String getPoster_url() {
		return poster_url;
	}
	public void setPoster_url(String poster_url) {
		this.poster_url = poster_url;
	}
	
	
}
