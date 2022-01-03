package com.ja.movie.onelinereply.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.ja.movie.vo.MovieLikeVo;
import com.ja.movie.vo.MovieVo;
import com.ja.movie.vo.OneLineReplyVo;
import com.ja.movie.vo.PosterVo;

public interface OneLineReplySQLMapper {

	public MovieVo getMovieVoByNo(int movie_no);
	public ArrayList<PosterVo> getMoviePosterByNo(int movie_no);
	public int[] getActorNoBymovieNo(int movie_no);
	public String getActorByActorNo(int actorNo);
	public void writeOnelineReply(OneLineReplyVo vo);
	public ArrayList<OneLineReplyVo> getOneLineReplyByMovieNo(int movie_no);
	public int checkOneLineReplyByMemberNo(OneLineReplyVo vo);
	public OneLineReplyVo getMyOneLineReplyByMemberNoAndMovieNo(OneLineReplyVo vo);
	public void deleteOneLineReplyByMovieNoAndMemberNo(int oneLineReply_no);
	public void updateOneLineReplyByMovieNoAndMemberNo(OneLineReplyVo vo);
	
	public Double getMovieStarAvg(int movie_no);
	public int getCountMovieLikeByMovieNo(int movie_no);
	public void likeThisMovie(MovieLikeVo vo);
	public int isLikeThisMovie (MovieLikeVo vo);
	public void deleteMovieLikeByMovieNoAndMemberNo (MovieLikeVo vo);
	public int getCountOneLineReplyByMovieNo(int movie_no);
	
	public ArrayList<HashMap<String, Object>> getMovieStarAVGGroupByGenderByMovieNo(int movie_no);
	public ArrayList<HashMap<String, Object>> getMovieCountGenderByMovieNo(int movie_no);
	
	public int getRandomGenreCategoryNoByMoiveNo(int movie_no);
	public ArrayList<MovieVo> getMovieListByGenreCategoryNo(int genre_category_no);
	public ArrayList<HashMap<String, Object>> getAgeGroupsCountByMovieNo(int movie_no); 
	
	public void UpdateReplyPoint(int no);
	public void deleteUpdateReplyPoint(int no);

}
