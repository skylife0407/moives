<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
	
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
	
	<title>회원가입</title>
	<script>
	
		var isIdChecked = false;
		
		function doSubmit(){
	
			var frm1 = document.getElementById("joinMember");
			
			//아이디가 입력되지 않았을 때
			var id = document.getElementById("id");
			if(id.value == ""){
				alert("아이디를 입력하셔야 됩니다.");
				id.focus();
				return;
			}
			
			//비밀번호가 입력되지 않았을 때
			var pw = document.getElementById("pw");
			if(pw.value == ""){
				alert("비밀번호를 입력해주세요");
				pw.focus();
				return;
			}
			
			//비밀번호 확인
			var pwConfirm = document.getElementById("pwConfirm");
			if(pw.value != pwConfirm.value){
				alert("비밀번호가 일치하지 않습니다.");
				pw.value = "";
				pwConfirm.value = "";
				
				pw.focus();
				return ;
			}
			
			//생일이 입력되지 않았을 때
			var birth = document.getElementById("birth");
			if(birth.value == ""){
				alert("생일을 입력해주세요.");
				birth.focus();
				return;
			}
			
			if(isIdChecked == false){
				alert("아이디 중복 확인을 해주세요");
				return;
			}
			
			
			
			joinMember.submit();
		}
		
		function checkId(){
			
			var idBox = document.getElementById("id");
			var idText = idBox.value;
			
			var xmlhttp = new XMLHttpRequest();
	
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
					
					var data = JSON.parse(xmlhttp.responseText);
		
					var checkIdAlertBox = document.getElementById("checkIdAlert");				
					
					if(data.result == true){
						isIdChecked = false;
						checkIdAlertBox.innerText = "사용 불가능한 아이디 입니다.";
						checkIdAlertBox.style.color = "red";
					}else{
						isIdChecked = true;
						checkIdAlertBox.innerText = "사용 가능한 아이디 입니다.";
						checkIdAlertBox.style.color = "green";
					}
				}
			};
			
			xmlhttp.open("get" , "./isExistId.do?id=" + idText); 
			xmlhttp.send();
			
			
		}
		
	</script>
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
		
		<div style="width: 1200px; margin: 0 auto; font-family: 'Nanum Gothic Coding', monospace;">
			<div class="container-fluid">
                <div class="row mt-3">
                    <div class="col"></div> <!--왼쪽 공백-->
                    
                    <!-- 전체 시작 -->
                    <div class="col-8 userInfofont">
                    	<div class="row mt-4">
                    		<div class="col text-center fs-2">
                    			환영합니다!
                    		</div>
                    	</div>
                    	<div class="row">
                    		<div class="col text-center text-danger" style="font-size:14px;">
                    			취향 저격 영화 추천 사이트 무비스 서비스를 지금 바로 시작해 보세요.
                    		</div>
                    	</div>
                    	
                    	<div class="row mt-4">
                    		<div class="col text-center fs-4">
                    			회원가입
                    		</div>
                    	</div>
                    	
                    	<div class="row mt-3">
                    		<div class="col border border-secondary p-4 bg-light">
                    			<form action="">
	                    			<div class="row text-center">
	                    				<div class="col-auto fw-bold text-secondary me-auto">
	                    					이용약관, 개인정보 수집 및 이용, 프로모션 안내 메일 수신(선택)에 모두 동의합니다.	                    				
	                    				</div>
	                    				<div class="col-auto">
	                    					<input class="form-check-input" type="checkbox" name="chkAll">
	                    				</div>
	                    			</div>
	                    			
	                    			<div class="row text-center mt-4">
	                    				<div class="col-auto fw-bold text-secondary pe-0">
	                    					이용약관 동의
	                    				</div>
	                    				<div class="col-auto text-danger ps-0 me-auto">(필수)</div>
	                    				<div class="col-auto">
	                    					<input class="form-check-input" type="checkbox" name="chkAll">
	                    				</div>
	                    			</div>
	                    			
	                    			<div class="row text-center mt-1">
	                    				<div class="col form-floating">
	                    					<textarea disabled class="form-control p-3" style="font-size:14px; resize:none; height:90px;">무비스를 이용해주셔서 감사합니다. 본 약관은 개인정보수집에대한 동의이며 회원가입 시 생년월일, 이메일 정보를 수집합니다. 수집된 정보는 탈퇴하면 없어지게되며 입력하지 않을 시 무비스를 이용할 수 없습니다. 선호장르 선택은 회원님의 취향추천에 대한 자료로 사용됩니다.무비스를 이용해주셔서 감사합니다. 본 약관은 개인정보수집에대한 동의이며 회원가입 시 생년월일, 이메일 정보를 수집합니다. 수집된 정보는 탈퇴하면 없어지게되며 입력하지 않을 시 무비스를 이용할 수 없습니다. 선호장르 선택은 회원님의 취향추천에 대한 자료로 사용됩니다.</textarea>
	                    				</div>
	                    			</div>
	                    			
	                    			<div class="row text-center mt-4">
	                    				<div class="col-auto fw-bold text-secondary pe-0">
	                    					개인정보 수집 및 이용에 대한 안내                    				
	                    				</div>
	                    				<div class="col-auto text-danger ps-0 me-auto">(필수)</div>
	                    				<div class="col-auto">
	                    					<input class="form-check-input" type="checkbox" name="chkAll">
	                    				</div>
	                    			</div>
	                    			
	                    			<div class="row text-center mt-1">
	                    				<div class="col form-floating">
	                    					<textarea disabled class="form-control p-3" style="font-size:14px; resize:none; height:90px;">무비스를 이용해주셔서 감사합니다. 본 약관은 개인정보수집에대한 동의이며 회원가입 시 생년월일, 이메일 정보를 수집합니다. 수집된 정보는 탈퇴하면 없어지게되며 입력하지 않을 시 무비스를 이용할 수 없습니다. 선호장르 선택은 회원님의 취향추천에 대한 자료로 사용됩니다.무비스를 이용해주셔서 감사합니다. 본 약관은 개인정보수집에대한 동의이며 회원가입 시 생년월일, 이메일 정보를 수집합니다. 수집된 정보는 탈퇴하면 없어지게되며 입력하지 않을 시 무비스를 이용할 수 없습니다. 선호장르 선택은 회원님의 취향추천에 대한 자료로 사용됩니다.</textarea>
	                    				</div>
	                    			</div>
                    			
                    				<div class="row text-center mt-4">
	                    				<div class="col-auto fw-bold text-secondary me-auto">
	                    					이벤트 등 프로모션 알림 메일 수신(선택)	                    				
	                    				</div>
	                    				<div class="col-auto">
	                    					<input class="form-check-input" type="checkbox" name="chkAll">
	                    				</div>
	                    			</div>
	                    			
	                    			<div class="row text-center mt-1">
	                    				<div class="col form-floating">
	                    					<textarea disabled class="form-control p-3" style="font-size:14px; resize:none; height:90px;">무비스를 이용해주셔서 감사합니다. 본 약관은 개인정보수집에대한 동의이며 회원가입 시 생년월일, 이메일 정보를 수집합니다. 수집된 정보는 탈퇴하면 없어지게되며 입력하지 않을 시 무비스를 이용할 수 없습니다. 선호장르 선택은 회원님의 취향추천에 대한 자료로 사용됩니다.무비스를 이용해주셔서 감사합니다. 본 약관은 개인정보수집에대한 동의이며 회원가입 시 생년월일, 이메일 정보를 수집합니다. 수집된 정보는 탈퇴하면 없어지게되며 입력하지 않을 시 무비스를 이용할 수 없습니다. 선호장르 선택은 회원님의 취향추천에 대한 자료로 사용됩니다.</textarea>
	                    				</div>
	                    			</div>

								</form>
                    		</div>
                    	</div>
                    	
                    	
                    	
                    	<div class="row mt-4">
                    		<div class="col">
                    			<form id="joinMember" action="./joinMemberProcess.do" method="post">
                    				<div class="row">
                    					<div class="col-auto text-danger pe-0">*</div>
                    					<div class="col-auto ps-1">아이디</div>
                    				</div>
                    				
                    				<div class="row mt-1">
                    					<div class="col">
                    						<input class="form-control" id="id" type="text" name="member_id" onblur="checkId()" required>
                    					</div>
                    				</div>
                    				<div class="row">
                    					<div class="col" id="checkIdAlert"></div>
                    				</div>
                    				
                    				
                    				<div class="row mt-3">
                    					<div class="col-auto text-danger pe-0">*</div>
                    					<div class="col">비밀번호</div>
                    				</div>
                    				<div class="row mt-1">
                    					<div class="col">
                    						<input class="form-control" id="pw" type="password" name="member_pw" required>
                    					</div>
                    				</div>
                    				
                    				<div class="row mt-3">
                    					<div class="col-auto text-danger pe-0">*</div>
                    					<div class="col">비밀번호 재확인</div>
                    				</div>
                    				<div class="row mt-1">
                    					<div class="col">
                    						<input class="form-control" id="pwConfirm" type="password" required>
                    					</div>
                    				</div>
                    				
                    				<div class="row mt-3">
                    					<div class="col-auto text-danger pe-0">*</div>
                    					<div class="col">닉네임</div>
                    				</div>
                    				<div class="row mt-1">
                    					<div class="col">
                    						<input class="form-control" type="text" name="member_nick" required>
                    					</div>
                    				</div>
                    				
                    				<div class="row mt-3">
                    					<div class="col">이메일</div>
                    				</div>
                    				<div class="row mt-1">
                    					<div class="col">
                    						<input class="form-control" type="email" name="member_email" placeholder="name@example.com">
                    					</div>
                    				</div>
                    				
                    				<div class="row mt-3">
                    					<div class="col-auto text-danger pe-0">*</div>
                    					<div class="col">생년월일</div>
                    				</div>
                    				<div class="row mt-1">
                    					<div class="col">
                    						<input class="form-control" id="birth" type="date" name="member_birth" required>
                    					</div>
                    				</div>
                    				
                    				<div class="row mt-3">
                    					<div class="col">성별</div>
                    				</div>
                    				<div class="row mt-1">
                    					<div class="col-auto">
                    						<input class="form-check-input"  type="radio" name="member_gender" value="M" checked>
                    					</div>
                    					<div class="col-auto ps-0">남자
                    						<!-- <i class="fas fa-male" style="font-size: 2.5rem;"></i> -->
                    					</div>
                    					<div class="col-auto">
                    						<input class="form-check-input"  type="radio" name="member_gender" value="F">
                    					</div>
                    					<div class="col-auto ps-0">여자
                    						<!-- <i class="fas fa-female" style="font-size: 2.5rem;"></i> -->
                    					</div>
                    				</div>
                    				
                    				<div class="row mt-3">
                    					<div class="col-auto">선호장르</div>
                    					<div class="col-auto ps-2 pt-1 text-danger" style="font-size:12px;">
                    						<i>* 선호장르는 회원가입 후 내정보에서 수정 가능 합니다.</i>
                    					</div>
                    				</div>
               						
                    				
                    				<div class="row mt-1">
                    					<div class="col-auto">
                    						<select name="genre_category_no">
												<c:forEach items="${genreList }" var="genreList">
													<option value="${genreList.genreCategoryVo.genre_category_no }">${genreList.genreCategoryVo.genre_name }</option>
												</c:forEach>
											</select>
                    					</div>
                    					<div class="col-auto">
                    						<select name="genre_category_no">
												<c:forEach items="${genreList }" var="genreList">
													<option value="${genreList.genreCategoryVo.genre_category_no }">${genreList.genreCategoryVo.genre_name }</option>
												</c:forEach>
											</select>
                    					</div>
                    					<div class="col-auto">
                    						<select name="genre_category_no">
												<c:forEach items="${genreList }" var="genreList">
													<option value="${genreList.genreCategoryVo.genre_category_no }">${genreList.genreCategoryVo.genre_name }</option>
												</c:forEach>
											</select>
                    					</div>
                    				</div>
                    				
                    				<div class="row mt-5 justify-content-center">
                    					<div class="col d-grid">
                    						<input type="button" onclick="doSubmit()" value="가입하기" class="btn btn-primary">
                    					</div>
                    					<!-- <div class="col-auto">
                    						<input type="button" value="취소" onClick="history.go(-1)" class="btn btn-outline-danger">
                    					</div> -->
                    				</div>
                    			</form>
                    		</div>
                    	</div>
                    	
                    	
                    </div> <!-- 전체 끝 -->
                    
                    
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
	                    <jsp:include page="../global/footer.jsp"></jsp:include>
	                    <div class="col-1"></div>
	                </div>
	    		</div>
        	</div>
    	</div>
		<!-- 풋터 끝 -->
		
	</body>
</html>