<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부산 주차장 현황</title>
	<link href="${cpath }/resources/css/header.css" rel="stylesheet" />
	<link href="${cpath }/resources/css/home.css" rel="stylesheet" />
	<link href="${cpath }/resources/css/login.css" rel="stylesheet" />
	<link href="${cpath }/resources/css/join.css" rel="stylesheet" />
	
	<%-- 카카오맵 api --%>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=18a8aab041a8eafe83b8a574f52193d2&libraries=services"></script>
	<%-- jquery --%>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<%-- sockjs --%>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
	<%-- stomp --%>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

</head>
<body>
	<div class="header_top frame flex">
		<h1><a href="${cpath }">부산광역시 공영주차장 정보</a></h1>
		<div class="header_right flex">
			<c:if test="${empty user }">
				<a href="${cpath }/member/login">로그인</a>
				<a href="${cpath }/member/join">회원가입</a>
			</c:if>
			<c:if test="${not empty user }">
				<a href="${cpath }/member/logout">로그아웃</a>
				<a href="${cpath }/member/join">마이페이지</a>
			</c:if>
		</div>
	</div>