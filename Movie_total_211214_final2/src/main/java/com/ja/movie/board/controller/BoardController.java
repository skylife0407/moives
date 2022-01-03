package com.ja.movie.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@RequestMapping("mainPage.do")
	public String mainPage() {
		
		return "board/mainPage";
	}
	
	@RequestMapping("movieListPage.do")
	public String movieListPage() {
		
		return "board/movieListPage";
	}
	
//	@RequestMapping("freePage.do")
//	public String freePage() {
//		
//		return "board/freeboard/freeBoardPage";
//	}
//	
//	@RequestMapping("reviewPage.do")
//	public String reviewPage() {
//		
//		return "board/reviewBoardPage";
//	}
//	@RequestMapping("qnaPage.do")
//	public String qnaPage() {
//		
//		return "board/qnaBoardPage";
//	}
//	

	

}
