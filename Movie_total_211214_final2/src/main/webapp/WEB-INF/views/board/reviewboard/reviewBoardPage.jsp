<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
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
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
		
		<title>영화 상세 리뷰 게시판</title>
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
			
			
					<!-- 여기에 내용 작성 -->	
		
					<div class="row mt-5"><!-- 게시판 로고 -->
						<div class="col-auto pe-0 pt-1">
							<i class="bi bi-camera fs-4 text-danger"></i>
						</div>
						<div class="col-auto fs-3 userInfofont">
							영화 상세리뷰
						</div>
					</div>
					<div class="row mt-4"><!-- 검색... -->
						<div class="col">
							<input style="font-family: FontAwesome;" class="form-control" type="text" placeholder="&#xf002 영화 제목을 검색하세요">
						</div>						
						<div class="col-auto d-grid">
							<input class="btn btn-secondary" type="submit" value="검색">
						</div>
					</div>
					
					<div class="row mt-2"><!-- 테이블 내용.. -->
					<div class="col">
							<div class="row mt-3">
								<c:forEach items="${list }" var="data">
									<c:if test="${data.reviewBoardVo.reviewboard_activity == 0 }">						
										<div class="col-3" style="margin-bottom: 30px;">			
										<a href="/movie/board/reviewboard/reviewReadContentPage.do?reviewboard_no=${data.reviewBoardVo.reviewboard_no }"><img src="/upload/${data.imgVo.reviewboard_image_link }" height="280" width="190"></a>								
										</div>
									</c:if>
								</c:forEach>
							</div>
					</div>	
					</div>
					
					

					
					<div class="row justify-content-center"><!-- 버튼들... -->
						<c:choose>
							<c:when test="${fn:length(list)!=0}">
								<div class="col-auto">
									<nav aria-label="...">
									  <ul class="pagination pagination-sm">
									    <li class="page-item disabled">
									      <a class="page-link">Previous</a>
									    </li>
									    <li class="page-item active" aria-current="page"><a class="page-link" href="#"  style="background-color: #c5bfc3; border-color: #c5bfc3;">1</a></li>
									    <li class="page-item">
									      <a class="page-link text-decoration-none text-dark" href="#" href="#">2</a>
									    </li>
									    <li class="page-item"><a class="page-link text-decoration-none text-dark"" href="#">3</a></li>
									    <li class="page-item"><a class="page-link text-decoration-none text-dark"" href="#">4</a></li>
									    <li class="page-item"><a class="page-link text-decoration-none text-dark"" href="#">5</a></li>
									    <li class="page-item">
									      <a class="page-link text-decoration-none text-dark" href="#">Next</a>
									    </li>
									  </ul>
									</nav>							
								</div>
								<div class="col-auto">
									<c:if test="${!empty sessionUser }">					
										<a class="btn btn-outline-dark" href="/movie/board/reviewboard/reviewWriteContentPage.do">글쓰기</a>
									</c:if>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col-auto">
									<div class="row justify-content-center mt-5">
										<div class="col-auto">
											<i class="bi bi-x-circle fs-2"></i>
										</div>
									</div>
									<div class="row mt-2">
										<div class="col text-center">
											작성된 상세리뷰가 없습니다.<br>
											첫 상세리뷰 글을 작성해 작성해 보세요.
										</div>
									</div>
									<div class="row mt-5" style="padding-bottom:130px;">
										<div class="col text-center">
											<c:choose>
												<c:when test="${!empty sessionUser }">
													<a class="btn btn-outline-dark" href="/movie/board/reviewboard/reviewWriteContentPage.do">글쓰기</a>
												</c:when>
												<c:otherwise>
													<a class="btn btn-outline-dark" href="/movie/member/loginPage.do">로그인</a>
												</c:otherwise>
											</c:choose>
											
										</div>
									</div>
								</div>
								
							</c:otherwise>
						</c:choose>
						
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

