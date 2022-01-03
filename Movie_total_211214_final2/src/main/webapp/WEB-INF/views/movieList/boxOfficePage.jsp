<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">    
<link rel="stylesheet" type="text/css" href="../resources/css/test.css">      
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<title>박스오피스</title>
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
<div style="width: 1200px; margin: 0 auto; font-family: 'Nanum Gothic Coding', monospace;">
	<div class="container-fluid">
                <div class="row mt-3 userInfofont">
                    <div class="col"></div> <!--왼쪽 공백-->

                    <!-- 전체 시작 -->
                    <div class="col-10">
			
			
			
			<!-- 바디 로우 -->
			<div class="row mt-4" style="text-align:left;">
			<div class="col-auto fs-5 fw-bold"><i class="bi bi-film text-danger"></i><font size=5> BoxOffice</font></div></div>

			<div class="row mt-4">
			
			
			<c:forEach items="${boxList }" var="box" begin="0" end="19">
				<div class="col-2" style="text-align:center; width: 190px; margin-left: 5px;">
				<c:forEach items="${posterVoList }" var="poster">
				
					<c:choose>
						<c:when test="${empty poster.poster_url }">
							<c:if test="${box.boxOfficeVo.movie_no == poster.movie_no }">
							<a href="/movie/board/onelinereply/contentsDetails.do?movie_no=${box.boxOfficeVo.movie_no }" style="color: black; text-decoration: none;">
							<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png" alt="이미지없음" height="280" width="180">
								<div class="row mt-1">
									<div class="col fw-bold" style="width:180px; font-size:14px;">
										${box.boxOfficeVo.movie_title }
									</div>
								</div>
							</a>
								<div class="row mb-3">
									<div class="col text-danger fw-bold">
										<i class="bi bi-star-fill text-danger"></i> ${box.movieStarAvg }
									</div>
								</div>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${box.boxOfficeVo.movie_no == poster.movie_no }">
								<a href="/movie/board/onelinereply/contentsDetails.do?movie_no=${box.boxOfficeVo.movie_no }" style="color: black; text-decoration: none;">
								<img src="${poster.poster_url }" height="280" width="180">
									<div class="row mt-1">
										<div class="col fw-bold" style="width:180px; font-size:14px;">
											${box.boxOfficeVo.movie_title  }
										</div>
									</div>
								</a>
									<div class="row mb-3">
										<div class="col text-danger fw-bold">
											<i class="bi bi-star-fill text-danger"></i> ${box.movieStarAvg }
										</div>
									</div>
							</c:if>
						</c:otherwise>
					</c:choose>
				
				</c:forEach>
				</div>
			</c:forEach>
			
			</div>
			<!-- 바디로우 끝 -->
			
				<div class="row mt-5"></div>
				<div class="row mt-5"></div>
				

				
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
	                    <jsp:include page="../global/footer.jsp"></jsp:include>
	                    <div class="col-1"></div>
	                </div>
	    		</div>
        	</div>
    	</div>
		<!-- 풋터 끝 -->
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>