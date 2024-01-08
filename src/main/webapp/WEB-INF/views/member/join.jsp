<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>Instagram clone login</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
		<!--아이콘,css-->
	<link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
	<jsp:include page="/WEB-INF/views/include/style.jsp"/>
	<script>
	'use strict';
    // 아이디와 닉네임 중복버튼을 클릭했는지의 여부를 확인하기위한 변수(버튼 클릭후에는 내용 수정처리 못하도록 처리)
    let idCheckSw = 0;
    
    $(function(){
	    //입력창에서 focus가 해제될 때 아이디 중복 검사하기
		$("#mid").blur(function(){
			let mid = myform.mid.value.trim();
			/* alert("입력한아이디 : " + mid);  */
			$.ajax({
				url		: '${ctp}/member/idCheck',
				type	: 'post',
				data	: {mid : mid},
				success	: function(res) {
					if(res==1){ws
						$('#demo').html("<font color='red'>이미 존재하는 아이디입니다.</font>");
						idCheckSw = 0;
						<!-- 이미 존재하는 아이디라면 idCheckSw=0으로(신규가입불가) -->
					} else {
						$('#demo').html("");
						idCheckSw = 1;
					}
				},
				error	: function() {
					alert("전송오류");
				}
			});
		});
    });
    
    function fCheck() {
    	// 유효성 검사.....
    	// 아이디,닉네임,성명,이메일,홈페이지,전화번호,비밀번호 등등....
    	
		let regMid = /^[a-zA-Z0-9_]{4,20}$/;
		let regPwd = /(?=.*[0-9a-zA-Z]).{4,20}$/;
		let regName = /^[가-힣a-zA-Z]+$/;
		let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		
		let mid = myform.mid.value.trim();
		let pwd = myform.pwd.value;
		let name = myform.name.value;
		let email = myform.email.value.trim();
		    	
		let submitFlag = 0;		// 모든 체크가 정상으로 종료되게되면 submitFlag는 1로 변경처리될수 있게 한다.
		    	
	    	
    	// 앞의 정규식으로 정의된 부분에 대한 유효성체크
    	if(idCheckSw!=1){
    		$('#demo').html("<font color='red'>이미 존재하는 아이디입니다.</font>");
    		myform.mid.focus();
    		return false;
    	}
    	else if(!regMid.test(mid)) {
    		$('#demo').html("<font color='red'>아이디는 4~20자리의 영문 대/소문자,숫자,언더바(_)만 사용가능합니다.</font>");
    		myform.mid.focus();
    		return false;
    	}
    	else if(!regPwd.test(pwd)) {
    		$('#demo').html("<font color='red'>비밀번호는 1개이상의 문자와 특수문자 조합의 6~24 자리로 작성해주세요.</font>");
	        myform.pwd.focus();
	        return false;
		}
		else if(!regName.test(name)) {
			$('#demo').html("<font color='red'>성명은 한글과 영문대소문자만 사용가능합니다.</font>");
	        myform.name.focus();
	        return false;
		}
		else if(!regEmail.test(email)) {
			$('#demo').html("<font color='red'>이메일 형식에 맞지않습니다.</font>");
	        myform.email.focus();
	        return false;
		}
        else {
	    	submitFlag = 1;
		}
    		// 전송전에 모든 체크가 끝나면 submitFlag가 1로 되게된다. 이때 값들을 서버로 전송처리한다.
		
    	if(submitFlag==1){
			myform.submit();
		}
    	
    }  
    
    //ID중복 체크, 모든 창 내용 작성 후 keyUp일때 가입버튼 활성화
    function joinKeyUp(){
    	let mid = myform.mid.value.trim();
		let pwd = myform.pwd.value;
		let name = myform.name.value;
		let email = myform.email.value.trim();
		if(mid!="" && pwd!="" && name != "" && email!="" && idCheckSw==1){
			$("#btnSubmit").prop("disabled",false);
		}
    }
	</script>
	<style>
		body{
			margin:0 auto;
		}

	 	/* 450px 이상이면 body 상단여백이 200px */
		@media ( min-width : 450px) {
			body {
				margin-top: 7%;
			}
			#bdr{
				border:1px solid #ddd;
			}
		}
	    /* 875xp이하면 id="hidden" */
	    /* id="875px의 최대 넓이가 400px로 변경됩니다."*/
		@media ( max-width : 875px) {
			#hidden {
				display: none;
			}
			#875px{
				max-width:400px;
			}
		}
		img:hover{
			cursor:pointer;
		}
		footer {
		    position: fixed;
		    /* height: 130px; */
		    bottom: 0;
		    width: 100%;
		}
	</style>
</head>
<body>
	<div class="container-fluid p-0">
		<div class="row mx-auto p-0" id="875px" style="max-width:800px">
			<div class="col mx-auto p-0 m-0" style="max-width:400px; height:600px;">
				<div class="row p-0 m-0 justify-content-center" id="bdr" style="width:350px; height:500px;">
					<!-- 로고 -->
					<div class="text-center pt-5" style="height:135px; width:100%">
						<img style="width:175px; vertical-align:middle;" src="${ctp}/images/instagram_text.png"/>
						<div class="m-3">
							<font class="mx-auto ml-3 mr-3" color="#666"><b>친구들의 사진과 동영상을 보려면<br/>가입하세요.</b></font>
						</div>
					</div>
					<!-- 로그인폼 -->
					<form name="myform" id="myform" method="post">
						<div class="mx-auto p-0 m-0" style="width:270px;">
							<div class="row mx-auto p-0 mb-2">
								<div class="col mx-auto p-0 m-0">
									<input type="text" name="mid" id="mid" onkeyup="joinKeyUp()" placeholder="사용자 이름" class="form-control" autofocus required />
								</div>
							</div>
							<div class="row mx-auto p-0 mb-2">
								<div class="col mx-auto p-0 m-0">
									<input type="text" name="name" id="name" onkeyup="joinKeyUp()"  placeholder="성명" class="form-control" required />
								</div>
							</div>
							<div class="row mx-auto p-0 mb-2">
								<div class="col mx-auto p-0 m-0">
									<input type="password" name="pwd" id="pwd" onkeyup="joinKeyUp()"  placeholder="비밀번호" class="form-control" required />
								</div>
							</div>
							<div class="row mx-auto p-0 mb-3">
								<div class="col mx-auto p-0 m-0">
									<input type="text" name="email" id="email" onkeyup="joinKeyUp()"  placeholder="이메일 주소" class="form-control" />
								</div>
							</div>
							<div class="row mx-auto p-0 mb-3">
								<div class="col mx-auto p-0 m-0 text-center">
									<div class="hr-sect"><b>준비되셨나요?</b></div>
								</div>
							</div>
							<div class="row mx-auto p-0 mb-2">
								<div class="col mx-auto p-0 m-0">
									<input type="button" id="btnSubmit" value="가입" onclick="fCheck()" disabled="disabled" class="btn btn-primary form-control" />
								</div>
							</div>
							<div class="row mx-auto text-center">
								<div class="mx-auto text-center" id="demo"></div>
							</div>
						</div>
					</form>
					<!-- 로그인폼끝 -->
				</div>
				<div class="row m-2" style="width:350px;"></div>
				<div class="row p-0 m-0 justify-content-center align-items-center" id="bdr" style="width:350px; height:60px;">
					<span> 계정이 있으신가요 ? <a href="/" class="text-primary">로그인</a> </span>
				</div>
				<div class="row m-2" style="width:350px;"></div>
				<div class="row p-0 m-0 justify-content-center align-items-center" style="width:350px;">
					<span><font color="777">앱을 다운로드하세요</font></span>
				</div>
				<div class="row m-2" style="width:350px;"></div>
				<div class="row p-0 m-0 justify-content-center align-items-center" style="width:350px;">
					<span class="mr-2"><img src="${ctp}/images/googlePlayLink.png" id="download" style="height:40px;"/></span>
					<span><img src="${ctp}/images/msLink.png" id="download" style="height:40px;"/></span>
				</div>
			</div>
		</div>
	</div>
</body>
<footer>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</footer>
</html>