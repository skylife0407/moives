package com.ja.movie.eventboard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.movie.eventboard.mapper.EventBoardSQLMapper;
import com.ja.movie.member.mapper.MemberSQLMapper;
import com.ja.movie.vo.EventBoardImageVo;
import com.ja.movie.vo.EventBoardLikeVo;
import com.ja.movie.vo.EventBoardReplyVo;
import com.ja.movie.vo.EventBoardVo;
import com.ja.movie.vo.MemberVo;

@Service
public class EventBoardServiceImpl {

	@Autowired
	private EventBoardSQLMapper eventboardSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;

	// 등록

	public void eventRegister(EventBoardVo vo, ArrayList<EventBoardImageVo> imageVoList) {

		int eventboard_no = eventboardSQLMapper.createEventBoardPK();

		vo.setEventboard_no(eventboard_no);

		eventboardSQLMapper.eventRegister(vo);

		// 이미지 정보 insert
		for (EventBoardImageVo imageVo : imageVoList) {
			imageVo.setEventboard_no(eventboard_no);
			eventboardSQLMapper.eventRegisterImage(imageVo);
		}

	}

	// 이벤트 페이지
	public ArrayList<HashMap<String, Object>> getEventList() {

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		ArrayList<EventBoardVo> eventBoardList = eventboardSQLMapper.getEventList();

		for (EventBoardVo eventboardVo : eventBoardList) {
			int member_no = eventboardVo.getMember_no();
			int event_no = eventboardVo.getEventboard_no();

			MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
			EventBoardImageVo imageVo = eventboardSQLMapper.getEventImageList(event_no);
			int totalLike = eventboardSQLMapper.totalLikeCount(event_no);

			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			map.put("eventVo", eventboardVo);
			map.put("imageVo", imageVo);
			map.put("totalLike", totalLike);

			list.add(map);

		}

		return list;

	}

	public HashMap<String, Object> getBoard(int eventboard_no) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		EventBoardVo eventboardVo = eventboardSQLMapper.getEventByNo(eventboard_no);
		int member_no = eventboardVo.getMember_no();
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);

		ArrayList<EventBoardImageVo> imageVoList = eventboardSQLMapper.getEventImagesByBoardNo(eventboard_no);

		map.put("eventBoardVo", eventboardVo);
		map.put("memberVo", memberVo);
		map.put("imageVoList", imageVoList);

		return map;
	}

	public void eventDelete(int eventboard_no) {
		eventboardSQLMapper.eventDelete(eventboard_no);
	}

	public void eventUpdate(EventBoardVo vo, ArrayList<EventBoardImageVo> imageVoList) {
		int eventboard_no = vo.getEventboard_no();

		for (EventBoardImageVo imageVo : imageVoList) {
			imageVo.setEventboard_no(eventboard_no);
			eventboardSQLMapper.evnetUpdateImage(imageVo);
		}

		eventboardSQLMapper.eventUpdate(vo);
	}

	// 댓글
	public void eventReplyContent(EventBoardReplyVo vo) {

		eventboardSQLMapper.eventReplyContent(vo);
	}

	public ArrayList<HashMap<String, Object>> getEventBoardReplyList(int eventboard_no) {

		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		ArrayList<EventBoardReplyVo> eventReplyList = eventboardSQLMapper.getEventBoardReplyList(eventboard_no);

		for (EventBoardReplyVo eventReplyVo : eventReplyList) {
			int member_no = eventReplyVo.getMember_no();
			MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberVo", memberVo);
			map.put("eventReplyVo", eventReplyVo);

			list.add(map);
		}
		return list;

	}

	public HashMap<String, Object> getEventReplyBoard(int replyeventboard_no) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		EventBoardReplyVo eventBoardReplyVo = eventboardSQLMapper.getEventReplyByNo(replyeventboard_no);

		int member_no = eventBoardReplyVo.getMember_no();
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);

		map.put("eventBoardReplyVo", eventBoardReplyVo);
		map.put("memberVo", memberVo);

		return map;

	}

	public void eventReplyDelete(int eventboard_reply_no) {
		eventboardSQLMapper.eventReplyDelete(eventboard_reply_no);
	}

	public void eventReplyUpdate(EventBoardReplyVo vo) {
		eventboardSQLMapper.eventReplyUpdate(vo);
	}

	// 좋아요 관련...
	public void doLikeProcess(EventBoardLikeVo vo) {

		int myCount = eventboardSQLMapper.myLikeCount(vo);

		if (myCount > 0) {
			eventboardSQLMapper.unLike(vo);
		} else {
			eventboardSQLMapper.like(vo);
		}
	}

	public int getTotalLikeCount(int eventboardNo) {
		return eventboardSQLMapper.totalLikeCount(eventboardNo);

	}

	public int getMyLikeCount(EventBoardLikeVo vo) {
		return eventboardSQLMapper.myLikeCount(vo);
	}

	// 포인트 획득
	public void writeUpdatePoint(int no) {
		eventboardSQLMapper.writeUpdatePoint(no);
	}

	public void deleteUpdatePoint(int no) {
		eventboardSQLMapper.deleteUpdatePoint(no);
	}
}
