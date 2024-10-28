<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

	<div class="wrap">
		<div class="login_header">
			<h1>로그인</h1>
		</div>
		<div class="login_form">
			<form method="POST">
				<p><input type="text" name="busanParking_Member_Id" placeholder="아이디" autofocus required></p>
				<p><input type="password" name="busanParking_Member_Password" placeholder="비밀번호" required></p>
				<p><input type="submit" value="로그인"></p>
			</form>
		</div>
		<div class="login_footer">
			<a href="${cpath }/member/join">아직 회원이 아니십니까? 회원가입 하러 가기</a>
		</div>
	</div>

	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>