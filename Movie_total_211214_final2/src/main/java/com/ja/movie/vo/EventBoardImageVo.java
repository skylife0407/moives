package com.ja.movie.vo;

public class EventBoardImageVo {

	private int eventboard_image_no;
	private int eventboard_no;
	private String eventboard_image_link;
	private String eventboard_image_filename;
	public EventBoardImageVo() {
		super();
	}
	public EventBoardImageVo(int eventboard_image_no, int eventboard_no, String eventboard_image_link,
			String eventboard_image_filename) {
		super();
		this.eventboard_image_no = eventboard_image_no;
		this.eventboard_no = eventboard_no;
		this.eventboard_image_link = eventboard_image_link;
		this.eventboard_image_filename = eventboard_image_filename;
	}
	public int getEventboard_image_no() {
		return eventboard_image_no;
	}
	public void setEventboard_image_no(int eventboard_image_no) {
		this.eventboard_image_no = eventboard_image_no;
	}
	public int getEventboard_no() {
		return eventboard_no;
	}
	public void setEventboard_no(int eventboard_no) {
		this.eventboard_no = eventboard_no;
	}
	public String getEventboard_image_link() {
		return eventboard_image_link;
	}
	public void setEventboard_image_link(String eventboard_image_link) {
		this.eventboard_image_link = eventboard_image_link;
	}
	public String getEventboard_image_filename() {
		return eventboard_image_filename;
	}
	public void setEventboard_image_filename(String eventboard_image_filename) {
		this.eventboard_image_filename = eventboard_image_filename;
	}
	
}
	
	