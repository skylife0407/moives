<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">    
		<link rel="stylesheet" type="text/css" href="../../resources/css/test.css">      
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
		<title>이벤트 상세 페이지</title>
	</head>
	
	<body>
    	<!-- 네비바 시작 -->
		<div style="width:100%; height:140px; margin: 0 auto" class="bg-dark">
	    	<div style="width:1200px; margin: 0 auto" class="bg-dark">
	    		<div class="container-fluid">
	    			<div class="row userInfofont">
	    				<div class="col-1"></div>
						<jsp:include page="../../global/search_userInfo.jsp"></jsp:include>
						<div class="col-1"></div>
                     </div>

                     <div class="row">
                     	<div class="col-1"></div>
						<div class="col">
						    <jsp:include page="../../global/nav_bar.jsp"></jsp:include>
						</div>
						<div class="col-1"></div>
                     </div>
	    		</div>
	    	</div>
    	</div>
		<!-- 네비바 끝 -->
		
		<div style="width: 1200px; margin: 0 auto; font-family: 'Nanum Gothic Coding', monospace;">
			<div class="container-fluid">
				<div class="row mt-3">
					<div class="col"></div> <!--왼쪽 공백-->
					
					<!-- 전체 시작 -->
					<div class="col-10 userInfofont"> 
					
					
						<!-- 내용 -->
						<div class="row mt-5">
							<div class="col ">
								<!-- 제목 -->
								<div class="row mt-2 border-bottom border-2 pb-2">
									<div class="col-auto pt-1">
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
										<fmt:formatDate value="${data.eventBoardVo.eventboard_startdate }"  pattern="yyyy-MM-dd" var="startdate"/>
										<fmt:formatDate value="${data.eventBoardVo.eventboard_enddate }" pattern="yyyy-MM-dd" var="enddate"/>
								
									
										<c:choose>
											<c:when test="${startdate < today && enddate > today }">
												<span class="badge rounded-pill bg-primary text-white fs-5">진행중인 이벤트</span>
											</c:when>
											<c:when test="${enddate < today }">
												<span class="badge rounded-pill bg-danger text-white fs-5">종료된 이벤트 </span>
											</c:when>
											<c:otherwise>
												<span class="badge rounded-pill bg-success text-white fs-5">예정된 이벤트 </span>
											</c:otherwise>
										</c:choose>
									
									</div>
									<div class="col-auto fs-4 me-auto"> 
										${data.eventBoardVo.eventboard_title } 
									</div>
									
									<div class="col-auto fs-6 pt-2">
										 <i class="bi bi-calendar3"></i> <fmt:formatDate value="${data.eventBoardVo.eventboard_startdate }" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${data.eventBoardVo.eventboard_enddate }" pattern="yyyy.MM.dd"/>
									</div>
									
									
								</div>
								<!-- 제목 끝-->
								
								<div class="row">
									<div class="col">
										
									</div>
								</div>
								
								<!-- 이미지 -->
								<div class="row mt-4">
									<div class="col text-center">
										<c:forEach items="${data.imageVoList}" var="list">
											<c:if test="${data.eventBoardVo.eventboard_no==list.eventboard_no }">
												<img src="/upload/${list.eventboard_image_link }" alt="Responsive image"  height="480" width="480">
											</c:if>
										</c:forEach>
									</div>
								</div>
								<!-- 이미지 -->
								
								<!-- 내용 -->
								<div class="row mt-3 justify-content-center">
									
									<div class="col-9 fs-5 text-center">
										${data.eventBoardVo.eventboard_content }
									</div>
								</div>
								
								
								<div class="row mt-3">
									<div class="col text-center">
										<c:if test="${!empty sessionUser }">
											<c:choose>
											<c:when test="${myLikeCount > 0 }">
												<h3><a href="./doLike.do?eventboard_no=${data.eventBoardVo.eventboard_no }"><i class="bi bi-hand-thumbs-up-fill text-primary"></i></a>${totalLikeCount }<br></h3>
											</c:when>
											<c:otherwise>
												<h3><a href="./doLike.do?eventboard_no=${data.eventBoardVo.eventboard_no }"><i class="bi bi-hand-thumbs-up text-primary"></i></a>${totalLikeCount }<br></h3>
											</c:otherwise>
											</c:choose>
										</c:if><br>
									</div>
								</div>
								<!-- 내용 끝-->
								
							</div>
						</div>
						
						<div class="row">
							<div class="col fs-5">
								댓글작성
							</div>
						</div>
						<hr>
						<!-- 댓글 쓰는곳-->
						<form action="/movie/board/eventboard/eventBoardReplyProcess.do" method="post">
							<div class="row">
								<input type="hidden" name="eventboard_no" value="${data.eventBoardVo.eventboard_no }">		
								<div class="col-9">
									<textarea class="form-control" name="eventboard_reply_content"></textarea>
								</div>
								<div class="col d-grid">
									<input class="btn btn-outline-dark" type="submit" value="작성 완료">
								</div>
							</div>
						</form>
						
						<!-- 댓글 쓰는곳 끝 -->
						
						<!-- 댓글 리스트-->
						<div class="row mt-3">
							<div class="col userInfofont">
								<c:forEach items="${eventReplyList}" var="list">
								<div class="row">
									<div class="col">
										<div class="row">
											<div class="col-9">
												<i class="bi bi-person-fill"></i> 작성자 | ${list.memberVo.member_nick }
											</div>
											<div class="col">
												<button type="button" class="btn btn-outline-dark btn-sm"><i class="bi bi-hand-thumbs-up">0</i></button>  <button type="button" class="btn btn-outline-dark btn-sm"><i class="bi bi-hand-thumbs-down">0</i></button>
												<button type="button" class="btn btn-outline-dark btn-sm">공감 확인</button>  <button type="button" class="btn btn-outline-dark btn-sm">신고</button>
											</div>
										</div>
										<div class="row">
											<div class="col">
												<i class="bi bi-chat-dots-fill"></i> 댓글 | ${list.eventReplyVo.eventboard_reply_content }
											</div>
										</div>
										<div class="row">
											<div class="col mt-2">
												<i class="bi bi-calendar-fill"></i> 작성일 | <fmt:formatDate value="${list.eventReplyVo.eventboard_reply_writedate  }" pattern="yy-MM-dd     hh:mm"/>
											</div>
										</div>
									</div>
									
									
									<div class="row mt-2">
									<c:if
										 test="${!empty sessionUser && list.memberVo.member_no==sessionUser.member_no }">
										 <div class="col">
										 	<a class="btn btn-success btn-sm" href="/movie/board/eventboard/eventBoardReplyUpdatePage.do?eventboard_reply_no=${list.eventReplyVo.eventboard_reply_no }&eventboard_no=${data.eventBoardVo.eventboard_no}">수정</a>
										 	<a class="btn btn-danger btn-sm" href="/movie/board/eventboard/eventBoardReplyDeleteProcess.do?eventboard_reply_no=${list.eventReplyVo.eventboard_reply_no }&eventboard_no=${data.eventBoardVo.eventboard_no}" >삭제</a>
										 </div>
										
						     	 	</c:if>
						     	 	</div>
								</div>
								<hr>
					   	 	  </c:forEach>
							</div>
						</div>
						<!-- 댓글 리스트 끝 -->
						
						<div class="row justify-content-center mt-3">
							<div class="col-auto">
								<a class="btn btn-secondary btn-sm" href="/movie/board/eventboard/eventBoardPage.do"><i class="bi bi-list"></i> 목록으로</a>
							</div>
						</div>
					
					</div>
					<!-- 전체 종료 -->
					
					<div class="col"></div> <!-- 오른쪽 공백 -->
				</div>
			</div>
		</div>
        
        <!-- 풋터 시작 -->
		<div style="width:100%; height:180px; margin: 80px auto 0px auto" class="bg-dark">
        	<div style="width:1200px; margin: 0 auto" class="bg-dark">
	        	<div class="container-fluid">
	    			<div class="row mt-4 pt-4 text-white">
	                    <div class="col-1"></div>
	                    <jsp:include page="../../global/footer.jsp"></jsp:include>
	                    <div class="col-1"></div>
	                </div>
	    		</div>
        	</div>
    	</div>
		<!-- 풋터 끝 -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>		
	</body>
</html>