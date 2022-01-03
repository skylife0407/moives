<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<div class="col-auto pe-3 mt-2 pt-1">
		<a class="fs-4 fw-bold" href="/movie/movieList/movieListPage.do"><img src="/movie/resources/img/movies.png" width="60" height="60" style="background-color: rgba(255,255,255,0);"></a>
	</div>
	<div class="col-7 mt-4 ms-2" >
		<div class="input-group mb-3">
			<input type="text" class="form-control" placeholder="영화 검색" aria-label="Recipient's username" aria-describedby="button-addon2">
			<button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
		</div>
	</div>
	
	<c:choose>
		<c:when test="${!empty sessionUser }">
			<div class="col-auto mt-4 pt-1 text-white">
			<i class="bi bi-coin text-warning userInfofont"></i> ${sessionUser.member_point } P
			</div>
			<div class="col-auto text-white dropdown mt-4 pt-1">
				<a class="dropdown-toggle text-decoration-none text-white" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					<i class="bi bi-person-fill"></i> ${sessionUser.member_nick }
				</a>
				<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
		            <li><a class="dropdown-item" href="/movie/member/memberInfo.do"><i class="bi bi-shield-lock"></i> 내정보</a></li>
		            <li><a class="dropdown-item" href="/movie/member/iconShopPage.do"><i class="bi bi-cart"></i> 아이콘상점</a></li>
		            <li><a class="dropdown-item" href="/movie/member/myWritePost.do"><i class="bi bi-person-lines-fill"></i> 내글보기</a></li>
		            <li><hr class="dropdown-divider"></li>
		            <li><a class="dropdown-item" href="/movie/member/logoutProcess.do"><i class="bi bi-box-arrow-right"></i> 로그아웃</a></li>
	          	</ul>
			</div>
		</c:when>
		<c:otherwise>
			<div class="col-auto mt-4 pt-1 ms-3">
				<a href="/movie/member/loginPage.do" class="text-white text-decoration-none">
					로그인
				</a>
			</div>
			<div class="col-auto mt-4 pt-1">
				<a href="/movie/member/joinMemberPage.do" class="text-white text-decoration-none">
					회원가입
				</a>
			</div>
		</c:otherwise>
	</c:choose>
