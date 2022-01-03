<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">

		<script>
		
			function calendar(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						var testList = new Array() ;
						
				        for(x of data.eventBoardList){
				        	// 객체 생성
				        	var tt = new Object() ;
				            
				            tt.title= x.eventVo.eventboard_title,
				            tt.start= x.eventVo.eventboard_startdate,
				            tt.end= x.eventVo.eventboard_enddate
				             
				            // 리스트에 생성된 객체 삽입
				            testList.push(tt) ;
				            //출력결과 : [{"number":1,"name":"Tester #1"},{"number":2,"name":"Tester #2"}]
				            
				        }
				         
				        // String 형태로 변환
				        var jsonData = JSON.stringify(testList) ;
				        console.log(jsonData);
				        
						var calendarEl = document.getElementById('calendar');
						
					    var calendar = new FullCalendar.Calendar(calendarEl, {
					      
					      editable: true,
					      selectable: true,
					      businessHours: true,
					      dayMaxEvents: true, // allow "more" link when too many events
					      events: testList
					    });
			
					    calendar.render();
					}
				};
				
				xmlhttp.open("get" , "./eventBoardCalendar.do"); 
				xmlhttp.send();		
				
			}
			
			
			function init(){
				calendar();			
				
			}
			
			window.addEventListener("DOMContentLoaded" , init);
	
		</script>

		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">    
		<link rel="stylesheet" type="text/css" href="../../resources/css/test.css">      
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

		<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

		<title>이달의 이벤트</title>
	</head>

	<body class="userInfofont">
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
                    
                    	<div class="row">
                    		<div class="col userInfofont">
                    			<div id='calendar'></div>
                    		</div>
                    	</div> 
                    <!-- 게시판 이름 -->
                    <div class="row mt-4">
						<div class="col fs-4 fw-bold text-center">
							이달의 이벤트
						</div>
					</div>
					<!-- 게시판 이름 끝 -->
					
					
					<!-- 왼쪽위 링크 -->
                    <div class="row mt-3">
                    	<div class="col">
                    		<nav aria-label="breadcrumb">
						 		<ol class="breadcrumb">
						  		  <li class="breadcrumb-item"><a href="#" style="color: blue; text-decoration: none;">진행중인 이벤트</a></li>
						   		  <li class="breadcrumb-item"><a href="#" style="color: green; text-decoration: none;">예정된 이벤트</a></li>
								  <li class="breadcrumb-item"><a href="#" style="color: red; text-decoration: none;">종료된 이벤트</a></li>
						  		</ol>
							</nav>
                    	</div>
                    </div>
                    <!-- 왼쪽위 링크 끝 -->
                    
                    <!-- 검색 -->
                    <div class="row mt-1"><!-- 검색... -->
						<div class="col">
							<input class="form-control" type="text" placeholder="이벤트를 검색하세요">
						</div>
						<div class="col-2 d-grid">
							<input class="btn btn-outline-dark" type="submit" value="검색">
						</div>
					</div>
					<!-- 검색 끝 -->
					
					<!-- 내용 -->
					<hr>
					<div class="row">
					<c:forEach items="${list }" var="data">
						<c:if test="${data.eventVo.eventboard_activity == 0 }">
					<div class="col-6">
					<div class="row mt-3">
						<div class="col">
							<a href="/movie/board/eventboard/eventBoardDetailPage.do?eventboard_no=${data.eventVo.eventboard_no }" ><img src="/upload/${data.imageVo.eventboard_image_link }" alt="Responsive image"  class="img-fluid" style="height:200px; width:226px;"></a>
						</div>
					
					
					
						<div class="col">
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
							<fmt:formatDate value="${data.eventVo.eventboard_startdate }"  pattern="yyyy-MM-dd" var="startdate"/>
							<fmt:formatDate value="${data.eventVo.eventboard_enddate }" pattern="yyyy-MM-dd" var="enddate"/>
						
							
							<c:choose>
								<c:when test="${startdate < today && enddate > today }">
									<span  style="color:white" class="badge rounded-pill bg-primary">진행중인 이벤트</span>
								</c:when>
								<c:when test="${enddate < today }">
									<span  style="color:white" class="badge rounded-pill bg-danger">종료된 이벤트 </span>
								</c:when>
								<c:otherwise>
									<span style="color:white" class="badge rounded-pill bg-success">예정된 이벤트 </span>
								</c:otherwise>
							</c:choose>
							
							
									<div class="row mb-3">
											<div class="col">
												<h4><a href="/movie/board/eventboard/eventBoardDetailPage.do?eventboard_no=${data.eventVo.eventboard_no }" style="color: black; text-decoration: none;">${data.eventVo.eventboard_title }</a></h4>
											</div>
									</div>
									
									<div class="row">
										<div class="col fs-6 text-secondary fw-bold pe-0">
											<i class="bi bi-calendar"></i> <fmt:formatDate value="${data.eventVo.eventboard_startdate }"  pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${data.eventVo.eventboard_enddate }" pattern="yyyy.MM.dd"/>
										</div>
									</div>
									
									<div class="row mt-1">
										<div class="col">
											<i class="bi bi-hand-thumbs-up-fill text-primary"></i> ${data.totalLike }<br>
										</div>
									</div>	
						
									<div class="row mt-4">
										
											<c:if
												 test="${!empty sessionUser && sessionUser.member_auth == 1 }">	
												 <div class="col-auto pe-0">
												 	<a class="btn btn-success btn-sm" href="/movie/board/eventboard/eventBoardUpdatePage.do?eventboard_no=${data.eventVo.eventboard_no }" >수정</a>
												</div>
												 <div class="col-auto ps-1">
												 	<a class="btn btn-danger btn-sm" href="/movie/board/eventboard/eventBoardDeleteProcess.do?eventboard_no=${data.eventVo.eventboard_no }">삭제</a>
												</div>
										
						     	 			</c:if>
										
									</div>
									
						</div>
						</div>
						</div>
						</c:if>
						</c:forEach>
						</div>
						  <hr>
                    
                    <!-- 등록 -->
                    <div class="row">
                    <div class="col"></div>
                    	<div class="col-2 d-grid">
                    	 	<c:if test="${!empty sessionUser && sessionUser.member_auth == 1 }">					
							<a class="btn btn-success" href="/movie/board/eventboard/eventBoardRegisterPage.do">등록</a>
							</c:if>
                    	</div>
                    </div>
					
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