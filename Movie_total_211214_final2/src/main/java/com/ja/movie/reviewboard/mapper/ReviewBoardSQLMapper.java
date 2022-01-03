package com.ja.movie.reviewboard.mapper;

import java.util.ArrayList;


import com.ja.movie.vo.FreeBoardReplyVo;
import com.ja.movie.vo.FreeBoardVo;
import com.ja.movie.vo.ReviewBoardImageVo;
import com.ja.movie.vo.ReviewBoardLikeVo;
import com.ja.movie.vo.ReviewBoardReplyVo;
import com.ja.movie.vo.ReviewBoardVo;

public interface ReviewBoardSQLMapper {
	
	public int createBoardPK();
	//
	public void reviewWriteContent(ReviewBoardVo vo);
	public ArrayList<ReviewBoardVo> getReviewList();
	public ReviewBoardVo getReviewBoardByNo(int no);
	public void reviewDeleteByNo(int no);
	public void reviewUpdate(ReviewBoardVo vo);
	public void increaseReviewReadCount(int no);
	
	//이미지 관련
	public void registerImage(ReviewBoardImageVo vo);
	public ArrayList<ReviewBoardImageVo> getReviewBoardImages(int reviewboardNo);
	
	
	
	//글작성시 포인트 획득
	   public void reviewUpdatePoint(int no);
	   public void reviewdeleteUpdatePoint(int no);
	   //댓글작성시 포인트 획득
	   public void reviewUpdateReplyPoint(int no);
	   public void reviewdeleteUpdateReplyPoint(int no);
	
	//좋아요 관련
	public void like(ReviewBoardLikeVo vo);
	public void unLike(ReviewBoardLikeVo vo);
	public int myLikeCount(ReviewBoardLikeVo vo);
	public int totalLikeCount(int reviewboardNo);
	
	//댓글관련
	public void reviewWriteReplyContent(ReviewBoardReplyVo vo);	
	public ArrayList<ReviewBoardReplyVo> getReviewBoardReplyList();
	
	//리뷰게시판 댓글 관련
	public void reviewReplyWriteContent(ReviewBoardReplyVo vo);
	public void reviewReplyDelete(int no);
	public void reviewReplyUpdate(ReviewBoardReplyVo vo);
	public ArrayList<ReviewBoardReplyVo> getReviewReplyByNo(int reviewBoard_no);
	public ReviewBoardImageVo getReviewBoardImg(int reviewBoard_no);
	
	
}
