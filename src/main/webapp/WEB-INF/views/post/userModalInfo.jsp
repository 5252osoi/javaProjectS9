<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine","\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<div class="w-100 h-100 m-0 p-0">
	<div class="profile-card pl-1">
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
    <div class="info-container d-flex justify-content-around text-center" style="height:65px; width:100%; ">
    	<div>
    		<p class="username">${mvo.post}</p>
    		<p class="sub-text">게시물</p>
    	</div>
    	<div>
    		<p class="username">${mvo.follow}</p>
    		<p class="sub-text">팔로워</p>
    	</div>
    	<div>
    		<p class="username">${mvo.follower}</p>
    		<p class="sub-text">팔로잉</p>
    	</div>
    </div>
	<!-- 이미지 출력 -->
	<div class="image-container d-flex justify-content-around">
		<c:forEach var="vo" items="${pvos}" varStatus="st">
			<c:forEach var="imageName" items="${fn:split(vo.FSName, '/')}" varStatus="st">
			    <c:if test="${st.first}">
			        <!-- 첫 번째 이미지만 썸네일로 출력 -->
			        <div class="pt-0" style="height: 120px; width: 120px;" object-fit: contain;">
			            <img src="${ctp}/severPostImg/${imageName}" style="height: 120px; width:120px; object-fit: contain" class="d-block" alt="${imageName}">
			        </div>
			    </c:if>
			</c:forEach>
		</c:forEach>
	</div>
	<!--  -->
	<div class="d-flex justify-content-center mt-1 mb-1">
		<!-- 로그인한 사람이 팔로우 하고있는지 아닌지 체크 하고 버튼 출력 -->
		<c:set var="follow" value="false"/>
		<c:forEach var="fvo" items="${fvos}" varStatus="st">
			<!-- fvos(팔로우 같으면 follow=true 로 체크) -->
			<c:if test="${mvo.mid==fvo.followeeMid}">
				<c:set var="follow" value="true"/>
			</c:if>
		</c:forEach>
		<c:if test="${sMid!=mvo.mid}">
			<c:if test="${follow eq 'false'}">
				<button type="button" onclick="userFollow('${mvo.mid}')" class="btn profile-edit-btn ml-2 p-2">&nbsp 팔로우 &nbsp </button>
			</c:if>
			<c:if test="${follow eq 'true'}">
				<button type="button" onclick="userUnFollow('${mvo.mid}')" class="btn profile-edit-btn ml-2 p-2">언팔로우 </button>
			</c:if>
		</c:if>
		<!-- 체크끝 -->
		<button type="button" class="btn btn-secondary ml-1" data-dismiss="modal">&nbsp 닫기 &nbsp </button>
	</div>
</div>