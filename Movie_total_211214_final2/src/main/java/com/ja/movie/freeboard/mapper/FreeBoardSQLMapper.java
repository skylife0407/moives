package com.ja.movie.freeboard.mapper;

import java.util.ArrayList;

import com.ja.movie.vo.FreeBoardReplyVo;
import com.ja.movie.vo.FreeBoardVo;

public interface FreeBoardSQLMapper {

	public void writeContent(FreeBoardVo vo);
	
	public ArrayList<FreeBoardVo> getList();
	
	public FreeBoardVo getBoardByNo(int no);
	
	public void deleteByNo(int no);
	
	public void update(FreeBoardVo vo);
	
	public void increaseReadCount(int no);
	
	//글작성시 포인트 획득
	public void writeUpdatePoint(int no);
	public void deleteUpdatePoint(int no);
	
	//댓글관련
	public void writeReplyContent(FreeBoardReplyVo vo);	
	public ArrayList<FreeBoardReplyVo> getFreeBoardReplyList();

	//자유게시판 댓글 관련
	public void replyWriteContent(FreeBoardReplyVo vo);
	public void replyDelete(int no);
	public void replyUpdate(FreeBoardReplyVo vo);
	public ArrayList<FreeBoardReplyVo> getReplyByNo(int freeboard_no);	
}
