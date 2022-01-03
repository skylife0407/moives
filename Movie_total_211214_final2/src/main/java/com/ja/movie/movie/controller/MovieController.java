package com.ja.movie.movie.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ja.movie.movie.service.MovieServiceImpl;
import com.ja.movie.moviePicture.service.MoviePictureServiceImpl;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.MovieVo;
import com.ja.movie.vo.PosterVo;

@Controller
@RequestMapping("/movieList/*")
public class MovieController {
	
	@Autowired
	private MovieServiceImpl movieService;
	
	@Autowired
	private MoviePictureServiceImpl moviePictureServiceImpl;
	
	@RequestMapping("movieListPage.do")
	public String movieListPage(Model model, HttpSession session) {
		
		try {
			MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
			int member_no = sessionUser.getMember_no();

			ArrayList<HashMap<String, Object>> favorList = movieService.getFavorGenreList(member_no);
			model.addAttribute("favorList", favorList);
		} catch (Exception e) {
			
		}
		
		ArrayList<HashMap<String, Object>> movieList = movieService.getMovieList();		
		model.addAttribute("movieList", movieList);
		
		ArrayList<HashMap<String, Object>> boxOfficeList = movieService.getBoxOfficeList();		
		model.addAttribute("boxList", boxOfficeList);
		
		ArrayList<PosterVo> posterVoList = moviePictureServiceImpl.posterList();	      
		model.addAttribute("posterVoList", posterVoList);
		
		ArrayList<HashMap<String, Object>> recommendList = movieService.getMovieRecommendList();		
		model.addAttribute("recommendList", recommendList);
		
		ArrayList<HashMap<String, Object>> starList = movieService.getMovieStarList();		
		model.addAttribute("starList", starList);
	
		return "movieList/movieListPage";
	}
	
	//마이초이스
	@RequestMapping("myChoicePage.do")
	public String myChoicePage(Model model, HttpSession session) {
		
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		ArrayList<HashMap<String, Object>> favorList = movieService.getFavorGenreList(member_no);
		model.addAttribute("favorList", favorList);
		
		ArrayList<PosterVo> posterVoList = moviePictureServiceImpl.posterList();	      
		model.addAttribute("posterVoList", posterVoList);
		
		return "movieList/myChoicePage";
	}
	
	//박스오피스
	@RequestMapping("boxOfficePage.do")
	public String boxOfficePage(Model model) {
		
		ArrayList<HashMap<String, Object>> boxOfficeList = movieService.getBoxOfficeList();		
		model.addAttribute("boxList", boxOfficeList);
		
		ArrayList<PosterVo> posterVoList = moviePictureServiceImpl.posterList();	     
		model.addAttribute("posterVoList", posterVoList);
		
		return "movieList/boxOfficePage";
	}

	
	//추천
	@RequestMapping("movieRecommendPage.do")
	public String movieRecommendPage(Model model) {
		
		ArrayList<HashMap<String, Object>> recommendList = movieService.getMovieRecommendList();		
		model.addAttribute("recommendList", recommendList);
		
		ArrayList<PosterVo> posterVoList = moviePictureServiceImpl.posterList();	     
		model.addAttribute("posterVoList", posterVoList);
		
		return "movieList/movieRecommendPage";
	}	
	
	//별점
	@RequestMapping("movieStarPage.do")
	public String movieStarPage(Model model) {
		
		ArrayList<HashMap<String, Object>> starList = movieService.getMovieStarList();		
		model.addAttribute("starList", starList);
		
		ArrayList<PosterVo> posterVoList = moviePictureServiceImpl.posterList();	     
		model.addAttribute("posterVoList", posterVoList);		
		
		return "movieList/movieStarPage";
	}
	
	
}
