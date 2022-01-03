package com.ja.movie.onelinereply.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.movie.member.mapper.MemberSQLMapper;
import com.ja.movie.moviePicture.mapper.PosterSQLMapper;
import com.ja.movie.onelinereply.mapper.OneLineReplySQLMapper;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.MovieLikeVo;
import com.ja.movie.vo.MovieVo;
import com.ja.movie.vo.OneLineReplyVo;
import com.ja.movie.vo.PosterVo;

@Service
public class OneLineReplyServiceImpl {
	
	@Autowired
	private OneLineReplySQLMapper onelinereplySQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	@Autowired
	private PosterSQLMapper posterSQLMapper;
	
	public HashMap<String, Object> contentDetails(int movie_no) {
		MovieVo movieVo = onelinereplySQLMapper.getMovieVoByNo(movie_no);
		ArrayList<PosterVo> posterVo = onelinereplySQLMapper.getMoviePosterByNo(movie_no);
		if (posterVo.get(0).getPoster_url() == null) {
			posterVo.get(0).setPoster_url("https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png");
		}
		
		int[] actorNos = null;
		try {
			actorNos = onelinereplySQLMapper.getActorNoBymovieNo(movie_no);
		} catch (IllegalArgumentException e) {
			
		}
		
		ArrayList<String> actorList = new ArrayList<String>();
		try {
			for(int actor_no: actorNos) {
				actorList.add(onelinereplySQLMapper.getActorByActorNo(actor_no));
			}
		} catch (NullPointerException e) {
			actorList.add("배우없음 또는 확인 불가");
		}

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("movieVo", movieVo);
		map.put("posterVo", posterVo);
		map.put("actorList", actorList);

		return map;
		
	}

	
	public void writeOneLineReply(OneLineReplyVo vo) {
		OneLineReplyVo checkingWrite = onelinereplySQLMapper.getMyOneLineReplyByMemberNoAndMovieNo(vo);
		
		if (checkingWrite == null) {
			onelinereplySQLMapper.writeOnelineReply(vo);
			//memberSQLMapper.updateMemberPointByMemberNo(addPoint, vo.getMember_no());
		}

	}
	
	public boolean checkOneLineWrite(OneLineReplyVo vo) {
		OneLineReplyVo onevo = onelinereplySQLMapper.getMyOneLineReplyByMemberNoAndMovieNo(vo);
		if (onevo != null) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public OneLineReplyVo getOneLineReplyVo(OneLineReplyVo vo) {
		return onelinereplySQLMapper.getMyOneLineReplyByMemberNoAndMovieNo(vo);
	}
	
	
	public ArrayList<HashMap<String, Object>> oneLineReplyList(int movie_no) {
		ArrayList<HashMap<String, Object>> oneLineReplyList = new ArrayList<HashMap<String,Object>>();
		
		for(OneLineReplyVo vo:onelinereplySQLMapper.getOneLineReplyByMovieNo(movie_no)) {
			HashMap<String, Object> map= new HashMap<String, Object>();
			MemberVo memberVo = memberSQLMapper.getMemberByNo(vo.getMember_no());
			map.put("memberVo", memberVo);
			map.put("oneLineReplyVo", vo);
			oneLineReplyList.add(map);
		}
		
		return oneLineReplyList;
	}
	
	public void UpdateReplyPoint(int no) {
		onelinereplySQLMapper.UpdateReplyPoint(no);
	}
	
	public void deleteUpdateReplyPoint(int no) {
		onelinereplySQLMapper.deleteUpdateReplyPoint(no);
	}

	public void deleteOneLineReply(OneLineReplyVo vo) {
		onelinereplySQLMapper.deleteOneLineReplyByMovieNoAndMemberNo(vo.getOneLineReply_no());
	}
	
	public void updateOneLineReply(OneLineReplyVo vo) {
		onelinereplySQLMapper.updateOneLineReplyByMovieNoAndMemberNo(vo);
	}

	public double movieStarAvg(int movie_no) {
		double avgmoviestar;
		try {
			avgmoviestar = onelinereplySQLMapper.getMovieStarAvg(movie_no);
		} catch (NullPointerException e) {
			avgmoviestar = 0;
		}
		
		return avgmoviestar;
	}
	//좋아요 관련...
	public void doLikeProcess(MovieLikeVo vo) {
		
		int myCount = onelinereplySQLMapper.isLikeThisMovie(vo);
		
		if(myCount > 0) {
			onelinereplySQLMapper.deleteMovieLikeByMovieNoAndMemberNo(vo);
		}else {
			onelinereplySQLMapper.likeThisMovie(vo);
		}
	}

	public int countMoiveLikes(int movie_no) {
		return onelinereplySQLMapper.getCountMovieLikeByMovieNo(movie_no);
	}
	
	public int isLikeThisMovie(MovieLikeVo vo) {
		return onelinereplySQLMapper.isLikeThisMovie(vo);
	}

	public int countOneLineReply(int movie_no) {
		return onelinereplySQLMapper.getCountOneLineReplyByMovieNo(movie_no);
	}
	
	public MovieVo getMovieVo(int movie_no) {
		return onelinereplySQLMapper.getMovieVoByNo(movie_no);
	}
	
	public ArrayList<String> getActors(int movie_no){
		int[] actorNos = null;
		try {
			actorNos = onelinereplySQLMapper.getActorNoBymovieNo(movie_no);
		} catch (IllegalArgumentException e) {
			System.out.println("actor null");
		}
		
		ArrayList<String> actorList = new ArrayList<String>();
		try {
			for(int actor_no: actorNos) {
				actorList.add(onelinereplySQLMapper.getActorByActorNo(actor_no));
			}
		} catch (NullPointerException e) {
			actorList.add("배우없음 또는 확인 불가");
		}
		
		return actorList;
	}
	
	public ArrayList<HashMap<String, Object>> getMovieStarAvgByGender(int movie_no) {
		return onelinereplySQLMapper.getMovieStarAVGGroupByGenderByMovieNo(movie_no);
		
	}
	
	public ArrayList<HashMap<String, Object>> getMovieCountGenderByMovieNo(int movie_no) {
		return onelinereplySQLMapper.getMovieCountGenderByMovieNo(movie_no);
	}
	
	public ArrayList<HashMap<String, Object>> getMovieListByGenreCategory(int movie_no){
		ArrayList<HashMap<String, Object>> movieListByGenreCategory = new ArrayList<HashMap<String, Object>>();
		
		int randomGenreCategoryNo = onelinereplySQLMapper.getRandomGenreCategoryNoByMoiveNo(movie_no);
		
		ArrayList<MovieVo> movieVoList = onelinereplySQLMapper.getMovieListByGenreCategoryNo(randomGenreCategoryNo);
		
		for(MovieVo vo:movieVoList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			PosterVo posterVo = new PosterVo();
			
			posterVo = posterSQLMapper.posterPrint(vo.getMovie_no());
			if (posterVo.getPoster_url() == null) {
				posterVo.setPoster_url("https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png");
			}
			map.put("posterVo", posterVo);
			map.put("movieVo",vo);
			movieListByGenreCategory.add(map);
		}
		
		return movieListByGenreCategory;
	}
	
	public ArrayList<HashMap<String, Object>> getAgeGroupsCntByMovieNo(int movie_no) {
		
		return onelinereplySQLMapper.getAgeGroupsCountByMovieNo(movie_no);
	}
	
	
	
}
