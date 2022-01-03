package com.ja.movie.eventboard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.movie.eventboard.service.EventBoardServiceImpl;


@Controller
@RequestMapping("/board/eventboard/*")
@ResponseBody
public class EventBoardRESTController {
	
	@Autowired
	private EventBoardServiceImpl eventBoardService;
	
	@RequestMapping("eventBoardCalendar.do")
	public HashMap<String, Object> getCalendarList() {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> eventBoardList = eventBoardService.getEventList();
		
		data.put("eventBoardList", eventBoardList);
		
		return data;
		
	} 


}	
		
	

