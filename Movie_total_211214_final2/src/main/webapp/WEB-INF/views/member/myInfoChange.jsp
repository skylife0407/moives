<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		<title>영화리스트</title>
	</head>
	<script type="text/javascript">
	
	function doSubmit(){
	
		var pwc = document.getElementById("pwChange");
		
		//비밀번호 확인
		var pw = document.getElementById("pw");
		var pwConfirm = document.getElementById("pwConfirm");
		if(pw.value != pwConfirm.value){
			alert("비밀번호가 일치하지 않습니다.");
			pw.value = "";
			pwConfirm.value = "";
			
			pw.focus();
			return ;
		}
		
		pwChange.submit();
}
	
	
	
</script>
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
					<div class="col-10"> 
				
					<div class="row mt-4">
						<div class="col"><h1>개인정보 변경</h1></div>
					</div>
				
					
					<div class="row mt-3">
					
						<!-- 비밀번호 변경 -->
						<div class="col" style="border: 1px solid #C0C0C0; margin: 5px;" >
							
							<div class="row mt-4">
								<div class="col ms-3">
									<font size=5>비밀번호 변경</font>
								</div>
							</div>
							
							<div class="row mt-2">
								<div class="col ms-3">
									<font color=#FF0000>안전한 비밀번호</font>로 내정보를 보호하세요.
								</div>
							</div>
							<div class="row mt-2">
								<div class="col ms-3">
									<font size=2><font color=#FFA500>다른 아이디/사이트에서 사용한 적 없는 비밀번호</font></font>
								</div>
							</div>
							<div class="row mt-2">
								<div class="col ms-3">
									<font size=2><font color=#FFA500>이전에 사용한 적 없는 비밀번호</font>가 안전합니다.</font>
								</div>
							</div>
							
							<div class="row mt-4">
								<div class="col">
								
									<form id="pwChange" action="./myPwChangeComplete.do" method="post">
									
										<div class="row ms-2">
											<div class="col">
													<input id="pw" type="password" name="member_pw" placeholder="비밀번호" size=28></div>
											<div class="col-2"></div>
										</div>
										
				
										
										<div class="row mt-3 ms-2">
											<div class="col">
													<input id="pwConfirm" type="password" placeholder="비밀번호확인" size=28></div>
											<div class="col-2"></div>
										</div>
										
											<div class="row mt-3 mb-4 ms-2">
													<div class="col">
														<input class="btn btn-outline-dark" type="button" onclick="doSubmit()" value="변경">
													</div>
												<div class="col-2"></div>
											</div>
										
									</form>
									
								</div>
							</div>
						</div>
						<!-- 비밀번호 변경 끝 -->
						
						<!-- 닉네임 및 이메일 변경 -->
						<div class="col" style="border: 1px solid #C0C0C0; margin: 5px;" >
							
							<div class="row mt-4">
								<div class="col ms-3">
									<font size=5>이메일 변경</font>
								</div>
							</div>
							
							<div class="row mt-4">
								<div class="col">
									<form action="./myEmailChangeComplete.do" method="post">
									
										<div class="row ms-2">
											<div class="col">
												<input type="text" name="member_email" placeholder="${memberVo.member_email }" size=28>
											</div>
										
											<div class="row mt-3 mb-4">
												<div class="col-2">
													<input class="btn btn-outline-dark" type="submit" value="변경">
												</div>
											</div>
										</div>
										
									</form>
								</div>
							</div>
							
							
							<div class="row mt-2">
								<div class="col ms-3">
									<font size=5>닉네임 변경</font>
								</div>
							</div>
						
							<div class="row mt-4">
								<div class="col">
									<form action="./myNickChangeComplete.do" method="post">
									
										<div class="row ms-2">
											<div class="col">
												<input type="text" name="member_nick" placeholder="${memberVo.member_nick }" size=28>
											</div>
										
											<div class="row mt-3 mb-4">
												<div class="col-2">
													<input class="btn btn-outline-dark" type="submit" value="변경">
												</div>
											</div>
										</div>
										
									</form>
								</div>
							</div>
							
						</div>
						<!-- 닉네임 및 이메일 변경 끝 -->
											</div>
					<div class="row mt-2">
						<div class="col" style="border: 1px solid #C0C0C0; margin: 5px;">
							<div class="row mt-3">
								<div class="col ms-3">
									<font size=5>선호장르 변경</font>
								</div>
							</div>
							<form action="./myChoiseMovieChangeComplete.do" method="post">

								<div class="row ms-2">
									<div class="col-auto mt-2">
										<select name="genre_category_no">
											<c:forEach items="${genreList }" var="genreList">
												<option
													value="${genreList.genreCategoryVo.genre_category_no }">${genreList.genreCategoryVo.genre_name }</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-auto mt-2">
										<select name="genre_category_no">
											<c:forEach items="${genreList }" var="genreList">
												<option
													value="${genreList.genreCategoryVo.genre_category_no }">${genreList.genreCategoryVo.genre_name }</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-auto mt-2">
										<select name="genre_category_no">
											<c:forEach items="${genreList }" var="genreList">
												<option
													value="${genreList.genreCategoryVo.genre_category_no }">${genreList.genreCategoryVo.genre_name }</option>
											</c:forEach>
										</select>
									</div>

									<div class="row mt-3 mb-4">
										<div class="col-2">
											<div><input class="btn btn-outline-dark" type="submit" value="변경"></div>
										</div>
									</div>
								</div>

							</form>
						</div>
					</div>
					</div>
						
					<div class="row mt-3">
						<div class="col" style="text-align:center;">
							<input class="btn btn-outline-dark" type="button" value="뒤로가기" onClick="history.go(-1)">
						</div>	
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