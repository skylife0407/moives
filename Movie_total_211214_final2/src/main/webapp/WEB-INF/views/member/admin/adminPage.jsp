<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
		<link rel="stylesheet" type="text/css" href="/movie/resources/css/test.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
		
		<style type="text/css">
			.pointBatingText {
				font-family: 'Nanum Gothic', sans-serif;
			}
		</style>
		
		<title>관리자 페이지 메인</title>
	</head>
	
	<body>
	<!-- 네비바 시작 -->
	<div style="width: 100%; height: 140px; margin: 0 auto" class="bg-dark">
		<div style="width: 1200px; margin: 0 auto" class="bg-dark">
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
				<!--왼쪽 공백-->
				<div class="col"></div>
				<!-- 전체 시작 -->
				<div class="col-10 userInfofont">
				
					<c:choose>
						<c:when test="${sessionUser.member_auth == 1 }">
							<div class="row mt-4">
								<div class="col-auto pe-0">
									<i class="bi bi-shield-lock-fill text-danger fs-4"></i>
								</div>
								<div class="col fs-5 pt-1">
									관리자 페이지
								</div>
							</div>
							<!-- 첫째줄 -->
							<div class="row mt-3">

								<!-- 사용자 관리 페이지 -->
								<div class="col bg-light" style="border: 1px solid #C0C0C0; margin: 5px;">
									<div class="row mt-4">
										<div class="col-auto pe-0 ms-3">
											<i class="bi bi-person-fill fs-4""></i>
										</div>
										<div class="col ps-1 fs-5 pt-1">
											사용자 관리
										</div>
									</div>
									<div class="row mt-2">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4 mb-4 ms-1">
										<div class="col">
											<a href="/movie/member/memberAdmin.do"><input class="btn btn-outline-danger" type="button" value="사용자 관리"></a>
										</div>
									</div>
								</div>
								<!-- 사용자 관리 페이지 끝 -->

								<!-- 자유게시판 관리 페이지 -->
								<div class="col bg-light" style="border: 1px solid #C0C0C0; margin: 5px;">
									<div class="row mt-4">
										<div class="col-auto pe-0 ms-3">
											<i class="bi bi-pencil-square fs-4"></i>
										</div>
										<div class="col ps-2 fs-5 pt-1">
											자유게시판
										</div>
									</div>
									<div class="row mt-2">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4 mb-4 ms-1">
										<div class="col">
											<a href="/movie/member/freeBoardAdmin.do"><input class="btn btn-outline-danger" type="button" value="자유게시판 관리"></a>
										</div>
									</div>
								</div>
								<!-- 자유게시판 관리 페이지 끝 -->
							</div>
							<!-- 첫째줄 끝 -->

							<!-- 두번째줄 -->
							<div class="row mt-3">

								<!-- 이벤트 관리 페이지 -->
								<div class="col bg-light" style="border: 1px solid #C0C0C0; margin: 5px;">
									<div class="row mt-4">
										<div class="col-auto pe-0 ms-3">
											<i class="bi bi-calendar-event-fill fs-4"></i>
										</div>
										<div class="col ps-2 fs-5 pt-1">
											이벤트게시판
										</div>
									</div>
									<div class="row mt-2">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4 mb-4 ms-1">
										<div class="col">
											<a href="/movie/member/eventBoardAdmin.do"><input class="btn btn-outline-danger" type="button" value="이벤트게시판 관리"></a>
										</div>
									</div>
								</div>
								<!-- 이벤트 관리 페이지 끝 -->

								<!-- 리뷰 관리 페이지 -->
								<div class="col bg-light" style="border: 1px solid #C0C0C0; margin: 5px;">
									<div class="row mt-4">
										<div class="col-auto pe-0 ms-3">
											<i class="bi bi-camera fs-4"></i>
										</div>
										<div class="col ps-2 fs-5 pt-1">
											리뷰게시판
										</div>
									</div>
									<div class="row mt-2">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4 mb-4 ms-1">
										<div class="col">
											<a href="/movie/member/reviewBoardAdmin.do"><input class="btn btn-outline-danger" type="button" value="리뷰게시판 관리"></a>
										</div>
									</div>
								</div>
								<!-- 리뷰 관리 페이지 끝 -->
							</div>
							<!-- 두번째줄 끝 -->

							<!-- 세번째줄 -->
							<div class="row mt-3">

								<!-- 아이콘 관리 페이지 -->
								<div class="col bg-light" style="border: 1px solid #C0C0C0; margin: 5px;">
									<div class="row mt-4">
										<div class="col-auto pe-0 ms-3">
											<i class="bi bi-emoji-smile fs-4"></i>
										</div>
										<div class="col ps-2 fs-5 pt-1">
											아이콘샵
										</div>
									</div>
									<div class="row mt-2">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4">
										<div class="col ms-3"></div>
									</div>
									<div class="row mt-4 mb-4 ms-1">
										<div class="col">
											<a href="/movie/member/iconShopAdmin.do"><input class="btn btn-outline-danger" type="button" value="아이콘샵 관리"></a>
										</div>
									</div>
								</div>
								<!-- 이벤트 관리 페이지 끝 -->


							</div>
							<!-- 세번째줄 끝 -->

						</c:when>
						<c:otherwise>
							잘못된 페이지 입니다. <a href="/movie/movieList/movieListPage.do">메인페이지로 돌아가기</a>
						</c:otherwise>
					</c:choose>
				</div>
				<!-- 전체 끝 -->
				<div class="col"></div>
			</div>
		</div>
	</div>
	
	<!-- 풋터 시작 -->
	<div style="width: 100%; height: 180px; margin: 80px auto 0px auto" class="bg-dark">
		<div style="width: 1200px; margin: 0 auto" class="bg-dark">
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