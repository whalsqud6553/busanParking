<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<script>
	alert('아이디 혹은 비밀번호가 틀립니다.');
	location.href = '${cpath}/member/login';
</script>

</body>
</html>