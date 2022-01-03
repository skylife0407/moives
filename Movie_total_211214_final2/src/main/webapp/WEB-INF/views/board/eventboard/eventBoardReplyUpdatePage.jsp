<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> 
 	<h1>댓글 수정</h1>
 	
	<form action="./eventBoardReplyUpdateProcess.do" method="get">
    
	수정 내용 :<br>
	<textarea rows="10" cols="60" name="eventboard_reply_content">${data.eventBoardReplyVo.eventboard_reply_content }</textarea>
	<br>
		<input type="hidden" name="eventboard_no" value="${data.eventBoardReplyVo.eventboard_no }">
		<input type="hidden" name="eventboard_reply_no" value="${data.eventBoardReplyVo.eventboard_reply_no }">
		<button type="reset" value="Reset">취소</button>
		<button type="submit" value="Submit">수정</button>
</form>

</body>
</html>
