package com.ja.movie.reviewboard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.movie.member.service.MemberServiceImpl;
import com.ja.movie.reviewboard.service.ReviewBoardServiceImpl;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.ReviewBoardLikeVo;
import com.ja.movie.vo.ReviewBoardReplyVo;

@Controller
@RequestMapping("/board/reviewboard/*")
@ResponseBody //Rest API...포워딩 안되고...JSON으로 리턴함...
public class ReviewBoardRESTController {

	@Autowired
	private ReviewBoardServiceImpl reviewboardService;
	
	@Autowired
	private MemberServiceImpl memberService; 
	
	
	@RequestMapping("doLikeRest.do")
	public void doLike(ReviewBoardLikeVo param , HttpSession session) {
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		param.setMember_no(member_no);
		
		reviewboardService.doLikeProcess(param);		
		
	}
	
	@RequestMapping("getMyLikeData.do")
	public HashMap<String, Object> getMyLikeData(ReviewBoardLikeVo param , HttpSession session){
		//내가 클릭 했냐??
		HashMap<String, Object> data = new HashMap<String, Object>();

		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		param.setMember_no(member_no);
		
		int myCount = reviewboardService.getMyLikeCount(param);		
		
		data.put("myLikeCount", myCount);
		
		return data;
	}
	
	@RequestMapping("getTotalLikeCount.do")
	public HashMap<String, Object> getTotalLikeCount(int reviewboard_no){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		int totalLikeCount = reviewboardService.getTotalLikeCount(reviewboard_no);
		data.put("totalLikeCount", totalLikeCount);
		
		return data;
	}
	
	//리뷰게시판 댓글 관련
	@RequestMapping("reviewCommentProcess.do")
	public HashMap<String, Object> reviewCommentProcess(ReviewBoardReplyVo param , HttpSession session) {
		
		HashMap<String, Object> data = new HashMap<String, Object>(); 
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		param.setMember_no(member_no);		
		//리뷰 글작성시 10포인트 제공 
		reviewboardService.reviewWriteReplyPoint(sessionUser.getMember_no());	
		reviewboardService.reviewReplyWriteContent(param);
		
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

	
	@RequestMapping("reviewReplyDeleteProcess.do")
	public void reviewReplyDeleteProcess(ReviewBoardReplyVo param, HttpSession session) {
	//리뷰 글삭제시 10포인트 소멸 
	MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
	reviewboardService.reviewDeleteReplyPoint(sessionUser.getMember_no());		
	reviewboardService.reviewDeleteReply(param);
		
	}
	
	@RequestMapping("reviewReplyUpdateProcess.do")
	public void reviewReplyUpdateProcess(ReviewBoardReplyVo param) {
	reviewboardService.reviewUpdateReply(param);
		
	}
	
	@RequestMapping("getReviewReplyList.do")
	public HashMap<String, Object> getReviewReplyList(int reviewboard_no){
	HashMap<String, Object> data = new HashMap<String, Object>(); 
		
	ArrayList<HashMap<String, Object>> reviewreplylist = 
	reviewboardService.getReviewReplyList(reviewboard_no);
		
	data.put("reviewreplylist", reviewreplylist);
		
	return data;	
	}
}
