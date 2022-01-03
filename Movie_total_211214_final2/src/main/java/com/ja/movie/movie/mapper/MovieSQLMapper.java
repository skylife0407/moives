package com.ja.movie.movie.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import com.ja.movie.vo.MovieVo;

public interface MovieSQLMapper {
	
	public ArrayList<MovieVo> getList();
	
	public ArrayList<MovieVo> boxOfficeList();
	
	public ArrayList<MovieVo> movieRecommendList();
	
	public ArrayList<MovieVo> movieStarList();
	
	//영화 별점 가져오기
	public double movieStarAvg(int movie_no);
	
	//선호장르
	public ArrayList<MovieVo> favorList(int member_no);
	
}
