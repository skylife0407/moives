<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">    
<link rel="stylesheet" type="text/css" href="../../resources/css/test.css">      
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
</head>
<body>
    	<!-- 네비바 시작 -->
		<div style="width:100%; height:140px; margin: 0 auto" class="bg-dark">
	    	<div style="width:1200px; margin: 0 auto" class="bg-dark">
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
		<div style="width: 1200px; margin: 0 auto;">
			<div class="container-fluid">
                <div class="row mt-3">
                    <div class="col"></div> <!--왼쪽 공백-->

                    <!-- 전체 시작 -->
                    <div class="col-10 userInfofont"> 
	
						<div class="row">
	
						<div class="col"></div>
						
						<div class="col-10">
	
						<font size=6>글을 작성하는 공간 입니다.</font>

						<form action="/movie/board/freeboard/writeContentProcess.do" method="post">
						
						<div class="row">
							<div class="col">
								<div class="row mt-2">
									<div class="col">
										<font size=4>${sessionUser.member_nick } 님의 글</font>
									</div>
								</div>
								
								<div class="row mt-2 mb-4">
									<div class="col">
										<input type="text" class="form-control" name="freeboard_title" placeholder="제목" style="border-top: none; border-bottom: 1px solid gray; border-left: none; border-right: none;">
									</div>
								</div>
								
								<div class="row mt-2">
									<div class="col">
										<textarea class="form-control" rows="10" name="freeboard_content" placeholder="내용"></textarea>
									</div>
								</div>
					
								<div class="row mt-3">
									<div class="col text-center">
										<input type="submit" value="작성 완료" class="btn btn-outline-dark">
									</div>
								</div>
							</div>
						</div>
			
			
					</form>
					
					</div>
		
				<div class="col"></div>
		
				</div>
				
				
				</div>
				<!-- 전체 끝 -->
				
				 <div class="col"></div> <!--오른쪽 공백-->
				
		</div>

	</div>

</div>

        <!-- 풋터 시작 -->
		<div style="width:100%; height:180px; margin: 80px auto 0px auto" class="bg-dark">
        	<div style="width:1200px; margin: 0 auto" class="bg-dark">
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
</body>
</html>