package com.ja.movie.member.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ja.movie.member.service.MemberServiceImpl;
import com.ja.movie.movie.service.MovieServiceImpl;
import com.ja.movie.moviePicture.service.MoviePictureServiceImpl;
import com.ja.movie.vo.FreeBoardVo;
import com.ja.movie.vo.IconVo;
import com.ja.movie.vo.MemberVo;
import com.ja.movie.vo.MovieLikeVo;
import com.ja.movie.vo.OneLineReplyVo;
import com.ja.movie.vo.PosterVo;
import com.ja.movie.vo.ReviewBoardVo;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@Autowired
	private MovieServiceImpl movieService;
	@Autowired
	private MoviePictureServiceImpl moviePictureService;
	
	@RequestMapping("loginPage.do")
	public String loginPage() {
		
		return "member/loginPage";
	}
	@RequestMapping("joincomp.do")
	public String joingcomp() {
		
		return "member/joinMemberComplete";
	}
	
	@RequestMapping("joinMemberPage.do")
	public String joinMemberPage(Model model) {
		
		ArrayList<HashMap<String, Object>> genreList = memberService.getGenreList();		
		model.addAttribute("genreList", genreList);
		
		return "member/joinMemberPage";
	}
	
	@RequestMapping("joinMemberProcess.do")
	public String joinMemberProcess(MemberVo param, int [] genre_category_no) {
		
		memberService.joinMember(param, genre_category_no);
		
		return "member/joinMemberComplete";
	}
	
	
	@RequestMapping("loginProcess.do")
	public String loginProcess(MemberVo param, HttpSession session) {
		
		MemberVo sessionUser = memberService.login(param);
		String memberActivity = memberService.loginCheck(param.getMember_id());

		if(sessionUser != null && memberActivity.equals("1")) { //로그인 성공
			
			//sessionUser에 MemberVo를 저장하고 sessionUser라는 키값으로 사용
			session.setAttribute("sessionUser", sessionUser);	
			//금일 최초 로그인시 10포인트 제공 
			memberService.loginLog(sessionUser.getMember_no());
			int count = memberService.loginPoint(sessionUser.getMember_no());
			//로그인시 3% 확률로 500포인트 제공  
			if(count == 1) {
				if((int)(Math.random()*100)+1 <= 3 ) {
					memberService.loginRandomUpdatePoint(sessionUser.getMember_no());
				}else {
					memberService.loginUpdatePoint(sessionUser.getMember_no());
				}
			}
			//일주일 연속 로그인시 500포인트 제공
			int continuity = memberService.weekloginPoint(sessionUser.getMember_no());
			if (continuity == 7) {
				memberService.continuityLoginPoint(sessionUser.getMember_no());
			}
			System.out.println(memberService.loginPoint(sessionUser.getMember_no()));
			return "redirect:../movieList/movieListPage.do";	
		} else if(memberActivity==null) {
			return "member/loginFail";
		} else if(memberActivity.equals("0")) {
			//비활성 계정 접근 시도
			return "member/accessFail";
		} else {
			//로그인 실패
			
			return "member/loginFail";
		}
		
	}
	

	@RequestMapping("logoutProcess.do")
	public String logoutProcess(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:../movieList/movieListPage.do";
	}
	
//	//회원정보 페이지
//	@RequestMapping("memberInfo.do")
//	public String memberInfo(Model model) {
//		
//		ArrayList<HashMap<String, Object>> movieList = movieService.getMovieList();		
//		model.addAttribute("movieList", movieList);
//		
//		ArrayList<HashMap<String, Object>> movieLikeList = memberService.getMovieLikeList();		
//		model.addAttribute("movieLikeList", movieLikeList);
//		
//		ArrayList<OneLineReplyVo> movieEvalList = memberService.getOneLineList();		
//		model.addAttribute("movieEvalList", movieEvalList);
//		
//		ArrayList<PosterVo> posterVoList = moviePictureService.posterList();	      
//		model.addAttribute("posterVoList", posterVoList);
//		
//		ArrayList<HashMap<String, Object>> list = memberService.getIconShopList();
//		model.addAttribute("iconList" , list);
//		
//		return "member/memberInfo";
//	}
	
	//6개 미만으로 받기
	   @RequestMapping("memberInfo.do")
	   public String memberInfo(MemberVo vo, Model model, HttpSession session) {
		  MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		  int member_no = sessionUser.getMember_no();
		  ArrayList<HashMap<String, Object>> genreVo = memberService.memberByGenre(member_no);
		  model.addAttribute("genreVo", genreVo);
		  ArrayList<HashMap<String, Object>> genreList = memberService.getGenreList();
		  model.addAttribute("genreList", genreList);
	      ArrayList<HashMap<String, Object>> movieList = movieService.getMovieList();      
	      model.addAttribute("movieList", movieList);
	      
	      ArrayList<PosterVo> posterVoList = moviePictureService.posterList();         
	      model.addAttribute("posterVoList", posterVoList);
	      
	      
	      
	      ArrayList<MovieLikeVo> movieLikeList = memberService.getMemberRecommend(member_no);
	      model.addAttribute("movieLikeList", movieLikeList);
	      
	      ArrayList<OneLineReplyVo> movieEvalList = memberService.getMemberEval(member_no);
	      model.addAttribute("movieEvalList", movieEvalList);
	      
	      ArrayList<HashMap<String, Object>> list = memberService.getIconShopList();
	      model.addAttribute("iconList" , list);
	      
	      return "member/memberInfo";
	   }
	
	
	//정보변경 페이지
	@RequestMapping("myInfoChange.do")
	public String myInfoChange(MemberVo vo, HttpSession session, Model model) {
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		vo.setMember_no(member_no);
		ArrayList<HashMap<String, Object>> genreList = memberService.getGenreList();		
		model.addAttribute("genreList", genreList);
		model.addAttribute("memberVo", sessionUser);
		
		return "member/myInfoChange";
	}
	
	//정보변경 완료 페이지
	@RequestMapping("myNickChangeComplete.do")
	public String myInfoChangeComplete(MemberVo vo, HttpSession session) {
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");		
		int member_no = sessionUser.getMember_no();
		vo.setMember_no(member_no);
		
		memberService.memberNickChange(vo);
		
		return "member/myInfoChangeComplete";
	}
	
	//이메일 변경 완료
   @RequestMapping("myEmailChangeComplete.do")
   public String myEmailChangeComplete(MemberVo vo, HttpSession session) {
      MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");      
      int member_no = sessionUser.getMember_no();
      vo.setMember_no(member_no);
      
      memberService.memberEmailChange(vo);
      
      return "member/myInfoChangeComplete";
   }
	
	@RequestMapping("myPwChangeComplete.do")
	public String myPwChangeComplete(MemberVo vo, HttpSession session) {
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");		
		int member_no = sessionUser.getMember_no();
		vo.setMember_no(member_no);
		
		memberService.memberPwChange(vo);
		
		return "member/myInfoChangeComplete";
	}
	@RequestMapping("myChoiseMovieChangeComplete.do")
	public String myChoiseMovieChangeComplete(int [] genre_category_no, HttpSession session) {
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");		
		int member_no = sessionUser.getMember_no();
		memberService.userGenreDel(member_no);
		memberService.memberMovieChange(member_no,genre_category_no);
		
		return "member/myInfoChangeComplete";
	}
	
	//내가 추천한영화 페이지
	@RequestMapping("myRecommendMovie.do")
	public String myRecommendMovie(Model model) {
		
		ArrayList<HashMap<String, Object>> movieList = movieService.getMovieList();		
		model.addAttribute("movieList", movieList);
		
		ArrayList<HashMap<String, Object>> movieLikeList = memberService.getMovieLikeList();		
		model.addAttribute("movieLikeList", movieLikeList);
		
		ArrayList<PosterVo> posterVoList = moviePictureService.posterList();         
	    model.addAttribute("posterVoList", posterVoList);
		
		return "member/myRecommendMovie";
	}
	
	//내가 평가한 영화 페이지
	@RequestMapping("myEvalMovie.do")
	public String myEvalMovie(Model model) {
	
		ArrayList<HashMap<String, Object>> movieList = movieService.getMovieList();		
		model.addAttribute("movieList", movieList);
		
		ArrayList<OneLineReplyVo> movieEvalList = memberService.getOneLineList();		
		model.addAttribute("movieEvalList", movieEvalList);
		
		ArrayList<PosterVo> posterVoList = moviePictureService.posterList();         
	    model.addAttribute("posterVoList", posterVoList);
		
		return "member/myEvalMovie";
	}
	
	//내가 쓴 글 보기 페이지
	@RequestMapping("myWritePost.do")
	public String myWritePost(Model model) {
		
		ArrayList<FreeBoardVo> freeBoardList = memberService.getFreeBoardList();		
		model.addAttribute("freeBoardList", freeBoardList);
		
		ArrayList<ReviewBoardVo> reviewBoardList = memberService.getReviewBoardList();
		model.addAttribute("reviewBoardList", reviewBoardList);
		
		return "member/myWritePost";
	}

	
	//관리자 메인페이지
	@RequestMapping("adminPage.do")
	public String adminPage() {
		
		return "member/admin/adminPage";
	}
	//사용자 관리 페이지
	@RequestMapping("memberAdmin.do")
	public String memberAdmin(Model model) {
		
		ArrayList<HashMap<String, Object>> list = memberService.getAdminMemberList();
		model.addAttribute("list" , list);
		
		return "member/admin/memberAdmin";
	}
	//자유게시판 관리 페이지
	@RequestMapping("freeBoardAdmin.do")
	public String freeBoardAdmin(Model model) {
		
		ArrayList<HashMap<String, Object>> list = memberService.getAdminfreeBoardList();
		model.addAttribute("list" , list);
		
		return "member/admin/freeBoardAdmin";
	}
	//리뷰게시판 관리 페이지
	@RequestMapping("reviewBoardAdmin.do")
	public String reviewBoardAdmin(Model model) {
		
		ArrayList<HashMap<String, Object>> list = memberService.getAdminReviewBoardList();
		model.addAttribute("list" , list);
		
		return "member/admin/reviewBoardAdmin";
	}
	//이벤트게시판 관리 페이지
	@RequestMapping("eventBoardAdmin.do")
	public String eventBoardAdmin(Model model) {
		
		ArrayList<HashMap<String, Object>> list = memberService.getAdminEventBoardList();
		model.addAttribute("list" , list);
		
		return "member/admin/eventBoardAdmin";
	}
	//아이콘상점 관리 페이지
	@RequestMapping("iconShopAdmin.do")
	public String iconShopAdmin(Model model) {
		
		ArrayList<HashMap<String, Object>> list = memberService.getIconShopList();
		model.addAttribute("list" , list);
		
		return "member/admin/iconShopAdmin";
	}

	//아이콘 등록 관련
	@RequestMapping("iconUpload.do")
	public String iconUpload(Model model) {
		
		return "member/admin/iconUpload";
	}
	
	@RequestMapping("iconUploadProcess.do")
	public String iconUploadProcess(int icon_price, MultipartFile [] files, HttpSession session) {
		
		String rootUploadFileFolderName = "C:/iconFiles";
		
		ArrayList<IconVo> iconVoList = new ArrayList<IconVo>();
		
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
			IconVo iconVo = new IconVo();
			iconVo.setIcon_price(icon_price);
			iconVo.setIcon_name(originalFileName);
			iconVo.setIcon_link(todayFolderName + "/" + randomFileName);	
			
			iconVoList.add(iconVo);
		}		
		
		memberService.iconUpload(iconVoList);
				
		return "redirect:../member/iconShopAdmin.do";
	}
	//아이콘 수정 관련
	@RequestMapping("iconChange.do")
	public String iconChange() {

		return "member/admin/iconChange";
	}
	@RequestMapping("iconChangeProcess.do")
	public String iconChangeProcess(int icon_no, int icon_price, HttpSession session, MultipartFile [] files) {
		
		String rootUploadFileFolderName = "C:/iconFiles";
		ArrayList<IconVo> iconVoList = new ArrayList<IconVo>();
		
		for(MultipartFile file : files) {
			
			if(file.isEmpty()) {
				continue;
			}			
			String originalFileName = file.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			UUID uuid = UUID.randomUUID();
			
			long currentTime = System.currentTimeMillis();
			
			String randomFileName = uuid.toString() + "_" + currentTime + ext; 
			
			Date today = new Date(); 
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); 
			String todayFolderName = sdf.format(today);
			
			File todayFolder = new File(rootUploadFileFolderName + "/" + todayFolderName);
			
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
			IconVo iconVo = new IconVo();
			iconVo.setIcon_no(icon_no);
			iconVo.setIcon_price(icon_price);
			iconVo.setIcon_name(originalFileName);
			iconVo.setIcon_link(todayFolderName + "/" + randomFileName);
			
			iconVoList.add(iconVo);
		}
		memberService.iconChange(iconVoList);
		
		return "redirect:../member/iconShopAdmin.do";
	}
	//아이콘상점 페이지
	@RequestMapping("iconShopPage.do")
	public String iconShopPage(Model model) {
		
		ArrayList<HashMap<String, Object>> list = memberService.getIconShopList();
		model.addAttribute("list" , list);
		
		return "member/iconShopPage";
	}
	
}