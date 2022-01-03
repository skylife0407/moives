<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		
		<script>
			function doActivity(target , boardNo){
				
				var xmlhttp = new XMLHttpRequest();
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						getActivity(target , boardNo);
					}
				};
				xmlhttp.open("get" , "./doActivityReviewBoard.do?board_no=" + boardNo + "&activity=" + target); 
				xmlhttp.send();
			}
		
			function getActivity(target , boardNo){
				
				var xmlhttp = new XMLHttpRequest();
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						//렌더링..
						//target.parent....
					}
				};
				xmlhttp.open("get" , "./getActivity.do?board_no=" + boardNo); 
				xmlhttp.send();
				
				
			}
			
		</script>
		<title>리뷰게시판 관리 페이지</title>
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
				
					<div class="col"></div> <!--왼쪽 공백-->
					
					<!-- 전체 시작 -->
					<div class="col-10 userInfofont">
						<c:choose>
							<c:when test="${sessionUser.member_auth == 1 }">
								<div class="row mt-3">
									<div class="col text-center fs-4">리뷰 게시판 관리</div>
								</div>
								
								<div class="row mt-3">
									<div class="col">
										<table class="table table-striped">
											<tr>
												<td>글 번호</td>
												<td>제목</td>
												<td>작성자</td>
												<td>작성일</td>
												<td>공개여부</td>
											</tr>
											<c:forEach items="${list }" var="reviewboarddate">
												<tr>
													<td><a href="/movie/board/reviewboard/reviewReadContentPage.do?reviewboard_no=${reviewboarddate.adminReviewBoardListVo.reviewboard_no }">${reviewboarddate.adminReviewBoardListVo.reviewboard_no }</a></td>
													<td>${reviewboarddate.adminReviewBoardListVo.reviewboard_title }</td>
													<td>${reviewboarddate.adminMemberListVo.member_nick }</td>
													<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${reviewboarddate.adminReviewBoardListVo.reviewboard_writedate }" /></td>
													<td>
														<p id="open" onclick="doActivity(0,${reviewboarddate.adminReviewBoardListVo.reviewboard_no })" class="btn<c:if test="${reviewboarddate.adminReviewBoardListVo.reviewboard_activity == 0 }"> btn-primary</c:if>">공개</p>
														<p id="close" onclick="doActivity(1,${reviewboarddate.adminReviewBoardListVo.reviewboard_no })" class="btn<c:if test="${reviewboarddate.adminReviewBoardListVo.reviewboard_activity == 1 }"> btn-primary</c:if>">비공개</p>
													</td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								잘못된 페이지 입니다. <a href="/movie/movieList/movieListPage.do">메인페이지로 돌아가기</a>
							</c:otherwise>
						</c:choose>
					
						<div class="row mt-5 justify-content-center">
							<div class="col-auto">
								<input class="btn btn-secondary" type="button" value="뒤로가기" onClick="history.go(-1)">
							</div>
						</div>
						
					</div>
					<!-- 전체 끝 -->
					
					<div class="col"></div> <!--왼쪽 공백-->
					
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