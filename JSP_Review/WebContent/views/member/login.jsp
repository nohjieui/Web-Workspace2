<%@ page import="com.kh.member.model.vo.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	String alertMsg = (String)session.getAttribute("alertMsg");
 	Member loginUser = (Member)session.getAttribute("loginUser");
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
<title>Insert title here</title>
</head>
<body>
	<c:set var="contextPath" value="<%= request.getContextPath() %>" />
	<script>
		const msg = "<%= alertMsg %>";
		
		if(msg != "null"){ // "성공적으로 로그인이 되었습니다." / "null"
			alert(msg);
			// 알람창을 띄워준 후 session에 담긴 메세지는 지워줘야함
			// 안그러면 menubar.jsp가 로딩될때마다 매번 alert함수가 실행됨
			<% session.removeAttribute("alertMsg"); %>
		}
	</script>
	
	<div class="Login-area">
<%-- 		<% if(loginUser == null) { %> --%>
		<c:choose>
			<c:when test="${empty loginUser }">
			
			
			<h1 >로그인</h1>
				<form id="login-form" action="${ contextPath }/login.me" method="post">
					<table>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="userId" required></td>
						</tr>
						<tr>
							<th>암호</th>
							<td><input type="password" name="userPwd" required></td>
						</tr>
						<tr align="center">
							<th colspan="2">
								<button>로그인</button>
								<button>취소</button>
								<button type="button" onclick="enrollPage();">회원가입</button>
							</th>
						</tr>
					</table>
				</form>
				<script>
					function enrollPage(){
						location.href = "${ contextPath }/enrollForm.me";
					}
				</script>
			</c:when>
			<c:otherwise>
				<div id="user-info">
					<h1>회원 전용 페이지</h1>
					안녕하세요. ${loginUser.userName }(${loginUser.userId })님 <br><br>
					<div>
						<button type="button" onclick="logoutPage();">로그아웃</button>
						<button type="button" onclick="myPage();">마이페이지</button>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<script>
		function logoutPage() {
			location.href = "${ contextPath }/logout.me";
		}
		function myPage() {
			location.href = "${ contextPath }/update.me";
		}
	</script>
</body>
</html>