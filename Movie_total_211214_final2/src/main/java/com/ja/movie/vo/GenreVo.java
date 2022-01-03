package com.ja.movie.vo;

public class GenreVo {
	
	private int user_genre_no;
	private int genrecategory_no;
	private int member_no;
	public GenreVo() {
		super();
	}
	public GenreVo(int user_genre_no, int genrecategory_no, int member_no) {
		super();
		this.user_genre_no = user_genre_no;
		this.genrecategory_no = genrecategory_no;
		this.member_no = member_no;
	}
	public int getUser_genre_no() {
		return user_genre_no;
	}
	public void setUser_genre_no(int user_genre_no) {
		this.user_genre_no = user_genre_no;
	}
	public int getGenrecategory_no() {
		return genrecategory_no;
	}
	public void setGenrecategory_no(int genrecategory_no) {
		this.genrecategory_no = genrecategory_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	

	
}
