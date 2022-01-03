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
		
		<title>자유게시판</title>
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
		
		<div style="width: 1200px; margin: 0 auto;">
			<div class="container-fluid">
				<div class="row mt-3">
					<div class="col"></div> <!--왼쪽 공백-->
		
						<!-- 전체 시작 -->
						<div class="col-10 userInfofont"> 
						
							<!-- 게시판 이름 -->
							<div class="row mt-4">
								<div class="col fs-4">
									<i class="bi bi-card-list text-danger"></i> 자유 게시판
								</div>
							</div>
							
							<!-- 게시판 이름 끝 -->
							
							<!-- 검색 -->
							<div class="row mt-2">
								<div class="col">
									<input class="form-control" type="text" placeholder="검색어를 입력하세요">
								</div>
								<div class="col-2 d-grid">
									<input class="btn btn-outline-dark" type="submit" value="검색">
								</div>
							</div>
							<!-- 검색 끝 -->
							
							<!-- 게시판 내용 -->
							<div class="row mt-5 border-bottom pb-1 fw-bold">
								<div class="col-1 text-center">번호</div>
								<div class="col">제목</div>
								<div class="col-2"><i class="text-dark bi bi-person" style="font-size: 1.3rem;"></i> 글쓴이</div>
								<div class="col-1 text-center"><i class="bi bi-eye" style="font-size: 1.3rem;"></i> 조회</div>
								<div class="col-2 text-center pt-1">등록일</div>
							</div>
							
							<c:forEach items="${list }" var="data">
								<c:if test="${data.freeBoardVo.freeboard_activity == 0 }">
								<div class="row mt-3 border-bottom pb-2">
									<div class="col-1 text-center">${data.freeBoardVo.freeboard_no }</div>
									<div class="col"><a href="/movie/board/freeboard/readContentPage.do?freeboard_no=${data.freeBoardVo.freeboard_no }" class="text-decoration-none text-dark">${data.freeBoardVo.freeboard_title }</a></div>
									<div class="col-2">${data.memberVo.member_nick }</div>
									<div class="col-1 text-center">${data.freeBoardVo.freeboard_readcount }</div>
									<div class="col-2 text-center"><fmt:formatDate value="${data.freeBoardVo.freeboard_writedate }" pattern="yy.MM.dd HH:MM"/></div>
								</div>
								</c:if>
							</c:forEach>
							<!-- 게시판 내용 끝 -->
							
							
							<!-- 글쓰기 버튼 -->
							<div class="row mt-4 justify-content-end">
								<div class="col-2 d-grid">
									<c:if test="${!empty sessionUser }">					
										<a class="btn btn-success" href="/movie/board/freeboard/writeContentPage.do">글쓰기</a>
									</c:if>
								</div>
							</div>
							<!-- 글쓰기 버튼 끝 -->
							
							<!-- 페이지네이션 -->
							
							<div class="row mt-4">
								<div class="col"></div>
							</div>
							
							<div class="row mt-3">
								<div class="col-3"></div>
								<div class="col">
									<div class="text-center">
									  <ul class="pagination" style="bg-color: gray;">
									    <li class="page-item">
									      <a class="page-link text-decoration-none text-dark">Previous</a>
									    </li>
									    <li class="page-item active" aria-current="page">
									    	<a class="page-link text-decoration-none text-dark" href="#" style="background-color: #c5bfc3; border-color: #c5bfc3;">1</a></li>
									    <li class="page-item"><a class="page-link text-decoration-none text-dark" href="#">2</a></li>
									    <li class="page-item"><a class="page-link text-decoration-none text-dark" href="#">3</a></li>
									    <li class="page-item"><a class="page-link text-decoration-none text-dark" href="#">4</a></li>
									    <li class="page-item"><a class="page-link text-decoration-none text-dark" href="#">5</a></li>
									    <li class="page-item">
									      <a class="page-link text-decoration-none text-dark" href="#">Next</a>
									    </li>
									  </ul>
									</div>							
								</div>
							</div>
							<!-- 페이지네이션 끝 -->
							<div class="row" style="padding-bottom:110px;">
								<div class="col" ></div>
							</div>
						
					</div>
					<!-- 전체 끝 -->
				
					<div class="col"></div><!-- 오른쪽 공백 -->
				
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