package com.ja.movie.vo;

public class MovieActorVo {
	private int Movie_actor_no;
	private int Movie_no;
	private int Actor_no;
	
	public MovieActorVo() {
		super();
	}

	public MovieActorVo(int movie_actor_no, int movie_no, int actor_no) {
		super();
		Movie_actor_no = movie_actor_no;
		Movie_no = movie_no;
		Actor_no = actor_no;
	}

	public int getMovie_actor_no() {
		return Movie_actor_no;
	}

	public void setMovie_actor_no(int movie_actor_no) {
		Movie_actor_no = movie_actor_no;
	}

	public int getMovie_no() {
		return Movie_no;
	}

	public void setMovie_no(int movie_no) {
		Movie_no = movie_no;
	}

	public int getActor_no() {
		return Actor_no;
	}

	public void setActor_no(int actor_no) {
		Actor_no = actor_no;
	}
	
	
	
}
