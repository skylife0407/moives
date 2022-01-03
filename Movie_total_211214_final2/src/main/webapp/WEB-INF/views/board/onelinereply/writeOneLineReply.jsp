<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="./writeOneLineReplyProcess.do">
	<input type="hidden" name="movie_no" value="${map.movieVo.movie_no }">
	<div class="row"> <!-- 타이틀 & 별점 -->
		<div class="col-2 fs-6 fw-bold">한줄평 쓰기</div>
		<div class="col">
			<%-- <c:forEach var="star" begin="1" end="5" >
				<i class = "fa fa-star" aria-hidden = "true" id = "st${star }"></i>	
			</c:forEach>
			<input type="hidden" name="oneLineReply_star" value="1"> --%>
			<!-- <i class = "fa fa-star" aria-hidden = "true" id = "st1"></i>  
			<i class = "fa fa-star" aria-hidden = "true" id = "st2"></i>  
			<i class = "fa fa-star" aria-hidden = "true" id = "st3"></i>  
			<i class = "fa fa-star" aria-hidden = "true" id = "st4"></i>  
			<i class = "fa fa-star" aria-hidden = "true" id = "st5"></i> -->  
		   <c:forEach var="star" begin="1" end="5" >
						<i class = "fa fa-star" aria-hidden = "true" id = "st${star }"></i>	
					</c:forEach>
					<input type="hidden" name="oneLineReply_star" value="1">
		</div>
	</div>
	<div class="row">
		<div class="col ">
			<c:choose>
				<c:when test="${!empty sessionUser &&  !isOneLineWrite}">
					<textarea placeholder="내용을 입력해주세요" rows="4" cols="50" style="resize: none;" name="oneLineReply_content" required></textarea>
					<!-- <select name="oneLineReply_star" required>
					  <option value="1">별점 1점</option>
					  <option value="2">별점 2점</option>
					  <option value="3">별점 3점</option>
					  <option value="4">별점 4점</option>
					  <option value="5">별점 5점</option>
					</select> -->
					
					<br>
					<button type="reset" value="Reset">취소</button>
					<button type="submit" value="Submit">작성</button>
				</c:when>
				<c:otherwise>
					<textarea placeholder="로그인 후 작성 가능 합니다." rows="4" cols="50" name="oneLineReply_content" style="resize: none;" disabled></textarea>
					<!-- <select name="oneLineReply_star" disabled>
					  <option value="1">별점 1점</option>
					  <option value="2">별점 2점</option>
					  <option value="3">별점 3점</option>
					  <option value="4">별점 4점</option>
					  <option value="5">별점 5점</option>
					</select> -->
					
					<br>
					<button type="reset" value="Reset" disabled>취소</button>
					<button type="submit" value="Submit" disabled>작성</button>
				</c:otherwise>		
			</c:choose>	
		</div>
	</div>
	  	
</form>