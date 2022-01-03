<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="updateOneLineReplyProcess.do">
	<input type="hidden" name="movie_no" value="${oneLineReplyVo.movie_no }">
	<h2>한줄평 수정 ${oneLineReplyVo.movie_no }</h2>
	별점<br>
	<textarea name="oneLineReply_content">${oneLineReplyVo.oneLineReply_content }</textarea><br>
			<select name="oneLineReply_star">
			  <option value="1" <c:if test="${oneLineReplyVo.oneLineReply_star == 1 }">selected</c:if>>별점 1점</option>
			  <option value="2" <c:if test="${oneLineReplyVo.oneLineReply_star == 2 }">selected</c:if>>별점 2점</option>
			  <option value="3" <c:if test="${oneLineReplyVo.oneLineReply_star == 3 }">selected</c:if>>별점 3점</option>
			  <option value="4" <c:if test="${oneLineReplyVo.oneLineReply_star == 4 }">selected</c:if>>별점 4점</option>
			  <option value="5" <c:if test="${oneLineReplyVo.oneLineReply_star == 5 }">selected</c:if>>별점 5점</option>
			</select>
			<br>
			<button type="reset" value="Reset">취소</button>
			<button type="submit" value="Submit">수정</button>
</form>