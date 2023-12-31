<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine","\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>Instagram clone</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<!--아이콘,css-->
	<link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
	<jsp:include page="/WEB-INF/views/include/style.jsp"/>
	<!---->
	<script>
		'use strict';
		
	</script>
	<style>
	/*스토리 뜨는곳 625px(고정), 포스트 올라가는 곳 470px(고정), 우측푸터는 300px(1160px미만일때 없어짐,좌측 마진으로 고정됨) */
		@media ( max-width : 1160px) {
			.right-col{
				display:none;
			}
			#s1160 {
				min-width:500px;
				display: flex;
				grid-template-columns: 100% 0%;
			}
			
			.main {
				/* text-align:center; */
				min-width:500px;
			}
			
		}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	
	    <!-- Story Section Start -->
    <section class="main">
        <div class="wrapper" id="s1160">
            <div class="left-col">
                <div class="status-wrapper">
                	<!-- 회원추천(랜덤회원 7명) -->
                	<c:forEach var="rmVo" items="${rmVos}">
	                    <div class="status-card">
	                        <div class="profile-pic"><a class="showMD" href="#"><img src="${ctp}/images/noprofile.png" alt=""></a></div>
	                        <p class="username"><a href="#">${rmVo.mid}</a></p>
	                    </div>
                	</c:forEach>
                </div>
                
                <!-- First Post -->
                <div id="nextPost">
                	<c:forEach var="vo" items="${vos}" varStatus="st">
		            	<div class="post">
				            <div class="info">
				                <div class="user">
				                    <div class="profile-pic">
				                        <img src="${ctp}/images/noprofile.png" alt="photo">
				                    </div>
				                    <p class="username"><a href="#">${vo.mid}</a></p>
				                </div>
				                <!-- 작성자아이디 = 세션아이디 일때 수정,삭제기능 -->
				                <c:if test="${sMid==vo.mid || sMid=='admin'}">
					                <div class="dropdown">
					                    <a class="dropdown-toggle" data-toggle="dropdown">
					                        <i class="ri-more-fill m-0 p-0"></i>
					                    </a>
					                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink"  style="width:50px;">
					                    	<c:if test="${sMid==vo.mid}">
							                    <li><button data-toggle="modal" data-target="#edit-modal" onclick="editPost('${vo.idx}','${vo.content}')" class="dropdown-item post_edit">수정</button></li>
					                    	</c:if>
						                    <li><a class="dropdown-item post_delete" href="javascript:deletePost(${vo.idx})">삭제</a></li>
					                    </ul>
					                </div>
				                </c:if>
				                <!--  -->
				            </div>
				            <img src="${ctp}/images/severPostImg/${vo.fSName}" style="object-fit:contain"class="post-image" alt="${vo.fName}">
				            <div class="post-content p-0 mt-4">
				                <div class="reaction-wrapper d-flex">
				                	<!-- 좋아요버튼 -->
				                	<c:set var="like" value="false"/>
				                	<c:forEach var="lVo" items="${lVos}">
				                		<!-- lVo(좋아요에있는 postIDX와 게시글의 IDX가 같으면 like=true 로 체크) -->
				                		<c:if test="${vo.idx==lVo.postIdx}">
					                		<c:set var="like" value="true"/>
				                		</c:if>
				                	</c:forEach>
				     				<c:if test="${like eq false}">
					     				<button class="btn btn-sm btn-light btn-main" onclick="likePlus(${vo.idx})"><i class="ri-heart-line m-1"></i></button>
				     				</c:if>
				     				<c:if test="${like eq true}">
					     				<button class="btn btn-sm btn-light btn-main" onclick="likeMinus(${vo.idx})"><font color="red"><i class="ri-heart-fill m-1"></i></font></button>
				     				</c:if>
				                    
				                    <button class="btn btn-sm btn-light btn-main" onclick="replyCheck(${vo.idx})"><i class="ri-chat-3-line m-1"></i></button>
				                    <button class="btn btn-sm btn-light btn-main"><div id="animated_div"><i class="ri-send-plane-2-line m-1"></i></div></button>
					                <button class="btn btn-sm btn-light btn-main ml-auto"><i class="ri-bookmark-line m-1"></i></button>
				                </div>
				                <p class="likes text-start"><c:if test="${vo.likes!=0}">좋아요 ${vo.likes} 개</c:if></p>
					            <span class="description">
					            	<a href="#"><b>${vo.mid}</b></a>
					            	${fn:replace(vo.content,newLine,'<br/>')}
					            </span>
				                <p class="post-time">${fn:substring(vo.wDate,0,11)}</p>
				                <div class="w-100"></div>
					            <!-- 댓글은 해당 글의 idx와 댓글VO의 postIdx가 같으면 출력되게끔 작성 -->
				            	<c:forEach var="rVo" items="${rVos}">
				            		<c:if test="${rVo.postIdx==vo.idx}">
				            		<!-- 댓글 -->
					            		<div class="description w-100 p-0 m-0">
				            				<a href="#"><b>${rVo.mid}</b></a>
				            				${fn:replace(rVo.content,newLine,'<br/>')}
				            				<!-- 댓글 삭제권한 (댓글작성자,게시글작성자,운영자) -->
				            				<c:if test="${sMid==vo.mid || sMid=='admin' || sMid==rVo.mid}">
				            					<a class="float-right" href="javascript:deleteReply(${rVo.idx})">&times;</a>
				            				</c:if>
					            		</div>
				            		</c:if>
				            	</c:forEach>
				            </div>
				            	<!-- 댓글입력 -->
				            <div class="comment-wrapper">
					            <input type="text" class="comment-box" id="comment${vo.idx}" placeholder="댓글 달기...">
					            <button class="comment-btn" onclick="replyCheck(${vo.idx})"><b>게시</b></button>
				            </div>
			        		<hr class="mt-0"/>
			        	</div>
                	</c:forEach>
		        </div>
		        <!-- 새로운 글 추가 -->
            </div>
            
    <!-- Story Section End -->

    <!-- right Sidebar Section Start --> 
        <div class="right-col">
            <div class="profile-card">
                <div class="profile-pic">
                	<a id="profile-pic-onclick" href="#">
	                    <img src="${ctp}/images/noprofile.png" title="프로필 사진을 변경하려면 클릭하세요" alt="내 프로필사진">
                	</a>
                	<input type="hidden" id="profileID" value="${sMid}">
                </div>
                <div>
                    <p class="username"><a href="#">${sMid}</a></p>
                    <p class="sub-text">${sName}</p>
                </div>
            </div>
            <p class="suggestion-text">회원님을 위한 추천</p>
            <!-- 추천인 아이디 출력 (최신 가입 회원) -->
            <c:forEach var="mVo" items="${mVos}" varStatus="st">
	            <div class="profile-card">
	                <div class="profile-pic">
	                    <a href="#"><img src="${ctp}/images/noprofile.png" alt=""></a>
	                </div>
	                <div>
	                    <p class="username"><a href="#">${mVo.mid}</a></p>
	                    <p class="sub-text">${mVo.name}</p>
	                </div>
	                <button class="action-btn float-right" onclick="alert('준비중이에요ㅠ')">팔로우</button>
	            </div>
            </c:forEach>
        </div>
    </div>
    </section>
    <!-- right Sidebar Section End -->
    
    <!-- 게시글을 등록하기위한 첫 모달창(이미지 입력) --> 
    <div class="modal fade " id="post-add-modal">
        <span>
	        <button type="button" class="close m-4 modal_close" data-dismiss="modal"><font size="15pt" color="#fff">&times;</font></button>
        </span>
        <div class="modal-dialog modal-xl modal-dialog-centered rounded-3">
            <div class="modal-content">
            	<div class="modal-header">
            		<font size="3pt" class="modal-title col-12 text-center"><b>새 게시물 만들기</b></font>
            	</div>
            	<!-- 모달내부에서 폼 입력하기 -->
                <div class="modal-body">
                    <form id="myform" method="post" action="postUpload.po" enctype="multipart/form-data">
                    	<table class="table table-borderless modaltable w-100 h-100">
                    		<tr class="h-100">
                    			<td class="col-8 h-100">
                    				<div class="text-center d-flex flex-column" id="modalDemo">
			                    		<div style="margin-top:120px;">
			                    			<i class="ri-image-add-line" style="font-size:80pt"></i>
			                    		</div>
										<p><font size="5pt">사진 파일을 여기에 업로드하세요</font></p>
			                    		<input type="button" style="width:135px;" class="btn btn-primary btn-sm mx-auto" onclick="clickFilebtn()" value="컴퓨터에서 선택" />
									</div>
									<input style="display:none;" type="file" value="컴퓨터에서 선택" name="fName" id="file" multiple/>
                    			</td>
                    			<td class="col-4">
                    				<div class="profile-card">
						                <div class="profile-pic">
						                    <img src="${ctp}/images/noprofile.png" alt="내 프로필사진">
						                </div>
						                <div>
						                    <p class="username">${sMid}</p>
						                    <p class="sub-text">${sName}</p>
						                    <input type="hidden" id="mid" value="${sMid}"/>
						                    <input type="hidden" id="name" value="${sName}"/>
						                    <input type="hidden" id="fileSize" name="fileSize"/>
						                    <input type="hidden" id="hostIp" name="hostIp" value="${pageContext.request.remoteAddr}"/>
						                </div>
						            </div>
		                    		<textarea rows="10" name="content" id="content" placeholder="내용을 입력하세요..." class="form-control" style="resize:none; border:none;"></textarea>
		                            <div class="hr-sect"><b>준비되셨나요?</b></div>
		                            <button type="button" onclick="fCheck()" class="btn btn-light float-right d-inline-flex align-items-center"><i class="ri-upload-2-fill" title="게시하기"></i><span class="btntext ml-2">게시하기</span></button>
                    			</td>
                    		</tr>
                    	</table>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- create Post Modal End  -->


    <!-- Edit Modal Start -->
    <!-- Edit Modal -->

   	<div class="modal fade" id="edit-modal">
   		<span>
	        <button type="button" class="close m-4 modal_close" data-dismiss="modal"><font size="15pt" color="#fff">&times;</font></button>
        </span>
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content"  style="height:500px">
	            <div class="modal-header">
	                <font size="3pt" class="modal-title col-12 text-center"><b>내용 수정</b></font>
	            </div>
	            <div class="modal-body">
                    <form id="editForm" method="post" action="postEdit.po">
                  		<div class="profile-card">
			                <div class="profile-pic">
			                    <img src="${ctp}/images/noprofile.png" alt="내 프로필사진">
			                </div>
			                <div>
			                    <p class="username">${sMid}</p>
			                    <p class="sub-text">${sName}</p>
			                </div>
			            </div>
						<textarea rows="10" name="content" id="content" placeholder="내용을 입력하세요..." class="form-control" style="resize:none; border:none;"></textarea>
						<input type="hidden" name="idx" id="idx" />
                       	<div class="hr-sect"><b>준비되셨나요?</b></div>
                       	<button onclick="editSubmit()" class="btn btn-light float-right d-inline-flex align-items-center"><i class="ri-upload-2-fill" title="수정하기"></i><span class="btntext ml-2">수정하기</span></button>
                    </form>
                </div>
	        </div>
	    </div>
  	</div>
	<!-- Edit Modal End -->	

</body>
</html>