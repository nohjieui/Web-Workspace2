<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gloock&family=Noto+Sans+KR:wght@300&family=Poppins:wght@700&display=swap" rel="stylesheet">

<title>Insert title here</title>
<style>
	*{
		font-family: 'Gloock', serif;
		letter-spacing: 1.5px;
	}
	h1{margin-top: 20px;}
	#login-form, #user-info{float: right}
	#login-form{margin-right: 25px;}
	#login-form th{padding-top: 8px;}
	#login-form input{
		border: none;
		border-bottom: 1px solid black;
		width: 160px;
	}
	#login-form button{
		border: none;
		background: none;
	}
	#user-info a{
		text-decoration: none;
		color: black;
		font-size: 12px;
	}
	.nav-area{background: white;}
	.menu{
		display: table-cell; /* 인라인 요소처럼 배치 가능 */
		height: 50px;
		width: 150px;
	}
	.menu a{
		text-decoration: none;
		color: black;
		font-size: 20px;
		font-weight: bold;
		display: block;
		width: 100%;
		height: 100%;
		
		line-height: 50px; /* 위 아래에서 가운데로 조정 */
	}
	.menu a:hover{
		border-bottom : 1px solid darkgray;
	}
	.outer{
	background: white;
	color: white;
	width: 1000px;
	margin: auto;
	margin-top: 50px;
	}
</style>
</head>
<body>
	<h1 align="center">My Project</h1>
	
	<div class="Login-area">
	
		<form id="login-form" action="<%= request.getContextPath() %>/login.me" method="post">
			<table>
				<tr>
					<th>Id</th>
					<td><input type="text" name="userId" required></td>
				</tr>
				<tr>
					<th>Pw</th>
					<td><input type="password" name="userPwd" required></td>
				</tr>
				<tr align="right">
					<th colspan="2">
						<button>Login</button>
						<button type="button" onclick="enrollPage();">Join</button>
					</th>
				</tr>
			</table>
		</form>
	</div>

	
	<br clear="both"> <!-- float 속성 해제 -->
	<br>
	
	<div class="nav-area" align="center">
		<div class="menu"><a href="<%= contextPath %>">Home</a></div>
		<div class="menu"><a href="<%= contextPath %>/list.no">Notice</a></div>
		<div class="menu"><a href="<%= contextPath %>/list.bo?currentPage=1">Board</a></div>
		<div class="menu"><a href="<%= contextPath %>/list.th">P-Board</a></div>
	</div>

</body>
</html>