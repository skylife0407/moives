<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		<script type="text/javascript">
			
			var logined = false;
			var sessionNo = null;
			var reviewboardNo = ${data.reviewBoardVo.reviewboard_no};
			
			 function like() {
				
				if(logined == false){
		
					var result = confirm("로그인 하셔야 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?");
					if(result){
						location.href = "../../member/loginPage.do";				
					}
					return;
				}
				
				
				//AJAX API 사용....
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						refreshLikeButton();
						refreshTotalLike();
					}
				};
				
				
				xmlhttp.open("get" , "./doLikeRest.do?reviewboard_no=${data.reviewBoardVo.reviewboard_no}"); 
				xmlhttp.send();
				
				
			}
			
			function refreshLikeButton(){
				
				if(logined == false){
					return;
				}
				
				//var aaa = null;
				//aaa.xxx = 10;
				
				
				var xmlhttp = new XMLHttpRequest();
		
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						//렌더링..DOM 조작 : 엘리먼트 접근 , 생성 , 추가 , 삭제... 속성 컨트롤 , 스타일 컨트롤..
						var heartButton = document.getElementById("heartButton");
						
						if(data.myLikeCount > 0){
							heartButton.setAttribute("class" , "bi bi-hand-thumbs-up-fill text-danger");
						}else{
							heartButton.setAttribute("class" , "bi bi bi-hand-thumbs-up text-danger");
						}
					}
				};
				
				xmlhttp.open("get" , "./getMyLikeData.do?reviewboard_no=${data.reviewBoardVo.reviewboard_no}"); 
				xmlhttp.send();
			}
			
			function refreshTotalLike(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						//렌더링...
						var totalCountBox = document.getElementById("totalCountBox");
						//totalCountBox.setAttribute("class", "size");
						totalCountBox.innerText = "" + data.totalLikeCount;
					}
				};
				
				xmlhttp.open("get" , "./getTotalLikeCount.do?reviewboard_no=${data.reviewBoardVo.reviewboard_no}"); 
				xmlhttp.send();
			}
			
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
			      
			      xmlhttp.open("post" , "./reviewCommentProcess.do"); 
			      xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			      xmlhttp.send("reviewboard_no=" + reviewboardNo + "&reviewboard_reply_content=" + commentText);
			      
			      commentBox.value = "";
			   }
			
			
			   function replyWriteContent(){
				
				if(logined == false){
		
					var result = confirm("로그인 하셔야 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?");
					if(result){
						location.href = "../../member/loginPage.do";				
					}
					return;
				}
				
				var commentBox = document.getElementById("abcd");
				var commentText = commentBox.value;
				
						
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						refreshCommentList();
					}
				};
				
				xmlhttp.open("post" , "./replyWriteContentProcess.do"); 
				xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				xmlhttp.send("reviewboard_no=" + reviewboardNo + "&reviewboard_reply_content=" + commentText);
				
				
				commentBox.value = "";
			} 
			
			function refreshReplyList(){
				
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						//렌더링...DOM 엘리먼트 컨트롤 : 생성 추가 삭제 접근... 속성...innerText등...
						
						var commentListBox = document.getElementById("commentListBox")
						
						var countReplyBox = document.getElementById("countReply");
						
						//제한조건...innerHTML은...절대 쓰지 마셈...!!!!! 단 아래처럼 초기화 할때 빼고...
						commentListBox.innerHTML = ""; //초기화...
						
						for(commentData of data.reviewreplylist){
							
							var outerRow = document.createElement("div");
							outerRow.setAttribute("class" , "row");
							
							var outerCol = document.createElement("div");
							outerCol.setAttribute("class" , "col reviewreplyWrapper");
							
							outerRow.appendChild(outerCol);
							
							var rowBox = document.createElement("div"); //<div></div>
							rowBox.setAttribute("class" , "row mb-2 border bg-light"); //<div class='row'></div>
							
							outerCol.appendChild(rowBox);
							
							var nickColBox = document.createElement("div");
							nickColBox.setAttribute("class" , "col-2 border-end fw-bold");
							nickColBox.innerText = commentData.memberVo.member_nick; //<div class='col-2 bg-primary'>afef</div>
							
							//조립...
							rowBox.appendChild(nickColBox);
							
							var contentColBox = document.createElement("div");
							contentColBox.setAttribute("class" , "col-5 border-end");
							contentColBox.innerText = commentData.reviewBoardReplyVo.reviewboard_reply_content;
							
							rowBox.appendChild(contentColBox);
							
							var dateColBox = document.createElement("div");
							dateColBox.setAttribute("class" , "col-2 me-auto");
							var date = new Date();
							/* result = date.toLocaleString(commentData.reviewBoardReplyVo.reviewboard_reply_writedate); */
							result = commentData.reviewBoardReplyVo.reviewboard_reply_writedate;
							dateColBox.innerText = result;
							
							rowBox.appendChild(dateColBox);
							
							
							
							//삭제 버튼...
							//수정버튼...
							var deleteColBox = document.createElement("div");
							var updateButtonBox = document.createElement("div");
							
							if(sessionNo == commentData.memberVo.member_no){
								deleteColBox.setAttribute("class" , "col-auto delete btn btn-outline-danger btn-sm");
								deleteColBox.setAttribute("onclick" , "replyDelete("+ commentData.reviewBoardReplyVo.reviewboard_reply_no +")");
								deleteColBox.innerText = "삭제";
								
								updateButtonBox.setAttribute("class" , "col-auto btn btn-outline-secondary btn-sm");
								updateButtonBox.setAttribute("onclick" , "createUpdateForm(this , "+ commentData.reviewBoardReplyVo.reviewboard_reply_no +")");
								updateButtonBox.innerText = "수정";
							}
							
							
							rowBox.appendChild(updateButtonBox);
							rowBox.appendChild(deleteColBox);
		
							//수정 입력 양식 위치 작업..
							var updateFormRow = document.createElement("div");
							updateFormRow.setAttribute("class","row updateFormRow");
		
							var updateFormCol = document.createElement("div");
							updateFormCol.setAttribute("class","col updateFormCol px-0");
							
		
							updateFormRow.appendChild(updateFormCol);
							
							outerCol.appendChild(updateFormRow);
							
							
							commentListBox.appendChild(outerRow);
						}
						
					}
				};
				
				xmlhttp.open("get" , "./getReviewReplyList.do?reviewboard_no=" + reviewboardNo); 
				xmlhttp.send();		
				
			}
			
			
			function createUpdateForm(e , reviewreplyNo){
				
				//수정 폼 초기화...
				var updateFormCols = document.getElementsByClassName("updateFormCol");
				for(x of updateFormCols){
					x.innerHTML = "";
				}
				
				console.log(e);
				
				var inputBox = document.createElement("textarea");
				inputBox.setAttribute("id" , "reviewupdateReplyContentTextArea");
				inputBox.setAttribute("cols", "80");
				
				var updateConfirmButton = document.createElement("button");
				updateConfirmButton.innerText = "수정 완료";
				updateConfirmButton.setAttribute("onclick" , "updateProcess("+reviewreplyNo+")");
				
				var wrapperBox = e.closest(".reviewreplyWrapper");
				var targetBox = wrapperBox.getElementsByClassName("updateFormCol");
				
				targetBox[0].appendChild(inputBox);
				targetBox[0].appendChild(updateConfirmButton);
				
			}
			
			function updateProcess(reviewreplyNo){
				
				var reviewupdateReplyContentTextArea = 
					document.getElementById("reviewupdateReplyContentTextArea");
				
				var replyContent = reviewupdateReplyContentTextArea.value;
		
				
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						//var data = JSON.parse(xmlhttp.responseText);
						refreshReplyList();
					}
				};
				
				xmlhttp.open("post" , "./reviewReplyUpdateProcess.do");
				xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				xmlhttp.send("reviewboard_reply_no=" + reviewreplyNo + "&reviewboard_reply_content=" + replyContent);					
				
			}
			
			
			
			function replyDelete(replyNo){
				
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						//var data = JSON.parse(xmlhttp.responseText);
						refreshReplyList();
					}
				};
				
				xmlhttp.open("get" , "./reviewReplyDeleteProcess.do?reviewboard_reply_no=" + replyNo); 
				xmlhttp.send();		
				
				
			}
			
			
			
			function init(){
				//로그인 상태 처리...
				getSessionUserInfo();
				
				if(logined == true){
					refreshLikeButton();
				}
				refreshReplyList();
				refreshTotalLike();
				
				//setInterval(refreshReplyList , 5000);	
				
			}
			
			window.addEventListener("DOMContentLoaded" , init);
		</script>
		
		<title>상세 페이지</title>
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
					<div class="row mt-5">
						<div class="col fs-1 text-center">	
							${data.reviewBoardVo.reviewboard_title }
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-auto">				
							<c:forEach items="${data.imageVoList }" var="imageVo">
								<img class="img-fluid" src="/upload/${imageVo.reviewboard_image_link }" alt="Responsive image" width="300px" height="450px" >
							</c:forEach>
						</div>	
						
						<div class="col border bg-light p-3">
							<div class="row mb-2 pb-2 border-bottom">
								<div class="col-2 fw-bold">영화제목</div>
								<div class="col border-start">소리도 없이</div>
							</div>
							<div class="row mb-2 pb-2 border-bottom">
								<div class="col-2   fw-bold">작성자</div>
								<div class="col border-start">${data.memberVo.member_nick }</div>
							</div>
							<div class="row mb-2 pb-2 border-bottom">
								<div class="col-2   fw-bold">작성일</div>
								<div class="col border-start">
									<fmt:formatDate value="${data.reviewBoardVo.reviewboard_writedate }" pattern="yyyy-MM-dd HH:mm"/>
								</div>
								
							</div>
							<div class="row mb-2 pb-2 border-bottom">
								<div class="col-2   fw-bold">조회수</div>
								<div class="col border-start">${data.reviewBoardVo.reviewboard_readcount }</div>
							</div>
							<div class="row ">
								<div class="col-2 fw-bold">내용</div>
								<div class="col form-floating border-start">
									${data.reviewBoardVo.reviewboard_content }
								</div>
							</div>
						</div>
					</div>
					
					<div class="row mt-3">
						<div class="col-1">
							<!-- 추천 하트 표시 -->
							<div class="row">
								<div class="col-auto heartlink pe-0">
									<i id="heartButton" class="bi bi-hand-thumbs-up text-danger" onclick="like()" style="font-size: 1.5rem;"></i></div> 
									<div class="col-auto ps-1 pt-2">
									<p id="totalCountBox"></p>
								</div>
							</div>
						</div>
						
						<div class="col">
							<div class="row justify-content-center">
								<c:if test="${!empty sessionUser && sessionUser.member_no == data.reviewBoardVo.member_no }">
									<div class="col-auto pe-0">
										<a class="btn btn-success btn-sm" href="/movie/board/reviewboard/reviewUpdateContentPage.do?reviewboard_no=${data.reviewBoardVo.reviewboard_no }"><i class="bi bi-pencil"></i> 수정</a>
									</div>
									<div class="col-auto pe-0">
										<a class="btn btn-danger btn-sm" href="/movie/board/reviewboard/reviewDeleteContentProcess.do?reviewboard_no=${data.reviewBoardVo.reviewboard_no }"><i class="bi bi-x"></i> 삭제</a>
									</div>
								</c:if>	
							</div>
						</div>
						<div class="col-1"></div>
						
					</div>
		
				
			
			 	
			 	 	<!-- 리뷰 타이틀  -->
                    <div class="row mt-4 border-bottom pb-2">
                    	<div class="col-auto fs-5 fw-bold pe-0"><i class="bi bi-card-text"></i> 댓글</div>
                    	<!-- <div class="col-auto ps-0 pt-1">(3)</div> -->
                    	<div class="col-auto me-auto px-1 pt-1 fs-6" id="countReply"></div>
                    	<div class="col-auto pt-1 pb-0 px-2 fs-6"><i class="bi bi-funnel"></i> 정렬</div>
                    	<div class="col-auto pt-1 pb-0 px-0 fs-6">|</div>
                    	<div class="col-auto pt-1 pb-0 ps-2 fs-6">최신순</div>
                    </div>
		                        
		          	<!-- 리뷰 타이틀 끝 -->
			 	
		
					<!-- 댓글 리스트 -->
					<div class="row mt-3">
						<div class="col">
							<div id="commentListBox"></div>
						</div>
					</div>
				
		
				
					<!-- 페이징 시작 -->
					<div class="row mt-3 justify-content-center">
					   	<div class="col-auto" id="pagenation">
					   		<nav aria-label="...">
							  <ul class="pagination pagination-sm">
							    <li class="page-item disabled">
							     <a class="page-link">Previous</a>
							    </li>
							    <li class="page-item active" aria-current="page"><a class="page-link" href="#"  style="background-color: #c5bfc3; border-color: #c5bfc3;">1</a></li>
							    <li class="page-item">
							     <a class="page-link text-decoration-none text-dark" href="#">2</a>
							    </li>
							   <li class="page-item"><a class="page-link text-decoration-none text-dark" href="#">3</a></li>
							    <li class="page-item"><a class="page-link text-decoration-none text-dark" href="#">4</a></li>
							    <li class="page-item"><a class="page-link text-decoration-none text-dark" href="#">5</a></li>
							    <li class="page-item">
							   <a class="page-link text-decoration-none text-dark" href="#">Next</a>
							    </li>
							  </ul>
							</nav>        
				          </div>
			          </div>
				   	<!-- 페이징 끝 -->
					
		
			
			<!-- 리뷰 작성 -->
		      <div class="row mt-4">
		         <div class="col">
		           	<div class="border border-secondary border-2 px-3 py-2 bg-white">
		           		<div class="row"> <!-- 타이틀 & 점수 -->
			              <div class="col-auto fs-6 fw-bold"><i class="bi bi-pencil-square"></i> 영화 리뷰에 대한 의견을 말해주세요.</div>
		                  <div class="col ps-0"> 
			                  <div id="rater"	></div>
			                   </div>
			              </div>
			              <div class="row mt-2">
			                    <div class="col-auto">
			                          <textarea id="reply" rows="3" cols="70"></textarea>
			                    </div>
			                    <div class="col-auto pt-51 ps-0">
			                       	<button class="btn btn-outline-dark" onclick="writeComment()">작성</button>
			                    </div>
			                  </div>
		                   	</div>
		                                		
		         </div>
		      </div>
		     <!-- 리뷰 작성 끝 -->	
				
			<div class="row justify-content-center mt-3">
				<div class="col-auto">
					<a class="btn btn-secondary btn-sm" href="/movie/board/reviewboard/reviewBoardPage.do"><i class="bi bi-list"></i> 목록으로</a>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	</body>
</html>