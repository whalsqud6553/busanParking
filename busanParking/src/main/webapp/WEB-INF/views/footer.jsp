<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	footer {
		width: 100%;
		height: 200px;
		background-color: #dcdcdc;
		margin-top: 100px;
	}
	footer > div {
		width: fit-content;
		margin: auto;
	}
	footer > div > p {
		text-align: center;
		font-size: 20px;
		padding: 86px;
	}
</style>
</head>
<body>

<footer>
	<div>
		<p>hello, welcome my page !!</p>
	</div>
</footer>

</body>
</html>