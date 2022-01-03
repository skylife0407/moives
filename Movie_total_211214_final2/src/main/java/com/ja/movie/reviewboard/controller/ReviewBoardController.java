package com.ja.movie.reviewboard.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ja.movie.movie.service.MovieServiceImpl;
import com.ja.movie.reviewboard.service.ReviewBoardServiceImpl;
import com.ja.movie.vo.FreeBoardReplyVo;
import com.ja.movie.vo.FreeBoardVo;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.PosterVo;
import com.ja.movie.vo.ReviewBoardImageVo;
import com.ja.movie.vo.ReviewBoardReplyVo;
import com.ja.movie.vo.ReviewBoardVo;

@Controller
@RequestMapping("/board/reviewboard/*")
public class ReviewBoardController {

	@Autowired
	private ReviewBoardServiceImpl reviewBoardService;
		
	@RequestMapping("reviewBoardPage.do")
	public String reviewPage(Model model/*, int board_no*/) {		
		
		ArrayList<HashMap<String, Object>> list = reviewBoardService.getReviewList();		
		model.addAttribute("list" , list);
		
//		HashMap<String, Object> data = reviewBoardService.getReview(board_no);		
//		model.addAttribute("datas" , data);
		
		return "board/reviewboard/reviewBoardPage";
	}
	
		
	@RequestMapping("reviewWriteContentPage.do")
	public String reviewContentPage() {
		
		return "board/reviewboard/reviewWriteContentPage";
	}
	
	@RequestMapping("reviewWriteContentProcess.do")
	public String reviewContentProcess(ReviewBoardVo param , MultipartFile [] files, HttpSession session) {
		
		String rootUploadFileFolderName = "C:/uploadFiles";
		
		ArrayList<ReviewBoardImageVo> imageVoList = new ArrayList<ReviewBoardImageVo>();
		
		//파일 업로드
		for(MultipartFile file : files) {
			
			if(file.isEmpty()) {
				continue;
			}
			
			String originalFileName = file.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			
			
			UUID uuid = UUID.randomUUID();
			long currentTime =  System.currentTimeMillis();
			
			String randomFileName = uuid.toString() + "_" + currentTime + ext;
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String todayFolderName = sdf.format(today);
			
			File  todayFolder = new File(rootUploadFileFolderName + "/" + todayFolderName);
			
			if(!todayFolder.exists()) {
				todayFolder.mkdirs();
			}
			
			String uploadFilePath = 
					rootUploadFileFolderName + "/" + todayFolderName + "/" + randomFileName;
			
			try {
			file.transferTo(new File(uploadFilePath));
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//데이터 구성
		ReviewBoardImageVo imageVo = new ReviewBoardImageVo();
		imageVo.setReviewboard_image_filename(originalFileName);
		imageVo.setReviewboard_image_link(todayFolderName + "/" + randomFileName);	
		
		imageVoList.add(imageVo);
	}	
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");	
		int member_no = sessionUser.getMember_no();
		
		param.setMember_no(member_no);
		
		reviewBoardService.reviewWriteUpdatePoint(member_no);
		reviewBoardService.reviewWriteContent(param , imageVoList);
				
		return "redirect:/board/reviewboard/reviewBoardPage.do";
	}
	
	@RequestMapping("reviewReadContentPage.do")
	public String reviewReadContentPage(int reviewboard_no , Model model) {
		
		HashMap<String, Object> data = reviewBoardService.getReview(reviewboard_no);
		
		model.addAttribute("data" , data);
		
		return "board/reviewboard/reviewReadContentPage";
	}
	
	@RequestMapping("reviewDeleteContentProcess.do")
	public String reviewDeleteContentProcess(int reviewboard_no, HttpSession session) {
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");   
	      int member_no = sessionUser.getMember_no();
	      reviewBoardService.reviewDeleteUpdatePoint(member_no);
		reviewBoardService.reviewDeleteContent(reviewboard_no);
		
		return "redirect:/board/reviewboard/reviewBoardPage.do";		
	}
	
	@RequestMapping("reviewUpdateContentPage.do")
	public String reviewUpdateContentPage(int reviewboard_no , Model model) {
		
		HashMap<String, Object> data = reviewBoardService.getReview(reviewboard_no);
		model.addAttribute("data" , data);
		
		return "board/reviewboard/reviewUpdateContentPage";
		}
	
	@RequestMapping("reviewUpdateContentProcess.do")
	public String reviewUpdateContentProcess(ReviewBoardVo vo) {
		
		reviewBoardService.reviewUpdateContent(vo);
			
		return "redirect:/board/reviewboard/reviewBoardPage.do";
	}
	
	//댓글목록
	@RequestMapping("reviewBoardReply.do")
	public String reviewReadReplyContent(Model model, HttpServletRequest request) {
		String reviewboard_no = request.getParameter("reviewboard_no");
		System.out.println(reviewboard_no);
			
		ArrayList<HashMap<String, Object>> replyList = reviewBoardService.getReviewBoardReplyList();
			
		model.addAttribute("reviewBoardReplyList", replyList);
			
		return "board/reviewboard/reviewBoardReply";
		}
		
	//댓글작성
	@RequestMapping("reviewBoardReplyProcess.do")
	public String reviewBoardReplyProcess(ReviewBoardReplyVo vo) {
			
		reviewBoardService.writeReviewBoardReply(vo);
			
		return "redirect:/board/reviewboard/reviewReadContentPage.do";
	}
	
	//리뷰 홈
//	@RequestMapping("reviewBoardPage.do")
//	
//	ArrayList<HashMap<String, Object>> movieList = movieService.getMovieList();		
//	model.addAttribute("movieList", movieList);

	
}
	
	
	

