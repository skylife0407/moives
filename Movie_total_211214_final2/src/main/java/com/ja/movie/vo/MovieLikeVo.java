package com.ja.movie.vo;

public class MovieLikeVo {
	private int Movie_Like_no;
	private int  Movie_no;
	private int  Member_no;
	
	public MovieLikeVo() {
		super();
	}

	public MovieLikeVo(int movie_Like_no, int movie_no, int member_no) {
		super();
		Movie_Like_no = movie_Like_no;
		Movie_no = movie_no;
		Member_no = member_no;
	}

	public int getMovie_Like_no() {
		return Movie_Like_no;
	}

	public void setMovie_Like_no(int movie_Like_no) {
		Movie_Like_no = movie_Like_no;
	}

	public int getMovie_no() {
		return Movie_no;
	}

	public void setMovie_no(int movie_no) {
		Movie_no = movie_no;
	}

	public int getMember_no() {
		return Member_no;
	}

	public void setMember_no(int member_no) {
		Member_no = member_no;
	}
	
	
}
