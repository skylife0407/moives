package com.ja.movie.vo;

import java.util.Date;

public class GameRoundVo {
	
	private int GameRound_no;
	private int  Member_no;
	private int  BatingAmount;
	private String  GameResult;
	private Date  GameStart_date;
	
	public GameRoundVo() {
		super();
	}

	public GameRoundVo(int gameRound_no, int member_no, int batingAmount, String gameResult, Date gameStart_date) {
		super();
		GameRound_no = gameRound_no;
		Member_no = member_no;
		BatingAmount = batingAmount;
		GameResult = gameResult;
		GameStart_date = gameStart_date;
	}

	public int getGameRound_no() {
		return GameRound_no;
	}

	public void setGameRound_no(int gameRound_no) {
		GameRound_no = gameRound_no;
	}

	public int getMember_no() {
		return Member_no;
	}

	public void setMember_no(int member_no) {
		Member_no = member_no;
	}

	public int getBatingAmount() {
		return BatingAmount;
	}

	public void setBatingAmount(int batingAmount) {
		BatingAmount = batingAmount;
	}

	public String getGameResult() {
		return GameResult;
	}

	public void setGameResult(String gameResult) {
		GameResult = gameResult;
	}

	public Date getGameStart_date() {
		return GameStart_date;
	}

	public void setGameStart_date(Date gameStart_date) {
		GameStart_date = gameStart_date;
	}
	
	
}
