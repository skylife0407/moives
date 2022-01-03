<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		
		<link rel="stylesheet" type="text/css" href="/movie/resources/css/test.css">
		
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
		
		<title>영화리스트</title>
	</head>
	<body>
		<!-- 네비바 시작 -->
		<div style="width:100%; height:140px; margin: 0 auto" class="bg-dark">
	    	<div style="width:1200px; margin: 0 auto" class="bg-dark">
	    		<div class="container-fluid">
	    			<div class="row userInfofont">
	    				<div class="col-1"></div>
						<jsp:include page="../global/search_userInfo.jsp"></jsp:include>
						<div class="col-1"></div>
                     </div>

                     <div class="row">
                     	<div class="col-1"></div>
						<div class="col">
						    <jsp:include page="../global/nav_bar.jsp"></jsp:include>
						</div>
						<div class="col-1"></div>
                     </div>
	    		</div>
	    	</div>
    	</div>
		<!-- 네비바 끝 -->
		
		<!-- 본문 시작 -->
		<div style="width: 1200px; margin: 0 auto; font-family: 'Noto Sans KR', sans-serif;">
			<div class="container-fluid">
   				<div class="row mt-3">
   					<div class="col"></div> <!--왼쪽 공백-->

					<!-- 전체 시작 -->
					<div class="col-10 userInfofont"> 
			
					<div class="row mt-3">
						<div class="col-auto pe-0">
							<i class="bi bi-layout-text-window-reverse fs-4 text-danger"></i>
						</div>
						<div class="col fs-5 pt-1">
							내가 쓴 글
						</div>
					</div>
			
					<div class="row mt-3">
						<div class="col-10 ms-2">
						
							<c:choose>
								<c:when test="${fn:length(freeBoardList)==0}">
									<div class="row justify-content-center mt-5">
										<div class="col-auto">
											<i class="bi bi-slash-circle fs-2"></i>
										</div>
									</div>
									<div class="row mt-2"">
										<div class="col text-center fs-5">
											작성한 글이 없습니다.<br>
											첫 글을 작성해 작성해 보세요.
										</div>
									</div>
									
									<div class="row mt-5 justify-content-center" style="padding-bottom:203px;">
										<div class="col-auto">
											<a class="btn btn-success" href="/movie/board/reviewboard/reviewBoardPage.do">영화리뷰쓰기</a>
										</div>
										<div class="col-auto">
											<input class="btn btn-secondary" type="button" value="뒤로가기" onClick="history.go(-1)">
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach items="${freeBoardList }" var="freeBoardList">
										<c:if test="${sessionUser.member_no ==  freeBoardList.member_no}">
											<div class="row mt-2 border">
												<div class="col-auto">제목</div>
												<div class="col">
													<a href="/movie/board/freeboard/readContentPage.do?freeboard_no=${freeBoardList.freeboard_no }">
														<b>${freeBoardList.freeboard_title }</b>
													</a>
												</div>
											</div>
										</c:if>
									</c:forEach>
									<div class="row mt-5 justify-content-center" style="padding-bottom:335px;">
										<div class="col-auto">
											<input class="btn btn-secondary" type="button" value="뒤로가기" onClick="history.go(-1)">
										</div>
									</div>
								</c:otherwise>
								
							</c:choose>
	
						</div>
					
					</div>
			

							
					</div>
					<!-- 전체 끝 -->
					
					<div class="col"></div><!-- 오른쪽 공백 -->
			
				</div>
			</div>
		</div>
		<!-- 본문 끝 -->

		<!-- 풋터 시작 -->
		<div style="width:100%; height:180px; margin: 80px auto 0px auto" class="bg-dark">
        	<div style="width:1200px; margin: 0 auto" class="bg-dark">
	        	<div class="container-fluid">
	    			<div class="row mt-4 pt-4 text-white">
	                    <div class="col-1"></div>
	                    <jsp:include page="../global/footer.jsp"></jsp:include>
	                    <div class="col-1"></div>
	                </div>
	    		</div>
        	</div>
    	</div>
		<!-- 풋터 끝 -->

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	</body>
</html>