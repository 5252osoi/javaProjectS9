<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%
	int level= session.getAttribute("sLevel") == null ? 99 :(int) session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!--아이콘,css-->
<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
<jsp:include page="/WEB-INF/views/include/style.jsp"/>
<!---->
<script>

</script>
<style>
	.logoicon{
		display:none;
	}
	/* 450px 이상이면 body 상단여백이 200px */
		@media ( min-width : 450px) {

		}
	    /* 1265xp이하면 class="btntext"=>display:none*/
	    /* class="sidebar,.bottom-nav"의 최대 넓이가 75px로 변경됩니다."*/
		@media ( max-width : 1265px) {
			.btntext {
				display: none;
			}
			.logo{
				display:none;
			}
			.logoicon{
				display:block;
			}
			.sidebar{
				max-width:75px;
			}
			.bottom-nav{
				width:75px;
			}
		}

</style>
	<div class="sidebar">
		<a href="${ctp}/post/main" class="logo">
			<img src="${ctp}/images/instagram_text.png" alt="logo" title="instagram(clone)"">
		</a>
		<a href="${ctp}/post/main" class="logoicon" title="instagram(clone)">
			<i class="ri-instagram-line" ></i>
		</a>
		
		<nav class="navbar">
			<ul class="navbar-nav">
				<li class="nav-item">
					<button type="button" title="홈으로" onclick="location.href='${ctp}/post/main';" class="nav-link btn btn-light d-inline-flex align-items-center">
						<i class="ri-home-5-fill ml-2"></i><span class="btntext ml-2">홈</span>
					</button>
				</li>
				<li class="nav-item">
					<button type="button" title="찾기" class="nav-link btn btn-light d-inline-flex align-items-center">
						<i class="ri-search-line ml-2"></i><span class="btntext ml-2">찾기</span>
					</button>
				</li>
				<li class="nav-item">
					<button type="button" title="탐색" class="nav-link btn btn-light d-inline-flex align-items-center">
						<i class="ri-compass-3-line ml-2"></i><span class="btntext ml-2">탐색</span>
					</button>
				</li>
				<li class="nav-item">
					<button type="button" title="릴스" class="nav-link btn btn-light d-inline-flex align-items-center">
						<i class="ri-clapperboard-line ml-2"></i><span class="btntext ml-2">릴스</span>
					</button>
				</li>
				<li class="nav-item">
					<button type="button" title="메시지" class="nav-link btn btn-light d-inline-flex align-items-center">
						<i class="ri-send-plane-fill ml-2"></i><span class="btntext ml-2">메시지</span>
					</button>
				</li>
				<li class="nav-item">
					<button type="button" title="알림" class="nav-link btn btn-light d-inline-flex align-items-center">
						<i class="ri-heart-line ml-2"></i><span class="btntext ml-2">알림</span>
					</button>
				</li>
				<li class="nav-item">
					<button type="button" title="만들기" id="posting" data-toggle="modal" data-target="#post-add-modal" class="nav-link btn btn-light d-inline-flex align-items-center">
						<i class="ri-add-box-line ml-2"></i><span class="btntext ml-2">만들기</span>
					</button>
				</li>
				<li class="nav-item">
					<button type="button" title="프로필" class="nav-link btn btn-light d-inline-flex align-items-center">
						<span class="profile-img ml-2"><img src="${ctp}/images/noprofile.png" alt="profile-img"></span><span class="btntext ml-2">프로필</span>
					</button>
				</li>


<%-- 
				<li class="nav-item">
					<div class="about">
						<div class="profile">
							<div class="profile-img">
								
							</div>
							<div class="name">
								<h1>${sMid}(${sName})</h1>
								<!--인증받은 계정이면 뜸-->
								<img src="${ctp}/images/" alt="verify">
							</div>
							<span>@${sMid}(${sName})</span>
						</div>
						<a class="nav-link" href="#">프로필<img src="#" alt=""></a>
					</div>
				</li> --%>
			</ul>
		</nav>
		<nav class="navbar bottom-nav">
			<ul class="navbar-nav">
				<li class="nav-item">
					<button type="button" onclick="location.href='logout.in';" title="로그아웃" class="nav-link btn btn-light d-inline-flex align-items-center">
						<i class="ri-logout-box-line ml-2"></i><span class="btntext ml-2">로그아웃</span>
					</button>
				</li>
			</ul>
		</nav>
	</div>




	