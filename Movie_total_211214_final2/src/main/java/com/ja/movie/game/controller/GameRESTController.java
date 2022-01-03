package com.ja.movie.game.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.movie.game.service.GameServiceImpl;
import com.ja.movie.vo.GamePlayingVo;
import com.ja.movie.vo.GameRoundVo;
import com.ja.movie.vo.MemberVo;

@Controller
@RequestMapping("/game/*")
@ResponseBody
public class GameRESTController {
	
	@Autowired
	private GameServiceImpl gameService;

	@RequestMapping("openGameProcess.do")
	public HashMap<String, Object> openGameProcess(GameRoundVo param, HttpSession session) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo =  (MemberVo) session.getAttribute("sessionUser");
		param.setMember_no(memberVo.getMember_no());
		int gameRound_no =  gameService.openGameRound(param);
		gameService.batting(param.getBatingAmount(), memberVo.getMember_no());
//		for(GamePlayingVo vo:openGame) {
//			System.out.println(vo.getCardShape()+" "+vo.getCardNumber());
//		}
		
		data.put("gameRound", gameRound_no);
		
		return data;
		
	}
	
	@RequestMapping("getCardInfo.do")
	public HashMap<String, Object> getCardInfo(int gameRound_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		ArrayList<GamePlayingVo> playingCardInfo = gameService.getGamePlayingInfo(gameRound_no);
		data.put("playingCardInfo", playingCardInfo);
		
		return data;
	}
	
	@RequestMapping("addPlayerCard.do")
	public HashMap<String, Object> addPlayerCard(int gameRound_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<GamePlayingVo> playingCardInfo= gameService.addPlayerCard(gameRound_no);
		data.put("playingCardInfo", playingCardInfo);
		return data;
	}
	
	@RequestMapping("stayProcess.do")
	public HashMap<String, Object> stayProcess(int gameRound_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<GamePlayingVo> playingCardInfo = gameService.dealerTurn(gameRound_no);
		data.put("playingCardInfo", playingCardInfo);
		
		return data;
	}
	
//	@RequestMapping("sendResult.do")
//	public HashMap<String, Object> sendResult(GameRoundVo param) {
//		HashMap<String, Object> data = new HashMap<String, Object>();
//		
//		System.out.println(param.getGameResult());
//		
//		return data;
//	}
	
	@RequestMapping("sendResult.do")
	public void sendResult(HttpSession session, GameRoundVo param) {
		MemberVo memberVo =  (MemberVo) session.getAttribute("sessionUser");
		int memberNo =  memberVo.getMember_no();
		gameService.result(memberNo, param);
	}
	
}
