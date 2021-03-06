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
		function doActivity(target, memberNo) {
	
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var data = JSON.parse(xmlhttp.responseText);
					getActivity(target, memberNo);
				}
			};
			xmlhttp.open("get", "./doMemberActivity.do?member_no=" + memberNo + "&activity=" + target);
			xmlhttp.send();
		}
		
		function getActivity(target, memberNo) {
	
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var data = JSON.parse(xmlhttp.responseText);
	
				}
			};
			xmlhttp.open("get", "./getActivity.do?member_no=" + memberNo + "&auth=" + target);
			xmlhttp.send();
		}
		
		
		function doAuth(target, memberNo) {
	
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var data = JSON.parse(xmlhttp.responseText);
					getAuth(target, memberNo);
				}
			};
			xmlhttp.open("get", "./doAuth.do?member_no=" + memberNo + "&auth=" + target);
			xmlhttp.send();
		}
		
		function getAuth(target, memberNo) {
	
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					var data = JSON.parse(xmlhttp.responseText);
	
				}
			};
			xmlhttp.open("get", "./getActivity.do?member_no=" + memberNo);
			xmlhttp.send();
		}
	</script>
	
	<title>????????? ?????? ?????????</title>
	
	</head>
	<body>
		<!-- ????????? ?????? -->
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
		<!-- ????????? ??? -->
	
		<div style="width: 1200px; margin: 0 auto; font-family: 'Nanum Gothic Coding', monospace;">
			<div class="container-fluid">
				<div class="row mt-3">
					
					<div class="col"></div> <!--?????? ??????-->
					
					<!-- ?????? ?????? -->
					<div class="col-10 userInfofont">
						<div class="row mt-3">
							<div class="col text-center fs-4">????????? ??????</div>
						</div>
						
						<div class="row mt-3">
							<div class="col">
								<table id="userinfo" class="table table-striped">
									<tr>
										<td>????????????</td>
										<td>?????????</td>
										<td>????????????</td>
										<td>??????</td>
									</tr>
									<c:forEach items="${list }" var="memberdate">
										<tr>
											<td>${memberdate.adminMemberListVo.member_no }</td>
											<td>${memberdate.adminMemberListVo.member_nick }</td>
											<td>
												<p id="memberOpen" onclick="doActivity(1,${memberdate.adminMemberListVo.member_no })" class="btn<c:if test="${memberdate.adminMemberListVo.member_activity == 1 }"> btn-primary</c:if>">??????</p>
												<p id="memberClose" onclick="doActivity(0,${memberdate.adminMemberListVo.member_no })" class="btn<c:if test="${memberdate.adminMemberListVo.member_activity == 0 }"> btn-primary</c:if>">?????????</p>
											</td>
											<td>
												<p id="user" onclick="doAuth(0,${memberdate.adminMemberListVo.member_no })" class="btn<c:if test="${memberdate.adminMemberListVo.member_auth == 0 }"> btn-primary</c:if>">?????????</p>
												<p id="admin" onclick="doAuth(1,${memberdate.adminMemberListVo.member_no })" class="btn<c:if test="${memberdate.adminMemberListVo.member_auth == 1 }"> btn-primary</c:if>">?????????</p>
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
						
						<div class="row mt-5 justify-content-center">
							<div class="col-auto">
								<input class="btn btn-secondary" type="button" value="????????????" onClick="history.go(-1)">
							</div>
						</div>
	
						
					</div>
					
					<div class="col"></div> <!--????????? ??????-->
					
				</div>
			</div>
		</div>

		<!-- ?????? ?????? -->
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
	<!-- ?????? ??? -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	</body>
</html>