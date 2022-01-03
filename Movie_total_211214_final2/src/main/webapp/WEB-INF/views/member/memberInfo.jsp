<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		
		<title>회원정보</title>
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
			
					<div class="row mt-4">
						<div class="col-auto pe-0">
							<i class="bi bi-person-circle fs-4 text-danger"></i>
						</div>
						<div class="col fs-4">내정보</div>
					</div>
					
					<!-- 첫째줄 -->
					<div class="row mt-3">
							
						<!-- 무비스 프로필 -->
						<div class="col" style="border: 1px solid #C0C0C0; margin: 5px;" >
					
							<div class="row mt-4">
								<div class="col ms-3">
									<font size=5>무비스 프로필</font>
								</div>
							</div>
							<div class="row mt-2">
								<div class="col ms-3">
									무비스에서의 <font color=#FFA500>'나'를 표현하는 프로필</font> 정보입니다.
								</div>
							</div>
							<div class="row mt-4">
								<div class="col-auto ms-3">
									
									<c:forEach items="${iconList }" var="icon">
										<c:if test="${icon.iconShopVo.icon_no==sessionUser.icon_no }">
											<img class="img-fluid" src="/iconFiles/${icon.iconShopVo.icon_link }">
										</c:if>
									</c:forEach>
									
								</div>
								<div class="col mb-4">
									<div class="row">
										<div class="col-auto fs-5">닉네임</div>
										<div class="col text-secandary pt-1">${sessionUser.member_nick }</div>
									</div>
									<div class="row mt-2">
										<div class="col-auto fs-5">보유포인트</div>
										<div class="col text-secandary pt-1">${sessionUser.member_point } P</div>
									</div>
								</div>
							</div>
							<div class="row mt-4 mb-4 ms-1">
								<div class="col">
									<a href="./myInfoChange.do"><input class="btn btn-outline-dark" type="button" value="비밀번호 및 닉네임 변경"></a>
								</div>
							</div>
						</div>
						<!-- 무비스 프로필 끝 -->
						
						<!-- 이메일 및 생일 -->
						<div class="col" style="border: 1px solid #C0C0C0; margin: 5px;">
							<div class="row mt-4">
								<div class="col ms-3">
									<font size=5>개인정보</font>
								</div>
							</div>
							<div class="row mt-2">
								<div class="col-auto ms-3 pe-0">
									<i class="bi bi-envelope fs-4"></i>
								</div>
								<div class="col fs-5">
									${sessionUser.member_email }
								</div>
							</div>
							<div class="row mt-3">
								<div class="col-auto ms-3 pe-0">
									<i class="bi bi-calendar-check fs-4"></i>
								</div>
								<div class="col fs-5 pt-1">
									<fmt:formatDate value="${sessionUser.member_birth }" pattern="yyyy.MM.dd"/>
								</div>
							</div>
							<div class="row mt-3">
								<div class="col-auto ms-3 pe-0">
									<i class="bi bi-bookmark-star fs-4"></i>
								</div>
								<div class="col-auto fs-5 pt-1">
									선호장르
								</div>
								<div class="col pt-1">
									<c:forEach items="${genreVo }" var="list">
										<c:if test="${list.GenreVo.member_no == sessionUser.member_no }">
											<c:forEach items="${genreList }" var="genreList">
												<c:if test="${list.GenreVo.genrecategory_no == genreList.genreCategoryVo.genre_category_no }">
													${genreList.genreCategoryVo.genre_name }
												</c:if>
											</c:forEach>
										</c:if> 
									</c:forEach>
								</div>
							</div>
							<div class="row mt-2">
								<div class="col"></div>
							</div>
							<div class="row ms-1" style="margin-top:24px;">
								<div class="col">
									<a href="./myInfoChange.do"><input class="btn btn-outline-dark" type="button" value="수정"></a>
								</div>
							</div>
						</div>
						<!-- 이메일 및 생일 끝 -->
					</div>
					<!-- 첫째줄 끝 -->
					
					<!-- 둘째줄 -->
					<div class="row mt-3">
					
						<!-- 내가 추천한 영화 -->
						<div class="col" style="border: 1px solid #C0C0C0; margin: 5px;" >
							<div class="row mt-4">
								<div class="col ms-3">
									<font size=5>내가 추천한 영화</font>
								</div>
								<div class="col-auto pt-2 ps-0 fw-bold" style="font-size:small">
									<a href="./myRecommendMovie.do" class="text-decoration-none text-dark">더보기<i class="bi bi-play-fill"></i></a>
								</div>
							</div>
						
							<div class="row mt-2 mb-3 justify-content-center">
								<c:forEach items="${movieLikeList }" var="movieLike">
									
<%-- 								 <c:if test="${sessionUser.member_no ==  movieLike.movieLikeVo.member_no}"> --%>
									
									<c:forEach items="${movieList }" var="movie">
										
										<c:if test="${movieLike.movie_no == movie.movieVo.movie_no }">
											<div class="col-auto" style="text-align:center;">
												
												<c:forEach items="${posterVoList }" var="poster">
													<c:choose>
														<c:when test="${empty poster.poster_url }">
															<c:if test="${movie.movieVo.movie_no == poster.movie_no }">
																<a href="/movie/board/onelinereply/contentsDetails.do?movie_no=${movie.movieVo.movie_no }" style="color: black; text-decoration: none;">
																	<div class="row mt-3">
																		<div class="col">
																			<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png" alt="이미지없음" height="200" width="135">
																		</div>
																	</div>
																	<div class="row">
																		<div class="col">
																			<font size=2>${movie.movieVo.movie_title }</font>
																		</div>
																	</div>
																</a>
															</c:if>
														</c:when>
														
														<c:otherwise>
															<c:if test="${movie.movieVo.movie_no == poster.movie_no }">
																<a href="/movie/board/onelinereply/contentsDetails.do?movie_no=${movie.movieVo.movie_no }" style="color: black; text-decoration: none;">
																	<div class="row mt-3">
																		<div class="col">
																			<img src="${poster.poster_url }" height="200" width="135">
																		</div>
																	</div>
																	<div class="row">
																		<div class="col">
																			<font size=2>${movie.movieVo.movie_title }</font>
																		</div>
																	</div>
																</a>
															</c:if>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</div>	
										</c:if>
											
									</c:forEach>
									
<%-- 								</c:if>  --%>
							</c:forEach>
						</div>
							
						</div>
						<!-- 내가 추천한 영화 끝 -->
						
						<!-- 내가 평가한 영화 -->
						<div class="col" style="border: 1px solid #C0C0C0; margin: 5px;" >
							<div class="row mt-4">
								<div class="col ms-3">
									<font size=5>내가 평가한 영화</font>
								</div>
								<div class="col-auto pt-2 ps-0 fw-bold" style="font-size:small">
									<a href="./myEvalMovie.do" class="text-decoration-none text-dark">더보기<i class="bi bi-play-fill"></i></a>
								</div>
							</div>
							
							<div class="row mt-2 mb-3 justify-content-center" >
								<c:forEach items="${movieEvalList }" var="movieEval">
<%-- 									<c:if test="${sessionUser.member_no ==  movieEval.member_no}"> --%>
										
										<c:forEach items="${movieList }" var="movie">
											<c:if test="${movieEval.movie_no == movie.movieVo.movie_no }">
												<div class="col-auto" style="text-align:center;">
													
													<c:forEach items="${posterVoList }" var="poster">
														<c:choose>
															<c:when test="${empty poster.poster_url }">
																<c:if test="${movie.movieVo.movie_no == poster.movie_no }">
																	<a href="/movie/board/onelinereply/contentsDetails.do?movie_no=${movie.movieVo.movie_no }" style="color: black; text-decoration: none;">
																		<div class="row mt-3">
																			<div class="col">
																				<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png" alt="이미지없음" height="200" width="135">
																			</div>
																		</div>
																		<div class="row">
																			<div class="col">
																				<font size=2>${movie.movieVo.movie_title }</font>
																			</div>
																		</div>
																	</a>
																</c:if>
															</c:when>
															
															<c:otherwise>
																<c:if test="${movie.movieVo.movie_no == poster.movie_no }">
																	<a href="/movie/board/onelinereply/contentsDetails.do?movie_no=${movie.movieVo.movie_no }" style="color: black; text-decoration: none;">
																		<div class="row mt-3">
																			<div class="col">
																				<img src="${poster.poster_url }" height="200" width="135">
																			</div>
																		</div>
																		<div class="row">
																			<div class="col">
																				<font size=2>${movie.movieVo.movie_title }</font>
																			</div>
																		</div>
																	</a>
																</c:if>
															</c:otherwise>
														</c:choose>
													</c:forEach>
													
												</div>
											</c:if>
										</c:forEach>
										
<%-- 									</c:if> --%>
								</c:forEach>
								
							</div>
							
						</div>
						<!-- 내가 평가한 영화 끝 -->
						
					</div>
					<!-- 둘째줄 끝 -->
					
					<div class="row" style="padding-bottom:100px;">
						<div class="col"></div>
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