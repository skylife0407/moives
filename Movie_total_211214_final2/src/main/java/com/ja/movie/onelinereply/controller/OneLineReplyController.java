package com.ja.movie.onelinereply.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ja.movie.moviePicture.service.MoviePictureServiceImpl;
import com.ja.movie.onelinereply.service.OneLineReplyServiceImpl;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.OneLineReplyVo;



@Controller
@RequestMapping("/board/onelinereply/*")
public class OneLineReplyController {
	
	@Autowired
	private OneLineReplyServiceImpl onelinereplyService;
	
	@Autowired
	private MoviePictureServiceImpl moviePictureServiceImpl;
	
	@RequestMapping("onelinereplyPage.do")
	public String mainPage() {
		
		return "board/onelinereply/onelinereplyPage";
	}
	
	@RequestMapping("contentsDetails.do")
	public String contentDetails(int movie_no, HttpSession session ,Model model) {
		
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		
		OneLineReplyVo oneLineReplyVo = new OneLineReplyVo();
		try {
			oneLineReplyVo.setMember_no(sessionUser.getMember_no());
		} catch (NullPointerException e) {
		}
		oneLineReplyVo.setMovie_no(movie_no); 
		
		boolean isOneLineWrite=onelinereplyService.checkOneLineWrite(oneLineReplyVo);
		model.addAttribute("isOneLineWrite",isOneLineWrite);
		
		HashMap<String,Object> map = onelinereplyService.contentDetails(movie_no);
		model.addAttribute("map",map);
		
	 	ArrayList<HashMap<String, Object>> list = onelinereplyService.oneLineReplyList(movie_no);
		model.addAttribute("onelinelist",list);
		
		ArrayList<HashMap<String, Object>> stllList = moviePictureServiceImpl.getStllList();
		model.addAttribute("stllList", stllList);
		
		double movieStarAvg = onelinereplyService.movieStarAvg(movie_no);
		model.addAttribute("movieStarAvg",movieStarAvg);
		
		int movieLikes = onelinereplyService.countMoiveLikes(movie_no);
		model.addAttribute("movieLikes",movieLikes);
		
		int oneLineReplyCount = onelinereplyService.countOneLineReply(movie_no);
		model.addAttribute("oneLineReplyCount", oneLineReplyCount);
		
		return "board/onelinereply/contentsDetails";
	}
	
	@RequestMapping("writeOneLineReply.do")
	public String writeOneLineReply() {

		return "board/onelinereply/writeOneLineReply";
	}
	
	@RequestMapping("writeOneLineReplyProcess.do")
	public String writeOneLineReplyProcess(OneLineReplyVo param, HttpSession session, Model model, RedirectAttributes redirect) {
		
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		int memberNo = sessionUser.getMember_no();
		param.setMember_no(memberNo);
		
		onelinereplyService.writeOneLineReply(param);

		redirect.addAttribute("movie_no",param.getMovie_no());
		
		return "redirect:/board/onelinereply/contentsDetails.do";
	}
	
	
	@RequestMapping("deleteOneLineReply.do")
	public String deleteOneLineReply(OneLineReplyVo param,int subPoint, RedirectAttributes redirect) {
		onelinereplyService.deleteOneLineReply(param);
		redirect.addAttribute("movie_no",param.getMovie_no());
		
		return "redirect:/board/onelinereply/contentsDetails.do";
	}
	
	@RequestMapping("updateOneLineReply.do")
	public String updateOneLineReply(OneLineReplyVo param, Model model) {
		OneLineReplyVo vo = onelinereplyService.getOneLineReplyVo(param);
		
		model.addAttribute("oneLineReplyVo", vo);
		
		return "board/onelinereply/updateOneLineReply";
	}
	
	
	@RequestMapping("updateOneLineReplyProcess.do")
	public String updateOneLineReply(OneLineReplyVo param, HttpSession session,RedirectAttributes redirect) {
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		param.setMember_no(member_no);
		onelinereplyService.updateOneLineReply(param);
		
		redirect.addAttribute("movie_no",param.getMovie_no());
		
		return "redirect:/board/onelinereply/contentsDetails.do";
	}

}
