package com.ja.movie.moviePicture.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.movie.moviePicture.service.MoviePictureServiceImpl;
import com.ja.movie.vo.PosterVo;

@Controller
@RequestMapping("/moviePicture/*")
public class MoviePictureController {

	@Autowired
	private MoviePictureServiceImpl moviePictureServiceImpl;
	
	@RequestMapping("poster.do")
	public String poster(Model model) {
      
		ArrayList<PosterVo> posterVoList = moviePictureServiceImpl.posterList();
	      
		model.addAttribute("posterVoList", posterVoList);
	      
		return "moviePicture/poster";
	}
	
	@RequestMapping("stll.do")
	public String stll(Model model) {
		
		ArrayList<HashMap<String, Object>> list = moviePictureServiceImpl.getStllList();
		
		model.addAttribute("stllList", list);
		
		return "moviePicture/stll";
	}
	
	
}
