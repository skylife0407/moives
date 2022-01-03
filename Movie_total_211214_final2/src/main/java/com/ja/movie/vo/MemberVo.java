package com.ja.movie.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MemberVo {
	
	private int member_no;
	private int icon_no;
	private String member_id;
	private String member_pw;
	private String member_nick;
	private String member_email;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date member_birth;
	private String member_gender;
	private String member_activity;
	private int member_point;
	private int member_auth;
	
	
	public MemberVo() {
		super();
	}
	public MemberVo(int member_no, int icon_no, String member_id, String member_pw, String member_nick,
			String member_email, Date member_birth, String member_gender, String member_activity, int member_point,
			int member_auth) {
		super();
		this.member_no = member_no;
		this.icon_no = icon_no;
		this.member_id = member_id;
		this.member_pw = member_pw;
		this.member_nick = member_nick;
		this.member_email = member_email;
		this.member_birth = member_birth;
		this.member_gender = member_gender;
		this.member_activity = member_activity;
		this.member_point = member_point;
		this.member_auth = member_auth;
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
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public Date getMember_birth() {
		return member_birth;
	}
	public void setMember_birth(Date member_birth) {
		this.member_birth = member_birth;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public String getMember_activity() {
		return member_activity;
	}
	public void setMember_activity(String member_activity) {
		this.member_activity = member_activity;
	}
	public int getMember_point() {
		return member_point;
	}
	public void setMember_point(int member_point) {
		this.member_point = member_point;
	}
	public int getMember_auth() {
		return member_auth;
	}
	public void setMember_auth(int member_auth) {
		this.member_auth = member_auth;
	}
	
}
