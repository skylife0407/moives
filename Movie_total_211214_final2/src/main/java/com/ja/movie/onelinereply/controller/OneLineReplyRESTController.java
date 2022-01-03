package com.ja.movie.onelinereply.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.movie.member.service.MemberServiceImpl;
import com.ja.movie.onelinereply.service.OneLineReplyServiceImpl;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.MovieLikeVo;
import com.ja.movie.vo.MovieVo;
import com.ja.movie.vo.OneLineReplyVo;


@Controller
@RequestMapping("/board/onelinereply/*")
@ResponseBody
public class OneLineReplyRESTController {

	@Autowired
	private OneLineReplyServiceImpl oneLineReplyService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@RequestMapping("doLikeRest.do")
	public void doLike(MovieLikeVo param , HttpSession session) {
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		param.setMember_no(member_no);
		
		oneLineReplyService.doLikeProcess(param);		
		
	}
	
	@RequestMapping("getMyLikeData.do")
	public HashMap<String, Object> getMyLikeData(MovieLikeVo param , HttpSession session){
		//내가 클릭 했냐??
		HashMap<String, Object> data = new HashMap<String, Object>();

		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		param.setMember_no(member_no);
		
		int myCount = oneLineReplyService.isLikeThisMovie(param);	
		
		data.put("myLikeCount", myCount);
		
		return data;
	}
	
	
	
	@RequestMapping("getTotalLikeCount.do")
	public HashMap<String, Object> getTotalLikeCount(int movie_no){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		int totalLikeCount = oneLineReplyService.countMoiveLikes(movie_no);
		data.put("totalLikeCount", totalLikeCount);
		
		return data;
	}
	
	@RequestMapping("getAvgStar.do")
	public HashMap<String, Object> getAvgStar(int movie_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		double movieStarAvg = oneLineReplyService.movieStarAvg(movie_no);
		data.put("movieStarAvg", movieStarAvg);
		
		return data;
	}
	
	
	//댓글 관련...
	@RequestMapping("writeCommentProcess.do")
	public HashMap<String, Object> writeCommentProcess(OneLineReplyVo param , HttpSession session) {
		
		HashMap<String, Object> data = new HashMap<String, Object>(); 
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		param.setMember_no(member_no);		
		
		oneLineReplyService.writeOneLineReply(param);
		
		oneLineReplyService.UpdateReplyPoint(member_no);

		/*
		if(문제가 없으면..??) {
			data.put("result", "success");
		}else {
			data.put("result", "fail");
			data.put("reason", "DB 연동 오류...");
			data.put("errorCode", "10053");
		}
		*/
		return data;
	}

	
	@RequestMapping("deleteCommentProcess.do")
	public void deleteCommentProcess(OneLineReplyVo param, HttpSession session) {
		
		oneLineReplyService.deleteOneLineReply(param);
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		oneLineReplyService.deleteUpdateReplyPoint(member_no);

		
	}
	
	@RequestMapping("updateCommentProcess.do")
	public void updateCommentProcess(OneLineReplyVo param) {
		oneLineReplyService.updateOneLineReply(param);
		
	}
	
	@RequestMapping("getCommentList.do")
	public HashMap<String, Object> getCommentList(int movie_no){
		HashMap<String, Object> data = new HashMap<String, Object>(); 
		
		ArrayList<HashMap<String, Object>> commentlist = 
				oneLineReplyService.oneLineReplyList(movie_no);
		
		ArrayList<HashMap<String, Object>> icons = memberService.getIconShopList();
		
		data.put("commentlist", commentlist);
		data.put("icons", icons);
		
		
		return data;
	}	
	
	@RequestMapping("checkingUserWrote.do")
	public HashMap<String, Object> checkingUserWrote(int movie_no, HttpSession session) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		OneLineReplyVo vo = new OneLineReplyVo();
		if(sessionUser != null) {
			int member_no = sessionUser.getMember_no();
			vo.setMember_no(member_no);
			vo.setMovie_no(movie_no);
		}else {
			int member_no = 0; 
			vo.setMember_no(member_no);
			vo.setMovie_no(movie_no);
		}
		
		boolean checkUserWrote = oneLineReplyService.checkOneLineWrite(vo);
		
		if(sessionUser != null && checkUserWrote) {
			data.put("isWrite", true);
		}else {
			data.put("isWrite", false);
		}
		
		return data;
	}
	
	@RequestMapping("getMyReply.do")
	public HashMap<String, Object> getMyReply(int movie_no, HttpSession session) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		OneLineReplyVo vo = new OneLineReplyVo();
		
		vo.setMember_no(member_no);
		vo.setMovie_no(movie_no);
		
		OneLineReplyVo myOneLineReplyVo = oneLineReplyService.getOneLineReplyVo(vo);
		
		data.put("myOneLineReplyVo", myOneLineReplyVo);
		
		return data;
	}
	
	@RequestMapping("getMovieInfo.do")
	public HashMap<String, Object> getMovieDetails(int movie_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MovieVo movieVo = oneLineReplyService.getMovieVo(movie_no);
		ArrayList<String> actorList = oneLineReplyService.getActors(movie_no);
		ArrayList<HashMap<String, Object>> movieStarAvgByGender = oneLineReplyService.getMovieStarAvgByGender(movie_no);
		ArrayList<HashMap<String, Object>> movieGenderCount = oneLineReplyService.getMovieCountGenderByMovieNo(movie_no);
		
		data.put("movieVo", movieVo);
		data.put("actorList", actorList);
		data.put("movieStarAvgByGender", movieStarAvgByGender);
		data.put("movieGenderCount", movieGenderCount);
		return data;
	}
	
	@RequestMapping("getMovieStatistics.do")
	public HashMap<String, Object> getMovieStatistics(int movie_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> movieStarAvgByGender = oneLineReplyService.getMovieStarAvgByGender(movie_no);
		ArrayList<HashMap<String, Object>> movieGenderCount = oneLineReplyService.getMovieCountGenderByMovieNo(movie_no);
		ArrayList<HashMap<String, Object>> getAgeGroupsCount = oneLineReplyService.getAgeGroupsCntByMovieNo(movie_no);
		data.put("movieStarAvgByGender", movieStarAvgByGender);
		data.put("movieGenderCount", movieGenderCount);
		data.put("getAgeGroupsCount", getAgeGroupsCount);
		return data;
	}
	
	@RequestMapping("getRecommendMoiveListByGenre.do")
	public HashMap<String, Object> recommendMovieByGenre(int movie_no) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> recommendMovieListByGenre = oneLineReplyService.getMovieListByGenreCategory(movie_no);
		data.put("recommendMovieListByGenre", recommendMovieListByGenre);
		
		return data;
	}
	
	
}
