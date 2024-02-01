<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
	<jsp:include page="/WEB-INF/views/include/userPageCss.jsp"/>
	<title>personalPage</title>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	<div style="margin-left:20%; padding:0 10%">
		<div class="container" >
			<div class="profile">
				<div class="profile-image">
				    <img src="${ctp}/images/noprofile.png" alt="${mvo.mid}님의 프로필사진">
				</div>
				<div class="profile-info">
					<div class="profile-user-settings">
						<h1 class="profile-user-name">${mvo.mid}</h1>
						<c:if test="${sMid==mvo.mid}">
							<button class="btn profile-edit-btn">프로필 수정</button>
							<button class="btn profile-settings-btn" aria-label="profile settings"><i class="fas fa-cog" aria-hidden="true"></i></button>
						</c:if>
						<!-- 로그인한 사람이 팔로우 하고있는지 아닌지 체크 하고 버튼 출력 -->
						<c:set var="follow" value="false"/>
	                	<c:forEach var="fvo" items="${fvos}" varStatus="st">
	                		<!-- lVo(좋아요에있는 postIDX와 게시글의 IDX가 같으면 follow=true 로 체크) -->
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
					</div>
					<p></p>
					<div class="profile-stats">
						<ul>
							<li><span class="profile-stat-count">${mvo.post}</span> 포스트</li>
							<li><span class="profile-stat-count">${mvo.follow}</span> 팔로워</li>
							<li><span class="profile-stat-count">${mvo.follower}</span> 팔로잉</li>
						</ul>
					</div>
					<p></p>
					<div class="profile-bio">
					     <p><span class="profile-real-name">${mvo.name}</span></p>
					     <p>${mvo.pr}</p>
					</div>
				</div>
			</div>
			<!-- profile section 끝 -->
		</div>
		<!--container 끝-->
		<hr/>
	
	      <div class="container">
	
	        <div class="gallery">
				<!-- 이미지 출력 -->
					<c:forEach var="vo" items="${vos}" varStatus="st">
						<c:forEach var="imageName" items="${fn:split(vo.FSName, '/')}" varStatus="st">
						    <c:if test="${st.first}">
						        <!-- 첫 번째 이미지만 썸네일로 출력 -->
						        <div class="gallery-item m-1 p-0" tabindex="0" data-toggle="modal" data-target="#postModal-${vo.idx}" data-post-id="${vo.idx}">
									<img src="${ctp}/severPostImg/${imageName}" class="gallery-image" alt="">
									<!-- 이미지가 1개보다 많으면 우상단에 아이콘표시 -->
									<c:if test="${fn:length(fn:split(vo.FSName, '/')) > 1}">
										<div class="gallery-item-type">
											<span class="visually-hidden">Gallery</span><i class="fas fa-clone" aria-hidden="true"></i>
										</div>									
									</c:if>
									<div class="gallery-item-info">
										<ul>
											<li class="gallery-item-likes"><span class="visually-hidden">좋아요</span><i class="fas fa-heart" aria-hidden="true"></i> ${vo.likes}</li>
											<li class="gallery-item-comments"><span class="visually-hidden">댓글:</span><i class="fas fa-comment" aria-hidden="true"></i> ${vo.reply}</li>
										</ul>
									</div>
								</div>
						    </c:if>
						</c:forEach>
		          		<!-- 모달 창 -->
						<div id="postModal-${vo.idx}" class="modal" tabindex="-1" role="dialog">
						    <div class="modal-dialog modal-xl modal-dialog-centered rounded-0" role="document">
						        <div class="modal-content"  style="object-fit:contain; overflow: hidden;">
						            <div class="modal-body"  style="object-fit:contain">
						                <!-- 모달 내용 -->
						            </div>
						        </div>
						    </div>
						</div>
					<!--  -->
					</c:forEach>
			<div class="gallery-item" tabindex="0">
	            <img src="https://images.unsplash.com/photo-1423012373122-fff0a5d28cc9?w=500&h=500&fit=crop" class="gallery-image" alt="">
	            <div class="gallery-item-type">
	              <span class="visually-hidden">Video</span><i class="fas fa-video" aria-hidden="true"></i>
	            </div>
	            <div class="gallery-item-info">
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">좋아요</span><i class="fas fa-heart" aria-hidden="true"></i> 30</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">댓글</span><i class="fas fa-comment" aria-hidden="true"></i> 2</li>
	              </ul>
	            </div>
	          </div>
	          
	          <div class="gallery-item" tabindex="0">
	            <img src="https://images.unsplash.com/photo-1497445462247-4330a224fdb1?w=500&h=500&fit=crop" class="gallery-image" alt="">
	            <div class="gallery-item-info">
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 89</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 5</li>
	              </ul>
	            </div>
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	            <img src="https://images.unsplash.com/photo-1426604966848-d7adac402bff?w=500&h=500&fit=crop" class="gallery-image" alt="">
	            <div class="gallery-item-type">
	              <span class="visually-hidden">Gallery</span><i class="fas fa-clone" aria-hidden="true"></i>
	            </div>
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 42</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 1</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	
	            <img src="https://images.unsplash.com/photo-1502630859934-b3b41d18206c?w=500&h=500&fit=crop" class="gallery-image" alt="">
	
	            <div class="gallery-item-type">
	
	              <span class="visually-hidden">Video</span><i class="fas fa-video" aria-hidden="true"></i>
	
	            </div>
	
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 38</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 0</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	
	            <img src="https://images.unsplash.com/photo-1498471731312-b6d2b8280c61?w=500&h=500&fit=crop" class="gallery-image" alt="">
	
	            <div class="gallery-item-type">
	
	              <span class="visually-hidden">Gallery</span><i class="fas fa-clone" aria-hidden="true"></i>
	
	            </div>
	
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 47</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 1</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	
	            <img src="https://images.unsplash.com/photo-1515023115689-589c33041d3c?w=500&h=500&fit=crop" class="gallery-image" alt="">
	
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 94</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 3</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	
	            <img src="https://images.unsplash.com/photo-1504214208698-ea1916a2195a?w=500&h=500&fit=crop" class="gallery-image" alt="">
	
	            <div class="gallery-item-type">
	
	              <span class="visually-hidden">Gallery</span><i class="fas fa-clone" aria-hidden="true"></i>
	
	            </div>
	
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 52</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 4</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	
	            <img src="https://images.unsplash.com/photo-1515814472071-4d632dbc5d4a?w=500&h=500&fit=crop" class="gallery-image" alt="">
	
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 66</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 2</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	
	            <img src="https://images.unsplash.com/photo-1511407397940-d57f68e81203?w=500&h=500&fit=crop" class="gallery-image" alt="">
	
	            <div class="gallery-item-type">
	
	              <span class="visually-hidden">Gallery</span><i class="fas fa-clone" aria-hidden="true"></i>
	
	            </div>
	
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 45</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 0</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	
	            <img src="https://images.unsplash.com/photo-1518481612222-68bbe828ecd1?w=500&h=500&fit=crop" class="gallery-image" alt="">
	
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 34</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 1</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	
	            <img src="https://images.unsplash.com/photo-1505058707965-09a4469a87e4?w=500&h=500&fit=crop" class="gallery-image" alt="">
	
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 41</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 0</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	          <div class="gallery-item" tabindex="0">
	
	            <img src="https://images.unsplash.com/photo-1423012373122-fff0a5d28cc9?w=500&h=500&fit=crop" class="gallery-image" alt="">
	
	            <div class="gallery-item-type">
	
	              <span class="visually-hidden">Video</span><i class="fas fa-video" aria-hidden="true"></i>
	
	            </div>
	
	            <div class="gallery-item-info">
	
	              <ul>
	                <li class="gallery-item-likes"><span class="visually-hidden">Likes:</span><i class="fas fa-heart" aria-hidden="true"></i> 30</li>
	                <li class="gallery-item-comments"><span class="visually-hidden">Comments:</span><i class="fas fa-comment" aria-hidden="true"></i> 2</li>
	              </ul>
	
	            </div>
	
	          </div>
	
	        </div>
	        <!-- End of gallery -->
	
	        <div class="loader"></div>
	
	      </div>
	      <!-- End of container -->
	
	</div>
	<script>
	'use strict'
		//현재 스크롤 위치 저장
		let lastScroll = 0;
		let curPage = 1;
		
	    // 각 포스트를 클릭했을 때 모달창 열기
	    $('.gallery-item').click(function() {
	        var postIdx = $(this).data('post-id');
	        // ajax로 포스트 정보요청
	        $.ajax({
	            type: "POST",
	            url: "${ctp}/post/showPostInfo",
	            data: {"idx": postIdx},
	            success: function(res) {
	                // 모달에 출력
	                $('#postModal-' + postIdx + ' .modal-body').html(res);
	                // 모달 열기
	                $('#postModal-' + postIdx).modal('show');
	            },
	            error: function() {
	                alert("전송실패");
	            }
	        });
	    });

	    
	</script>		

</body>
</html>
