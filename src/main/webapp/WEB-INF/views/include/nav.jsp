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
	'use strict;'

	    //유저 팔로우
		function userFollow(mid){
	    	$.ajax({
	    		url  : "${ctp}/member/userFollow",
	    		type : "post",
	    		data : {follower :'${sMid}',
	    				followee : mid
	    		},
	    		success:function(res) {
	    			if(res == "0") alert('팔로우실패 ');
	    			else location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류!!");
	    		}
	    	});
		}
	    //유저 언팔로우
		function userUnFollow(mid){
	    	$.ajax({
	    		url  : "${ctp}/member/userUnFollow",
	    		type : "post",
	    		data : {follower :'${sMid}',
	    				followee : mid
	    		},
	    		success:function(res) {
	    			if(res == "0") alert('언팔로우실패 ');
	    			else location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류!!");
	    		}
	    	});
		}
	    //댓글달기
 	    function replyCheck(idx) {
	    	let content = $("#comment"+idx).val();
	    	if(content.trim() == "") {
	    		alert("댓글을 입력하세요");
	    		$("#comment"+idx).focus();
	    		return false;
	    	}
	    	let query = {
	    			postIdx  	: idx,
	    			mid			: '${sMid}',
	    			hostIp		: '${pageContext.request.remoteAddr}',
	    			content		: content
	    	}
	    	$.ajax({
	    		url  : "${ctp}/post/postReplyInput",
	    		type : "post",
	    		data : query,
	    		success:function(res) {
	    			if(res.trim()!=='') {
	    				alert("댓글이 입력되었습니다.");
	    				location.reload();
	    			}
	    			else {
	    				alert("댓글 입력 실패");
	    			}
	    		},
	    		error : function() {
	    			alert("전송오류!!");
	    		}
	    	});
	    } 
	    
	    //댓글삭제
	    function deleteReply(idx){
	    	let ans = confirm("이 댓글을 삭제하시겠어요?")
	    	if(!ans)return false;
	    	$.ajax({
	    		url  : "${ctp}/post/postReplyDelete",
	    		type : "post",
	    		data : {idx : idx},
	    		success:function(res) {
	    			if(res == "1") {
	    				alert("댓글을 삭제했습니다.");
	    				location.reload();
	    			}
	    			else alert("댓글삭제실패ㅋㅋ");
	    		},
	    		error : function() {
	    			alert("전송 오류!!");
	    		}
	    	});
	    }
	    //좋아요 누르기 (게시글)
		function likePlus(idx) {
	    	$.ajax({
	    		url  : "${ctp}/post/likePlus",
	    		type : "post",
	    		data : {idx : idx,
	    				mid : '${sMid}'
	    		},
	    		success:function(res) {
	    			if(res == "0") alert('좋아요실패ㅋㅋ싫어요ㅋㅋ');
	    			else location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류!!");
	    		}
	    	});
	    }
  		//좋아요 한번 더 누르기(게시글)
	  	function likeMinus(idx) {
	    	$.ajax({
	    		url  : "${ctp}/post/likeMinus",
	    		type : "post",
	    		data : {idx : idx,
	    				mid : '${sMid}'
	    		},
	    		success:function(res) {
	    			if(res == "0") alert('싫어요실패ㅋㅋ좋아요ㅋㅋ.');
	    			else location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류!!");
	    		}
	    	});
	    }
  		
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
					<button type="button" onclick="location.href='${ctp}/';" title="로그아웃" class="nav-link btn btn-light d-inline-flex align-items-center">
						<i class="ri-logout-box-line ml-2"></i><span class="btntext ml-2">로그아웃</span>
					</button>
				</li>
			</ul>
		</nav>
	</div>

	    
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
                    <form id="myform" method="post" action="${ctp}/post/postUpload" enctype="multipart/form-data">
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
									<input style="display:none;" type="file" value="컴퓨터에서 선택" name="files" id="files" multiple />
                    			</td>
                    			<td class="col-4">
                    				<div class="profile-card">
						                <div class="profile-pic">
						                    <img src="${ctp}/images/noprofile.png" alt="내 프로필사진">
						                </div>
						                <div>
						                    <p class="username">${sMid}</p>
						                    <p class="sub-text">${sName}</p>
						                    <input type="hidden" name="mid" id="mid" value="${sMid}"/>
						                    <input type="hidden" name="name" id="name" value="${sName}"/>
						                    <input type="hidden" name="fileSize" id="fileSize" />
						                    <input type="hidden" name="hostIp" id="hostIp" value="${pageContext.request.remoteAddr}"/>
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
	


	