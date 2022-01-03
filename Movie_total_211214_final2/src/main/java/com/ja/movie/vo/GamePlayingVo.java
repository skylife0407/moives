package com.ja.movie.vo;

public class GamePlayingVo {
	private int GamePlaying_no;
	private int GameRound_no;
	private int CardShape;
	private int CardNumber;
	private String Player;
	
	public GamePlayingVo() {
		super();
	}

	public GamePlayingVo(int gamePlaying_no, int gameRound_no, int cardShape, int cardNumber, String player) {
		super();
		GamePlaying_no = gamePlaying_no;
		GameRound_no = gameRound_no;
		CardShape = cardShape;
		CardNumber = cardNumber;
		Player = player;
	}

	public int getGamePlaying_no() {
		return GamePlaying_no;
	}

	public void setGamePlaying_no(int gamePlaying_no) {
		GamePlaying_no = gamePlaying_no;
	}

	public int getGameRound_no() {
		return GameRound_no;
	}

	public void setGameRound_no(int gameRound_no) {
		GameRound_no = gameRound_no;
	}

	public int getCardShape() {
		return CardShape;
	}

	public void setCardShape(int cardShape) {
		CardShape = cardShape;
	}

	public int getCardNumber() {
		return CardNumber;
	}

	public void setCardNumber(int cardNumber) {
		CardNumber = cardNumber;
	}

	public String getPlayer() {
		return Player;
	}

	public void setPlayer(String player) {
		Player = player;
	}
}
