<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css"> 
		<link rel="stylesheet" type="text/css" href="../../resources/css/test.css">      
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
	
		<title>상세 리뷰 작성페이지</title>
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
		
		<div style="width: 1200px; margin: 0 auto; font-family: 'Nanum Gothic Coding', monospace;">
			<div class="container-fluid">
                <div class="row mt-3">
                    <div class="col"></div> <!--왼쪽 공백-->

                    <!-- 전체 시작 -->
                    <div class="col-10 userInfofont"> 
			
						<div class="row mt-5">
							<div class="col-auto pe-0">
								<i class="bi bi-file-earmark-slides fs-4 text-danger"></i>
							</div>
							<div class="col fs-4">
								상세 리뷰 작성
							</div>
						</div>
						
						<div class="row mt-4">
							<div class="col">
								<form action="/movie/board/reviewboard/reviewWriteContentProcess.do" method="post" enctype="multipart/form-data">
									<div class="row fs-5">
										<div class="col-1 pe-0">
											<!-- <i class="bi bi-person-fill"></i>  -->작성자 
										</div>
										<div class="col">
											${sessionUser.member_nick }
										</div>
									</div>
									
									<div class="row mt-2 fs-5">
										<div class="col-1 pe-0">
											<!-- <i class="bi bi-person-fill"></i>  -->제목 
										</div>
										<div class="col">
											<input class="form-control" type="text" name="reviewboard_title">
										</div>
									</div>
									
									<div class="row mt-2 fs-5">
										<div class="col-1 pe-0">
											<!-- <i class="bi bi-person-fill"></i>  -->내용 
										</div>
										<div class="col">
											<textarea class="form-control" rows="10" cols="120" name="reviewboard_content"></textarea>
										</div>
									</div>
									
									<div class="row mt-2">
										<div class="col-1"></div>
										<div class="col">
										  <input class="form-control" type="file" id="formFile" multiple accept="image/*" name="files">
										</div>
									</div>
										
									<div class="row mt-4">
										<div class="col-1"></div>
										<div class="col d-grid">
											<input class="btn btn-primary" type="submit" value="작성 완료">	  
										</div>
									</div>
									
								</form>
							</div>
						</div>
				
						
					</div>
					<!-- 전체 끝 -->
					
					<div class="col"></div> <!-- 오른쪽 공백 -->
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