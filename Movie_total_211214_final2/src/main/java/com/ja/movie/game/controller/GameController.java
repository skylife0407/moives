package com.ja.movie.game.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.movie.game.service.GameServiceImpl;
import com.ja.movie.vo.GamePlayingVo;
import com.ja.movie.vo.GameRoundVo;
import com.ja.movie.vo.MemberVo;

@Controller
@RequestMapping("/game/*")
public class GameController {
	
	@Autowired
	private GameServiceImpl gameService;
	
	@RequestMapping("gameIndexPage.do")
	public String GameIndexPage() {
		return "game/gameIndexPage";
	}
	
//	@RequestMapping("openGameProcess.do")
//	public ArrayList<GamePlayingVo> openGameProcess(GameRoundVo param, HttpSession session) {
//		
//		MemberVo memberVo =  (MemberVo) session.getAttribute("sessionUser");
//		param.setMember_no(memberVo.getMember_no());
//		ArrayList<GamePlayingVo> openGame =  gameService.openGameRound(param);
//		for(GamePlayingVo vo:openGame) {
//			System.out.println(vo.getCardShape()+" "+vo.getCardNumber());
//		}
//		
//		return openGame;
//		
//	}
	

}
