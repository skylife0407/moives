package com.ja.movie.game.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.movie.game.mapper.GameSQLMapper;
import com.ja.movie.vo.GamePlayingVo;
import com.ja.movie.vo.GameRoundVo;

@Service
public class GameServiceImpl {

	@Autowired
	private GameSQLMapper gameSQLMapper;
	
	public void batting(int batingAmount, int memberNo) {
		gameSQLMapper.battingPoint(batingAmount, memberNo);
	}
	
	public void result(int memberNo, GameRoundVo vo) {
		int batingAmount = gameSQLMapper.reulstPonit(vo.getGameRound_no());
		
		if(vo.getGameResult().equals("bjp")) {
			gameSQLMapper.blackJackPoint(batingAmount, memberNo);
		}else if(vo.getGameResult().equals("bjd")) {
//			gameSQLMapper.basicWinnerPoint(batingAmount, memberNo);
		}else if(vo.getGameResult().equals("bjt")) {
			gameSQLMapper.drowPoint(batingAmount, memberNo);
		}else if(vo.getGameResult().equals("pw")) {
			gameSQLMapper.basicWinnerPoint(batingAmount, memberNo);
		}else if(vo.getGameResult().equals("dw")) {
//			gameSQLMapper.basicWinnerPoint(batingAmount, memberNo);
		}else if(vo.getGameResult().equals("tie")) {
			gameSQLMapper.drowPoint(batingAmount, memberNo);
		}
		
		System.out.println(vo.getGameResult());
		System.out.println(vo.getGameRound_no());
		System.out.println(batingAmount);
		System.out.println(memberNo);
		
		
	}	
	
	public int openGameRound(GameRoundVo vo) {
		int gameRound_no = gameSQLMapper.createGameRoundPK();
		vo.setGameRound_no(gameRound_no);
		
		gameSQLMapper.startGame(vo);
		
		ArrayList<GamePlayingVo> defaultCardSetList = new ArrayList<GamePlayingVo>();
		
		
		while(defaultCardSetList.size()<4) {
			defaultCardSetList = gameSQLMapper.getCurrentCardInfobyGameroundNo(gameRound_no);
			
			int randomCardShpae = (int)(Math.random()*4) +1;
			int randomCardNumber = (int)(Math.random()*13) +1;
			
			//사이즈가 2보다 작으면 딜러 카드 먼저 생성
			if(defaultCardSetList.size() <2) {
				if(defaultCardSetList.size() == 0) {
					GamePlayingVo gvo = new GamePlayingVo();
					gvo.setGameRound_no(gameRound_no);
					gvo.setCardShape(randomCardShpae);
					gvo.setCardNumber(randomCardNumber);
					gvo.setPlayer("D");
					gameSQLMapper.createDefaultCardDistribute(gvo);
					defaultCardSetList.add(gvo);
					continue;
				}else {
					if(randomCardShpae == defaultCardSetList.get(0).getCardShape() && randomCardNumber == defaultCardSetList.get(0).getCardNumber()) {
						continue;
					}else {
						GamePlayingVo gvo = new GamePlayingVo();
						gvo.setGameRound_no(gameRound_no);
						gvo.setCardShape(randomCardShpae);
						gvo.setCardNumber(randomCardNumber);
						gvo.setPlayer("D");
						gameSQLMapper.createDefaultCardDistribute(gvo);
						defaultCardSetList.add(gvo);
						continue;
					}
				}
				
			} else {
				ArrayList<Boolean> checkDuplicate = new ArrayList<Boolean>();
				for(GamePlayingVo volist : defaultCardSetList) {
					if(volist.getCardShape() == randomCardShpae && volist.getCardNumber() == randomCardNumber) {
						checkDuplicate.add(true);
					}else {
						checkDuplicate.add(false);
					}
				}
				
				boolean isDuplicate = checkDuplicate.contains(true);
				if(isDuplicate == true) {
					continue;
				}else {
					GamePlayingVo gvo = new GamePlayingVo();
					gvo.setGameRound_no(gameRound_no);
					gvo.setCardShape(randomCardShpae);
					gvo.setCardNumber(randomCardNumber);
					gvo.setPlayer("P");
					gameSQLMapper.createDefaultCardDistribute(gvo);
					defaultCardSetList.add(gvo);
					continue;
				}
				
			}
			
		}
		return gameRound_no;
	}
	
	public ArrayList<GamePlayingVo> getGamePlayingInfo(int gameRound_no) {
		return gameSQLMapper.getCurrentCardInfobyGameroundNo(gameRound_no);
	}
	
	public ArrayList<GamePlayingVo> addPlayerCard(int gameRound_no) {
		
		ArrayList<GamePlayingVo> currentCardList = gameSQLMapper.getCurrentCardInfobyGameroundNo(gameRound_no);
		
		while(true) {
			int randomCardShpae = (int)(Math.random()*4) +1;
			int randomCardNumber = (int)(Math.random()*13) +1;
			ArrayList<Boolean> checkDuplicate = new ArrayList<Boolean>();
			for(GamePlayingVo volist : currentCardList) {
				if(volist.getCardShape() == randomCardShpae && volist.getCardNumber() == randomCardNumber) {
					checkDuplicate.add(true);
				}else {
					checkDuplicate.add(false);
				}
			}
			
			boolean isDuplicate = checkDuplicate.contains(true);
			if(isDuplicate == true) {
				continue;
			}else {
				GamePlayingVo gvo = new GamePlayingVo();
				gvo.setGameRound_no(gameRound_no);
				gvo.setCardShape(randomCardShpae);
				gvo.setCardNumber(randomCardNumber);
				gvo.setPlayer("P");
				gameSQLMapper.createDefaultCardDistribute(gvo);
				currentCardList.add(gvo);
				break;
			}
		}
		
		return currentCardList;
		
	}
	
	public ArrayList<GamePlayingVo> dealerTurn(int gameRound_no) {
		ArrayList<GamePlayingVo> currentCardList = gameSQLMapper.getCurrentCardInfobyGameroundNo(gameRound_no);
		
		int dealrSum=0;
		
		for(int i=0; i<2; i++){
			if(currentCardList.get(i).getCardNumber() == 1){
				dealrSum+=11;
				if(dealrSum >21 ){
					dealrSum-=10;
				}
			}else if(currentCardList.get(i).getCardNumber() == 11 ||currentCardList.get(i).getCardNumber() == 12||currentCardList.get(i).getCardNumber() == 13){
				dealrSum+=10;
			}else{
				dealrSum+=currentCardList.get(i).getCardNumber();
			}
		}
		
		System.out.println(dealrSum+"beforeAdd");
				
		while(dealrSum <= 16) {
		//if(dealrSum <= 16) {
			
			while(true) {
				int randomCardShpae = (int)(Math.random()*4) +1;
				int randomCardNumber = (int)(Math.random()*13) +1;
				ArrayList<Boolean> checkDuplicate = new ArrayList<Boolean>();
				for(GamePlayingVo volist : currentCardList) {
					if(volist.getCardShape() == randomCardShpae && volist.getCardNumber() == randomCardNumber) {
						checkDuplicate.add(true);
					}else {
						checkDuplicate.add(false);
					}
				}
				
				boolean isDuplicate = checkDuplicate.contains(true);
				if(isDuplicate == true) {
					continue;
				}else {
					GamePlayingVo gvo = new GamePlayingVo();
					gvo.setGameRound_no(gameRound_no);
					gvo.setCardShape(randomCardShpae);
					gvo.setCardNumber(randomCardNumber);
					gvo.setPlayer("D");
					gameSQLMapper.createDefaultCardDistribute(gvo);
					currentCardList.add(gvo);
					break;
				}
			}
			
			dealrSum=0;
			
			for(GamePlayingVo tmp: currentCardList) {
				if(tmp.getPlayer().equals("D")) {
					if(tmp.getCardNumber() == 1){
						dealrSum+=11;
						if(dealrSum >21 ){
							dealrSum-=10;
						}
					}else if(tmp.getCardNumber() == 11 ||tmp.getCardNumber() == 12||tmp.getCardNumber() == 13){
						dealrSum+=10;
					}else{
						dealrSum+=tmp.getCardNumber();
					}
				}
			}
			
			System.out.println(dealrSum+"beforeAdd");

		}
		
		return currentCardList;
	}
	
	
	
}
