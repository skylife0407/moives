package com.ja.movie.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.movie.member.service.MemberServiceImpl;
import com.ja.movie.vo.MemberVo;


@Controller
@RequestMapping("/member/*")
@ResponseBody
public class MemberRESTController {
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@RequestMapping("isExistId.do")
	public HashMap<String, Object> isExistId(String id){
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		boolean isExist = memberService.isExistId(id);
		data.put("result", isExist);
		
		return data;
	}
	
	
	@RequestMapping("getSessionUserInfo.do")
	public HashMap<String,Object> getSessionUserInfo(HttpSession session){
		
		HashMap<String,Object> data = new HashMap<String,Object>();
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		
		if(sessionUser != null) {
			data.put("isLogined", true);
			data.put("sessionNo", sessionUser.getMember_no());
			data.put("sessionNick", sessionUser.getMember_nick());
			data.put("sessionPoint", sessionUser.getMember_point());
			
		}else {
			data.put("isLogined", false);
		}
		return data;
	}
	
	@RequestMapping("doMemberActivity.do")
	public void doMemberActivity(int member_no, int activity) {

		memberService.adminMemberActivity(member_no, activity);
	}
	@RequestMapping("doAuth.do")
	public void doAuth(int member_no, int auth) {

		memberService.adminMemberAuth(member_no, auth);
	}
	
	
	@RequestMapping("doActivityFreeBoard.do")
	public void doActivityFreeBoard(int board_no, int activity) {

		memberService.adminFreeBoardPatch(board_no, activity);
	}
	@RequestMapping("doActivityReviewBoard.do")
	public void doActivityReviewBoard(int board_no, int activity) {

		memberService.adminReviewBoardPatch(board_no, activity);
	}
	@RequestMapping("doActivityEventBoard.do")
	public void doActivityEventBoard(int board_no, int activity) {

		memberService.adminEventBoardPatch(board_no, activity);
	}
	//아이콘 구매 설정
	@RequestMapping("iconBuy.do")
	public void iconBuy(int member_no, int icon_no, int icon_price) {

		memberService.iconBuy(member_no, icon_no, icon_price);
	}

}
