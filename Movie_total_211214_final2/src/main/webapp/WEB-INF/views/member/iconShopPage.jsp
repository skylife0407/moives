<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
		<link rel="stylesheet" type="text/css"href="/movie/resources/css/test.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
		
		<script>
			function doIconBuy(iconNo,iconPrice){
				
				var xmlhttp = new XMLHttpRequest();
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
					}
				};
				xmlhttp.open("get" , "./iconBuy.do?member_no=" + ${sessionUser.member_no } + "&icon_no=" + iconNo + "&icon_price=" + iconPrice); 
				xmlhttp.send();		
			}
			
		</script>
		
		<title>아이콘 상점 페이지</title>
	</head>
	
	<body>
		<!-- 네비바 시작 -->
		<div style="width: 100%; height: 140px; margin: 0 auto" class="bg-dark">
			<div style="width: 1200px; margin: 0 auto" class="bg-dark">
				<div class="container-fluid">
					<div class="row userInfofont">
						<div class="col-1"></div>
						<jsp:include page="/WEB-INF/views/global/search_userInfo.jsp"></jsp:include>
						<div class="col-1"></div>
					</div>
	
					<div class="row">
						<div class="col-1"></div>
						<div class="col">
							<jsp:include page="/WEB-INF/views/global/nav_bar.jsp"></jsp:include>
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
	
						<div class="row mt-4">
							<div class="col fs-4">아이콘 상점</div>
						</div>
						
							<!-- 첫째줄 -->
							<div class="row mt-3">
								<c:forEach items="${list }" var="icon">
								<!-- 첫번째 아이콘 -->							
								<div class="col-2" style="border: 1px solid #C0C0C0; margin: 5px;">
									<div class="row mt-4">
										<div class="col text-center fs-5">
											${icon.iconShopVo.icon_no}번 아이콘
										</div>
									</div>
									<div class="row mt-4 justify-content-center">
										<div class="col-auto">
											<img class="img-fluid" src="/iconFiles/${icon.iconShopVo.icon_link }" width="80" height="80">
										</div>
									</div>
									<div class="row mt-4 ms-1">
										<div class="col text-center">${icon.iconShopVo.icon_price } P</div>
									</div>
									<div class="row mt-2 mb-4 justify-content-center">
										<div class="col-auto">
											<c:choose>
												<c:when test="${sessionUser.member_point >= icon.iconShopVo.icon_price }">
													<input class="btn btn-outline-dark" onclick="doIconBuy(${icon.iconShopVo.icon_no},${icon.iconShopVo.icon_price })" type="button" value="구매">
												</c:when>
												<c:otherwise>
													<input class="btn btn-outline-danger" type="button" value="포인트부족">
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
								<!-- 첫번째 아이콘 끝 -->
								</c:forEach>
							</div>
							<!-- 첫째줄 끝 -->
							
							<div class="row" style="margin-top:50px;">
								<div class="col">
									
								</div>
							</div>
						
					</div>
					<!-- 오른쪽 공백 -->
					<div class="col"></div>
				</div>
			</div>
		</div>

		<!-- 풋터 시작 -->
		<div style="width: 100%; height: 180px; margin: 80px auto 0px auto"
			class="bg-dark">
			<div style="width: 1200px; margin: 0 auto" class="bg-dark">
				<div class="container-fluid">
					<div class="row mt-4 pt-4 text-white">
						<div class="col-1"></div>
						<jsp:include page="/WEB-INF/views/global/footer.jsp"></jsp:include>
						<div class="col-1"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- 풋터 끝 -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	</body>
</html>