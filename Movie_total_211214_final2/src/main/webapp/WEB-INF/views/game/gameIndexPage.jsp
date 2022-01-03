<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">
<style type="text/css">
.pointBatingText {
	font-family: 'Nanum Gothic', sans-serif;
}
</style>
<script type="text/javascript">
		var logined = false;
		var sessionNo = null;
		var sessionPoint = null;
		var gameRound=0;
		var cardinfo=null;
		var cardAddTime;
		
		function getSessionUserInfo(){

			var xmlhttp = new XMLHttpRequest();
			
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
					var data = JSON.parse(xmlhttp.responseText);
					
					if(data.isLogined == true){
						logined = true;
						sessionNo = data.sessionNo; 
						sessionPoint = data.sessionPoint
					}else{
						logined = false;
					}
				}
			};
			
			xmlhttp.open("get" , "../member/getSessionUserInfo.do" , false); 
			xmlhttp.send();		
		}
		
		function showBtn(){
			var startButtonBox = document.getElementById("startBtnBox");
			startButtonBox.innerHTML = ""; //초기화...
			var startButton = document.createElement("button");
			startButton.setAttribute("class" ,"btn btn-primary");
			startButton.setAttribute("onclick" ,"showTable()");
			startButton.innerText = "게임 입장";
			startButtonBox.appendChild(startButton);
		}
		
		function checkAmount(){
			var inputBox = document.getElementById("inputAmount");
			var amount = inputBox.value;
			
			if(amount <= 9) {
				alert("최소 배팅포인트인 10포인트보다 적습니다!!");
			}else if (amount > sessionPoint) {
				alert("보유 포인트가 부족합니다!!");
			}else {
				showDefaultCardSet();
			}
			
		}
		
		function showDefaultCardSet(){
			var inputBox = document.getElementById("inputAmount");
			var amount = inputBox.value;
			
			var xmlhttp = new XMLHttpRequest();
			
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
					var data = JSON.parse(xmlhttp.responseText);
					gameRound = data.gameRound;
					/* var innerTitle = document.getElementById("contentInnerTitle");
					innerTitle.remove(); //초기화... */
					
					var contentBody = document.getElementById("contentBody");
					contentBody.innerHTML = ""; //초기화...
					contentBody.setAttribute("style" ,"background-color:#02551D; border-style: solid; border-width: 12px; border-color: #5e4705; border-radius: 12px;");
					contentBody.setAttribute("class" ,"col fs-6 py-4 px-4");
					doGame();
				}
			};
			
			xmlhttp.open("get" , "./openGameProcess.do?batingAmount="+amount); 
			xmlhttp.send();		
		}
		
		
		function revealDealerCard(){
			var dealerRowBox = document.getElementById("dealerRowBox");
			dealerRowBox.innerHTML = ""; //초기화...
			
			for(var i=0; i<2; i++){
				var elementName = document.createElement("div");
				elementName.setAttribute("class" ,"col-auto");
				var cardImg = document.createElement("img");
				cardImg.src = "/movie/resources/img/cards/card_" + cardinfo.playingCardInfo[i].cardShape + "_" + cardinfo.playingCardInfo[i].cardNumber + ".jpg"
				cardImg.setAttribute("class" , "img-fluid");
				cardImg.setAttribute("style" , "width:100px; height:130px;");
				elementName.appendChild(cardImg);
				
				dealerRowBox.appendChild(elementName);
				
			}
			var size = cardinfo.playingCardInfo.length -1;
			for(var i=size; i>3; i--){
				if(cardinfo.playingCardInfo[i].player === 'D'){
					var elementName = document.createElement("div");
					elementName.setAttribute("class" ,"col-auto");
					
					var cardImg = document.createElement("img");
					cardImg.src = "/movie/resources/img/cards/card_" + cardinfo.playingCardInfo[i].cardShape + "_" + cardinfo.playingCardInfo[i].cardNumber + ".jpg"
					cardImg.setAttribute("class" , "img-fluid");
					cardImg.setAttribute("style" , "width:100px; height:130px;");
					elementName.appendChild(cardImg);
					dealerRowBox.appendChild(elementName);	
				}
			}
		}
		
		function changeModalTitleAndFooter(){
			
			var buttonsRowBox = document.getElementById("buttonsRowBox");
			buttonsRowBox.innerHTML = ""; //초기화...
			var closeButtonCol = document.createElement("div");
			closeButtonCol.setAttribute("class" ,"col-auto");
			var closeButton = document.createElement("button");
			closeButton.setAttribute("class" ,"btn btn-secondary");
			closeButton.setAttribute("onclick" ,"window.location.reload()");
			closeButton.innerText = "종료";
			
			closeButtonCol.appendChild(closeButton);
			buttonsRowBox.appendChild(closeButtonCol);
			
		}
		function blackJack(){
			if(this.length == 2 && this.includes(1) &&this.includes(10) ){
				return true;
			}
			return false;
		}
		
		function getMiddleRowBox(a) {
			var showResultBox = document.getElementById("middleRowBox");
			showResultBox.innerHTML = ""; //초기화...
			var showResultCol = document.createElement("div");
			showResultCol.setAttribute("class" ,"col");
			showResultCol.setAttribute("style" ,"color: gold;font-size: xx-large;font-weight: bold;");
			showResultCol.innerText = a;
			showResultBox.appendChild(showResultCol);
			
		}
		
		function sendResult(a){
			var xmlhttp = new XMLHttpRequest();
			var test= a;
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
					//var data = JSON.parse(xmlhttp.responseText);
				
				}
			};
			xmlhttp.open("get" , "./sendResult.do?gameRound_no="+gameRound+"&gameResult="+test); 
			xmlhttp.send();			
		}
		
		function checkResult(a){
			
			var xmlhttp = new XMLHttpRequest();
			
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
					var data = JSON.parse(xmlhttp.responseText);
					cardinfo = data;
					var dealerCard = new Array();
					var playerCard = new Array();
					for(x of data.playingCardInfo){
						if(x.player === 'P'){
							if(x.cardNumber ==11 || x.cardNumber==12|| x.cardNumber==13){
								playerCard.push(10);	
							}else{
								playerCard.push(x.cardNumber);
							}
						}else{
							if(x.cardNumber ==11 || x.cardNumber==12|| x.cardNumber==13){
								dealerCard.push(10);	
							}else{
								dealerCard.push(x.cardNumber);
							}
						}
					}
					
					
					var sumPlayerCard = 0;
					var sumDealerCard = 0;
					
					for(p of playerCard){
						if(p == 1){
							sumPlayerCard+=11;
							if(sumPlayerCard >21 ){
								sumPlayerCard-=10;
							}
						}else if(p == 11 ||p == 12||p == 13){
							sumPlayerCard+=10;
						}else{
							sumPlayerCard+=p;
						}
						
					}
					
					for(d of dealerCard){
						if(d == 1){
							sumDealerCard+=11;
							if(sumDealerCard >21 ){
								sumDealerCard-=10;
							}
						}else if(d == 11 ||d == 12||d == 13){
							sumDealerCard+=10;
						}else{
							sumDealerCard+=d;
						}
					}
					
					var dealerScore = document.getElementById("dealerScoreColBox");
					dealerScore.innerText=""
					if(dealerCard[1]==1){
						dealerScore.innerText="Dealer Number: 1 or 11";
					}else{
						dealerScore.innerText="Dealer Number: "+dealerCard[1];
					}
					
					dealerScore.setAttribute("class" ,"col-auto text-white fw-bold");
					
					// 1,10 || 10,1 일때 블랙잭
					if(data.playingCardInfo.length == 4){
						var checkBlackJackResult = [true];
						checkBlackJackResult=[];
						checkBlackJackResult.push(blackJack.apply(playerCard));
						checkBlackJackResult.push(blackJack.apply(dealerCard));
						if(!checkBlackJackResult.includes(false)){
							changeModalTitleAndFooter();
							revealDealerCard();
							var dealerScore = document.getElementById("dealerScoreColBox");
							dealerScore.innerText=""
							dealerScore.innerText="Dealer Number: "+sumDealerCard;
							dealerScore.setAttribute("class" ,"col-auto text-white fw-bold");
							
							getMiddleRowBox("BlackJack! Tie");
							sendResult("bjt");
						} else if(checkBlackJackResult[0]==true && checkBlackJackResult[1]==false){
							changeModalTitleAndFooter();
							revealDealerCard();
							var dealerScore = document.getElementById("dealerScoreColBox");
							dealerScore.innerText=""
							dealerScore.innerText="Dealer Number: "+sumDealerCard;
							dealerScore.setAttribute("class" ,"col-auto text-white fw-bold");
							
							getMiddleRowBox("BlackJack! Player Win");
							sendResult("bjp");
						} else if(checkBlackJackResult[0]==false && checkBlackJackResult[1]==true){
							changeModalTitleAndFooter();
							revealDealerCard();
							var dealerScore = document.getElementById("dealerScoreColBox");
							dealerScore.innerText=""
							dealerScore.innerText="Dealer Number: "+sumDealerCard;
							dealerScore.setAttribute("class" ,"col-auto text-white fw-bold");
							
							getMiddleRowBox("BlackJack! Dealer Win");
							sendResult("bjd");
						} else{
							console.log("계속진행");
						}
					}
				
					
					
					if(a === 'stay'){
						if(sumDealerCard>21){
							revealDealerCard();
							var dealerScore = document.getElementById("dealerScoreColBox");
							dealerScore.innerText=""
							dealerScore.innerText="Dealer Number: "+sumDealerCard;
							dealerScore.setAttribute("class" ,"col-auto text-white fw-bold");
							
							getMiddleRowBox("Player Win | Dealer Busted "+sumDealerCard);
							sendResult("pw");
						}else if(sumDealerCard == sumPlayerCard){
							revealDealerCard();
							var dealerScore = document.getElementById("dealerScoreColBox");
							dealerScore.innerText=""
							dealerScore.innerText="Dealer Number: "+sumDealerCard;
							dealerScore.setAttribute("class" ,"col-auto text-white fw-bold");
							
							getMiddleRowBox("Tie");
							sendResult("tie");
							
						}else if(sumDealerCard > sumPlayerCard){
							revealDealerCard();
							var dealerScore = document.getElementById("dealerScoreColBox");
							dealerScore.innerText=""
							dealerScore.innerText="Dealer Number: "+sumDealerCard;
							dealerScore.setAttribute("class" ,"col-auto text-white fw-bold");
							
							getMiddleRowBox("Dealer Win");
							sendResult("dw");
							
						}else if(sumDealerCard < sumPlayerCard){
							revealDealerCard();
							var dealerScore = document.getElementById("dealerScoreColBox");
							dealerScore.innerText=""
							dealerScore.innerText="Dealer Number: "+sumDealerCard;
							dealerScore.setAttribute("class" ,"col-auto text-white fw-bold");
							
							getMiddleRowBox("Player Win");
							sendResult("pw");
							
						}
					}
					
					var playerScore = document.getElementById("playerScoreColBox");
					playerScore.innerText=""
					playerScore.innerText="Player Number: "+sumPlayerCard;
					playerScore.setAttribute("class" ,"col-auto text-white fw-bold");
					
					
					
				}
			};
			
			xmlhttp.open("get" , "./getCardInfo.do?gameRound_no="+gameRound); 
			xmlhttp.send();	
			
		}
		
		function doGame(){
			
			var xmlhttp = new XMLHttpRequest();
			
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
					var data = JSON.parse(xmlhttp.responseText);
					
					var contentBody = document.getElementById("contentBody");
					
					var hitButton = document.createElement("button");
					hitButton.setAttribute("class" ,"btn btn-success");
					hitButton.innerText = "Hit";
					hitButton.setAttribute("onclick" ,"addPlayerCard()");
					var stayButton = document.createElement("button");
					stayButton.setAttribute("class" ,"btn btn-secondary");
					stayButton.setAttribute("onclick" ,"stay()");
					stayButton.innerText = "Stay";
					
					var bodyoutterRowBox = document.createElement("div");
					bodyoutterRowBox.setAttribute("class" ,"row");
					var bodyoutterColBox = document.createElement("div");
					bodyoutterColBox.setAttribute("class" ,"col");
					
					var dealerScoreRowBox = document.createElement("div");
					dealerScoreRowBox.setAttribute("class" ,"row justify-content-center mb-2");
					var dealerScoreColBox = document.createElement("div");
					dealerScoreColBox.setAttribute("class" ,"col-auto");
					dealerScoreColBox.setAttribute("id" ,"dealerScoreColBox");
					var dealerRowBox = document.createElement("div");
					dealerRowBox.setAttribute("class" ,"row justify-content-center");
					dealerRowBox.setAttribute("id" ,"dealerRowBox");
					
					var middleRowBox = document.createElement("div");
					middleRowBox.setAttribute("class" ,"row my-5 text-center");
					middleRowBox.setAttribute("id" ,"middleRowBox");
					
					var playerRowBox = document.createElement("div");
					playerRowBox.setAttribute("class" ,"row justify-content-center");
					playerRowBox.setAttribute("id" ,"playerRowBox");
					var playerScoreRowBox = document.createElement("div");
					playerScoreRowBox.setAttribute("class" ,"row justify-content-center mt-2");
					var playerScoreColBox = document.createElement("div");
					playerScoreColBox.setAttribute("class" ,"col-auto");
					playerScoreColBox.setAttribute("id" ,"playerScoreColBox");
					
					dealerScoreRowBox.appendChild(dealerScoreColBox);
					playerScoreRowBox.appendChild(playerScoreColBox);
					
					var playerNumber;
					for(var i=0; i<2; i++){
						var elementName = document.createElement("div");
						elementName.setAttribute("class" ,"col-auto");
						//elementName.innerText = data.playingCardInfo[i].cardShape + "/"+ data.playingCardInfo[i].cardNumber;
						var cardImg = document.createElement("img");
						if(i==0){
							cardImg.src = "/movie/resources/img/cards/card_back.jpg"
						}else{
							cardImg.src = "/movie/resources/img/cards/card_" + data.playingCardInfo[i].cardShape + "_" + data.playingCardInfo[i].cardNumber + ".jpg"
						}
						cardImg.setAttribute("class" , "img-fluid");
						cardImg.setAttribute("style" , "width:100px; height:130px;");
						
						elementName.appendChild(cardImg);
						
						
						dealerRowBox.appendChild(elementName);
					}
					
					for(var i=2; i<4; i++){
						var elementName = document.createElement("div");
						elementName.setAttribute("class" ,"col-auto");
						var cardImg = document.createElement("img");
						cardImg.src = "/movie/resources/img/cards/card_" + data.playingCardInfo[i].cardShape + "_" + data.playingCardInfo[i].cardNumber + ".jpg"
						cardImg.setAttribute("class" , "img-fluid");
						cardImg.setAttribute("style" , "width:100px; height:130px;");
						elementName.appendChild(cardImg);
						playerRowBox.appendChild(elementName);
					}
					
					bodyoutterColBox.appendChild(dealerScoreRowBox);
					bodyoutterColBox.appendChild(dealerRowBox);
					bodyoutterColBox.appendChild(middleRowBox);
					bodyoutterColBox.appendChild(playerRowBox);
					bodyoutterColBox.appendChild(playerScoreRowBox);
					bodyoutterRowBox.appendChild(bodyoutterColBox);
					
					contentBody.appendChild(bodyoutterRowBox);
					
					var hrRowBox = document.createElement("div");
					hrRowBox.setAttribute("class" ,"row");
					var hrColBox = document.createElement("div");
					hrColBox.setAttribute("class" ,"col");
					var hrTag = document.createElement("hr");
					
					hrColBox.appendChild(hrTag);
					hrRowBox.appendChild(hrColBox);
					contentBody.appendChild(hrRowBox);
					
					var buttonsRowBox = document.createElement("div");
					buttonsRowBox.setAttribute("class" ,"row justify-content-center");
					buttonsRowBox.setAttribute("id" ,"buttonsRowBox");
					var hitColBox = document.createElement("div");
					hitColBox.setAttribute("class" ,"col-auto");
					var stayColBox = document.createElement("div");
					stayColBox.setAttribute("class" ,"col-auto");
					
					hitColBox.appendChild(hitButton);
					stayColBox.appendChild(stayButton);
					buttonsRowBox.appendChild(hitColBox);
					buttonsRowBox.appendChild(stayColBox);
					contentBody.appendChild(buttonsRowBox);
					
					checkResult("default");
					
				}
			};
			
			xmlhttp.open("get" , "./getCardInfo.do?gameRound_no="+gameRound); 
			xmlhttp.send();		
			
	    }
		
		function addPlayerCard(){
			var xmlhttp = new XMLHttpRequest();
			
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
			
					var data = JSON.parse(xmlhttp.responseText);
					
					var sumPlayerCardNum = 0;
					
					var playerRowBox = document.getElementById("playerRowBox");
					
					var num = data.playingCardInfo.length;
					
					var elementName = document.createElement("div");
					elementName.setAttribute("class" ,"col-auto");
					var cardImg = document.createElement("img");
					//elementName.innerText = data.playingCardInfo[num-1].cardShape + "/"+ data.playingCardInfo[num-1].cardNumber;
					cardImg.src = "/movie/resources/img/cards/card_" + data.playingCardInfo[num-1].cardShape + "_" + data.playingCardInfo[num-1].cardNumber + ".jpg"
					cardImg.setAttribute("class" , "img-fluid");
					cardImg.setAttribute("style" , "width:100px; height:130px;");
					elementName.appendChild(cardImg);
					
					playerRowBox.appendChild(elementName);
					
					for(var i=2; i<data.playingCardInfo.length; i++){
						if(data.playingCardInfo[i].cardNumber == 1){
							sumPlayerCardNum+=11;
							if(sumPlayerCardNum >21 ){
								sumPlayerCardNum-=10;
							}
						}else if(data.playingCardInfo[i].cardNumber == 11 ||data.playingCardInfo[i].cardNumber == 12||data.playingCardInfo[i].cardNumber == 13){
							sumPlayerCardNum+=10;
						}else{
							sumPlayerCardNum+=data.playingCardInfo[i].cardNumber;
						}
					}
					
					var playerScore = document.getElementById("playerScoreColBox");
					playerScore.innerText=""
					playerScore.innerText="Player Number: "+sumPlayerCardNum;
					playerScore.setAttribute("class" ,"col-auto text-white fw-bold");
					
					if(sumPlayerCardNum>21){
						changeModalTitleAndFooter();
						var dealerRowBox = document.getElementById("dealerRowBox");
						dealerRowBox.innerHTML = ""; //초기화...
						
						for(var i=0; i<2; i++){
							var elementName = document.createElement("div");
							elementName.setAttribute("class" ,"col-auto");
							var cardImg = document.createElement("img");
							cardImg.src = "/movie/resources/img/cards/card_" + data.playingCardInfo[i].cardShape + "_" + data.playingCardInfo[i].cardNumber + ".jpg"
							cardImg.setAttribute("class" , "img-fluid");
							cardImg.setAttribute("style" , "width:100px; height:130px;");
							elementName.appendChild(cardImg);
							
							dealerRowBox.appendChild(elementName);
						}
						var showResultBox = document.getElementById("middleRowBox");
						var showResultCol = document.createElement("div");
						showResultCol.setAttribute("class" ,"col");
						showResultCol.setAttribute("style" ,"color: gold;font-size: xx-large;font-weight: bold;");
						showResultCol.innerText = "Dealer Win | Player Busted "+sumPlayerCardNum;
						sendResult("dw");
						showResultBox.appendChild(showResultCol);
						
						var dealerScore = document.getElementById("dealerScoreColBox");
						var dealerScoreSum=0;
						
						for(var i=0; i<2; i++){
							if(data.playingCardInfo[i].cardNumber == 1){
								dealerScoreSum+=11;
								if(dealerScoreSum >21 ){
									dealerScoreSum-=10;
								}
							}else if(data.playingCardInfo[i].cardNumber == 11 ||data.playingCardInfo[i].cardNumber == 12||data.playingCardInfo[i].cardNumber == 13){
								dealerScoreSum+=10;
							}else{
								var dealercardnum = data.playingCardInfo[i].cardNumber;
								console.log(data.playingCardInfo[i].cardNumber+"ss");
								console.log(dealercardnum);
								console.log(dealerScoreSum);
								dealerScoreSum+=dealercardnum;
							}
						}
						
						dealerScore.innerText="";
						
						dealerScore.innerText="Dealer Number: "+dealerScoreSum;
						dealerScore.setAttribute("class" ,"col-auto text-white fw-bold");
						
						var playerScore = document.getElementById("playerScoreColBox");
						playerScore.innerText=""
						playerScore.innerText="Player Number: "+sumPlayerCardNum;
						playerScore.setAttribute("class" ,"col-auto text-white fw-bold");
					}
					
					
					
				}
			};
			
			xmlhttp.open("get" , "./addPlayerCard.do?gameRound_no="+gameRound); 
			xmlhttp.send();		
			
		}
		
		function stay(){
			var xmlhttp = new XMLHttpRequest();
			
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4 && xmlhttp.status==200){
					var data = JSON.parse(xmlhttp.responseText);
					changeModalTitleAndFooter();

					if(data.playingCardInfo.length==4){
						checkResult("stay");
					}else{
						var dealerRowBox = document.getElementById("dealerRowBox");
						dealerRowBox.innerHTML = ""; //초기화...
						
						for(var i=0; i<2; i++){
							var elementName = document.createElement("div");
							elementName.setAttribute("class" ,"col-auto");
							var cardImg = document.createElement("img");
							cardImg.src = "/movie/resources/img/cards/card_" + data.playingCardInfo[i].cardShape + "_" + data.playingCardInfo[i].cardNumber + ".jpg"
							cardImg.setAttribute("class" , "img-fluid");
							cardImg.setAttribute("style" , "width:100px; height:130px;");
							elementName.appendChild(cardImg);
							
							dealerRowBox.appendChild(elementName);
						}
						
						var size = data.playingCardInfo.length -1;
						for(var i=size; i>3; i--){
							if(data.playingCardInfo[i].player === 'D'){
								var elementName = document.createElement("div");
								elementName.setAttribute("class" ,"col-auto");
								
								var cardImg = document.createElement("img");
								//elementName.innerText = data.playingCardInfo[i].cardShape + "/"+ data.playingCardInfo[i].cardNumber;
								cardImg.src = "/movie/resources/img/cards/card_" + data.playingCardInfo[i].cardShape + "_" + data.playingCardInfo[i].cardNumber + ".jpg"
								cardImg.setAttribute("class" , "img-fluid");
								cardImg.setAttribute("style" , "width:100px; height:130px;");
								elementName.appendChild(cardImg);
								dealerRowBox.appendChild(elementName);
								checkResult("stay");
							}else{
								checkResult("stay");
								break;
							}
						}
					}
					
					
				}
			};
			
			xmlhttp.open("get" , "./stayProcess.do?gameRound_no="+gameRound); 
			xmlhttp.send();	
		}
		
		function setBatingAmout(a){
			document.getElementById("inputAmount").value = a;
		}

		function showTable(){
			var contentBgImg = document.getElementById("contentBgImg");
			var contentBodyBottom = document.getElementById("contentBodyBottom");
			var innerTitle = document.getElementById("contentInnerTitle");
			//innerTitle.innerText = "입장준비";
			contentBgImg.innerHTML = ""; //초기화...
			contentBodyBottom.innerHTML = ""; //초기화...
			innerTitle.remove(); //초기화...
			
			var contentBody = document.getElementById("contentBody");
			contentBody.innerHTML = ""; //초기화...
			
			var startBtnBox = document.getElementById("startBtnBox");
			startBtnBox.remove();
			
			
			var textAndInputRowBox = document.createElement("div");
			textAndInputRowBox.setAttribute("class" ,"row justify-content-center mt-5");
			
			var chipsRowBox = document.createElement("div");
			chipsRowBox.setAttribute("class" ,"row mt-4 justify-content-center");
			var chip20ColBox = document.createElement("div");
			chip20ColBox.setAttribute("class" ,"col-auto");
			var chip50ColBox = document.createElement("div");
			chip50ColBox.setAttribute("class" ,"col-auto");
			var chip100ColBox = document.createElement("div");
			chip100ColBox.setAttribute("class" ,"col-auto");
			
			var textBox = document.createElement("div");
			textBox.setAttribute("class" ,"col-auto");
			var inputBox = document.createElement("div");
			inputBox.setAttribute("class" ,"col-auto");
			var buttonBox = document.createElement("div");
			buttonBox.setAttribute("class" ,"col-auto");
			
			var pTag = document.createElement("p");
			pTag.setAttribute("class" ,"text-white pointBatingText");
			pTag.innerText = "포인트 배팅 ";
			var batingInputBox = document.createElement("input");
			batingInputBox.setAttribute("type" ,"number");
			batingInputBox.setAttribute("name" ,"batingAmount");
			batingInputBox.setAttribute("min" ,"1");
			batingInputBox.setAttribute("id" ,"inputAmount");
			batingInputBox.setAttribute("class" ,"form-control");
			batingInputBox.setAttribute("value" ,"10");
			var doGameBtn = document.createElement("button");
			doGameBtn.setAttribute("onclick" ,"checkAmount()");
			//doGameBtn.setAttribute("onclick" ,"showDefaultCardSet()");
			doGameBtn.setAttribute("class" ,"btn btn-primary ms-2");
			doGameBtn.innerText = "게임 시작";
			
			var chip20Img = document.createElement("img");
			chip20Img.setAttribute("src" ,"../resources/img/cards/chip20.png");
			chip20Img.setAttribute("onclick" ,"setBatingAmout(20)");
			chip20Img.setAttribute("class" ,"img-fluid");
			chip20Img.setAttribute("width" ,"70px");
			chip20Img.setAttribute("height" ,"70px");
			var chip50Img = document.createElement("img");
			chip50Img.setAttribute("src" ,"../resources/img/cards/chip50.png");
			chip50Img.setAttribute("onclick" ,"setBatingAmout(50)");
			chip50Img.setAttribute("class" ,"img-fluid");
			chip50Img.setAttribute("width" ,"70px");
			chip50Img.setAttribute("height" ,"70px");
			var chip100Img = document.createElement("img");
			chip100Img.setAttribute("src" ,"../resources/img/cards/chip100.png");
			chip100Img.setAttribute("onclick" ,"setBatingAmout(100)");
			chip100Img.setAttribute("class" ,"img-fluid");
			chip100Img.setAttribute("width" ,"70px");
			chip100Img.setAttribute("height" ,"70px");
			
			var contentBody = document.getElementById("contentBody");
			contentBody.innerHTML = ""; //초기화...
			contentBody.setAttribute("style" ,"height:435px; background-color:#02551D; border-style: solid; border-width: 12px; border-color: #5e4705; border-radius: 12px;");
			contentBody.setAttribute("class" ,"col fs-6 py-4 px-4");
			
			chip20ColBox.appendChild(chip20Img);
			chip50ColBox.appendChild(chip50Img);
			chip100ColBox.appendChild(chip100Img);
			chipsRowBox.appendChild(chip20ColBox);
			chipsRowBox.appendChild(chip50ColBox);
			chipsRowBox.appendChild(chip100ColBox);
			
			textBox.appendChild(pTag);
			inputBox.appendChild(batingInputBox);
			buttonBox.appendChild(doGameBtn);
			
			textAndInputRowBox.appendChild(textBox);
			textAndInputRowBox.appendChild(inputBox);
			textAndInputRowBox.appendChild(buttonBox);
			
			contentBody.appendChild(textAndInputRowBox);
			contentBody.appendChild(chipsRowBox);
			
			
		}
		
		function goToLoginPage(){
			location.href = "/movie/member/loginPage.do";
		}
		
		function init(){
			//로그인 상태 처리...
			getSessionUserInfo();
			
			if(logined == true){
				showBtn();
			}
			
			if(logined == false){
				
				var startButtonBox = document.getElementById("startBtnBox");
				startButtonBox.innerHTML = ""; //초기화...
				var startButton = document.createElement("button");
				startButton.setAttribute("class" ,"btn btn-primary");
				//startButton.setAttribute("disabled","disabled");
				startButton.setAttribute("onclick","goToLoginPage()");
				startButton.innerText = "로그인 후 이용 가능 합니다.";
				startButtonBox.appendChild(startButton);
			} 
			
		}
		
		window.addEventListener("DOMContentLoaded" , init);

	</script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<link rel="stylesheet" type="text/css" href="../resources/css/test.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

<title>미니게임 페이지</title>
</head>
<body>
	<!-- 네비바 시작 -->
	<div style="width: 100%; height: 140px; margin: 0 auto" class="bg-dark">
		<div style="width: 1200px; margin: 0 auto" class="bg-dark">
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
	<div style="width: 1200px; margin: 0 auto">
		<div class="container-fluid">
			<div class="row mt-3">
				<div class="col"></div>
				<!--왼쪽 공백-->

				<!-- 전체 시작 -->
				<div class="col-10">



					<!-- 바디(내용) 시작 -->

					<div class="row mt-5">
						<div class="col fs-3 fw-bold" id="title">
							<i class="bi bi-controller"></i> 블랙잭
						</div>
					</div>
					<hr>
					<!-- 내용 시작-->
					<div class="row mt-3" id="contentBgImg">
						<div class="col">
							<img src="../resources/img/cards/blackjack_main_1000.jpg">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col-2 fs-4 fw-bold" id="contentInnerTitle">
							<i class="bi bi-joystick"></i> 규칙
						</div>
						<div class="col fs-6" id="contentBody">
							<p>
								카드 두 장을 기본적으로 지급받는다.<br>
								<br> 카드의 숫자 합이 21점 또는 21점에 가장 가깝게 만들면 승리.<br>
								<br> 처음 받은 2장 합쳐 21이 나오는 경우 <b>블랙잭</b>이 되며 21이 되지 않았을 경우 합계가 21점에 가까워지도록 하기 위해 딜러로부터 카드를 추가로 받을 수 있다. 추가 카드는 제한없이 몇 장이라도 요구할 수 있다.<br>
								<br> 자신의 카드 숫자 합이 21을 초과하게 되는 순간 딜러의 결과에 관계없이 플레이어가 패배한다.<br>
								<br> K, Q, J는 10에 해당하며, 에이스는 1 혹은 11 어느 쪽으로도 계산할 수 있다. <br>
								<br> 딜러와 참가자가 동시에 블랙잭인 경우에는 푸시(Push)라 하여 무승부가 된다.<br> 이 경우엔 플레이어는 얻는 건 없고 자신이 베팅한 금액만 돌려받는다.<br>
								<br> 딜러는 플레이어의 추가가 모두 끝난 뒤에 정해진 규칙에 따라 본인이 카드를 더 받을 것인지를 결정한다. <br> 딜러는 가진 카드의 합계가 16점 이하이면 반드시 1장을 더 받아야 하고, 17점 이상이면 카드를 더 받지 않고 멈춘다.
							</p>
						</div>
					</div>
					<div class="row" id="contentBodyBottom">
						<div class="col-2 fs-4 fw-bold mt-3">
							<i class="bi bi-dice-5"></i> 용어
						</div>
						<div class="col fs-6 mt-3">
							<p>
								<b>힛(Hit)</b><br> 처음 2장의 상태에서 카드를 더 뽑는 것을 Hit이라고 한다.<br>
								<br> <b>스탠드, 스테이(Stand, Stay)</b><br> 카드를 더 뽑지 않고 차례를 마치는 것을 스탠드, 혹은 스테이라고 부른다.<br>
								<br> <b>버스트(Bust)</b><br> 카드 총합이 21을 넘는 경우. 플레이어가 버스트 당하면 경기 흐름에 상관없이 바로 패배하여 배당금을 잃는다.<br>
								<br> <b>블랙잭(Blackjack)</b><br> 게임내 가장 높은 가치. Ace 한장과 10에 해당하는 패(10,J,Q,K)로 21을 이루는 경우 베팅금액의 1.5배를 돌려준다.
							</p>
						</div>
					</div>
					<!-- 내용 끝 -->
					<div class="row mt-3">
						<div class="col text-center" id="startBtnBox">
							<!-- <button type="button" class="btn btn-primary" onclick="doModal()">Game Start</button> -->
						</div>
					</div>

					<!-- 바디(내용) 끝 -->



				</div>
				<!-- 전체 끝-->

				<div class="col"></div>
				<!--오른쪽 공백-->
			</div>
		</div>
	</div>
	<!-- 본문 끝 -->

	<!-- 풋터 시작 -->
	<div style="width: 100%; height: 180px; margin: 80px auto 0px auto" class="bg-dark">
		<div style="width: 1200px; margin: 0 auto" class="bg-dark">
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