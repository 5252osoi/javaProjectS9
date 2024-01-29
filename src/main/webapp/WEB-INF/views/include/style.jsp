<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
@import url('https://fonts.googleapis.com/css?family=Poppins&display=swap');
*{
    font-family: 'poppins', sans-serif;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    list-style: none;
    text-decoration: none;
}
body{
    letter-spacing: 0.5px;
}
footer {
    position: absolute;
    height: 50px;
    margin-top: 150px; 
    width: 100%;
}
a:hover{
	cursor:pointer;
	color: #CCC;
	text-decoration: none;
}
::-webkit-scrollbar{
    width: 8px;
}
::-webkit-scrollbar-track{
	background-color: #dddddd;
}
::-webkit-scrollbar-thumb{
	background-color: #888888;
}
:root{
    --gradient: linear-gradient(to right, #e2336b, #fcac46);
}

.sidebar {
    position: fixed;
    width: 245px;
    height: 100vh;
    padding: 20;
    z-index: 1000;
   /*  background-color: grey; */
    border-right: 1px solid #ddd;
}
.rightside{
	width:300px;
	margin-left:85px;
}
.logo img{
	position:absolute;
    width:105px;
    margin-top: 2.3rem;
    margin-left: 1.6rem;
}
.logoicon i{
	position:absolute;
    margin-top: 2rem;
    margin-left: 1.6rem;
}
.profile{
    display: flex;
    align-items: center;
    flex-direction: column;
    justify-content: center;
    margin-top: 1.4rem;
}
.profile-img{
    display: flex;
    align-items: center;
    justify-content: center;
/*     border-radius: 50%;
    width: 25px;
    height: 25px;
    border: 2px solid #e2336b;  */
}
.profile-img img{
    width: 25px;
    height: 25px;
    object-fit: cover;
    border-radius: 50%;
    object-position: center;
}
.name{
    display: flex;
    align-items: center;
    margin: 1rem 0 0.4rem;
}
.name h1{
    font-size: 1.1rem;
}
.name img{
    margin-left: 4px;
    width: 20px;
    object-fit: cover;
}
.navbar{
	margin-top:100px;
	width:100%;
}
.navbar-nav{
	width:100%
}
.nav-item{
	width:100%
}
.nav-item button{
	background-color:white;
	border:none;
	height:45px;
	width:97%;
	margin: 0 auto;
	margin-bottom:10px;
}
.btn-light{
	background-color: white;
	border:none;
}
.btn-main{
	margin:0;
	padding:0;
	text-align:center;
}
/*버튼 내부 폰트 사이즈*/

.btntext{
	font-size:11pt;
}
i {
	font-size:22pt;
}
.sidebar .bottom-nav{
	position:fixed;
	bottom:0;
	max-width: 245px;
}
/*hr태그안에 글쓰기*/
.hr-sect {
	display: flex;
	flex-basis: 100%;
	align-items: center;
	color: rgba(0, 0, 0, 0.35);
	font-size: 12px;
	margin: 8px 0px;
}
.hr-sect::before,
.hr-sect::after {
	content: "";
	flex-grow: 1;
	background: rgba(0, 0, 0, 0.35);
	height: 1px;
	font-size: 0px;
	line-height: 0px;
	margin: 0px 16px;
}
/*글작성시 모달창css*/
.modal-dialog,
.modal-content {
	height:80vh;
}
/*모달창css끝*/
.modal-body {
    /* 100% = dialog height, 120px = header + footer */
    max-height: calc(100% - 55px);
}
.modaltable{
	height:100%;
}
/*메인화면css*/
.main {
    width: 100%;
    padding: 40px 0;
    margin-left:45px;
    display: flex;
    justify-content: center;
    margin-left: 50px; 
}

.wrapper {
    width: 70%;
    max-width: 1000px;
    display: grid;
    grid-template-columns: 75% 25%;
    grid-gap: 20px;
    margin:0 auto;
}

.left-col {
    display: flex;
    flex-direction: column;
    margin:0 auto;
}

.status-wrapper {
    width: 600px;
    height: 120px;
    background: #fff;
   /*  border: 1px solid #dfdfdf;
    border-radius: 10px; */
    padding: 10px;
    padding-right: 0;
    display: flex;
    align-items: center;
    overflow: hidden;
    overflow-x: auto;
    margin: 0 auto;
}

.status-wrapper::-webkit-scrollbar {
    display: none;
}

.status-card {
    flex: 0 0 auto;
    width: 70px;
    max-width: 70px;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-right: 10px;
    margin-top: 15px;
}

.profile-pic {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    overflow: hidden;
    padding: 3px;
    background: linear-gradient(45deg, rgb(255, 230, 0), rgb(255, 0, 128) 80%);
}

.profile-pic img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 50%;
    border: 2px solid #fff;
}

.username {
    width: 100%;
    overflow: hidden;
    text-align: center;
    font-size: 12px;
    margin-top: 5px;
    color: rgba(0, 0, 0, 0.5);
}
/* Story Section End */

/* Post Section Start */
.post  {
    width: 100%;
    max-width:470px;
    height: auto;
    background: #fff;
   /*  border: 1px solid #dfdfdf; */
    margin-top: 20px;
    margin: 0 auto;
}

.info{
    width: 100%;
    height: 60px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 20px;
}

.info .username {
    width: auto;
    font-weight: bold;
    color: #000;
    font-size: 14px;
    margin-left: 10px;
}

.info .options {
    height: 10px;
    cursor: pointer;
}

.info .user {
    display: flex;
    align-items: center;
}

.info .profile-pic {
    height: 40px;
    width: 40px;
    padding: 0;
    background: none;
}

.info .profile-pic img{
    border: none;
}

.post-image{
    width: 100%;
    height: 500px;
    object-fit: cover;
}

.carousel-inner img {
	width: 100%;
	height: 100%;
}

.post-content{
    width: 100%;
    padding: 20px;
}

.likes{
    font-weight: bold;
}

.description{
    margin: 10px 0;
    font-size: 14px;
    line-height: 20px;
}

.description span{
    font-weight: bold;
    margin-right: 10px;
}

.post-time{
    color: rgba(0, 0, 0, 0.5);
    font-size: 12px;
}

.comment-wrapper{
    width: 100%;
    height: 50px;
    border-radius: 1px solid #dfdfdf;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom:0;
}

.comment-wrapper .icon{
    height: 30px;
}

.comment-box{
    width: 80%;
    height: 100%;
    border: none;
    outline: none;
    font-size: 14px;
}

.comment-btn,
.action-btn{
    width: 70px;
    height: 100%;
    background: none;
    border: none;
    outline: none;
    text-transform: capitalize;
    font-size: 16px;
    color: rgb(0, 162, 255);
    opacity: 0.5;
}

.reaction-wrapper{
    width: 100%;
    height: 50px;
    display: flex;
    margin-top: -20px;
    align-items: center;
}

.reaction-wrapper .icon{
    height: 25px;
    margin: 0;
    margin-right: 20px;
}

.reaction-wrapper .icon.save{
    margin-left: auto;
}

.post2  {
    width: 100%;
    height: auto;
    background: #fff;
    border: 1px solid #dfdfdf;
    margin-top: 10px;
}
/* Post Section End */


/* Sidebar Section Start */
.right-col{
    padding: 20px;
    width:300px;
}

.profile-card{
    width: fit-content;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 10px;
}

.profile-card .profile-pic{
    flex: 0 0 auto;
    padding: 0;
    background: none;
    width: 40px;
    height: 40px;
    margin-right: 10px;
}

.profile-card:first-child .profile-pic{
    width: 70px;
    height: 70px;
}

.profile-card .profile-pic img{
    border: none;
}

.profile-card .username{
    font-weight: 500;
    font-size: 14px;
    color: #000;
    text-align: start;
}

.sub-text{
    color: rgba(0, 0, 0, 0.5);
    font-size:12px;
    font-weight: 500;
    margin-top: -10px;
}

.action-btn{
    opacity: 1;
    font-weight: 700;
    font-size: 12px;
}

.suggestion-text{
    font-size: 14px;
    color: rgba(0, 0, 0, 0.5);
    font-weight: 700;
    margin: 20px 0;
}

/* 아이디 hover 시 modal창 띄우기 */
.username {
    position: relative;
    overflow: hidden;
}

.username:hover {
    opacity: 0.8;
    cursor: pointer;
}

</style>