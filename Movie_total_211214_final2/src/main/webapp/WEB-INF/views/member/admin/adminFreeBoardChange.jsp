<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 관리 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
<link rel="stylesheet" type="text/css" href="/movie/resources/css/test.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
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
				<div class="col-10">

					<c:choose>
						<c:when test="${sessionUser.member_auth == 1 }">
							<form action="./AdminFreeBoardChangeProcess.do" method="post">
								계정상태 : <input name="freeboard_activity" value="${list.freeboard_activity }"><br> <input type="hidden" name="freeboard_no" value="${list.freeboard_no }"> <input type="submit" value="변경">
							</form>
						</c:when>
						<c:otherwise>
							잘못된 페이지 입니다. <a href="/movie/movieList/movieListPage.do">메인페이지로 돌아가기</a>
						</c:otherwise>
					</c:choose>
				</div>
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