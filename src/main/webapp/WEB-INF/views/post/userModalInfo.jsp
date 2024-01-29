<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine","\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<div class="w-100 h-100">
	<div class="profile-card">
    	<div class="profile-pic">
			<a id="profile-pic-onclick" href="#">
				<img src="${ctp}/images/noprofile.png" title="프로필 사진을 변경하려면 클릭하세요" alt="내 프로필사진">
			</a>
			<input type="hidden" id="profileID" value="${mvo.mid}">
		</div>
		<div>
			<p class="username"><a href="#">${mvo.mid}</a></p>
			<p class="sub-text">${mvo.name}</p>
        </div>
    </div>
	<!-- 이미지 출력 -->
	<div class="image-container">
		<c:forEach var="imageName" items="${fn:split(vo.FSName, '/')}" varStatus="st">
			<div class="carousel-item${st.index == 0 ? ' active' : ''}" style="height: 500px; object-fit: contain;">
				<img src="${ctp}/severPostImg/${imageName}" style="max-height: 500px; object-fit: contain" class="d-block" alt="${imageName}">
			</div>
		</c:forEach>
		
		<c:forEach var="imageUrl" items="${pvos.}">
			<img src="${imageUrl}" class="user-image" alt="User Image">
		</c:forEach>
	</div>
	<!--  -->
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	</div>
</div>