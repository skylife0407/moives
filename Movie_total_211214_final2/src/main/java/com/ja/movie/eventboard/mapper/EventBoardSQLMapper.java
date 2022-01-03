package com.ja.movie.eventboard.mapper;

import java.util.ArrayList;

import com.ja.movie.vo.EventBoardImageVo;
import com.ja.movie.vo.EventBoardLikeVo;
import com.ja.movie.vo.EventBoardReplyVo;
import com.ja.movie.vo.EventBoardVo;

public interface EventBoardSQLMapper {
	//이벤트 페이지
	public ArrayList<EventBoardVo> getEventList();
	
	public void eventDelete(int no);
	
	public void eventUpdate(EventBoardVo vo);
	
	public void evnetUpdateImage(EventBoardImageVo vo);
	
	//등록 페이지
	public int createEventBoardPK();
	
	public void eventRegister(EventBoardVo vo);
	
	
	
	
	//상세 페이지
	public EventBoardVo getEventByNo(int eventboard_no);
	
	public void eventReplyContent(EventBoardReplyVo vo);
	
	public ArrayList<EventBoardReplyVo> getEventBoardReplyList(int eventboard_no);
	
	public EventBoardReplyVo getEventReplyByNo(int no);
	
	public void eventReplyDelete(int eventboard_reply_no);
	
	public void eventReplyUpdate(EventBoardReplyVo vo);
	
	
	
	//이미지 관련
	public void eventRegisterImage(EventBoardImageVo vo);
	public ArrayList<EventBoardImageVo> getEventImagesByBoardNo(int eventboardNo);
	
	public EventBoardImageVo getEventImageList(int image_no);
	
	//좋아요 관련
	public void like(EventBoardLikeVo vo);
	public void unLike(EventBoardLikeVo vo);
	public int myLikeCount(EventBoardLikeVo vo);
	public int totalLikeCount(int eventboardNo);
	   
	//글작성시 포인트 획득
	   public void writeUpdatePoint(int no);
	   public void deleteUpdatePoint(int no);
	
}
