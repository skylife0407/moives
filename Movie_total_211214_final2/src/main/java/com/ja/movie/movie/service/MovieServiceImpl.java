package com.ja.movie.movie.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.movie.movie.mapper.MovieSQLMapper;
import com.ja.movie.vo.MovieVo;

@Service
public class MovieServiceImpl {
	
	@Autowired
	private MovieSQLMapper movieSQLMapper;
	
	//영화 목록 받아오기.
	public ArrayList<HashMap<String, Object>> getMovieList(){
		
		ArrayList<HashMap<String, Object>> list =
			new ArrayList<HashMap<String,Object>>();		
		ArrayList<MovieVo> movieList = movieSQLMapper.getList();
		
		for(MovieVo movieVo : movieList) {			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("movieVo", movieVo);
			
			list.add(map);			
		}		
		return list;
	}
	
	//박스오피스 목록 받아오기
	public ArrayList<HashMap<String, Object>> getBoxOfficeList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<MovieVo> boxOfficeList = movieSQLMapper.boxOfficeList();
		
		for(MovieVo boxOfficeVo : boxOfficeList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("boxOfficeVo", boxOfficeVo);
			map.put("movieStarAvg", movieSQLMapper.movieStarAvg(boxOfficeVo.getMovie_no()));
			
			list.add(map);
		}
		
		return list;
	}

	
	//추천이 많은 영화 목록 불러오기
	public ArrayList<HashMap<String, Object>> getMovieRecommendList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<MovieVo> movieRecommentList = movieSQLMapper.movieRecommendList();
		
		for(MovieVo recommendList : movieRecommentList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("movieLikeVo", recommendList);
			map.put("movieStarAvg", movieSQLMapper.movieStarAvg(recommendList.getMovie_no()));
			
			list.add(map);
			
		}
		
		return list;
	}
	
	
	//별점순 영화 불러오기
	public ArrayList<HashMap<String, Object>> getMovieStarList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<MovieVo> movieStarList = movieSQLMapper.movieStarList();
		
		for(MovieVo starList : movieStarList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("movieStarVo", starList);
			map.put("movieStarAvg", movieSQLMapper.movieStarAvg(starList.getMovie_no()));
			
			list.add(map);
			
		}
		
		return list;
	}	
	
	
	//선호 장르 받아오기
	public ArrayList<HashMap<String, Object>> getFavorGenreList(int member_no) {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<MovieVo> favorGenreVo = movieSQLMapper.favorList(member_no);
		

		for(MovieVo favorList : favorGenreVo) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("favorGenreVo", favorList);
			map.put("movieStarAvg", movieSQLMapper.movieStarAvg(favorList.getMovie_no()));
			
			list.add(map);
			
		}
		
		return list;
	}
	
	
}
