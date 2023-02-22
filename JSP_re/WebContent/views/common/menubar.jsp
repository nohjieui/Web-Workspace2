<%@ page import="com.kh.member.model.vo.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();

	Member loginUser = (Member)session.getAttribute("loginUser");

	String alertMsg = (String)session.getAttribute("alertMsg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome C Class</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	#login-form, #user-info{float: right}
	#user-info a{
		text-decoration: none;
		color: black;
		font-size: 12px;
	}
	.nav-area{background: black;}
	.menu{
		display: table-cell; /* 인라인 요소처럼 배치 가능 */
		height: 50px;
		width: 150px;
	}
	.menu a{
		text-decoration: none;
		color: white;
		font-size: 20px;
		font-weight: bold;
		display: block;
		width: 100%;
		height: 100%;
		
		line-height: 50px; /* 위 아래에서 가운데로 조정 */
	}
	.menu a:hover{
		background: darkgray;
	}
	.outer{
	background: black;
	color: white;
	width: 1000px;
	margin: auto;
	margin-top: 50px;
	}
</style>
</head>
<body>
	<script>
		const msg = "<%= alertMsg %>"
		if(msg != "null"){ // "성공적으로 로그인이 되었습니다." / "null"
			alert(msg);
			// 알람창을 띄워준 후 session에 담긴 메세지는 지워줘야함
			// 안그러면 menubar.jsp가 로딩될때마다 매번 alert함수가 실행됨
			<% session.removeAttribute("alertMsg"); %>
		}
	</script>
	<h1 align="center">Welcome C Class</h1>
	
	<div class="loginarea">
		
		<% if(loginUser == null) { %>
		<!-- 로그인 이전에만 보여지는 로그인 form -->
		<form id="login-form" action="<%= contextPath %>/login.me" method="post">
			<table>
				<tr>
					<td>아이디 : </td>
					<td><input type="text" name="userId" required></td>
				</tr>
				<tr>
					<td>비밀번호 : </td>
					<td><input type="password" name="userPwd" required></td>
				</tr>
				<tr>
					<th colspan="2">
						<button>로그인</button>
						<button type="button" onclick="enrollPage();">회원가입</button>
					</th>
				</tr>
			</table>
		</form>
		<script>
			function enrollPage() {
				// url 설정
				location.href = "<%= contextPath %>/enrollForm.me";
			}
		</script>
		<% } else { %>
			<!-- 로그인 성공 후 -->
			<div id="user-info">
				<b><%= loginUser.getUserName() %></b>님 환영합니다. <br><br>
				<div align="center">
					<a href="<%= contextPath %>/mypage.me">마이페이지</a>
					<a href="<%= contextPath %>/logout.me">로그아웃</a>
				</div>
			</div>
		<% } %>
	</div>

	
	<br clear="both">
	<br>
	
	<div class="nav-area" align="center">
		<div class="menu"><a href="<%= contextPath %>">HOME</a></div>
		<div class="menu"><a href="<%= contextPath %>/list.no">공지사항</a></div>
		<div class="menu"><a href="<%= contextPath %>/list.bo?currentPage=1">일반게시판</a></div>
		<div class="menu"><a href="<%= contextPath %>/list.th">사진게시판</a></div>
	</div>
</body>
</html>