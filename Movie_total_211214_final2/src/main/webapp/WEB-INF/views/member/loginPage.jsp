<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		
		<title>로그인 페이지</title>
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
		
		<div style="width: 1200px; height: 60vh;  margin: 0 auto; font-family: 'Nanum Gothic Coding', monospace;">
			<div class="container-fluid">
            	<div class="row mt-3">
                    <div class="col"></div> <!--왼쪽 공백-->

                    <!-- 전체 시작 -->
                    <div class="col-8 userInfofont border py-4 px-5 bg-light" style="margin-top:90px;">
                    
                    	<div class="row">
                    		<div class="col fs-3 text-center">로그인</div>
                    	</div>
                    	
                    	<div class="row mt-3">
                    		<div class="col">
                    			<form action="./loginProcess.do" method="post">
									<div class="row mt-3">
										<div class="col-auto">
											<i class="bi bi-person fs-4"></i>
										</div>
										<div class="col ps-1">
											<input class="form-control" type="text" name="member_id" placeholder="아이디">
										</div>
									</div>
									<div class="row mt-3">
										<div class="col-auto">
											<i class="bi bi-shield-lock fs-4"></i>
										</div>
										<div class="col ps-1">
											<input class="form-control" type="password" name="member_pw" placeholder="비밀번호">
										</div>
									</div>
									
									<div class="row mt-2">
										<div class="col-auto ">
											<input class="form-check-input" type="checkbox" value="">
										</div>
										<div class="col ps-1 text-secondary">아이디 저장</div>
									</div>
									
									<div class="row mt-3">
										<div class="col d-grid">
											<input type="submit" class="btn btn-primary" value="로그인">
										</div>
									</div>
								</form>
							</div>
                    	</div>
                    	
                    	<div class="row mt-3 justify-content-center">
                    		<div class="col-auto me-1 border-end">
                    			<a class="text-secondary" href="">ID/PW 찾기</a>
							</div>
                    		<div class="col-auto">
                    			<a class="text-secondary" href="./joinMemberPage.do">회원가입</a>
							</div>
                    	</div>
	
						
					</div>
					<!-- 전체 끝 -->
					
					<div class="col"></div>
				</div>
			</div>
		</div>
	    
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