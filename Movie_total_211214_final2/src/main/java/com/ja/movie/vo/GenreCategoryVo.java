package com.ja.movie.vo;

public class GenreCategoryVo {
	
	private int genre_category_no;
	private String genre_name;
	
	public GenreCategoryVo() {
		super();
	}

	public GenreCategoryVo(int genre_category_no, String genre_name) {
		super();
		this.genre_category_no = genre_category_no;
		this.genre_name = genre_name;
	}

	public int getGenre_category_no() {
		return genre_category_no;
	}

	public void setGenre_category_no(int genre_category_no) {
		this.genre_category_no = genre_category_no;
	}

	public String getGenre_name() {
		return genre_name;
	}

	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}
	
	
	
}
