package com.ja.movie.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class MovieVo {
	private int movie_no;
	private String movie_title;
	private String movie_title_Eng;
	private String movie_directorNm;
	private String movie_company;
	private String movie_plotText;
	private int movie_runtime;
	private String movie_rating;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date movie_repRlsDate;
	
	public MovieVo() {
		super();
	}

	public MovieVo(int movie_no, String movie_title, String movie_title_Eng, String movie_directorNm,
			String movie_company, String movie_plotText, int movie_runtime, String movie_rating,
			Date movie_repRlsDate) {
		super();
		this.movie_no = movie_no;
		this.movie_title = movie_title;
		this.movie_title_Eng = movie_title_Eng;
		this.movie_directorNm = movie_directorNm;
		this.movie_company = movie_company;
		this.movie_plotText = movie_plotText;
		this.movie_runtime = movie_runtime;
		this.movie_rating = movie_rating;
		this.movie_repRlsDate = movie_repRlsDate;
	}

	public int getMovie_no() {
		return movie_no;
	}

	public void setMovie_no(int movie_no) {
		this.movie_no = movie_no;
	}

	public String getMovie_title() {
		return movie_title;
	}

	public void setMovie_title(String movie_title) {
		this.movie_title = movie_title;
	}

	public String getMovie_title_Eng() {
		return movie_title_Eng;
	}

	public void setMovie_title_Eng(String movie_title_Eng) {
		this.movie_title_Eng = movie_title_Eng;
	}

	public String getMovie_directorNm() {
		return movie_directorNm;
	}

	public void setMovie_directorNm(String movie_directorNm) {
		this.movie_directorNm = movie_directorNm;
	}

	public String getMovie_company() {
		return movie_company;
	}

	public void setMovie_company(String movie_company) {
		this.movie_company = movie_company;
	}

	public String getMovie_plotText() {
		return movie_plotText;
	}

	public void setMovie_plotText(String movie_plotText) {
		this.movie_plotText = movie_plotText;
	}

	public int getMovie_runtime() {
		return movie_runtime;
	}

	public void setMovie_runtime(int movie_runtime) {
		this.movie_runtime = movie_runtime;
	}

	public String getMovie_rating() {
		return movie_rating;
	}

	public void setMovie_rating(String movie_rating) {
		this.movie_rating = movie_rating;
	}

	public Date getMovie_repRlsDate() {
		return movie_repRlsDate;
	}

	public void setMovie_repRlsDate(Date movie_repRlsDate) {
		this.movie_repRlsDate = movie_repRlsDate;
	}
	
	
	
	
}
