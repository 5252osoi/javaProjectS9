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
		
		//현재 스크롤 위치 저장
		let lastScroll = 0;
		let curPage = 1;
		//무한스크롤 
		$(document).scroll(function(e){
		
		    var currentScroll = $(this).scrollTop();					//현재 높이 저장
		    var documentHeight = $(document).height();					//전체 문서의 높이
		    var nowHeight = $(this).scrollTop() + $(window).height();	//(현재 화면상단 + 현재 화면 높이)
		    
		    //스크롤이 아래로 내려갔을때만 해당 이벤트 진행.
		    if(currentScroll > lastScroll){
		        //nowHeight을 통해 현재 화면의 끝이 어디까지 내려왔는지 파악가능 
		        //즉 전체 문서의 높이에 일정량 근접했을때 글 더 불러오기)
		        if(documentHeight < (nowHeight + (documentHeight*0.1))){
		            console.log("다음 페이지 가져오기");
		            curPage++;
		            getList(curPage);
		        }
		    }
		    //현재위치 최신화
		    lastScroll = currentScroll;
		});
		// 스크롤 했을때 다음 리스트 불러오기
		function getList(curPage) {
			$.ajax({
				type: "post",
				url : "${ctp}/post/scrollPage",
				data :{	"curPage" 		: curPage,
						"order" 		: "scrollPage"},
				success:function(res){
		        	//서버에서 전송된 데이터를 nextPost 에 추가하기
					
		        	$("#nextPost").append(res);
				},
				error : function(){
	                alert("불러오기 실패");
	            }
			});
		}
		
		//새로고침했을때 마지막 스크롤바가 있던 위치로 가기
		window.addEventListener("load", function() {
            window.scrollTo(0, lastScroll);
        });
		
	    function fCheck() {
	    	let fName = document.getElementById("files").value;
	    	let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
	    	let maxSize = 1024 * 1024 * 30;   // 1KByte=1024Byte=10^3Byte=2^10Byte, 1MByte=2^20Byte=10^6Byte, 1GByte=2^30Byte=10^9Byte, 1TByte=2^40Byte=10^12Byte)
	    	
	    	if(fName.trim() == "") {
	    		alert("업로드할 파일을 선택하세요!");
	    		return false;
	    	}
	    	let fileSize = document.getElementById("files").files[0].size;
	    	$('#fileSize').val(fileSize);
	    	if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
	    		alert("업로드 가능한 파일은 'jgp/gif/png/' 만 가능합니다.");
	    	} else if(fileSize > maxSize) {
	    		alert("업로드할 파일의 최대용량은 30MByte입니다.");
	    	} else {
	    		myform.submit();
	    	}
	    }
		
		//모달 내부에서 파일넣기 버튼을 누르면 hidden속에있는 파일 버튼넣어짐
		function clickFilebtn(){
			document.getElementById('files').click();
		}
		
		//모달창이 닫힐때 안에 있는 내용 초기화하기(새로고침)
		$(document).ready(function(){
			$('.modal').on('hidden.bs.modal', function () {
				location.reload();
			});
		});
		
		//파일을 넣으면 모달창에 이미지 띄우기
	    $(function(){
	    	$("#files").on("change", function(e){
	    		// 그림파일 체크
	    		let files = e.target.files;
	    		let filesArr = Array.prototype.slice.call(files);
	    		
	    		//console.log('filesArr',filesArr);
	    		
	    		filesArr.forEach(function(f){
	    			if(!f.type.match("image.*")) {
	    				alert("업로드할 파일은 이미지파일만 가능합니다.");
	    			}
	    		});
	    		
	    		// 멀티파일 이미지 미리보기
	    		let i = e.target.files.length;
	    		//들어온 파일의 갯수가 null이 아니면 #modalDemo안의 내용을 지우고 다시 출력
	    		if(i!=null){
					let strDemo='';
	    			strDemo+='<div class="w3-content w3-display-container d-inline-flex align-items-center" style="overflow:auto; height:655px;"> ';
	    			strDemo+='<div class="w-100 h-100" id="mdlDemo" >';
	    			strDemo+='</div>';
	    			strDemo+='</div>';
	    			
	    			$('#modalDemo').html(strDemo);
	    			
		    		for(let image of files) {
						let img = document.createElement("img");
		    			let reader = new FileReader();
		    			reader.onload = function(e) {
		    				img.setAttribute("src", e.target.result);
		    				//img.setAttribute("width", 700);
		    			}
		    			reader.readAsDataURL(e.target.files[--i]);
		    			document.querySelector("#mdlDemo").append(img);
		    		}
	    		}
	    	});
	    });
		
	    function editPost(idx,content) {
	    	$("#edit-modal #idx").val(idx);
	    	$("#edit-modal #content").val(content);
	    	console.log(idx);
	    }; 
	    
	    
	    function editSubmit(){
			document.getElementById("editForm").submit();
	    };
	    
	    //포스트 삭제
	    function deletePost(idx){
	    	let ans = confirm("이 게시물을 삭제하시겠어요?");
	    	if(!ans) return false;
	    	$.ajax({
	    		url  : "${ctp}/post/postDelete",
	    		type : "post",
	    		data : {"idx" : idx},
	    		success:function(res) {
	    			if(res == "1") {
	    				alert("포스트를 삭제했습니다.");
	    				location.reload();
	    			}
	    			else alert("포스트삭제실패ㅋㅋ");
	    		},
	    		error : function() {
	    			alert("전송 오류!!");
	    		}
	    	});
	    }
	    

	  	$(document).ready(function () {
	  	    // Carousel 초기화
	  	    $('.carousel').carousel();
	  	});
	  	
		 // username에 hover 이벤트 추가
	  	$(document).on('mouseenter', '.username', function (e) {
	  	    // 해당 사용자에 대한 모달 내용 업데이트
	  	    var userId = $(this).text();
	  	    
	  	    // 모달 위치 및 크기 설정
	  	    var x = e.clientX ;
	  	    var y = e.clientY ;
	  	    $('#userModal-' + userId).css({
	  	        'top': y + 'px',
	  	        'left': x + 'px',
	  	        'width': '365px',
	  	        'height': '335px',
	  	        'overflow': 'visible'
	  	    });
	  	    $('#userModal-' + userId+ ' .modal-content').css({
	  	    	'height':'335px',
	  	    	'border-radius': '10px',
	  	    	'max-height':'335px',
	  	    	'box-shadow': '0px 0px 10px rgba(0, 0, 0, 0.5)'
	  	    });
	  	    // 모달 열기
	  	    $('#userModal-' + userId).modal({
	  	        backdrop: false, // 뒷배경 어두워지는 것 제거
	  	        show: true
	  	    });
	  	    
	  	    $.ajax({
	  	    	type:"post",
	  	    	url:"${ctp}/post/userModalInfo",
	  	    	data:{"mid":userId},
	  	    	success:function(res){
	  	    		displayUserInfo(res,userId);
	  	    	},
	  	    	error:function(){
	  	    		alert("전송오류");
	  	    	}
	  	    });
	  	    
	  	}).on('click', '.username', function () {
	  	    // 클릭 시 userPage로 이동
	  	    var userId = $(this).text();
	  	    window.location.href = "${ctp}/member/userPage?mid=" + userId;
	  	    
	  	}).on('mouseleave', '.username', function () {
	  	    // 마우스가 떠날 때 모달 닫기
	  	    var userId = $(this).text();
	  	    $('#userModal-' + userId).modal('hide');
	  	});
		 
		 //모달창에 출력
		function displayUserInfo(res,userId){
			$('#userModal-'+userId+' .modal-body').html(res);
		}
		

		
		
		
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
                	<!-- scrollPage.jsp와 같이 사용하는부분 -->
                	<c:forEach var="vo" items="${vos}" varStatus="st">
		            	<div class="post">
				            <div class="info">
				                <div class="user">
				                    <div class="profile-pic">
				                        <img src="${ctp}/images/noprofile.png" alt="photo">
				                    </div>
				                    <p class="username" data-toggle="userModal-${vo.mid}" data-target="#userModal-${vo.mid}">${vo.mid}</p>
				                </div>
				                <!-- forEach문 안에 모달창을 만들어놔야 동적으로 사용할 수 있음 -->
							    <!-- 사용자에 대한 모달 -->
							    <div class="modal fade" id="userModal-${vo.mid}" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
							        <div class="modal-dialog" role="document">
							            <div class="modal-content">
							                <div class="modal-body">
							                    <!-- 해당 사용자에 대한 내용 -->
							                    <p>${vo.mid}님에 관련된 내용입니다.</p>
							                </div>
							            </div>
							        </div>
							    </div>		
							    <!-- 사용자 모달 종료 -->
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
								<!-- 이미지파일 이름을 /로 분리하고 슬라이드 표시(carousel로표시) -->
				                <div id="imageCarousel-${vo.idx}" style="object-fit:contain" class="carousel slide mt-2" data-interval="false" data-ride="carousel">
				                    <div class="carousel-inner" style="object-fit:contain">
				                        <c:forEach var="imageName" items="${fn:split(vo.FSName, '/')}" varStatus="st">
				                            <div class="carousel-item${st.index == 0 ? ' active' : ''}" style="height: 500px; object-fit: contain;">
				                                <img src="${ctp}/severPostImg/${imageName}" style="max-height: 500px; object-fit: contain" class="d-block" alt="${imageName}">
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
					            	<a href="${ctp}/member/userPage?mid=${vo.mid}"><b>${vo.mid}</b></a>
					            	${fn:replace(vo.content,newLine,'<br/>')}
					            </span>
				                <p class="post-time">${fn:substring(vo.WDate,0,11)}</p>
				                <div class="w-100"></div>
					            <!-- 댓글은 해당 글의 idx와 댓글VO의 postIdx가 같으면 출력되게끔 작성 -->
				            	<c:forEach var="rVo" items="${rVos}">
				            		<c:if test="${rVo.postIdx==vo.idx}">
				            		<!-- 댓글 -->
					            		<div class="description w-100 p-0 m-0">
				            				<a href="${ctp}/member/userPage?mid=${rVo.mid}"><b>${rVo.mid}</b></a>
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
                    <p class="username"><a href="${ctp}/member/userPage/${sMid}">${sMid}</a></p>
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
	                    <p class="username"><a href="${ctp}/member/userPage?mid=${mVo.mid}">${mVo.mid}</a></p>
	                    <p class="sub-text">${mVo.name}</p>
	                </div>
	                <!-- 로그인한 사람이 팔로우 하고있는지 아닌지 체크 하고 버튼 출력 -->
						<c:set var="follow" value="false"/>
	                	<c:forEach var="fvo" items="${fvos}" varStatus="st">
	                		<!-- lVo(좋아요에있는 postIDX와 게시글의 IDX가 같으면 follow=true 로 체크) -->
	                		<c:if test="${mVo.mid==fvo.followeeMid}">
		                		<c:set var="follow" value="true"/>
	                		</c:if>
	                	</c:forEach>
	                	<c:if test="${sMid!=mVo.mid}">
		                	<c:if test="${follow eq 'false'}">
				                <button class="action-btn float-right" onclick="userFollow('${mVo.mid}')">팔로우</button>
		     				</c:if>
		     				<c:if test="${follow eq 'true'}">
				                <button class="action-btn float-right" onclick="userUnFollow('${mVo.mid}')">언팔로우</button>
		     				</c:if>
	     				</c:if>
	                	<!-- 체크끝 -->
	            </div>
            </c:forEach>
        </div>
    </div>
    </section>
    <!-- right Sidebar Section End -->


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
                    <form id="editForm" method="post" action="{ctp}/post/postEdit">
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
	<!-- Carousel Modal Start -->
	<div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-lg" role="document">
	        <div class="modal-content">
	            <div class="modal-body">
	                <!-- 이미지 슬라이드쇼 -->
	                <div id="imageCarousel" class="carousel slide" data-ride="carousel">
	                    <div class="carousel-inner">
	                        <!-- 이미지가 추가될 부분 -->
	                    </div>
	                    <a class="carousel-control-prev" href="#imageCarousel" role="button" data-slide="prev">
	                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	                        <span class="sr-only">이전</span>
	                    </a>
	                    <a class="carousel-control-next" href="#imageCarousel" role="button" data-slide="next">
	                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
	                        <span class="sr-only">다음</span>
	                    </a>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- Carousel Modal End-->
</body>
</html>