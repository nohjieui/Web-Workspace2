<%@ page import="com.kh.member.model.vo.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String contextPath = request.getContextPath();
	Member loginUser = (Member)session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userId = loginUser.getUserId();
		String userName = loginUser.getUserName();
		String phone = loginUser.getPhone();
		String email = loginUser.getEmail();
		String grade = loginUser.getGrade();
	%>
	<h1>회원 수정</h1>
	<form id="enroll-form" action="<%= contextPath %>/update.me" method="post">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="userName" required value="<%= userName %>"></td>
				<td></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="userId" required readonly value="<%= userId %>"></td>
				<td></td>
			</tr>
			<tr>
				<td>암호</td>
				<td><input type="password" name="userPwd" required>&nbsp;*</td>
				<td></td>
			</tr>
			<tr>
				<td>암호확인</td>
				<td><input type="password" required>&nbsp;*</td>
				<td></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" value="<%= email == null ? "" : email %>">&nbsp;</td>
				<td></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="phone" value="<%= phone == null ? "" : phone %>">&nbsp;</td>
				<td></td>
			</tr>
			<tr>
				<td>등급</td>
				<td>
					<input type="radio" name="grade" id="member" value="일반회원">
					<label for="member">일반회원</label>
					<input type="radio" name="grade" id="admin" value="관리자">
					<label for="admin">관리자</label>
				</td>
				<td></td>
			</tr>
			<tr align="center">
				<td colspan="3">
					<button type="submit">확인</button>
					<button type="reset">취소</button>
				</td>
			</tr>
		</table>
		
		<script>
			$(function() {
				let grade = "<%= grade == null ? "" : grade %>";
				
				if(grade.search($(this).val()) >= 0){ // interest 문자열로부터 현재 체크박스의 value가 포함되어 있는지 확인
					$(this).attr("checked", true);
				}

				
			});	
		</script>
	</form>
</body>
</html>