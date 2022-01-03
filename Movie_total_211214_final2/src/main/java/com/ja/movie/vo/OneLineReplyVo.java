package com.ja.movie.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class OneLineReplyVo {
	
	private int OneLineReply_no;
	private int Movie_no;
	private int Member_no;
	private int Icon_no;
	private String OneLineReply_content;
	@JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Date OneLineReply_writedate;
	private int OneLineReply_star;
	
	
	public OneLineReplyVo() {
		super();
	}
	public OneLineReplyVo(int oneLineReply_no, int movie_no, int member_no, int icon_no, String oneLineReply_content,
			Date oneLineReply_writedate, int oneLineReply_star) {
		super();
		OneLineReply_no = oneLineReply_no;
		Movie_no = movie_no;
		Member_no = member_no;
		Icon_no = icon_no;
		OneLineReply_content = oneLineReply_content;
		OneLineReply_writedate = oneLineReply_writedate;
		OneLineReply_star = oneLineReply_star;
	}
	
	
	public int getOneLineReply_no() {
		return OneLineReply_no;
	}
	public void setOneLineReply_no(int oneLineReply_no) {
		OneLineReply_no = oneLineReply_no;
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
	public int getIcon_no() {
		return Icon_no;
	}
	public void setIcon_no(int icon_no) {
		Icon_no = icon_no;
	}
	public String getOneLineReply_content() {
		return OneLineReply_content;
	}
	public void setOneLineReply_content(String oneLineReply_content) {
		OneLineReply_content = oneLineReply_content;
	}
	public Date getOneLineReply_writedate() {
		return OneLineReply_writedate;
	}
	public void setOneLineReply_writedate(Date oneLineReply_writedate) {
		OneLineReply_writedate = oneLineReply_writedate;
	}
	public int getOneLineReply_star() {
		return OneLineReply_star;
	}
	public void setOneLineReply_star(int oneLineReply_star) {
		OneLineReply_star = oneLineReply_star;
	}
	
}
