<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="navbar navbar-expand-lg navbar-light bg-dark">
	<div class="container-fluid px-0 justify-content-around navfont">
	    <a class="nav-link text-white fs-5 px-0" href="/movie/movieList/movieListPage.do">
	    	영화리스트
	    </a>
	    <a class="nav-link text-white fs-5 px-0" href="/movie/board/reviewboard/reviewBoardPage.do">
	    	영화리뷰
	    </a>
	    <a class="nav-link text-white fs-5 px-0" href="/movie/board/eventboard/eventBoardPage.do">
	    	이벤트
	    </a>
	    <a class="nav-link text-white fs-5 px-0" href="/movie/board/freeboard/freeBoardPage.do">
	    	자유게시판
	    </a>
	    <a class="nav-link text-white fs-5 px-0" href="/movie/game/gameIndexPage.do">
	    	미니게임
	    </a>
	    <c:if test="${sessionUser.member_auth == 1 }">
			<a class="nav-link text-white fs-5 px-0" href="/movie/member/adminPage.do">
				관리자 페이지
			</a>		
		</c:if>
	</div>
</nav>