package com.ja.movie.moviePicture.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.movie.movie.mapper.MovieSQLMapper;
import com.ja.movie.moviePicture.mapper.PosterSQLMapper;
import com.ja.movie.moviePicture.mapper.StllSQLMapper;
import com.ja.movie.vo.MovieVo;
import com.ja.movie.vo.PosterVo;
import com.ja.movie.vo.StllVo;

@Service
public class MoviePictureServiceImpl {
	
	@Autowired
	private PosterSQLMapper posterSQLMapper;
	
	@Autowired
	private StllSQLMapper stllSQLMapper;
	
	@Autowired
	private MovieSQLMapper movieSQLMapper;
	
	//포스터 목록 받아오기
	public ArrayList<PosterVo> posterList() {
	      ArrayList<PosterVo> list = new ArrayList<PosterVo>();
	      
	      ArrayList<MovieVo> movieList= movieSQLMapper.getList();
	      
	      for(MovieVo vo:movieList) {
	         list.add(posterSQLMapper.posterPrint(vo.getMovie_no()));
	      }
	      
	      return list;
	   }
	
	//스틸컷 목록 받아오기
	public ArrayList<HashMap<String, Object>> getStllList(){
		
		ArrayList<HashMap<String, Object>> list =
				new ArrayList<HashMap<String,Object>>();
		
		ArrayList<StllVo> stllList = stllSQLMapper.stllPrint();
		
		for(StllVo stllVo : stllList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("stllVo", stllVo);
			
			list.add(map);
			
		}
		
		return list;
	}
}
