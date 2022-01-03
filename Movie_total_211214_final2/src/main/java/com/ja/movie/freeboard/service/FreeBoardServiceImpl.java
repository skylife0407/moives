package com.ja.movie.freeboard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.movie.freeboard.mapper.FreeBoardSQLMapper;
import com.ja.movie.member.mapper.MemberSQLMapper;
import com.ja.movie.vo.FreeBoardReplyVo;
import com.ja.movie.vo.FreeBoardVo;
import com.ja.movie.vo.MemberVo;

@Service
public class FreeBoardServiceImpl {
	
	@Autowired
	private FreeBoardSQLMapper freeboardSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	public void writeContent(FreeBoardVo vo) {
			
		freeboardSQLMapper.writeContent(vo);
		
	}
	
	public ArrayList<HashMap<String, Object>> getBoardList() {
		
		ArrayList<HashMap<String, Object>> list = 
				new ArrayList<HashMap<String, Object>>();
		
		ArrayList<FreeBoardVo> boardList = freeboardSQLMapper.getList();
		
		for(FreeBoardVo boardVo : boardList) {
			int member_no = boardVo.getMember_no();
			
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberVo", memberVo);
		map.put("freeBoardVo", boardVo);
		
		list.add(map);
		
		}
		
		return list;
		
	}
	
	public HashMap<String, Object> getBoard(int board_no) {
		
		freeboardSQLMapper.increaseReadCount(board_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		FreeBoardVo boardVo = freeboardSQLMapper.getBoardByNo(board_no);
		int member_no = boardVo.getMember_no();
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
		
		map.put("freeBoardVo", boardVo);
		map.put("memberVo", memberVo);
		
		return map;
	}
	
	public void deleteContent(int board_no) {
		freeboardSQLMapper.deleteByNo(board_no);
	}
	
	public void updateContent(FreeBoardVo vo) {
		freeboardSQLMapper.update(vo);
		
	}
	
	//포인트 획득
	public void writeUpdatePoint(int no) {
			freeboardSQLMapper.writeUpdatePoint(no);
	}
	public void deleteUpdatePoint(int no) {
		freeboardSQLMapper.deleteUpdatePoint(no);
	}	

	//댓글 관련
	public void writeFreeBoardReply(FreeBoardReplyVo vo) {
		
		freeboardSQLMapper.writeReplyContent(vo);
		
	}
	
	public ArrayList<HashMap<String, Object>> getFreeBoardReplyList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<FreeBoardReplyVo> replyList = freeboardSQLMapper.getFreeBoardReplyList();
		
		for(FreeBoardReplyVo replyVo : replyList) {
			int member_no = replyVo.getMember_no();			
			MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			map.put("replyVo", replyVo);
			
			list.add(map);			
		}		
		return list;
	}
	
	//자유게시판 댓글 관련
	public void replyWriteContent(FreeBoardReplyVo vo) {	
		freeboardSQLMapper.replyWriteContent(vo);
    }


	public void writeReply(FreeBoardReplyVo vo) {
		freeboardSQLMapper.replyWriteContent(vo);
	}
	
	public void deleteReply(FreeBoardReplyVo vo) {
		freeboardSQLMapper.replyDelete(vo.getFreeboard_reply_no());
	}
	
	public void updateReply(FreeBoardReplyVo vo) {
		freeboardSQLMapper.replyUpdate(vo);
	}
	 
	public ArrayList<HashMap<String,Object>> getReplyList(int freeboardNo){		
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<FreeBoardReplyVo> freeBoardReplyVoList = freeboardSQLMapper.getReplyByNo(freeboardNo);
		
		for(FreeBoardReplyVo freeBoardReplyVo : freeBoardReplyVoList) {
			int memberNo = freeBoardReplyVo.getMember_no();			
			MemberVo memberVo = memberSQLMapper.getMemberByNo(memberNo);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			
			map.put("freeBoardReplyVo", freeBoardReplyVo);
			list.add(map);
		}		
		return list;
	}
}
