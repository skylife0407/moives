package com.ja.movie.member.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.movie.vo.EventBoardVo;
import com.ja.movie.vo.FreeBoardVo;
import com.ja.movie.vo.GenreCategoryVo;
import com.ja.movie.vo.GenreVo;
import com.ja.movie.vo.IconVo;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.MovieLikeVo;
import com.ja.movie.vo.OneLineReplyVo;
import com.ja.movie.vo.ReviewBoardVo;

public interface MemberSQLMapper {
	
	public int createMemberPK();
	public void register(MemberVo vo);
	
	public MemberVo getMemberByIdAndPw(MemberVo vo);
	
	public MemberVo getMemberByNo(int no);
	public String getMemberByActivity(String id);

	public int getCountByMemberId(String id);
	
	//회원가입 시 장르 선택 관련
	public ArrayList<GenreCategoryVo> genreList();
	public void registerGenre(GenreVo vo);
	public ArrayList<GenreVo> memberByGenre(int no);
	
	//회원정보페이지 관련
	//닉네임 변경
	public void memberNickChange(MemberVo vo);   
	//비밀번호 변경
	public void memberPwChange(MemberVo vo);
	//이메일 변경
	public void memberEmailChange(MemberVo vo);
	//선호장르 변경
	public void memberMovieChange(GenreVo vo);
	public void userGenreDel(int no);
	//추천리스트 받기
	public ArrayList<MovieLikeVo> recommendList();
	
	//평가리스트 받기
	public ArrayList<OneLineReplyVo> evalList();
	
	//6개미만 추천
	public ArrayList<MovieLikeVo> memberRecommend(int member_no);
	//6개미만 평가
	public ArrayList<OneLineReplyVo> memberEval(int member_no);
	

	//자유게시판 게시글 리스트 받기
	public ArrayList<FreeBoardVo> freeBoardList();
	
	//리뷰게시판 게시글 리스트 받기
	public ArrayList<ReviewBoardVo> reviewBoardList();
	
	//로그인시 포인트 획득
	public void registerAttend(int vo);
	public int getAttendanceCheck(int no);
	public int getContinuityPoint(int no);
	public void loginUpdatePoint(int member_no);
	public void loginRandomUpdatePoint(int member_no);
	public void continuityLoginPoint(int member_no);

	//관리자 관련
	public ArrayList<MemberVo> adminMemberList();
	public ArrayList<ReviewBoardVo> adminReviewBoardList();
	public ArrayList<EventBoardVo> adminEventBoardList();
	
	public void adminFreeBoardPatch(@Param("boardNo") int boardNo, @Param("activityNo") int activityNo);
	public void adminReviewBoardPatch(@Param("boardNo") int boardNo, @Param("activityNo") int activityNo);	
	public void adminEventBoardPatch(@Param("boardNo") int boardNo, @Param("activityNo") int activityNo);
	public void adminMemberActivity(@Param("memberNo") int memberNo, @Param("activityNo") int activityNo);
	public void adminMemberAuth(@Param("memberNo") int memberNo, @Param("authNo") int authNo);
	
	//아이콘상점 리스트 받기
	public ArrayList<IconVo> iconShopList();
	public void iconBuy(@Param("memberNo") int memberNo, @Param("iconNo") int iconNo, @Param("iconPrice") int iconPrice);
	public void iconUploadImage(IconVo vo);
	public void iconChangeImage(IconVo vo);

	
}
