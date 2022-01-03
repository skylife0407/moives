<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="freeBoardReplyProcess.do">
	<div style="text-align:center;">
	<h4>댓글작성</h4>
	</div>
		<c:choose>
			<c:when test="${!empty sessionUser }">
				<div style="text-align:center;">
					<textarea placeholder="내용을 작성하세요." id="reply" rows="4" cols="50"></textarea>
					<button onclick="writeComment()">등록</button>
				</div>
			</c:when>
			<c:otherwise>
				<div style="text-align:center;">
					<textarea placeholder="로그인 후 이용해주세요" rows="4" cols="50" disabled></textarea>
				</div>
			</c:otherwise>
		</c:choose>
</form>


