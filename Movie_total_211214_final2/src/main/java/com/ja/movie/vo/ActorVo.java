package com.ja.movie.vo;

public class ActorVo {
	private int Actor_no;
	private String Actor_Actorname;
	
	public ActorVo() {
		super();
	}

	public ActorVo(int actor_no, String actor_Actorname) {
		super();
		Actor_no = actor_no;
		Actor_Actorname = actor_Actorname;
	}

	public int getActor_no() {
		return Actor_no;
	}

	public void setActor_no(int actor_no) {
		Actor_no = actor_no;
	}

	public String getActor_Actorname() {
		return Actor_Actorname;
	}

	public void setActor_Actorname(String actor_Actorname) {
		Actor_Actorname = actor_Actorname;
	}
	
	
	 
}
