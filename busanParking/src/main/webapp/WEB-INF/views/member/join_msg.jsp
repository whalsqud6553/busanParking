<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<script>
	const row = '${row}';
	if(row == '1') {
		alert('회원가입 성공. 로그인을 해주세요');
		location.href = '${cpath}/member/login';
	}
	else {
		alert('회원가입 실패. 다시 시도해주세요');
		location.href = '${cpath}/member/join';
	}
</script>

</body>
</html>