<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine","\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/include/style.jsp"/>
<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
<!--아이콘,css-->
<link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
<jsp:include page="/WEB-INF/views/include/style.jsp"/>

                   	<table class="table table-borderless modaltable w-100 h-100" style="object-fit:contain">
                   		<tr class="h-100"  style="object-fit:contain">
                   			<td class="col-8 h-100"  style="object-fit:contain">
                   			
                   				<!-- 이미지파일 이름을 /로 분리하고 슬라이드 표시(carousel로표시) -->
				                <div id="imageCarousel-${vo.idx}" style="object-fit:contain; max-height: 100%;" class="carousel slide" data-interval="false" data-ride="carousel">
				                    <div class="carousel-inner" style="object-fit: contain; max-height: 100%;">
				                        <c:forEach var="imageName" items="${fn:split(vo.FSName, '/')}" varStatus="st">
				                            <div class="carousel-item${st.index == 0 ? ' active' : ''}">
				                                <img src="${ctp}/severPostImg/${imageName}" style="max-width: 100%; max-height: 730px; object-fit: contain;" class="d-block w-100 h-100" alt="${imageName}">
				                            </div>
				                        </c:forEach>
				                    </div>
				                    <a class="carousel-control-prev" href="#imageCarousel-${vo.idx}" role="button" data-slide="prev">
				                        <span class="carousel-control-prev-icon text-secondary" aria-hidden="true"></span>
				                        <span class="sr-only">이전</span>
				                    </a>
				                    <a class="carousel-control-next" href="#imageCarousel-${vo.idx}" role="button" data-slide="next">
				                        <span class="carousel-control-next-icon text-secondary" aria-hidden="true"></span>
				                        <span class="sr-only">다음</span>
				                    </a>
				                </div>	
				                <!-- 슬라이드종료 -->	  
                   			</td>
                   			<td class="col-4" style="height:100%;">
                   				<div class="profile-card">
					                <div class="profile-pic">
					                    <img src="${ctp}/images/noprofile.png" alt="내 프로필사진">
					                </div>
					                <div>
					                    <p class="username">${sMid}</p>
					                </div>
					            </div>
					            <hr class="mb-1"/>
                   				<div class="profile-card">
					                <div class="profile-pic">
					                    <img src="${ctp}/images/noprofile.png" alt="내 프로필사진">
					                </div>
					                <div class="">
					                    <p class="username">${vo.mid}</p>
					                    <p class="sub-text">${fn:replace(vo.content,newLine,'<br/>')}</p>
					                </div>
					            </div>
					            <div>
						            <c:forEach var="rVo" items="${rVos}">
					            		<!-- 댓글 -->
					            		<div class="description w-100 p-0 m-0">
				            				<a href="${ctp}/member/userPage/${rVo.mid}"><b>${rVo.mid}</b></a>
				            				${fn:replace(rVo.content,newLine,'<br/>')}
				            				<!-- 댓글 삭제권한 (댓글작성자,게시글작성자,운영자) -->
				            				<c:if test="${sMid==vo.mid || sMid=='admin' || sMid==rVo.mid}">
				            					<a class="float-right" href="javascript:deleteReply(${rVo.idx})">&times;</a>
				            				</c:if>
					            		</div>
					            	</c:forEach>
					            </div>
				            	<hr/>
				            	<div id="footer">
						            <div class="reaction-wrapper d-flex">
					                	<!-- 좋아요버튼 -->
				                		<!-- lVo(좋아요에있는 postIDX와 게시글의 IDX가 같으면 like=true 로 체크) -->
					                	<c:set var="like" value="false"/>
				                		<c:if test="${vo.idx==lVo.postIdx}">
					                		<c:set var="like" value="true"/>
				                		</c:if>
					     				<c:if test="${like eq false}">
						     				<button class="btn btn-sm btn-light btn-main" onclick="likePlus('${vo.idx}')"><i class="ri-heart-line m-1"></i></button>
					     				</c:if>
					     				<c:if test="${like eq true}">
						     				<button class="btn btn-sm btn-light btn-main" onclick="likeMinus('${vo.idx}')"><font color="red"><i class="ri-heart-fill m-1"></i></font></button>
					     				</c:if>
					                    
					                    <button class="btn btn-sm btn-light btn-main" onclick="replyCheck(${vo.idx})"><i class="ri-chat-3-line m-1"></i></button>
					                    <button class="btn btn-sm btn-light btn-main"><div id="animated_div"><i class="ri-send-plane-2-line m-1"></i></div></button>
						                <button class="btn btn-sm btn-light btn-main ml-auto"><i class="ri-bookmark-line m-1"></i></button>
					                </div>
					                <p class="likes text-start"><c:if test="${vo.likes!=0}">좋아요 ${vo.likes} 개</c:if></p>					            
					                <hr class="m-0 p-0"/>
					                <div class="comment-wrapper">
						            	<input type="text" class="comment-box" id="comment${vo.idx}" placeholder="댓글 달기...">
						            	<button class="comment-btn" onclick="replyCheck(${vo.idx})"><b>게시</b></button>
				            		</div>
				           		</div>
                   			</td>
                   		</tr>
                   	</table>
    <!-- create Post Modal End  -->