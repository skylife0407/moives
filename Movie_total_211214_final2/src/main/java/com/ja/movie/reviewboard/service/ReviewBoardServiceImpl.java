package com.ja.movie.reviewboard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.ja.movie.member.mapper.MemberSQLMapper;
import com.ja.movie.movie.mapper.MovieSQLMapper;
import com.ja.movie.moviePicture.mapper.PosterSQLMapper;
import com.ja.movie.reviewboard.mapper.ReviewBoardSQLMapper;
import com.ja.movie.vo.FreeBoardReplyVo;
import com.ja.movie.vo.FreeBoardVo;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.MovieVo;
import com.ja.movie.vo.PosterVo;
import com.ja.movie.vo.ReviewBoardImageVo;
import com.ja.movie.vo.ReviewBoardLikeVo;
import com.ja.movie.vo.ReviewBoardReplyVo;
import com.ja.movie.vo.ReviewBoardVo;

	@Service
	public class ReviewBoardServiceImpl {

	@Autowired
	private ReviewBoardSQLMapper reviewboardSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;	
	
	
	public void reviewWriteContent(ReviewBoardVo vo , ArrayList<ReviewBoardImageVo> imageVoList) {
		
		int reviewboard_no = reviewboardSQLMapper.createBoardPK();
		vo.setReviewboard_no(reviewboard_no);
		reviewboardSQLMapper.reviewWriteContent(vo);
		
		//이미지 정보 insert
		for(ReviewBoardImageVo imageVo : imageVoList) {
			imageVo.setReviewboard_no(reviewboard_no);
			reviewboardSQLMapper.registerImage(imageVo);
		}
		
		
		
	}
	
	public ArrayList<HashMap<String, Object>> getReviewList() {
		
		ArrayList<HashMap<String, Object>> list = 
				new ArrayList<HashMap<String, Object>>();
		
		ArrayList<ReviewBoardVo> reviewBoardList = reviewboardSQLMapper.getReviewList();
		
		for(ReviewBoardVo reviewboardVo : reviewBoardList) {
			int member_no = reviewboardVo.getMember_no();
			int reviewBoard_no = reviewboardVo.getReviewboard_no();
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
		ReviewBoardImageVo imgVo = reviewboardSQLMapper.getReviewBoardImg(reviewBoard_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberVo", memberVo);
		map.put("reviewBoardVo", reviewboardVo);
		map.put("imgVo", imgVo);
		
		list.add(map);
		
		}
		
		return list;
	}


	public HashMap<String, Object> getReview(int review_no) {
	
		reviewboardSQLMapper.increaseReviewReadCount(review_no);
	
		HashMap<String, Object> map = new HashMap<String, Object>();
	
		ReviewBoardVo reviewboardVo = reviewboardSQLMapper.getReviewBoardByNo(review_no);
		int member_no = reviewboardVo.getMember_no();
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
	
		ArrayList<ReviewBoardImageVo> imageVoList =
				reviewboardSQLMapper.getReviewBoardImages(review_no);
		
		map.put("reviewBoardVo", reviewboardVo);
		map.put("memberVo", memberVo);
		map.put("imageVoList", imageVoList);
		
		return map;
	}

	public void reviewDeleteContent(int review_no) {
		reviewboardSQLMapper.reviewDeleteByNo(review_no);
	}
	
	public void reviewUpdateContent(ReviewBoardVo vo) {
		
		reviewboardSQLMapper.reviewUpdate(vo);
		
	}

	//리뷰 글작성 포인트 획득
	   public void reviewWriteUpdatePoint(int no) {
	      reviewboardSQLMapper.reviewUpdatePoint(no);
	   }
	   public void reviewDeleteUpdatePoint(int no) {
	      reviewboardSQLMapper.reviewdeleteUpdatePoint(no);
	   }
	   //리뷰 댓글작성 포인트 획득
	   public void reviewWriteReplyPoint(int no) {
	      reviewboardSQLMapper.reviewUpdateReplyPoint(no);
	   }
	   public void reviewDeleteReplyPoint(int no) {
	      reviewboardSQLMapper.reviewdeleteUpdateReplyPoint(no);
	   }	
		
	//댓글 관련
	public void writeReviewBoardReply(ReviewBoardReplyVo vo) {
			
		reviewboardSQLMapper.reviewReplyWriteContent(vo);
			
	}
		
	public ArrayList<HashMap<String, Object>> getReviewBoardReplyList(){
			
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();		
	ArrayList<ReviewBoardReplyVo> replyList = reviewboardSQLMapper.getReviewBoardReplyList();
			
	for(ReviewBoardReplyVo replyVo : replyList) {
		int member_no = replyVo.getMember_no();			
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);			
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberVo", memberVo);
		map.put("replyVo", replyVo);	
		
		list.add(map);			
	}		
	return list;
}

	//리뷰게시판 댓글 관련
	public void reviewReplyWriteContent(ReviewBoardReplyVo vo) {	
		reviewboardSQLMapper.reviewReplyWriteContent(vo);
   }


	public void reviewWriteReply(ReviewBoardReplyVo vo) {
		reviewboardSQLMapper.reviewReplyWriteContent(vo);
	}
		
	public void reviewDeleteReply(ReviewBoardReplyVo vo) {
		reviewboardSQLMapper.reviewReplyDelete(vo.getReviewboard_reply_no());
	}
		
	public void reviewUpdateReply(ReviewBoardReplyVo vo) {
		reviewboardSQLMapper.reviewReplyUpdate(vo);
	}
		 
	public ArrayList<HashMap<String,Object>> getReviewReplyList(int reviewboardNo){		
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();		
		ArrayList<ReviewBoardReplyVo> reviewBoardReplyVoList = reviewboardSQLMapper.getReviewReplyByNo(reviewboardNo);
		
		for(ReviewBoardReplyVo reviewBoardReplyVo : reviewBoardReplyVoList) {
			System.out.println(reviewBoardReplyVo.getReviewboard_reply_content());
			
		}
		
		for(ReviewBoardReplyVo reviewBoardReplyVo : reviewBoardReplyVoList) {
			int memberNo = reviewBoardReplyVo.getMember_no();			
			MemberVo memberVo = memberSQLMapper.getMemberByNo(memberNo);
				
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
				
			map.put("reviewBoardReplyVo", reviewBoardReplyVo);
			list.add(map);
		}		
		return list;
	}

	//좋아요 관련...
	public void doLikeProcess(ReviewBoardLikeVo vo) {
			
		int myCount = reviewboardSQLMapper.myLikeCount(vo);
			
		if(myCount > 0) {
			reviewboardSQLMapper.unLike(vo);
		}else {
			reviewboardSQLMapper.like(vo);
		}
	}

	public int getTotalLikeCount(int boardNo) {
		return reviewboardSQLMapper.totalLikeCount(boardNo);
	}
		
	public int getMyLikeCount(ReviewBoardLikeVo vo) {
		return reviewboardSQLMapper.myLikeCount(vo);
	}
		

}