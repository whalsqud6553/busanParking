<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
	
	<div class="wrap">
		<select id="gugun" onchange="getData()">
			<option>지역구를 선택해주세요.</option>
			<option value="해운대">해운대</option>
			<option value="기장군">기장군</option>
			<option value="금정구">금정구</option>
			<option value="동래구">동래구</option>
			<option value="연제구">연제구</option>
			<option value="수영구">수영구</option>
			<option value="부산진구">부산진구</option>
			<option value="남구">남구</option>
			<option value="동구">동구</option>
			<option value="서구">서구</option>
			<option value="중구">중구</option>
			<option value="사하구">사하구</option>
			<option value="영도구">영도구</option>
			<option value="강서구">강서구</option>
			<option value="사상구">사상구</option>
			<option value="북구">북구</option>
		</select>
		<div class="home_main">
			<div id="map">
				
			</div>
		</div>
	</div>
	
	<dialog class="chat_modal">
		<p onclick="closeModal()" style="text-align: right; cursor: pointer">X</p>
		<h2 id="status" style="text-align: center">연결 대기중...</h2>
		<br><br>
	
		<!-- 메시지 출력 영역 -->
		<div id="groupMessageArea"></div>
		
		<input type="text" id="message" placeholder="Press Enter for send message." onkeyup="if(window.event.keyCode==13){(send())}">
	</dialog>
	
	<jsp:include page="footer.jsp"></jsp:include>
	
	<script>
	
	const API_KEY = '50b7b0Arwu2I2%2BbueVBfClaIB%2BpBP53VasxgyMCcROfbqdCTifR%2Fc1Ymm498n2wOtQ65wpWwuH3ENiIxBb7UGQ%3D%3D';
	
	// 주차장 이름
	const pkNams = [];
	// 지도 변수
	let map;
	// json 객체
	let ob;
	
	// 채팅 모달창
	let modal = document.querySelector('.chat_modal');
	
	// 채팅 변수
	let socket;
	let stompClient;
	let roomId;
	
	// 로그인 여부
	let user = '${user}';
	
	async function onLoadMap() {
		const url = 'http://apis.data.go.kr/6260000/BusanPblcPrkngInfoService/getPblcPrkngInfo?ServiceKey=' + API_KEY 
		+ '&pageNo=1&numOfRows=5000&resultType=json';
		const response = await fetch(url);
		const data = await response.json();
		
		console.log(data.response.body.items.item);
		
		ob = data.response.body.items.item;
		
		var container = document.getElementById('map');
			
		var option = {	// 지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(35.179724394542916, 129.0750428025961),
			level: 8
		};
		
		// 지도 생성(지도를 표시할 위치, 지도 기본 옵션)
		map = new kakao.maps.Map(container, option);
		
	}
	
	function getData() {
		
 		// 주소-좌표 변환 객체 생성
 		var geocoder = new kakao.maps.services.Geocoder();
 		
 		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성
 		var bounds = new kakao.maps.LatLngBounds();
 		
 		let gugun = document.getElementById('gugun').value;
 		
 		let locations = [];
		
		ob.forEach((a, index) => {
			if(a.jibunAddr == '-') {
				if(a.doroAddr.includes(gugun)) {
					locations[index] = a.doroAddr;
					pkNams[index] = a.pkNam;
				}
			}
			else {
				if(a.jibunAddr.includes(gugun)) {
					locations[index] = a.jibunAddr;
					pkNams[index] = a.pkNam;
				}
			}
		})
		
 		
		locations.forEach((location, index) => { //추가한 코드
		    // 주소로 좌표를 검색합니다
			geocoder.addressSearch(location, function(result, status) {
			
			  	// 정상적으로 검색이 완료됐으면
				if(status === kakao.maps.services.Status.OK) {
					
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					
					// 결과값으로 받은 위치를 마커로 표시합니다
					var marker = new kakao.maps.Marker({
					  map: map,
					  position: coords
					});
					
					bounds.extend(coords); // 현재 코드에서 좌표정보는 point[i]가 아닌 coords이다
					
					var iwContent = '<div class="mapInfo" style="width:170px;text-align:center;padding:6px 0;"><p>'
									+ pkNams[index] + '</p>'
									+ '<button class="chatBtn">채팅방 입장💌</button>'
									+ '</div>';
					
					// 인포윈도우로 장소에 대한 설명을 표시합니다
					var infowindow = new kakao.maps.InfoWindow({
					  content: iwContent,
					  removable: true
					});
					
					kakao.maps.event.addListener(marker, 'click', function() {
						infowindow.open(map, marker);
						let chatBtn = document.querySelectorAll('.chatBtn');
						chatBtn.forEach(a => {
							a.onclick = function() {
								if(user == '') {
									let flag = confirm('로그인 후 이용하실 수 있습니다. 로그인 페이지로 이동 하시겠습니까?');
									if(flag) {
										window.location.href = '${cpath}/member/login';
									}
								}
								else {
									modal.showModal();
									connect();
									
									function connect() {
										// webSocket 매핑 주소
										socket = new SockJS('/busanParking/chat');
										// stomp
										stompClient = Stomp.over(socket);
										// 방이름 == 주차장이름
										roomId = a.previousElementSibling.innerText 

										
	 									// stomp 실행
										stompClient.connect({}, (frame) => {
											
											let status = document.getElementById('status');
											console.log(status);
											
											status.innerText = '연결되었습니다.';
											
											console.log("Connected : " + frame);
											
											stompClient.subscribe('/broker/room/' + roomId, onReceive);
										})
										
										function onReceive(chat) {
											const param = JSON.parse(chat.body);
											const content = param.content;
											const userid = param.from;
											const time = param.time;
											
											const messageArea = document.getElementById('groupMessageArea');
											const div = document.createElement('div');
											div.className = 'messageArea'
											
											const sender = document.createElement('p');
											sender.className = 'sender';
											sender.innerText = userid;
											
											const msg = document.createElement('p');
											msg.className = 'msg';
											msg.innerText = content;
											
											div.appendChild(sender);
											div.appendChild(msg);
											
											messageArea.appendChild(div);
										}
										
									}
								}
							}
						})
						
					})
					
					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setBounds(bounds);
				}
			});
		});
	}
	
	function send() {
		let message = document.getElementById('message');
		
		if(message.value.length < 1) {
			alert('한글자 이상 입력해주세요.');
		}
		else {
			stompClient.send("/app/enter", {}, JSON.stringify({
				from: '${user.busanParking_Member_Id}',
				content: message.value,
				roomId: roomId,
			}));
			
			document.getElementById('message').value = '';
			
			let chat_modal = document.querySelector('.chat_modal');
			
			scrollHeight = chat_modal.scrollHeight
			
			chat_modal.scrollTop = scrollHeight
		}
	}
	
	function closeModal() {
		document.querySelector('.chat_modal').close();
		stompClient.disconnect();
	}
	
	function closeChatModalOnEsc(event) {
	    if (event.key === "Escape") {
	        document.querySelector('.chat_modal').close();
	        stompClient.disconnect();
	    }
	}
	document.addEventListener("keydown", closeChatModalOnEsc);
	
	window.onload = onLoadMap();
	</script>
</body>
</html>