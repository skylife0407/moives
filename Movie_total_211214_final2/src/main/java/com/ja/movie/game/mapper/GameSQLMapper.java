package com.ja.movie.game.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.movie.vo.GamePlayingVo;
import com.ja.movie.vo.GameRoundVo;

public interface GameSQLMapper {
	public int createGameRoundPK();
	
	public void startGame(GameRoundVo vo);
	public void createDefaultCardDistribute(GamePlayingVo vo);
	public ArrayList<GamePlayingVo> getCurrentCardInfobyGameroundNo(int gameRound_no);
	public void addPlayerCard(GamePlayingVo vo);
	public ArrayList<GamePlayingVo> getDealerCardInfobyGameroundNo(int gameRound_no);
	
	public int battingPoint(@Param("batingAmount") int batingAmount, @Param("memberNo") int memberNo);
	public int basicWinnerPoint(@Param("batingAmount") int batingAmount, @Param("memberNo") int memberNo);
	public int blackJackPoint(@Param("batingAmount") int batingAmount, @Param("memberNo") int memberNo);
	public int drowPoint(@Param("batingAmount") int batingAmount, @Param("memberNo") int memberNo);
	public int reulstPonit(int no);
}
