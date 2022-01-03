package com.ja.movie.freeboard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.movie.freeboard.service.FreeBoardServiceImpl;
import com.ja.movie.vo.FreeBoardReplyVo;
import com.ja.movie.vo.FreeBoardVo;
import com.ja.movie.vo.MemberVo;

@Controller
@RequestMapping("/board/freeboard/*")
public class FreeBoardController {
	
	@Autowired
	private FreeBoardServiceImpl freeboardService;
	
	@RequestMapping("freeBoardPage.do")
	public String mainPage(Model model) {		
		
		ArrayList<HashMap<String, Object>> list = freeboardService.getBoardList();
		
		model.addAttribute("list" , list);
		
		return "board/freeboard/freeBoardPage";
	}
	
	
	
	@RequestMapping("writeContentPage.do")
	public String writeContentPage() {
		
		return "board/freeboard/writeContentPage";
	}
	
	
	@RequestMapping("writeContentProcess.do")
	public String writeContentProcess(FreeBoardVo param , HttpSession session) {
		
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");	
		int member_no = sessionUser.getMember_no();
		
		param.setMember_no(member_no);
		freeboardService.writeUpdatePoint(member_no);
		freeboardService.writeContent(param);
				
		return "redirect:/board/freeboard/freeBoardPage.do";
	}
	
	@RequestMapping("readContentPage.do")
	public String readContentPage(int freeboard_no , Model model) {
		
		HashMap<String, Object> data = freeboardService.getBoard(freeboard_no);
		
		model.addAttribute("data" , data);
		
		return "board/freeboard/readContentPage";
	}
	
	@RequestMapping("deleteContentProcess.do")
	public String deleteContentProcess(int freeboard_no, HttpSession session) {
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");	
		int member_no = sessionUser.getMember_no();
		freeboardService.deleteUpdatePoint(member_no);
		freeboardService.deleteContent(freeboard_no);
		
		return "redirect:/board/freeboard/freeBoardPage.do";		
	}
	
	@RequestMapping("updateContentPage.do")
	public String updateContentPage(int freeboard_no , Model model) {
		
		HashMap<String, Object> data = freeboardService.getBoard(freeboard_no);
		model.addAttribute("data" , data);
		
		return "board/freeboard/updateContentPage";
	}
	
	@RequestMapping("updateContentProcess.do")
	public String updateContentProcess(FreeBoardVo vo) {
		
		freeboardService.updateContent(vo);
		
		return "redirect:/board/freeboard/freeBoardPage.do";
	}
	
	//댓글목록
	@RequestMapping("freeBoardReply.do")
	public String readReplyContent(Model model, HttpServletRequest request) {
		String freeboard_no = request.getParameter("freeboard_no");
		System.out.println(freeboard_no);
		
		ArrayList<HashMap<String, Object>> replyList = freeboardService.getFreeBoardReplyList();
		
		model.addAttribute("freeBoardReplyList", replyList);
		
		return "board/freeboard/freeBoardReply";
	}
	
	//댓글작성
	@RequestMapping("freeBoardReplyProcess.do")
	public String freeBoardReplyProcess(FreeBoardReplyVo vo) {
		
		freeboardService.writeFreeBoardReply(vo);
		
		return "redirect:/board/freeboard/readContentPage.do";
	}
	
	
}
