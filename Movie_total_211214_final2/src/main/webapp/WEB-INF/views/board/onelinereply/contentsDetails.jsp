<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        
        <link rel="stylesheet" type="text/css" href="../../resources/css/slick.css">
  		<link rel="stylesheet" type="text/css" href="../../resources/css/slick-theme.css">
        
        <link rel="stylesheet" type="text/css" href="../../resources/css/test.css">
        
        <link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.0/font/bootstrap-icons.css">

        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
        google.charts.load('current', {'packages':['bar']});
            google.charts.load('current', {'packages':['corechart']});
		    google.charts.setOnLoadCallback(getMovieStatistics);

            var logined = false;
			var iswrite = false;
			var sessionNo = null;
			var movieNo = ${map.movieVo.movie_no};
			var myReply = null;	
			var myReplyNo = 0;
			var myStar = 0;
			var is_action = false;
			
			function oneTimeListener(element, type, callback) {
				element.addEventListener(type, function() {
					element.removeEventListener(type, arguments.callee);
					return callback();
				});
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

            function checkingUserWrote(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						if(data.isWrite == true){
							iswrite = true;
						}else{
							iswrite = false;
						}
					}
				};
				
				xmlhttp.open("get" , "./checkingUserWrote.do?movie_no=" + movieNo , false); 
				xmlhttp.send();		
			}

            function like() {
				
				if(logined == false){
					var result = confirm("로그인 하셔야 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?");
					if(result){
						location.href = "../../member/loginPage.do";				
					}
					return;
				}
				
				var xmlhttp = new XMLHttpRequest();

				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						refreshLikeButton();
						refreshTotalLike();
					}
				};	

				xmlhttp.open("get" , "./doLikeRest.do?movie_no=" + movieNo); 
				xmlhttp.send();
			}

            function refreshLikeButton(){				
				if(logined == false){
					return;
				}		

				var xmlhttp = new XMLHttpRequest();

				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						var heartButton = document.getElementById("heartButton");
						
						if(data.myLikeCount > 0){
							heartButton.setAttribute("class" , "bi bi-heart-fill text-danger");
						}else{
							heartButton.setAttribute("class" , "bi bi-heart text-danger");
						}
						getMovieStatistics();
					}
				};
	
				xmlhttp.open("get" , "./getMyLikeData.do?movie_no=" + movieNo); 
				xmlhttp.send();
			}
            
            function refreshTotalLike(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						//렌더링...
						var totalCountBox = document.getElementById("totalCountBox");
						
						totalCountBox.innerText = "추천수 " + data.totalLikeCount;
					}
				};
				
				xmlhttp.open("get" , "./getTotalLikeCount.do?movie_no=" + movieNo); 
				xmlhttp.send();
			}

            function refreshAvgStar(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						var avgStarBox = document.getElementById("avgStarBox");
						avgStarBox.innerHTML = ""; //초기화...
						var textnode = document.createTextNode("평균 ");
						var starIcon = document.createElement("i");
						starIcon.setAttribute("class" , "bi bi-star-fill text-warning");
						var textavg = document.createTextNode(data.movieStarAvg.toFixed(2));
						
						avgStarBox.appendChild(textnode);
						avgStarBox.appendChild(starIcon);
						avgStarBox.appendChild(textavg);
						
						
						var progressBox = document.getElementById("progressBox");
						progressBox.innerHTML = ""; //초기화...
						var progressBar = document.createElement("div");
						progressBar.setAttribute("class" , "progress-bar bg-success");
						progressBar.setAttribute("role" , "progressbar");
						progressBar.setAttribute("style", "width:"+(data.movieStarAvg/5)*100+"%");
						progressBar.setAttribute("aria-valuenow" , "45");
						progressBar.setAttribute("aria-valuemin" , "0");
						progressBar.setAttribute("aria-valuemax" , "100");
						
						progressBox.appendChild(progressBar);
						
					}
				};
				
				xmlhttp.open("get" , "./getAvgStar.do?movie_no=" + movieNo); 
				xmlhttp.send();
			}

            function displayMovieInfo(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						var directorBox = document.getElementById("directorBox");
						
						var directorInnerBox = document.createElement("p");
						var directName  = data.movieVo.movie_directorNm;
						var textnode = document.createTextNode(directName);
						
						directorInnerBox.appendChild(textnode); 
						directorBox.appendChild(directorInnerBox);
						
						var plotBox = document.getElementById("plot");
						var plotInnerBox = document.createElement("p");
						plotInnerBox.setAttribute("class", "text-truncate");
						plotInnerBox.setAttribute("style", "max-width: 700px;");
						var plot  = data.movieVo.movie_plotText;
						var textnode = document.createTextNode(plot);
						
						plotInnerBox.appendChild(textnode); 
						plotBox.appendChild(plotInnerBox);
						
						var actorBox = document.getElementById("actorBox");
						
						var actorInnerBox = document.createElement("p");
						var actors  = data.actorList;
						var textnode = document.createTextNode(actors);
						actorInnerBox.appendChild(textnode); 
						actorBox.appendChild(actorInnerBox);
						
						var releaseBox = document.getElementById("releaseBox");
						
						var releaseInnerBox = document.createElement("p");
						var release  = data.movieVo.movie_repRlsDate;
						var textnode = document.createTextNode(release);
						
						releaseInnerBox.appendChild(textnode); 
						releaseBox.appendChild(releaseInnerBox);
						 
					}
					
				};
				xmlhttp.open("get" , "./getMovieInfo.do?movie_no=" + movieNo); 
				xmlhttp.send();
			}

            function seeMorePlot(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);

						var seeMorePlot = document.getElementById("seeMorePlot");
						var seeMoreA = document.getElementById("seeMorePlotA");
						seeMoreA.innerHTML = ""; //초기화...
						var shortPlot = document.createTextNode("접기");
						seeMoreA.appendChild(shortPlot);
						seeMoreA.setAttribute("onclick", "seeShortPlot()");
						seeMoreA.setAttribute("class", "bi bi-caret-up-fill");
						seeMorePlot.replaceChild(seeMoreA, seeMorePlot.childNodes[0]);
						
						var plotBox = document.getElementById("plot");
						plotBox.innerHTML = ""; //초기화...
						plotBox.setAttribute("class", "col fs-6");
						plotBox.removeAttribute("style");
						var innerPlotBox = document.createElement("p");
						var totalPlot  = data.movieVo.movie_plotText;
						var textnode = document.createTextNode(totalPlot);
						innerPlotBox.appendChild(textnode); 
						plotBox.appendChild(innerPlotBox);
					}
				};
				
				xmlhttp.open("get" , "./getMovieInfo.do?movie_no=" + movieNo); 
				xmlhttp.send();	
			}
			
			function seeShortPlot(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);

						var seeMorePlot = document.getElementById("seeMorePlot");
						var seeMoreA = document.getElementById("seeMorePlotA");
						
						seeMoreA.innerHTML = ""; //초기화...
						var shortPlot = document.createTextNode("더보기");
						seeMoreA.appendChild(shortPlot);
						seeMoreA.setAttribute("onclick", "seeMorePlot()");
						seeMoreA.setAttribute("class", "bi bi-caret-down-fill");
						seeMorePlot.replaceChild(seeMoreA, seeMorePlot.childNodes[0]);
						
						var plotBox = document.getElementById("plot");
						plotBox.innerHTML = ""; //초기화...
						plotBox.setAttribute("class", "col fs-6");
						var innerPlotBox = document.createElement("p");
						innerPlotBox.setAttribute("class", "text-truncate");
						innerPlotBox.setAttribute("style", "max-width: 700px;");
						var totalPlot  = data.movieVo.movie_plotText;
						var textnode = document.createTextNode(totalPlot);
						innerPlotBox.appendChild(textnode); 
						plotBox.appendChild(innerPlotBox);
					}
				};
				
				xmlhttp.open("get" , "./getMovieInfo.do?movie_no=" + movieNo); 
				xmlhttp.send();	
			}

            function getMovieStatistics(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						
						/* 성별별 추천 수  파이그래프 */
						var drawData = new google.visualization.DataTable();
						drawData.addColumn('string', '성별');
						drawData.addColumn('number', '평균점수');
						
						if(data.movieGenderCount.length ==0){
									
						}else if (data.movieGenderCount.length == 1 &&  data.movieGenderCount[0].MEMBER_GENDER=='M') {
							drawData.addRow(["남", data.movieGenderCount[0].COUNTGENDER]);
							drawData.addRow(["여",0]);	
						}else if (data.movieGenderCount[0].MEMBER_GENDER=='F') {
							drawData.addRow(["남", 0]);
							drawData.addRow(["여",data.movieGenderCount[0].COUNTGENDER]);	
						}
						else{
							for(x of data.movieGenderCount){
								if (x.MEMBER_GENDER=='M'){
									drawData.addRow(["남" , x.COUNTGENDER ]);	
								}else{
									drawData.addRow(["여" , x.COUNTGENDER ]);
								}
								
							}
						}

				        var options = {
				          title: '추천수 비율',
				          width: 300,
					      height: 300
				        };

						var chart = new google.visualization.PieChart(document.getElementById('piechart'));
						chart.draw(drawData, options);
						
						
						/* 성별별 평균 별점 컬럼차트 */ 
						var drawData2 = new google.visualization.DataTable();
						drawData2.addColumn('string', '성별');
						drawData2.addColumn('number', '평균점수');
						drawData2.addColumn({type: 'string', role: 'style'});
						
						if(data.movieStarAvgByGender.length ==0){
							drawData2.addRow(["남", 0, '#3366CC']);
							drawData2.addRow(["여", 0, '#DC3912']);	
						}else if (data.movieStarAvgByGender.length == 1 &&  data.movieStarAvgByGender[0].MEMBER_GENDER=='M') {
							drawData2.addRow(["남", data.movieStarAvgByGender[0].MOVIEGENDERSTARAVG, '#3366CC']);
							drawData2.addRow(["여",0, '#DC3912']);	
						}else if (data.movieStarAvgByGender[0].MEMBER_GENDER=='F') {
							drawData2.addRow(["남", 0, '#3366CC']);
							drawData2.addRow(["여",data.movieStarAvgByGender[0].MOVIEGENDERSTARAVG, '#DC3912']);	
						}
						else{
							drawData2.addRow(["남", data.movieStarAvgByGender[0].MOVIEGENDERSTARAVG, '#3366CC']);
							drawData2.addRow(["여", data.movieStarAvgByGender[1].MOVIEGENDERSTARAVG, '#DC3912']);
						}
						
					    var view = new google.visualization.DataView(drawData2);
					    view.setColumns([0, 1,
					                     { calc: "stringify",
					                       type: "string",
					                       sourceColumn: 1,
					                       role: "annotation" },
					                     2]);

					    var options = {
					      title: "남/여 평균 별점",
					      width: 300,
					      height: 300,
					      bar: {groupWidth: "50%"},
					      legend: { position: "none" },
					      vAxis: {
					      	viewWindowMode: "explicit",
					        viewWindow: {min: 0, max: 5},
					        ticks: [0, 1, 2, 3, 4, 5]
					      }
					    };
					    
					    var chart2 = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
					    chart2.draw(view, options);
					    
					    /* 성별별 평균 별점 컬럼차트2 */ 
					    var cars = new Array();
					    for(t of data.getAgeGroupsCount){
					    	cars.push(t.CNT);
					    }
					    Array.prototype.max = function() {
					    	  return Math.max.apply(null, this);
					    };
					    var highest = cars.max();
					    
						var drawData3 = new google.visualization.DataTable();
						drawData3.addColumn('string', '연령대');
						drawData3.addColumn('number', '연령수');
						drawData3.addColumn({type: 'string', role: 'style'});
						
						if(data.getAgeGroupsCount.length==0){
							drawData3.addRow(["10대",0,'gray']);
							drawData3.addRow(["20대",0,'gray']);
							drawData3.addRow(["30대",0,'gray']);
							drawData3.addRow(["40대",0,'gray']);
							drawData3.addRow(["50대",0,'gray']);
							drawData3.addRow(["60대",0,'gray']);
						}else{
							for(var i=0; i<data.getAgeGroupsCount.length; i++){
								if(data.getAgeGroupsCount[i].CNT==highest){
									drawData3.addRow([data.getAgeGroupsCount[i].BUCKET , data.getAgeGroupsCount[i].CNT, '#7C56D5' ]);	
								}else{
									drawData3.addRow([data.getAgeGroupsCount[i].BUCKET , data.getAgeGroupsCount[i].CNT, 'gray' ]);	
								}
							}
						}
						
					    var view = new google.visualization.DataView(drawData3);
					    view.setColumns([0, 1,
					                     { calc: "stringify",
					    					sourceColumn: 1,
					                       type: "string",
					                       role: "annotation" },
					                     2]);

					    var options = {
					      title: "한줄 평 연령대",
					      width: 300,
					      height: 300,
					      bar: {groupWidth: "70%"},
					      legend: { position: "none" }, 
					      vAxis: {
						      	viewWindowMode: "explicit",
						        viewWindow: {min: 0},
						        ticks: [0, 1, 2, 3, 4, 5,6,7,8,9,10]
						      }
					    };
					    var chart3 = new google.visualization.ColumnChart(document.getElementById("columnchart_valuesaa"));
					    chart3.draw(view, options);
					    /* var chart3 = new google.charts.Bar(document.getElementById("columnchart_valuesaa"));
				        chart3.draw(view, google.charts.Bar.convertOptions(options)); */
					}
				};
				
				xmlhttp.open("get" , "./getMovieStatistics.do?movie_no=" + movieNo); 
				xmlhttp.send();	
			}
            
            
            function recommendMovieByGenre(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);

						var outterRowBox = document.getElementById("recommendMovieList");
						
						for(x of data.recommendMovieListByGenre){
							if(x.movieVo.movie_no != movieNo){
								var outterColBox = document.createElement("div");
								outterColBox.setAttribute("class" , "col text-center");
								
								var innerRowForPoster = document.createElement("div");
								innerRowForPoster.setAttribute("class" , "row");
								var innerColForPoster = document.createElement("div");
								innerColForPoster.setAttribute("class" , "col");
								var posterLink = document.createElement("a");
								var currentUrl = window.location.href;
								var setUrl = currentUrl.split('=');
								setUrl = setUrl[0]+"="+x.movieVo.movie_no;
								var poster = document.createElement("img");
								
								posterLink.setAttribute("href", setUrl);
								poster.setAttribute("src" , x.posterVo.poster_url);
								poster.setAttribute("width" , "210px;");
								poster.setAttribute("height" , "300px;");
								
								var innerRowForTitle = document.createElement("div");
								innerRowForTitle.setAttribute("class" , "row");
								var innerColForTitle = document.createElement("div");
								innerColForTitle.setAttribute("class" , "col text-center");
								var title  = x.movieVo.movie_title;
								var textnode = document.createTextNode(title);
								
								posterLink.appendChild(poster);
								innerColForPoster.appendChild(posterLink);
								innerRowForPoster.appendChild(innerColForPoster);
								outterColBox.appendChild(innerRowForPoster);
								
								innerColForTitle.appendChild(textnode);
								innerRowForTitle.appendChild(innerColForTitle);
								outterColBox.appendChild(innerRowForTitle);
								
								outterRowBox.appendChild(outterColBox);							
							}
							
							
						}

					}
				};
				
				xmlhttp.open("get" , "./getRecommendMoiveListByGenre.do?movie_no=" + movieNo); 
				xmlhttp.send();
            }

            function onload(event) {
				starRating1 = raterJs( {
					starSize:23, 
					element:document.querySelector("#rater"), 
					rateCallback:function rateCallback(rating, done) {
						this.setRating(rating);
						done(rating); 
					}
				}); 				 
			}

            function writeComment(){
				
				if(logined == false){
		
					var result = confirm("로그인 하셔야 이용 가능합니다. 로그인 페이지로 이동하시겠습니까?");
					if(result){
						location.href = "../../member/loginPage.do";				
					}
					return;
				}	
				if(logined && iswrite){
					checkingUserWrote();
					var result = confirm("이미 작성한 리뷰가 있습니다. 수정하시겠습니까?");
					if(result){
						getMyReply();
						createUpdateForm(document.getElementById("commentListBox") , myReplyNo);
					}
					return;
				}
				
				var commentBox = document.getElementById("oneLineReplyContent");
				var commentText = commentBox.value;
						
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						refreshAvgStar();
						refreshCommentList();
						getMovieStatistics();
						
						//...별초기화...
						starRating1.setRating(0);
						
					}
				};
				
				xmlhttp.open("post" , "./writeCommentProcess.do"); 
				xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				xmlhttp.send("movie_no=" + movieNo + "&oneLineReply_content=" + commentText+"&oneLineReply_star="+starRating1.getRating());
				
				commentBox.value = "";
			}

            function refreshCommentList(){
            	is_action = false;
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						var commentListBox = document.getElementById("commentListBox");
						
						var commentListLength  = data.commentlist.length;
						var countReplyBox = document.getElementById("countReply");
						countReplyBox.innerHTML = ""; //초기화...	
						countReplyBox.innerText = "("+commentListLength+")";
						
						if(commentListLength != 0){
							//제한조건...innerHTML은...절대 쓰지 마셈...!!!!! 단 아래처럼 초기화 할때 빼고...
							commentListBox.innerHTML = ""; //초기화...
							
							for(commentData of data.commentlist){
								var outerRow = document.createElement("div");
								outerRow.setAttribute("class" , "row mx-0 mb-1  border");
								outerRow.setAttribute("style" , "background-color: #fbfcfc;");
								
								var outerCol = document.createElement("div");
								outerCol.setAttribute("class" , "col commentWrapper");
								
								outerRow.appendChild(outerCol);
								
								var rowBox = document.createElement("div"); //<div></div>
								rowBox.setAttribute("class" , "row"); //<div class='row'></div>
								
								outerCol.appendChild(rowBox);
								
								var iconColBox = document.createElement("div");
								iconColBox.setAttribute("class" , "col-auto px-1 py-1 border-end");
								var iconImg = document.createElement("img");
								for(icon of data.icons){
									if(icon.iconShopVo.icon_no==commentData.memberVo.icon_no){
										iconImg.src = "/iconFiles/"+icon.iconShopVo.icon_link;
									}
									
								}
								//iconImg.src = "/movie/resources/img/icons/ranking.png"
								iconImg.setAttribute("class" , "img-fluid");
								iconColBox.appendChild(iconImg);

								var replyContentColBox = document.createElement("div");
								replyContentColBox.setAttribute("class" , "col px-3 py-1");
								
								var replyFirstInnerRowBox = document.createElement("div");
								replyFirstInnerRowBox.setAttribute("class" , "row mt-1");
								
								var nickColBox = document.createElement("div");
								nickColBox.setAttribute("class" , "col-auto fw-bold");
								nickColBox.innerText = commentData.memberVo.member_nick;
								
								var dateColBox = document.createElement("div");
								dateColBox.setAttribute("class" , "col-auto me-auto");
								dateColBox.setAttribute("style" , "font-size:12px;");
								dateColBox.innerText = "("+commentData.oneLineReplyVo.OneLineReply_writedate+")";
								
								
								//수정버튼...
								var updateButtonBox = document.createElement("div");
								updateButtonBox.setAttribute("class" , "col-auto pe-1");
								updateButtonBox.setAttribute("id" , "updateReplyButton");
								
								if(sessionNo == commentData.memberVo.member_no){
									var updateButton = document.createElement("button");
									updateButton.setAttribute("class" ,"btn btn-outline-secondary btn-sm");
									updateButton.setAttribute("onclick" ,"createUpdateForm(this , "+ commentData.oneLineReplyVo.oneLineReply_no +")");
									updateButton.innerText = "수정";
									updateButtonBox.appendChild(updateButton);
									
								}
								
								//삭제버튼.
								var deleteColBox = document.createElement("div");
								deleteColBox.setAttribute("class" , "col-auto ps-1");
								
								if(sessionNo == commentData.memberVo.member_no){
									var deleteButton = document.createElement("button");
									deleteButton.setAttribute("class" ,"btn btn-outline-danger btn-sm");
									deleteButton.setAttribute("onclick" ,"deleteComment("+ commentData.oneLineReplyVo.oneLineReply_no +")");
									deleteButton.innerText = "삭제";
									deleteColBox.appendChild(deleteButton);
								}
								
								
								replyFirstInnerRowBox.appendChild(nickColBox);
								replyFirstInnerRowBox.appendChild(dateColBox);
								replyFirstInnerRowBox.appendChild(updateButtonBox);
								replyFirstInnerRowBox.appendChild(deleteColBox);
								
								var replySecondInnerRowBox = document.createElement("div");
								replySecondInnerRowBox.setAttribute("class" , "row mt-2");
								
								var starColBox = document.createElement("div");
								starColBox.setAttribute("class" , "col-auto text-warning fw-bold");
								starColBox.innerText = "★ "+commentData.oneLineReplyVo.oneLineReply_star;
								replySecondInnerRowBox.appendChild(starColBox);
								
								var contentColBox = document.createElement("div");
								contentColBox.setAttribute("class" , "col");
								contentColBox.innerText = commentData.oneLineReplyVo.oneLineReply_content;
								replySecondInnerRowBox.appendChild(contentColBox);
								
								
								rowBox.appendChild(iconColBox);
								replyContentColBox.appendChild(replyFirstInnerRowBox);
								replyContentColBox.appendChild(replySecondInnerRowBox);
								rowBox.appendChild(replyContentColBox);
								

								//수정 입력 양식 위치 작업..
								var updateFormRow = document.createElement("div");
								updateFormRow.setAttribute("class","row updateFormRow");
			
								var updateFormCol = document.createElement("div");
								updateFormCol.setAttribute("class","col updateFormCol px-0");
			
								updateFormRow.appendChild(updateFormCol);
								outerCol.appendChild(updateFormRow);
								
								commentListBox.appendChild(outerRow);
								/* var hrTag = document.createElement("hr");
								hrTag.setAttribute("class","my-1");
								commentListBox.appendChild(hrTag); */
							}
						}else{
							var pagenationColBox = document.getElementById("pagenation");
							pagenationColBox.innerHTML = ""; //초기화...
							commentListBox.innerHTML = ""; //초기화...
							var outerRow = document.createElement("div");
							outerRow.setAttribute("class" , "row");
							
							var outerCol = document.createElement("div");
							outerCol.setAttribute("class" , "col commentWrapper");
							
							outerRow.appendChild(outerCol);
							
							var rowBox = document.createElement("div"); //<div></div>
							rowBox.setAttribute("class" , "row"); //<div class='row'></div>
							
							outerCol.appendChild(rowBox);
							
							var nullColBox = document.createElement("div");
							nullColBox.setAttribute("class" , "col text-center");
							
							var textnode = document.createTextNode("작성된 리뷰가 없습니다.");
							nullColBox.appendChild(textnode); 
							
							//조립...
							rowBox.appendChild(nullColBox);
							commentListBox.appendChild(rowBox);
						}
						
						var myReplyOffCanvasBox = document.getElementById("myReplyOffCanvas");
						if(sessionNo != null && commentListLength != 0){
							myReplyOffCanvasBox.innerHTML = ""; //초기화...
							var seeMyRelplyOffCanvasButton = document.createElement("button");
            				var icon = document.createElement("i");
            				var textnode = document.createTextNode(" 내글보기");
            				seeMyRelplyOffCanvasButton.setAttribute("class" , "btn btn-secondary btn-sm");
            				seeMyRelplyOffCanvasButton.setAttribute("data-bs-toggle" , "offcanvas");
            				seeMyRelplyOffCanvasButton.setAttribute("data-bs-target" , "#offcanvasRight");
            				seeMyRelplyOffCanvasButton.setAttribute("aria-controls" , "offcanvasRight");
            				seeMyRelplyOffCanvasButton.setAttribute("onclick" , "offcanvasBodyView()");
            				icon.setAttribute("class" , "bi bi-person-lines-fill");
							
            				seeMyRelplyOffCanvasButton.appendChild(icon);
            				seeMyRelplyOffCanvasButton.appendChild(textnode);
            				myReplyOffCanvasBox.appendChild(seeMyRelplyOffCanvasButton);
						}else{
							myReplyOffCanvasBox.innerHTML = ""; //초기화...	
						}
						
					}
				};
				
				xmlhttp.open("get" , "./getCommentList.do?movie_no=" + movieNo); 
				xmlhttp.send();		
				
			}
            
            
            function getMyReply(){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						var data = JSON.parse(xmlhttp.responseText);
						myReply = data.myOneLineReplyVo.oneLineReply_content;
						myReplyNo = data.myOneLineReplyVo.oneLineReply_no;
						myStar = data.myOneLineReplyVo.oneLineReply_star;
					}
				};
				
				xmlhttp.open("get" , "./getMyReply.do?movie_no=" + movieNo , false); 
				xmlhttp.send();		
			}
            
            function offcanvasBodyView(){
            	
            	getMyReply();
            	
            	var offcanvasBodyBox = document.getElementById("offcanvasBody");
            	offcanvasBodyBox.innerHTML = ""; //초기화...
            	
            	var contentBox = document.createElement("p");
            	var content = document.createTextNode(myReply);
            	var starBox = document.createElement("p");

				for(let i=0; i<myStar; i++){
					var starIcon = document.createElement("i");
					starIcon.setAttribute("class" , "bi bi-star-fill text-warning");
					starBox.appendChild(starIcon);
				}
				
				contentBox.appendChild(starBox);
				contentBox.appendChild(content);
				
				offcanvasBodyBox.appendChild(contentBox);
				
				var updatebtn = document.createElement("button");
				updatebtn.setAttribute("class" , "btn btn-secondary");
				updatebtn.innerText = "수정";
				var deletebtn = document.createElement("button");
				deletebtn.setAttribute("class" , "btn btn-danger");				
				deletebtn.innerText = "삭제";
				
				offcanvasBodyBox.appendChild(updatebtn);
				offcanvasBodyBox.appendChild(deletebtn);
				
            }
			
			
			var starRating1 = null;
			var starRatingUpdate = null;
			
			function createStarUpdate(){
				starRatingUpdate = raterJs( {
					starSize:23, 
					element:document.querySelector("#rateruuu"), 
					rateCallback:function rateCallback(rating, done) {
						this.setRating(rating);
						done(rating); 
					}
				}); 				 
			}
			
			
			function createUpdateForm(e , oneLineReplyNo){
				getMyReply();
				if (is_action === true) { return false; }
				is_action = true;
				
				var inputOutterBox = document.createElement("div");
				inputOutterBox.setAttribute("class" ,"row");
				var inputOutterCol = document.createElement("div");
				inputOutterCol.setAttribute("class" ,"col");
				
				var inputLowOutterBox = document.createElement("div");
				inputLowOutterBox.setAttribute("class" ,"row mt-1");
				var lowStarCol = document.createElement("div");
				lowStarCol.setAttribute("class" ,"col-auto ms-2 mt-1");
				var lowUpdatebuttonCol = document.createElement("div");
				lowUpdatebuttonCol.setAttribute("class" ,"col-auto px-0 me-1");
				var lowCancelbuttonCol = document.createElement("div");
				lowCancelbuttonCol.setAttribute("class" ,"col-auto px-0");
				//inputOutterBox.setAttribute("class" ,"border border-secondary border-2");
								
				var inputBox = document.createElement("textarea");
				inputBox.setAttribute("id" , "updateCommentContentTextArea");
				inputBox.setAttribute("class" , "form-control");
				inputBox.value = myReply;
				var updateConfirmButton = document.createElement("button");
				updateConfirmButton.innerText = "수정완료";
				updateConfirmButton.setAttribute("class" , "btn btn-primary btn-sm me-1");
				updateConfirmButton.setAttribute("onclick" , "updateProcess("+oneLineReplyNo+")");
				var updateCancelButton = document.createElement("button");
				updateCancelButton.innerText = "취소";
				updateCancelButton.setAttribute("class" , "btn btn-outline-dark btn-sm");
				updateCancelButton.setAttribute("onclick" , "refreshCommentList()");
				
				var star = document.createElement("div");
				star.setAttribute("id","rateruuu");
				
				inputOutterCol.appendChild(inputBox); 
				inputOutterBox.appendChild(inputOutterCol); 
				
				lowStarCol.appendChild(star);
				lowUpdatebuttonCol.appendChild(updateConfirmButton);
				lowCancelbuttonCol.appendChild(updateCancelButton);
				inputLowOutterBox.appendChild(lowStarCol); 
				inputLowOutterBox.appendChild(lowUpdatebuttonCol); 
				inputLowOutterBox.appendChild(lowCancelbuttonCol); 
				
				
				var wrapperBox = e.closest(".commentWrapper");
				var targetBox = wrapperBox.getElementsByClassName("updateFormCol");
				
				targetBox[0].appendChild(inputOutterBox);
				targetBox[0].appendChild(inputLowOutterBox);
				
				createStarUpdate();
			}
			
			
			function updateProcess(oneLineReplyNo){
				
				var updateCommentContentTextArea = 
					document.getElementById("updateCommentContentTextArea");
				
				var commentContent = updateCommentContentTextArea.value;
		
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						refreshAvgStar();
						getMovieStatistics();
						refreshCommentList();
					}
				};
				
				xmlhttp.open("post" , "./updateCommentProcess.do");
				xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
				xmlhttp.send("oneLineReply_no=" + oneLineReplyNo + "&oneLineReply_content=" + commentContent + "&oneLineReply_star="+starRatingUpdate.getRating());					
				
			}
			
			function deleteComment(oneLineReplyNo){
				var xmlhttp = new XMLHttpRequest();
				
				xmlhttp.onreadystatechange = function(){
					if(xmlhttp.readyState==4 && xmlhttp.status==200){
						refreshAvgStar();
						getMovieStatistics();
						refreshCommentList();
					}
				};
				
				xmlhttp.open("get" , "./deleteCommentProcess.do?oneLineReply_no=" + oneLineReplyNo); 
				xmlhttp.send();		
				
			}


            function init(){
				//로그인 상태 처리...
				getSessionUserInfo();
				checkingUserWrote();
				
				if(logined == true){
					refreshLikeButton();
				}
				
				if(logined == false){
					var commentBox = document.getElementById("oneLineReplyContent");
					commentBox.setAttribute('disabled',true);
					commentBox.value="로그인 후 이용 가능 합니다.";
				}
				
				refreshTotalLike();
				refreshAvgStar();
				refreshCommentList();
				displayMovieInfo();
				recommendMovieByGenre()
			}
			
			window.addEventListener("DOMContentLoaded" , init);
			window.addEventListener("load", onload, false); 
        </script>
		<style type="text/css">
			
		</style>
        <title>영화 상세페이지</title>
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
        <div style="width: 1200px; margin: 0 auto">
            <div class="container-fluid">
                <div class="row mt-3">
                    <div class="col"></div> <!--왼쪽 공백-->

                    <!-- 전체 시작 -->
                    <div class="col-10"> 

                        <!-- 바디(내용) 시작 -->

                        <!-- 영화 타이틀 시작 -->
                        <div class="row mt-3">
                            <div class="col fs-3 fw-bold" style="text-align:center;">
								${map.movieVo.movie_title }
							</div>
                        </div>
                        <!-- 영화 타이틀 끝 -->

                        <!-- 포스터 시작 -->
                        <div class="row">
                        	<div class="col-4"></div>
                        	<div class="col"></div>
                        </div>
                        
                        <div class="row bg-light bg-opacity-50 justify-content-center mt-3">
                            <!-- 캐럴셀 시작 -->
                            <div class="col-4">
                                <div id="carouselExampleControls" class="carousel carousel-dark slide" data-bs-ride="carousel">
									<div class="carousel-inner">
										<c:forEach items="${map.posterVo }" var="poster" varStatus="status">
											<c:choose>
												<c:when test="${status.first }">
													<c:set var="set_" value="active" />
												</c:when>
												<c:otherwise>
													<c:set var="set_" value="" />
												</c:otherwise>
											</c:choose>
											
											<div class="carousel-item <c:out value="${set_}" />">
												<img src="${poster.poster_url }" class="d-block" alt="..."
													style="width: 300px; height: 450px;">
											</div>
										</c:forEach>
									</div>
									<button class="carousel-control-prev" type="button"
										data-bs-target="#carouselExampleControls" data-bs-slide="prev">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Previous</span>
									</button>
									<button class="carousel-control-next" type="button"
										data-bs-target="#carouselExampleControls" data-bs-slide="next">
										<span class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Next</span>
									</button>
								</div>	
                            </div>
                            <!-- 캐럴셀 끝 -->   
                        </div>
                        <!-- 포스터 끝 -->
                        
                        <!-- 추천 및 별점평균 시작 -->
                        <div class="row mt-3">
                        	<!-- 하트모양 시작 -->
                        	<div class="col-auto heartlink pe-0">
								<i id="heartButton" class="bi bi-heart text-danger" onclick="like()"></i>
							</div>
							<!-- 하트모양 끝 -->
							
							<!-- 추천 수 시작 -->
                        	<div class="col ps-2">
                        		<div><b id="totalCountBox"></b></div>
                        	</div>
                        	<!-- 추천 수 끝 -->
                        	
                        	<!-- 별점 평균 시작 -->
                        	<div class="col-auto pe-0">
                        		<div><b id="avgStarBox"></b></div>
                        	</div>
                        	<!-- 별점 평균 끝 -->
                        	
                        	<!-- 별점 평균 바 시작 -->
                        	<div class="col ps-3 pt-1">
                        		<div class="progress" id="progressBox" style="height: 20px;"></div>
                        	</div>
                        	<!-- 별점 평균 바 끝-->
                        </div>
                        <!-- 추천 및 평균별점 끝 -->

                        
                        <!-- 스틸컷 시작 -->

                        <!-- 스틸컷 title 시작-->
                        <div class="row mt-5">
                        	<div class="col fs-5 fw-bold"><i class="bi bi-camera"></i> 갤러리 </div>
                        </div>
                        <!-- 스틸컷 title 끝-->

                        <!-- 스티컷 이미지 시작-->
                        <div class="row mt-3">
                            <div class="col">
                               <section class="center slider">
									<c:forEach items="${stllList }" var="stll">
	                                	<c:if test="${map.movieVo.movie_no == stll.stllVo.movie_no }">
	                                    	<div>
	                                        	<img src="${stll.stllVo.stll_url }">
	                                    	</div>
	                                	</c:if>
	                             	</c:forEach>
								</section>
                            </div>
                            
                        </div>
                        <!-- 스티컷 이미지 끝-->

                        <!-- 스틸컷 끝 -->

                        <!-- 영화 내용 시작  -->
                        <div class="row mt-5">
							<div class="col fs-5 fw-bold"><i class="bi bi-info-circle"></i> 영화 정보 </div>
						</div>
						<hr>
                        <!-- 감독 시작 -->
                        <div class="row mt-3">
							<div class="col-2 fs-4 fw-bold">감독</div>
							<div class="col fs-6" id="directorBox"></div>
						</div>
                        <!-- 감독 끝 -->

                        <!-- 줄거리 시작 -->
                        <div class="row mt-3">
							<div class="col-2 fs-4 fw-bold">줄거리</div>
							<div class="col fs-6 text-truncate" style="max-width: 750px;" id="plot"></div>
							<div class="col-1" id="seeMorePlot">
								<i class="bi bi-caret-down-fill" onclick="seeMorePlot()" id="seeMorePlotA" style="font-size: 12px;">더보기</i>
							</div>
						</div>
                        <!-- 줄거리 끝 -->

                        <!-- 출연진 시작 -->
                        <div class="row mt-3">
							<div class="col-2 fs-4 fw-bold">출연진</div>
							<div class="col fs-6" id="actorBox"></div>
						</div>
                        <!-- 출연진 끝 -->

                        <!-- 개봉일 시작 -->
                        <div class="row mt-3">
							<div class="col-2 fs-4 fw-bold">개봉일</div>
							<div class="col fs-6" id="releaseBox"></div>
						</div>
                        <!-- 개봉일 끝 -->

                        <!-- 영화 내용 끝 -->

                        <!-- 통계 그래프 시작 -->
                        <div class="row mt-5">
                        	<div class="col fs-5 fw-bold"><i class="bi bi-bar-chart-line"></i> 영화 평가</div>
                        </div>
                        <hr>
                        
                        <div class="row">

                            <!-- 그래프 1 시작 -->
                            <div class="col">
                                <div id="piechart"></div>
                            </div>
                            <!-- 그래프 1 끝 -->

                            <!-- 그래프 2 시작 -->
                            <div class="col">
                                <div id="columnchart_values"></div>
                            </div>
                            <!-- 그래프 2 끝 -->
                            
                            <!-- 그래프 3 시작 -->
                            <div class="col">
                                <div id="columnchart_valuesaa"></div>
                            </div>
                            <!-- 그래프 3 끝 -->

                        </div>
                        <!-- 통계 그래프 끝 -->

                        <!-- 한줄 리뷰 시작 -->
                        <!-- 한줄 리뷰 타이틀 및 정렬 시작 -->
                        <div class="row">
                        	<div class="col-auto fs-5 fw-bold pe-0"><i class="bi bi-card-text"></i> 한줄 평</div>
                        	<div class="col-auto me-auto px-1 pt-1 fs-6" id="countReply">(${oneLineReplyCount })</div>
                        	<div class="col-auto pt-1 pb-0 px-2 fs-6">별점순</div>
                        	<div class="col-auto pt-1 pb-0 px-0 fs-6">|</div>
                        	<div class="col-auto pt-1 pb-0 ps-2 fs-6">최신순</div>
                        </div>
                        <hr>
                        <!-- 한줄 리뷰 타이틀 및 정렬 끝 -->

                        <!-- 리뷰 리스트 시작 -->
                        <div class="row mt-3">
                            <div class="col">
                            	<div class="row">
                            		<div class="col">
                            			<div id="commentListBox"></div>
                            		</div>
                            	</div>
                            	<!-- 리뷰 페이지 네이션 및 내글보기 임시 시작 -->
                            	<div class="row mt-2">
                            		<div class="col"></div> <!-- 공백 -->
                            		
                            		<!-- 페이지 네이션 시작 -->
                            		<div class="col" id="pagenation">
                            			<nav aria-label="...">
										  <ul class="pagination pagination-sm">
										    <li class="page-item disabled">
										      <a class="page-link">Previous</a>
										    </li>
										    <li class="page-item active" aria-current="page">
										    	<a class="page-link" href="#">1</a>
										    </li>
										    <li class="page-item"><a class="page-link" href="#">2</a></li>
										    <li class="page-item"><a class="page-link" href="#">3</a></li>
										    <li class="page-item"><a class="page-link" href="#">4</a></li>
										    <li class="page-item"><a class="page-link" href="#">5</a></li>
										    <li class="page-item">
										      <a class="page-link" href="#">Next</a>
										    </li>
										  </ul>
										</nav>
                            		</div>
                            		<!-- 페이지 네이션 끝 -->
                            		
                            		<!-- 내글 보기 시작 -->
                            		<div class="col text-end" id="myReplyOffCanvas">
                            			<!-- <button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                            				<i class="bi bi-person-lines-fill"></i> 내글보기
                            			</button> -->
                            		</div>

									<div class="offcanvas offcanvas-end" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
									  <div class="offcanvas-header">
									    <h5 id="offcanvasRightLabel">내 글 보기</h5>
									    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
									  </div>
									  <div class="offcanvas-body" id="offcanvasBody">
									    ㅅㄷㄴㅅ
									  </div>
									</div>
                            		<!-- 내글 보기 끝-->
                            	</div>
                            	<!-- 리뷰 페이지 네이션 및 내글보기 임시 끝 -->
                                
                            </div>
                        </div>
                        <!-- 리뷰 리스트 끝 -->
                        

                        <!-- 리뷰 작성 시작 -->
                         <div class="row mt-4">
                            <div class="col">
                            	<div class="border border-secondary border-2 px-3 py-2 bg-white">
                            		<div class="row"> <!-- 타이틀 & 별점 -->
                            			
	                                    <div class="col-auto fs-6 fw-bold"><i class="bi bi-pencil-square"></i> 영화는 어땠나요?</div>
	                                    <div class="col ps-0"> 
	                                        <div id="rater"	></div>
	                                    </div>
	                                </div>
	                                <div class="row mt-2">
	                                    <div class="col-auto">
	                                        <textarea id="oneLineReplyContent" rows="3" cols="70"></textarea>
	                                    </div>
	                                    <div class="col-auto pt-51 ps-0">
	                                    	<button class="btn btn-outline-secondary" onclick="writeComment()">작성</button>
	                                    </div>
	                                </div>
                            	</div>
                                		
                            </div>
                        </div>
                        <!-- 리뷰 작성 끝 -->

                        <!-- 한줄 리뷰 끝 -->

						<!-- 같은 장르 영화 랜덤 추천 시작 -->
						<div class="row mt-5">
							<div class="col fs-5 fw-bold"><i class="bi bi-grid-1x2"></i> 비슷한 작품</div>
						</div>
						<hr>
                        <div class="row mt-4 justify-content-evenly" id="recommendMovieList"></div>
                        <!-- 같은 장르 영화 랜덤 추천 시작 -->
                        
                        <!-- 목록으로 가기 시작 -->
                        <div class="row mt-3">
                            <div class="col text-center">
                                <a href="../../movieList/movieListPage.do" class="btn btn-secondary btn-sm bi bi-list-ul"> 목록</a>
                            </div>
                        </div>
                        <!-- 목록으로 가기 끝 -->
                        
                        <!-- 바디(내용) 끝 -->


                    </div>
                    <!-- 전체 끝-->

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

        <script src="../../resources/js/index.js?v=3"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
		<script src="../../resources/js/slick.js" type="text/javascript" charset="utf-8"></script> 
		<script type="text/javascript">
		  $(document).on('ready', function() {
		    $(".center").slick({
		      dots: true,
		      infinite: true,
		      centerMode: true,
		      slidesToShow: 5,
		      slidesToScroll: 3
		    });
		  });
		</script>
    </body>
</html>
