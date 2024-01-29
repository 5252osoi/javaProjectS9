<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>



                 	<!-- scrollPage.jsp와 같이 사용하는부분 -->
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
				            <!-- <img src="${ctp}/severPostImg/${vo.FSName}" style="object-fit:contain" class="post-image" alt="${vo.FName}"> -->
				<!-- 이미지파일 이름을 /로 분리하고 슬라이드 표시 -->
                <div id="imageCarousel-${vo.idx}" style="object-fit:contain" class="carousel slide mt-2 post-image" data-ride="carousel">
                    <div class="carousel-inner">
                        <c:forEach var="imageName" items="${fn:split(vo.FSName, '/')}" varStatus="st">
                            <div class="carousel-item${st.index == 0 ? ' active' : ''}">
                                <img src="${ctp}/severPostImg/${imageName}" style="max-height: 300px; object-fit: contain" class="d-block w-100" alt="${imageName}">
                            </div>
                        </c:forEach>
                    </div>
                    <a class="carousel-control-prev" href="#imageCarousel-${vo.idx}" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">이전</span>
                    </a>
                    <a class="carousel-control-next" href="#imageCarousel-${vo.idx}" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">다음</span>
                    </a>
                </div>	
                <!-- 슬라이드종료 -->	            
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
				                <p class="post-time">${fn:substring(vo.WDate,0,11)}</p>
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
                	<!-- scrollPage.jsp와 같이 사용하는부분 -->