<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

	<div class="wrap">
		<div class="join_header">
			<h1>회원가입</h1>
		</div>
		<div class="join_form">
			<form method="POST">
				<p>
					<input type="text" id="memberId" name="busanParking_Member_Id" oninput="idErase()" placeholder="아이디" autofocus required>
					<button type="button" id="idCheckBtn" onclick="idDuplicationCheck()">ID 중복확인</button>
				</p>
				<span id="idConfirm"></span>
				<p><input type="password" id="pw1" oninput="pwCheck()" name="busanParking_Member_Password" placeholder="비밀번호" minlength="4" required></p>
				<p><input type="password" id="pw2" oninput="pwCheck()" placeholder="비밀번호확인" required></p>
				<span id="pwConfirm"></span>
				<p>
					<input type="text" id="memberNickName" name="busanParking_Member_Nickname" oninput="nickErase()" placeholder="닉네임" minlength="2" required>
					<button type="button" id="nickCheckBtn" onclick="nickDuplicationCheck()">닉네임 중복확인</button>
				</p>
				<span id="nickConfirm"></span>
				<p><input id="joinBtn" type="submit" value="회원가입" disabled></p>
			</form>
		</div>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>
	
	<script>
		
		// ------- 아이디 중복 체크
		function idDuplicationCheck() {
			let memberId = $('#memberId').val();
			
			if(memberId.length < 4) {
				$('#idConfirm').text('아이디는 4글자 이상만 가능합니다.').css('color', 'red');
				$('#memberId').focus();
				$('#joinBtn').hover(function() {
					$('#joinBtn').css('background', '#f8f8f8');
					$('#joinBtn').css('cursor', 'default');
					$('#joinBtn').css('color', '#6d6d93');
					$('#joinBtn').attr('disabled', true);
				})
				return;
			}
			
			$.ajax ({
				url: 'idDuplicationCheck', 		// 요청 주소
				type: 'GET', 							// get, post, put 등
				async: true,							// 비동기 여부 (default "true")
				data: {
					member_id: memberId					// member_id라는 이름으로 memberId 변수를 백엔드로 전달		
				},
				success: function(data) {
					
					if(data.row == '1') {
						$('#idConfirm').text('이미 사용중인 아이디입니다.').css('color', 'red');
						$('#joinBtn').hover(function() {
							$('#joinBtn').css('background', '#f8f8f8');
							$('#joinBtn').css('cursor', 'default');
							$('#joinBtn').css('color', '#6d6d93');
							$('#joinBtn').attr('disabled', true);
						})
					}
					else {
						$('#idConfirm').text('사용가능한 아이디입니다.').css('color', 'green');
						$('#joinBtn').hover(function () {
							$('#joinBtn').css('background', 'yellow');
							$('#joinBtn').css('cursor', 'pointer');
							$('#joinBtn').css('color', 'black');
							$('#joinBtn').attr('disabled', false);
						}, function() {
							$('#joinBtn').css('background', '#f8f8f8');
							$('#joinBtn').css('color', 'black');
							$('#joinBtn').attr('disabled', false);
						})
					}
				}
			}); 
		}
		
		// ------ 비밀번호 확인
		const pw1 = document.getElementById('pw1');
		const pw2 = document.getElementById('pw2');
		
		function pwCheck() {
			if(pw1.value == pw2.value) {
				if(pw1.value.length >= 4 && pw2.value.length >= 4) {
					$('#pwConfirm').text('비밀번호가 일치합니다.').css('color', 'green');
					$('#joinBtn').hover(function () {
						$('#joinBtn').css('background', 'yellow');
						$('#joinBtn').css('cursor', 'pointer');
						$('#joinBtn').css('color', 'black');
						$('#joinBtn').attr('disabled', false);
					}, function() {
						$('#joinBtn').css('background', '#f8f8f8');
						$('#joinBtn').css('color', 'black');
						$('#joinBtn').attr('disabled', false);
					})
				}
				else {
					$('#pwConfirm').text('비밀번호는 4글자 이상만 가능합니다.').css('color', 'red');
					$('#joinBtn').hover(function() {
						$('#joinBtn').css('background', '#f8f8f8');
						$('#joinBtn').css('cursor', 'default');
						$('#joinBtn').css('color', '#6d6d93');
						$('#joinBtn').attr('disabled', true);
					})
				}
			}
			else {
				$('#pwConfirm').text('비밀번호가 일치하지 않습니다.').css('color', 'red');
				$('#joinBtn').hover(function() {
					$('#joinBtn').css('background', '#f8f8f8');
					$('#joinBtn').css('cursor', 'default');
					$('#joinBtn').css('color', '#6d6d93');
					$('#joinBtn').attr('disabled', true);
				})
			}
		}
		
		// ------------닉네임 중복 체크
		function nickDuplicationCheck() {
			let nick = $('#memberNickName').val();
			
			if(nick.length < 2) {
				$('#nickConfirm').text('닉네임은 두글자 이상만 가능합니다.').css('color', 'red');
				$('#memberNickName').focus();
				$('#joinBtn').hover(function() {
					$('#joinBtn').css('background', '#f8f8f8');
					$('#joinBtn').css('cursor', 'default');
					$('#joinBtn').css('color', '#6d6d93');
					$('#joinBtn').attr('disabled', true);
				})
				return;
			}
			
			$.ajax({
				url: 'nickDuplicationCheck',
				type: 'GET',
				asunc: true,
				data: {
					member_nick: nick
				},
				success: function(data) {
					
					if(data.row == '1') {
						$('#nickConfirm').text('이미 사용중인 닉네임입니다.').css('color', 'red');
						$('#joinBtn').hover(function() {
							$('#joinBtn').css('background', '#f8f8f8');
							$('#joinBtn').css('cursor', 'default');
							$('#joinBtn').css('color', '#6d6d93');
							$('#joinBtn').attr('disabled', true);
						})
					}
					else {
						$('#nickConfirm').text('사용가능한 닉네임입니다.').css('color', 'green');
						$('#joinBtn').hover(function () {
							$('#joinBtn').css('background', 'yellow');
							$('#joinBtn').css('cursor', 'pointer');
							$('#joinBtn').css('color', 'black');
							$('#joinBtn').attr('disabled', false);
						}, function() {
							$('#joinBtn').css('background', '#f8f8f8');
							$('#joinBtn').css('color', 'black');
							$('#joinBtn').attr('disabled', false);
						})
					}
				}
			})
		}
		
		// 중복체크 후 지웠을때
		function idErase() {
			$('#idConfirm').text('중복확인을 눌러주세요.').css('color', 'red');
			$('#joinBtn').hover(function() {
				$('#joinBtn').css('background', '#f8f8f8');
				$('#joinBtn').css('cursor', 'default');
				$('#joinBtn').css('color', '#6d6d93');
				$('#joinBtn').attr('disabled', true);
			})
		}
		
		function nickErase() {
			$('#nickConfirm').text('중복확인을 눌러주세요.').css('color', 'red');
			$('#joinBtn').hover(function() {
				$('#joinBtn').css('background', '#f8f8f8');
				$('#joinBtn').css('cursor', 'default');
				$('#joinBtn').css('color', '#6d6d93');
				$('#joinBtn').attr('disabled', true);
			})
		}
	</script>
</body>
</html>