<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		
		<link rel="stylesheet" type="text/css" href="../../resources/css/test.css?v=2">
		
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
		
		<script type="text/javascript">
	
			var logined = false;
			var sessionNo = null;
			var freeboardNo = ${data.freeBoardVo.freeboard_no};
			
			function getSessionUserInfo(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						if(data.isLogined == true){
							logined = true;
							sessionNo = data.sessionNo; 
						}else{
							logined = false;
						}
					}
				};
				
				xmlhttp.open("get" , "../../member/getSessionUserInfo.do" , false); 
				xmlhttp.send();		
			} 
			
			function writeComment(){
			      
			      if(logined == false){
		
			         var result = confirm("로그인 하셔야 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?");
			         if(result){
			            location.href = "../../member/loginPage.do";            
			         }
			         return;
			      }
			      
			      var commentBox = document.getElementById("reply");
			      var commentText = commentBox.value;
			      
			            
			      var xmlhttp = new XMLHttpRequest();
			      
			      xmlhttp.onreadystatechange = function(){
			         if(xmlhttp.readyState==4 && xmlhttp.status==200){
			            var data = JSON.parse(xmlhttp.responseText);
			            
			            refreshReplyList();
			         }
			      };
			      
			      xmlhttp.open("post" , "./writeCommentProcess.do"); 
			      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			      xmlhttp.send("freeboard_no=" + freeboardNo + "&freeboard_reply_content=" + commentText);
			      
			      commentBox.value = "";
			   }
			
			
			function refreshReplyList(){
				
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						//렌더링...DOM 엘리먼트 컨트롤 : 생성 추가 삭제 접근... 속성...innerText등...
						
						var commentListBox = document.getElementById("commentListBox")
						
						//제한조건...innerHTML은...절대 쓰지 마셈...!!!!! 단 아래처럼 초기화 할때 빼고...
						commentListBox.innerHTML = ""; //초기화...
						
						for(commentData of data.replylist){
							
							var outerRow = document.createElement("div");
							outerRow.setAttribute("class" , "row");
							
							var outerCol = document.createElement("div");
							outerCol.setAttribute("class" , "col replyWrapper");
							
							outerRow.appendChild(outerCol);
							
							var rowBox = document.createElement("div"); //<div></div>
							rowBox.setAttribute("class" , "row mb-2 border bg-light"); //<div class='row'></div>
							
							outerCol.appendChild(rowBox);
							
							var nickColBox = document.createElement("div");
							nickColBox.setAttribute("class" , "col-2 border-end fw-bold");
							nickColBox.innerText = commentData.memberVo.member_nick; 
							
							//조립...
							rowBox.appendChild(nickColBox);
							
							var contentColBox = document.createElement("div");
							contentColBox.setAttribute("class" , "col-5 border-end");
							contentColBox.innerText = commentData.freeBoardReplyVo.freeboard_reply_content;
							
							rowBox.appendChild(contentColBox);
							
							var dateColBox = document.createElement("div");
							dateColBox.setAttribute("class" , "col-2 me-auto");
							var date = new Date(commentData.freeBoardReplyVo.freeboard_reply_writedate);
							//result = date.toLocaleString();					
							
							var str = date.getFullYear() + "/" + (date.getMonth()+1) + "/" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes(); 
							
							dateColBox.innerText = str;
							
							rowBox.appendChild(dateColBox);
							
							//삭제 버튼...
							
							var deleteColBox = document.createElement("div");
							
							
							if(sessionNo == commentData.memberVo.member_no){
								deleteColBox.setAttribute("class" , "col-1 btn btn-outline-danger btn-sm");
								deleteColBox.setAttribute("onclick" , "replyDelete("+ commentData.freeBoardReplyVo.freeboard_reply_no +")");
								deleteColBox.innerText = "삭제";
							}
							
							//수정버튼...
							var updateButtonBox = document.createElement("div");
							
							if(sessionNo == commentData.memberVo.member_no){
								updateButtonBox.setAttribute("class" , "col-1 btn btn-outline-dark btn-sm");
								updateButtonBox.setAttribute("onclick" , "createUpdateForm(this , "+ commentData.freeBoardReplyVo.freeboard_reply_no +")");
								updateButtonBox.innerText = "수정";
							} 
		
							rowBox.appendChild(updateButtonBox);
							rowBox.appendChild(deleteColBox);
		
							//수정 입력 양식 위치 작업..
							var updateFormRow = document.createElement("div");
							updateFormRow.setAttribute("class","row mt-2");
		
							var updateFormCol = document.createElement("div");
							updateFormCol.setAttribute("class","col updateFormCol");
							
		
							updateFormRow.appendChild(updateFormCol);
							
							outerCol.appendChild(updateFormRow);
							
							
							commentListBox.appendChild(outerRow);
						}
						
					}
				};
				
				xmlhttp.open("get" , "./getReplyList.do?freeboard_no=" + freeboardNo); 
				xmlhttp.send();		
				
			}
			
			
			function createUpdateForm(e , replyNo){
				
				//수정 폼 초기화...
				var updateFormCols = document.getElementsByClassName("updateFormCol");
				for(x of updateFormCols){
					x.innerHTML = "";
				}
				var replycontainerRow = document.createElement("div");
				replycontainerRow.setAttribute("class" , "row p-3 border");
				
				var replycontainertextCol = document.createElement("div");
				replycontainertextCol.setAttribute("class" , "col");
				
				var replycontainerbtnCol = document.createElement("div");
				replycontainerbtnCol.setAttribute("class" , "col-auto");

				
				var inputBox = document.createElement("textarea");
				inputBox.setAttribute("id" , "updateReplyContentTextArea");
				inputBox.setAttribute("class" , "form-control");
				
				var updateConfirmButton = document.createElement("button");
				updateConfirmButton.innerText = "수정 완료";
				updateConfirmButton.setAttribute("onclick" , "updateProcess("+replyNo+")");
				updateConfirmButton.setAttribute("class" , "btn btn-success btn-sm ms-2");
				
				var wrapperBox = e.closest(".replyWrapper");
				var targetBox = wrapperBox.getElementsByClassName("updateFormCol");
				
				replycontainertextCol.appendChild(inputBox);
				replycontainerbtnCol.appendChild(updateConfirmButton);
				replycontainerRow.appendChild(replycontainertextCol);
				replycontainerRow.appendChild(replycontainerbtnCol);
				
				targetBox[0].appendChild(replycontainerRow);
				
			}
			
			function updateProcess(replyNo){
				
				var updateReplyContentTextArea = 
					document.getElementById("updateReplyContentTextArea");
				
				var replyContent = updateReplyContentTextArea.value;
		
				
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						//var data = JSON.parse(xmlhttp.responseText);
						refreshReplyList();
					}
				};
				
				xmlhttp.open("post" , "./replyUpdateProcess.do");
				xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				xmlhttp.send("freeboard_reply_no=" + replyNo + "&freeboard_reply_content=" + replyContent);					
				
			}
			
			
			
			function replyDelete(replyNo){
				
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						//var data = JSON.parse(xmlhttp.responseText);
						refreshReplyList();
					}
				};
				
				xmlhttp.open("get" , "./replyDeleteProcess.do?freeboard_reply_no=" + replyNo); 
				xmlhttp.send();		
				
				
			}
			
			
			
			function init(){
				//로그인 상태 처리...
				getSessionUserInfo();
				
				if(logined == true){
					//refreshLikeButton();
				}
				refreshReplyList();
				//refreshTotalLike();
				
				//setInterval(refreshReplyList , 5000);	
				
			}
			
			window.addEventListener("DOMContentLoaded" , init);
		</script>
		
		<title>자유게시판 상세 페이지</title>

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
				
		<!-- 본문 시작 -->
		<div style="width: 1200px; margin: 0 auto;">
			<div class="container-fluid">
				<div class="row mt-3">
				
					<div class="col"></div> <!--왼쪽 공백-->
					
					<!-- 전체 시작 -->
					<div class="col-10">
						<div class="row mt-4">
							<div class="col fs-3 fw-bold">${data.freeBoardVo.freeboard_title }</div>
						</div> 
					
						<div class="row mt-2 pb-2 border-bottom border-secondary">
							<div class="col-auto pe-0"><i class="bi bi-person-fill"></i></div>
							<div class="col-2 me-auto fw-bold">${data.memberVo.member_nick }</div>
							
							<div class="col-auto"><i class="bi bi-calendar3"></i> <fmt:formatDate value="${data.freeBoardVo.freeboard_writedate }" pattern="yy.MM.dd HH:MM"/></div>
							
							<div class="col-auto pe-0"><i class="bi bi-eye"></i> 조회수</div>
							<div class="col-auto">${data.freeBoardVo.freeboard_readcount }</div>
						</div>
					
						<!-- 게시판 정보 -->
					
					
						<%-- <div class="col"><font size=6 color=#FE2E64>${data.freeBoardVo.freeboard_title }</font></div> --%>
						
						<div class="row mt-2 pb-2 border-bottom border-secondary">
							<div class="col">${data.freeBoardVo.freeboard_content }</div>
						</div>
						
					
						<!-- 목록 삭제 수정버튼 -->
						<c:if test="${!empty sessionUser && sessionUser.member_no == data.freeBoardVo.member_no }">
							<div class="row mt-3 justify-content-end">
								<div class="col-auto pe-0">
									<a href="/movie/board/freeboard/updateContentPage.do?freeboard_no=${data.freeBoardVo.freeboard_no }" class="btn btn-secondary btn-sm">수정</a>
								</div>
								<div class="col-auto">
									<a href="/movie/board/freeboard/deleteContentProcess.do?freeboard_no=${data.freeBoardVo.freeboard_no }" class="btn btn-danger btn-sm">삭제</a>
								</div>
							</div>			
						</c:if>		
						<!-- 목록 삭제 수정버튼 끝 -->	
					
						<div class="row mt-3">
							<div class="col fs-5 fw-bold">
								<i class="bi bi-chat"> 댓글목록</i>
							</div>
						</div>
							
						<!-- 댓글 리스트 -->
						<div class="row mt-3">
							<div class="col">
								<div id="commentListBox"></div>
							</div>
						</div>
						
						<!-- 댓글 작성 -->
						<%-- <c:choose>
							<c:when test="${!empty sessionUser }"> --%>
						
						<div class="row mt-5 border p-3">
							<div class="col-2 border-end">${sessionUser.member_nick }</div>
							<div class="col ps-0 me-auto">
								<textarea class="form-control" placeholder="악의적인 댓글은 인터넷 문화를 병들게 합니다." id="reply" rows="" cols=""></textarea>
							</div>
							<div class="col-auto d-grid">
								<button class="btn btn-primary" onclick="writeComment()">등록</button>
							</div>
						</div>		
						
						<!-- 댓글 작성 끝 -->
					
						<div class="row justify-content-center mt-3">
							<div class="col-auto">
								<a class="btn btn-secondary btn-sm" href="/movie/board/freeboard/freeBoardPage.do"><i class="bi bi-list"></i> 목록으로</a>
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