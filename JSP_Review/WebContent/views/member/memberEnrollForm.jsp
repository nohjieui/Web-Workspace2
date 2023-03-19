<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	#enrollForm button{margin: 10px}
</style>
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	'*'표시 항목은 필수 입력 항목입니다. <br>
	<form id="enrollForm" action="<%= request.getContextPath() %>/insert.me" method="post">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="userName" required>&nbsp;*</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="userId" required>&nbsp;* <input type="button" value="중복체크"></td>
			</tr>
			<tr>
				<td>암호</td>
				<td><input type="password" name="userPwd" required>&nbsp;*</td>
			</tr>
			<tr>
				<td>암호확인</td>
				<td><input type="password" required>&nbsp;*</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email">&nbsp;</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="phone">&nbsp;</td>
			</tr>
			<tr>
				<td>등급</td>
				<td>
					<input type="radio" name="grade" id="member" value="일반회원">
					<label for="member">일반회원</label>
					<input type="radio" name="grade" id="admin" value="관리자">
					<label for="admin">관리자</label>
				</td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<button type="submit">확인</button>
					<button type="reset">취소</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>