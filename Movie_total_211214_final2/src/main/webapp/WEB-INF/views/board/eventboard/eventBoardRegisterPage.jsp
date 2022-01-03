<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		
		<title>이벤트 등록 페이지</title>
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

						<!-- 여기에 내용 작성 -->
						<div class="row mt-4">
							<div class="col fs-4">
								<i class="bi bi-calendar3 text-danger"></i> 이벤트 등록
							</div>
						</div>
						<form action="/movie/board/eventboard/eventBoardRegisterProcess.do" method="post" enctype="multipart/form-data">
							<div class="row mt-4">
								<div class="col-2 pe-0">이벤트명</div>
								<div class="col ps-0">
									<input class="form-control" type="text" name="eventboard_title">
								</div>
							</div>
							
							<div class="row mt-3">
								<div class="col-2 pe-0">내용</div>
								<div class="col ps-0">
									<textarea class="form-control"  rows="10" cols="60" name="eventboard_content"></textarea>
								</div>
							</div>
							
							<div class="row mt-3">
								<div class="col-2 pe-0">이벤트 기간</div>
								<div class="col-auto ps-0 pe-0">시작일</div>
								<div class="col-auto">
									<input class="form-control" id="startdate" type="date" name="eventboard_startdate">
								</div>
								<div class="col-auto pe-0 ms-3">종료일</div>
								<div class="col-auto">
									<input class="form-control" id="startdate" type="date" name="eventboard_enddate">
								</div>
							</div>
							
							<div class="row mt-3">
								<div class="col-2">첨부파일</div>
								<div class="col ps-0 ">
									<input class="form-control"  type="file" multiple accept="image/*" name="files">
								</div>
							</div>
							
							<div class="row mt-5">
								<div class="col d-grid">
									<input class="btn btn-primary" type="submit" value="작성 완료">
								</div>
							</div>
						</form>

					</div>
					<!-- 전체 종료 -->
					
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

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>		
	</body>
</html>