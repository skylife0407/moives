package com.ja.movie.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.movie.eventboard.mapper.EventBoardSQLMapper;
import com.ja.movie.member.mapper.MemberSQLMapper;
import com.ja.movie.reviewboard.mapper.ReviewBoardSQLMapper;
import com.ja.movie.vo.EventBoardVo;
import com.ja.movie.vo.FreeBoardVo;
import com.ja.movie.vo.GenreCategoryVo;
import com.ja.movie.vo.GenreVo;
import com.ja.movie.vo.IconVo;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.MovieLikeVo;
import com.ja.movie.vo.OneLineReplyVo;
import com.ja.movie.vo.ReviewBoardVo;
import com.ja.movie.test.MessageDigestUtil;

@Service
public class MemberServiceImpl {
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	@Autowired
	private EventBoardSQLMapper eventBoardSQLMapper;
	@Autowired
	private ReviewBoardSQLMapper reviewMemberSQLMapper;
	
	public boolean isExistId(String id) {
		
		int count = memberSQLMapper.getCountByMemberId(id);		
		if(count > 0) {
			return true;
		}else {
			return false;
		}
		
	}
	
	public void joinMember(MemberVo vo, int [] genre_category_no) {
		
		int memberNo = memberSQLMapper.createMemberPK();
		vo.setMember_no(memberNo);
		String hashValue = MessageDigestUtil.getPasswordHashCode(vo.getMember_pw());
		vo.setMember_pw(hashValue);
		
		memberSQLMapper.register(vo);
		
		if(genre_category_no != null) {
			for(int no : genre_category_no) {
				GenreVo genreVo = new GenreVo();
				genreVo.setGenrecategory_no(no);
				genreVo.setMember_no(memberNo);
				
				memberSQLMapper.registerGenre(genreVo);
			}
		}
		
	}
	//계정장르정보	
	public ArrayList<HashMap<String, Object>> memberByGenre(int no) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<GenreVo> genreList = memberSQLMapper.memberByGenre(no);
		
		for(GenreVo genreVo : genreList) {			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("GenreVo", genreVo);
			
			list.add(map);
		}		
		return list;
	}
	
	//장르 목록 받아오기
	public ArrayList<HashMap<String, Object>> getGenreList() {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<GenreCategoryVo> genreList = memberSQLMapper.genreList();
		
		for(GenreCategoryVo genreCategoryVo : genreList) {			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("genreCategoryVo", genreCategoryVo);
			
			list.add(map);
		}		
		return list;		
	}

	public MemberVo login(MemberVo vo) {
		//암호화부분
		String hashValue = MessageDigestUtil.getPasswordHashCode(vo.getMember_pw());
		vo.setMember_pw(hashValue);
		
		MemberVo result = memberSQLMapper.getMemberByIdAndPw(vo);
		
		return result;
	}
	
	//정보 변경
	public void memberNickChange(MemberVo vo) {
		
		memberSQLMapper.memberNickChange(vo);
		
	}
	
	//이메일 변경
	public void memberEmailChange(MemberVo vo) {
		memberSQLMapper.memberEmailChange(vo);
	}
	
	public void userGenreDel(int member_no) {
		memberSQLMapper.userGenreDel(member_no);
	}
	public void memberMovieChange(int member_no, int [] genre_category_no) {
		
		
		if(genre_category_no != null) {
			for(int no : genre_category_no) {
				GenreVo genreVo = new GenreVo();
				genreVo.setGenrecategory_no(no);
				genreVo.setMember_no(member_no);
				
				memberSQLMapper.memberMovieChange(genreVo);
			}
		}		
	}

	
	//비밀번호 변경
	public void memberPwChange(MemberVo vo) {
		//암호화부분
		String hashValue = MessageDigestUtil.getPasswordHashCode(vo.getMember_pw());
		vo.setMember_pw(hashValue);
		memberSQLMapper.memberPwChange(vo);		
	}
	

	
	
	//Movie_Like테이블 받아오기
	public ArrayList<HashMap<String, Object>> getMovieLikeList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<MovieLikeVo> movieLikeList = memberSQLMapper.recommendList();
		
		for(MovieLikeVo movieLikeVo : movieLikeList) {			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("movieLikeVo", movieLikeVo);
			
			list.add(map);
		}
		return list;
	}
	
	//OneLineReply테이블 받아오기
	public ArrayList<OneLineReplyVo> getOneLineList(){
		
		ArrayList<OneLineReplyVo> list = new ArrayList<OneLineReplyVo>();		
		ArrayList<OneLineReplyVo> movieEvalList = memberSQLMapper.evalList();
		
		for(OneLineReplyVo movieEval : movieEvalList) {			
			list.add(movieEval);			
		}		
		return list;
	}
	
	//6개 미만으로 추천 받아오기
	   public ArrayList<MovieLikeVo> getMemberRecommend(int member_no){
	      
	      ArrayList<MovieLikeVo> list = new ArrayList<MovieLikeVo>();
	      ArrayList<MovieLikeVo> memberRecommend = memberSQLMapper.memberRecommend(member_no);
	      
	      for(MovieLikeVo movieLikeVo : memberRecommend) {
	         list.add(movieLikeVo);
	      }
	      
	      return list;
	   }
	   
	   //6개 미만으로 평가 받아오기
	   public ArrayList<OneLineReplyVo> getMemberEval(int member_no){
	      
	      ArrayList<OneLineReplyVo> list = new ArrayList<OneLineReplyVo>();
	      ArrayList<OneLineReplyVo> memberEval = memberSQLMapper.memberEval(member_no);
	      
	      for(OneLineReplyVo oneLineReplyVo : memberEval) {
	         list.add(oneLineReplyVo);
	      }
	      
	      return list;
	   }

	
	
	
	
	
	//FreeBoard테이블 받아오기
	public ArrayList<FreeBoardVo> getFreeBoardList(){
		
		ArrayList<FreeBoardVo> list = new ArrayList<FreeBoardVo>();		
		ArrayList<FreeBoardVo> freeBoardList = memberSQLMapper.freeBoardList();
		
		for(FreeBoardVo freeBoard : freeBoardList) {			
			list.add(freeBoard);
		}		
		return list;
	}
	
	//ReviewBoard테이블 받아오기
	public ArrayList<ReviewBoardVo> getReviewBoardList(){
		
		ArrayList<ReviewBoardVo> list = new ArrayList<ReviewBoardVo>();
		
		ArrayList<ReviewBoardVo> reviewBoardList = memberSQLMapper.reviewBoardList();
		
		for(ReviewBoardVo reviewBoard : reviewBoardList ) {
			
			list.add(reviewBoard);
		}
		
		return list;
	}
	
	// 로그인 로그 및 포인트
	public void loginLog(int no) {
		memberSQLMapper.registerAttend(no);
	}
	public void loginUpdatePoint(int member_no) {
		memberSQLMapper.loginUpdatePoint(member_no);
	}
	public void loginRandomUpdatePoint(int member_no) {
		memberSQLMapper.loginRandomUpdatePoint(member_no);
	}
	public void continuityLoginPoint(int member_no) {
		memberSQLMapper.continuityLoginPoint(member_no);
	}
	public int loginPoint(int no) {
		return memberSQLMapper.getAttendanceCheck(no);
	}
	public int weekloginPoint(int no) {
		return memberSQLMapper.getContinuityPoint(no);
	}
	
	//회원정보 테이블 받아오기
	public ArrayList<HashMap<String, Object>> getAdminMemberList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<MemberVo> adminMemberList = memberSQLMapper.adminMemberList();
		
		for(MemberVo adminMemberListVo : adminMemberList) {			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("adminMemberListVo", adminMemberListVo);			
			list.add(map);
		}		
		return list;
	}	
	//계정상태 조회
	public MemberVo viewAdminMember(int member_no) {
		
		MemberVo memberNo = memberSQLMapper.getMemberByNo(member_no);
		
		return memberNo;
	}
	//로그인 체킹
	public String loginCheck(String member_id) {
			
		String memberActivity = memberSQLMapper.getMemberByActivity(member_id);
		
		return memberActivity;
	}

	
	//계정 활성상태변경
	public void adminMemberActivity(int memberNo, int activityNo) {
		
		memberSQLMapper.adminMemberActivity(memberNo, activityNo);	
	}
	//계정 권한변경
	public void adminMemberAuth(int memberNo, int authNo) {
		
		memberSQLMapper.adminMemberAuth(memberNo, authNo);
	}
	
	//자유게시판 테이블 받아오기
	public ArrayList<HashMap<String, Object>> getAdminfreeBoardList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<FreeBoardVo> adminFreeBoardList = memberSQLMapper.freeBoardList();
		
		for(FreeBoardVo adminFreeBoardListVo : adminFreeBoardList) {
			int member_no = adminFreeBoardListVo.getMember_no();			
			MemberVo adminMemberListVo = memberSQLMapper.getMemberByNo(member_no);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("adminFreeBoardListVo", adminFreeBoardListVo);
			map.put("adminMemberListVo", adminMemberListVo);
			list.add(map);
		}		
		return list;
	}
	//자유게시판 설정
	public void adminFreeBoardPatch(int boardNo, int activityNo) {
		
		memberSQLMapper.adminFreeBoardPatch(boardNo,activityNo);
	}
	
	//리뷰게시판 테이블 받아오기
	public ArrayList<HashMap<String, Object>> getAdminReviewBoardList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<ReviewBoardVo> adminReviewBoardList = reviewMemberSQLMapper.getReviewList();
		
		for(ReviewBoardVo adminReviewBoardListVo : adminReviewBoardList) {
			int member_no = adminReviewBoardListVo.getMember_no();			
			MemberVo adminMemberListVo = memberSQLMapper.getMemberByNo(member_no);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("adminReviewBoardListVo", adminReviewBoardListVo);
			map.put("adminMemberListVo", adminMemberListVo);
			
			list.add(map);
		}		
		return list;
	}
	//리뷰게시판 설정
	public void adminReviewBoardPatch(int boardNo, int activityNo) {
		
		memberSQLMapper.adminReviewBoardPatch(boardNo, activityNo);
	}
	
	//이벤트게시판 테이블 받아오기
	public ArrayList<HashMap<String, Object>> getAdminEventBoardList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<EventBoardVo> adminEventBoardList = eventBoardSQLMapper.getEventList();
		
		for(EventBoardVo adminEventBoardListVo : adminEventBoardList) {
			int member_no = adminEventBoardListVo.getMember_no();			
			MemberVo adminMemberListVo = memberSQLMapper.getMemberByNo(member_no);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("adminEventBoardListVo", adminEventBoardListVo);
			map.put("adminMemberListVo", adminMemberListVo);
			
			list.add(map);
		}		
		return list;
	}
	//이벤트게시판 설정
	public void adminEventBoardPatch(int boardNo, int activityNo) {
		
		memberSQLMapper.adminEventBoardPatch(boardNo, activityNo);
	}
	
	//아이콘상점 테이블 받아오기
	public ArrayList<HashMap<String, Object>> getIconShopList(){
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();		
		ArrayList<IconVo> iconShopList = memberSQLMapper.iconShopList();
		
		for(IconVo iconShopVo : iconShopList) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();			
			map.put("iconShopVo", iconShopVo);
			list.add(map);
		}		
		return list;
	}
	//아이콘 구매설정
	public void iconBuy(int member_no, int icon_no, int icon_price) {
		
		memberSQLMapper.iconBuy(member_no, icon_no, icon_price);
	}
	public void iconChange(ArrayList<IconVo> iconVoList) {

		for(IconVo iconVo : iconVoList) {
			memberSQLMapper.iconChangeImage(iconVo);
		}		
	}
	public void iconUpload(ArrayList<IconVo> iconVoList) {
		
		//이미지 정보 insert
		for(IconVo iconVo : iconVoList) {
			memberSQLMapper.iconUploadImage(iconVo);
		}
	}
		
}