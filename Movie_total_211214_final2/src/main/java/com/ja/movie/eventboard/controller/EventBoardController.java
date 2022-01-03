package com.ja.movie.eventboard.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ja.movie.eventboard.service.EventBoardServiceImpl;
import com.ja.movie.vo.EventBoardImageVo;
import com.ja.movie.vo.EventBoardLikeVo;
import com.ja.movie.vo.EventBoardReplyVo;
import com.ja.movie.vo.EventBoardVo;
import com.ja.movie.vo.MemberVo;

@Controller
@RequestMapping("/board/eventboard/*")
public class EventBoardController {
	
	@Autowired
	private EventBoardServiceImpl eventboardService;
	
	@RequestMapping("eventBoardPage.do")
	public String mainPage(Model model) {
		
		ArrayList<HashMap<String, Object>> list = eventboardService.getEventList();
		
		model.addAttribute("list" , list);
		
		
		
		return "board/eventboard/eventBoardPage";
	}
	
	@RequestMapping("eventBoardRegisterPage.do")
	public String eventBoardRegisterPage() {
		
		return "board/eventboard/eventBoardRegisterPage";
	}
	
	@RequestMapping("eventBoardRegisterProcess.do")
	public String eventBoardRegisterProcess(EventBoardVo param , MultipartFile [] files, HttpSession session) {
		
		String rootUploadFileFolderName = "C:/uploadFiles";
		
		ArrayList<EventBoardImageVo> imageVoList = new ArrayList<EventBoardImageVo>(); 
		
		
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
			
			
			EventBoardImageVo imageVo = new EventBoardImageVo();
			imageVo.setEventboard_image_filename(originalFileName);
			imageVo.setEventboard_image_link(todayFolderName + "/" + randomFileName);
			
			imageVoList.add(imageVo);
		}
		
		
		
		MemberVo memberVo =  (MemberVo) session.getAttribute("sessionUser");
		int member_no = memberVo.getMember_no();
		
		
		param.setMember_no(member_no);
		
		eventboardService.eventRegister(param , imageVoList);
		
		return "redirect:../eventboard/eventBoardPage.do";
	}
	
	@RequestMapping("eventBoardDetailPage.do")
	public String eventBoardDetailPage(int eventboard_no , Model model , HttpSession session) {
		
		HashMap<String, Object> data = eventboardService.getBoard(eventboard_no);
		
		model.addAttribute("data", data);
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		
		if(sessionUser != null) {
			int member_no = sessionUser.getMember_no();
			EventBoardLikeVo eventBoardLikeVo = new EventBoardLikeVo();
			eventBoardLikeVo.setEventboard_no(eventboard_no);
			eventBoardLikeVo.setMember_no(member_no);
			int myLikeCount = eventboardService.getMyLikeCount(eventBoardLikeVo);
			model.addAttribute("myLikeCount", myLikeCount);
		}
		
		int totalLikeCount = eventboardService.getTotalLikeCount(eventboard_no);
		model.addAttribute("totalLikeCount" , totalLikeCount);
		
		
		
		ArrayList<HashMap<String, Object>> eventReplyList = eventboardService.getEventBoardReplyList(eventboard_no);
		model.addAttribute("eventReplyList" , eventReplyList);
		
		
		return "board/eventboard/eventBoardDetailPage";
	}
	
	@RequestMapping("eventBoardDeleteProcess.do")
	public String eventBoardDeleteProcess(int eventboard_no) {
		
		eventboardService.eventDelete(eventboard_no);
		
		return "redirect:/board/eventboard/eventBoardPage.do";
	}
	
	@RequestMapping("eventBoardUpdatePage.do")
	public String eventBoardUpdatePage(int eventboard_no , Model model) {
		HashMap<String, Object> data = eventboardService.getBoard(eventboard_no);
		
		model.addAttribute("data" , data);
		
		return "board/eventboard/eventBoardUpdatePage";
	}
	
	@RequestMapping("eventBoardUpdateProcess.do")
	public String eventBoardUpdateProcess(int eventboard_no, EventBoardVo vo, MultipartFile [] files, HttpSession session, RedirectAttributes redirect) {
		
		String rootUploadFileFolderName = "C:/uploadFiles";
		
		ArrayList<EventBoardImageVo> imageVoList = new ArrayList<EventBoardImageVo>(); 
		
		
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
			
			
			EventBoardImageVo imageVo = new EventBoardImageVo();
			imageVo.setEventboard_image_filename(originalFileName);
			imageVo.setEventboard_image_link(todayFolderName + "/" + randomFileName);
			
			imageVoList.add(imageVo);
		}
		
		eventboardService.eventUpdate(vo, imageVoList);
		redirect.addAttribute("eventboard_no", eventboard_no);
		
		return "redirect:/board/eventboard/eventBoardPage.do";
	}
	
	@RequestMapping("eventBoardReplyProcess.do")
	public String eventBoardReplyProcess(EventBoardReplyVo param, Model model, HttpSession session, RedirectAttributes redirect) {
		
		ArrayList<HashMap<String, Object>> list = eventboardService.getEventList();
		model.addAttribute("list" , list);
		
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");	
		int member_no = sessionUser.getMember_no();
		param.setMember_no(member_no);
		eventboardService.writeUpdatePoint(member_no);
		eventboardService.eventReplyContent(param);
		
		redirect.addAttribute("eventboard_no",param.getEventboard_no());
		
		return "redirect:/board/eventboard/eventBoardDetailPage.do";
		
		
	}
	
	@RequestMapping("eventBoardReplyDeleteProcess.do")
	public String eventBoardReplyDeleteProcess(int eventboard_no, int eventboard_reply_no, HttpSession session) {
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");	
		int member_no = sessionUser.getMember_no();
		eventboardService.deleteUpdatePoint(member_no);
		eventboardService.eventReplyDelete(eventboard_reply_no);
		
		return "redirect:/board/eventboard/eventBoardDetailPage.do?eventboard_no="+eventboard_no;
	}
	
	@RequestMapping("eventBoardReplyUpdatePage.do")
	public String eventBoardReplyUpdatePage(int eventboard_reply_no , Model model) {
		HashMap<String, Object> data = eventboardService.getEventReplyBoard(eventboard_reply_no);
		
		model.addAttribute("data" , data);
		
		return "board/eventboard/eventBoardReplyUpdatePage";
	}
	
	@RequestMapping("eventBoardReplyUpdateProcess.do")
	public String eventBoardReplyUpdateProcess(EventBoardReplyVo param, HttpSession session, RedirectAttributes redirect) {
		
		eventboardService.eventReplyUpdate(param);

		redirect.addAttribute("eventboard_no", param.getEventboard_no());
		return "redirect:/board/eventboard/eventBoardDetailPage.do";
}
		
	@RequestMapping("doLike.do")
	public String doLike(EventBoardLikeVo param , HttpSession session) {
	
		MemberVo sessionUser = (MemberVo)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		param.setMember_no(member_no);
		
		eventboardService.doLikeProcess(param);
		
		return "redirect:/board/eventboard/eventBoardDetailPage.do?eventboard_no=" + param.getEventboard_no();
		
		
	
	
	
	
	
	}
}	
		
	

