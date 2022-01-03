<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<link rel="stylesheet" type="text/css" href="../resources/css/test.css?v=2">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

<title>영화리스트</title>
</head>
<body>
	<!-- 네비바 시작 -->
	<div style="width: 100%; height: 140px; margin: 0 auto" class="bg-dark">
		<div style="width: 1200px; margin: 0 auto" class="bg-dark">
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
	<div style="width: 1200px; margin: 0 auto;">
		<div class="container-fluid">
			<div class="row mt-3">
				<div class="col"></div>
				<!--왼쪽 공백-->
				<!-- 전체 시작 -->
				<div class="col-10 userInfofont text-center">

					<div class="row mt-3">
						<div class="col">
							<i class="bi bi-exclamation-triangle fs-1 text-danger"></i>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col fs-3">
							로그인에 실패 하였습니다.
						</div>
					</div>
					
					<div class="row mt-3">
						<div class="col">
							아이디 혹은 비밀번호가 틀렸습니다. 다시 확인해 주세요.
						</div>
					</div>
					<div class="row mt-4">
						<div class="col">
							<a class="btn btn-secondary" href="./loginPage.do">로그인 페이지로</a>
						</div>
					</div>
					
					<div class="row" style="margin-top:70px;">
						<div class="col">
							
						</div>
					</div>
					
				</div>
				<!-- 전체 끝 -->
				
				<div class="col"></div>
					<!-- 오른쪽 공백 -->
			</div>
		</div>
	</div>
	<!-- 본문 끝 -->
	<!-- 풋터 시작 -->
	<div style="width: 100%; height: 180px; margin: 80px auto 0px auto" class="bg-dark">
		<div style="width: 1200px; margin: 0 auto" class="bg-dark">
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