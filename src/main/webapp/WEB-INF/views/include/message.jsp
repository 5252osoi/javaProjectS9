<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<title>message.jsp</title>	
	<script>
		'use strict';
		alert("${msg}");
		location.href="${ctp}/${url}";
	</script>
</head>
<body>
</body>
</html>
