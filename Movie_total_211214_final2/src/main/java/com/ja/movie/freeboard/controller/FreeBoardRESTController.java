package com.ja.movie.freeboard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.movie.freeboard.service.FreeBoardServiceImpl;
import com.ja.movie.member.service.MemberServiceImpl;
import com.ja.movie.vo.FreeBoardReplyVo;
import com.ja.movie.vo.FreeBoardVo;
import com.ja.movie.vo.MemberVo;


@Controller
@RequestMapping("/board/freeboard/*")
@ResponseBody //Rest API...포워딩 안되고...JSON으로 리턴함...
public class FreeBoardRESTController {

	@Autowired
	private FreeBoardServiceImpl freeboardService;
	
	@Autowired
	private MemberServiceImpl memberService; 
	
//	
//	@RequestMapping("doLikeRest.do")
//	public void doLike(BoardLikeVo param , HttpSession session) {
//		
//		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
//		int member_no = sessionUser.getMember_no();
//		
//		param.setMember_no(member_no);
//		
//		boardService.doLikeProcess(param);		
//		
//	}
//	
//	@RequestMapping("getMyLikeData.do")
//	public HashMap<String, Object> getMyLikeData(BoardLikeVo param , HttpSession session){
//		//내가 클릭 했냐??
//		HashMap<String, Object> data = new HashMap<String, Object>();
//
//		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
//		int member_no = sessionUser.getMember_no();
//		param.setMember_no(member_no);
//		
//		int myCount = boardService.getMyLikeCount(param);		
//		
//		data.put("myLikeCount", myCount);
//		
//		return data;
//	}
//	
//	@RequestMapping("getTotalLikeCount.do")
//	public HashMap<String, Object> getTotalLikeCount(int board_no){
//		HashMap<String, Object> data = new HashMap<String, Object>();
//		
//		int totalLikeCount = boardService.getTotalLikeCount(board_no);
//		data.put("totalLikeCount", totalLikeCount);
//		
//		return data;
//	}
	
	//자유게시판 댓글 관련
	@RequestMapping("writeCommentProcess.do")
	public HashMap<String, Object> replyWriteContentProcess(FreeBoardReplyVo param , HttpSession session) {
		
		HashMap<String, Object> data = new HashMap<String, Object>(); 
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		param.setMember_no(member_no);		
		//글작성시 100포인트 제공 
		freeboardService.writeUpdatePoint(sessionUser.getMember_no());	
		freeboardService.replyWriteContent(param);
		
		/*
		if(문제가 없으면..??) {
			data.put("result", "success");
		}else {
			data.put("result", "fail");
			data.put("reason", "DB 연동 오류...");
			data.put("errorCode", "10053");
		}
		*/
		return data;
	}

	
	@RequestMapping("replyDeleteProcess.do")
	public void replyDeleteProcess(FreeBoardReplyVo param, HttpSession session) {
		//글삭제시 100포인트 소멸 
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		freeboardService.deleteUpdatePoint(sessionUser.getMember_no());		
		freeboardService.deleteReply(param);
		
	}
	
	@RequestMapping("replyUpdateProcess.do")
	public void replyUpdateProcess(FreeBoardReplyVo param) {
		freeboardService.updateReply(param);
		
	}
	
	@RequestMapping("getReplyList.do")
	public HashMap<String, Object> getReplyList(int freeboard_no){
		HashMap<String, Object> data = new HashMap<String, Object>(); 
		
		ArrayList<HashMap<String, Object>> replylist = 
		freeboardService.getReplyList(freeboard_no);
		
		data.put("replylist", replylist);
		
		return data;
	}
}
