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

<style>
	#enrollForm button{margin: 10px}
</style>
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	'*'표시 항목은 필수 입력 항목입니다. <br>
	<form id="enroll-form" action="<%= contextPath %>/insert.me" method="post">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="userName" required>&nbsp;*</td>
				<td></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="userId" required>&nbsp;* </td>
				<td><button type="button" onclick="idCheck();">중복확인</button></td>
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
				<td><input type="text" name="email">&nbsp;</td>
				<td></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="phone">&nbsp;</td>
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
				<td></td>
			</tr>
		</table>
	</form>
	<script>
	function idCheck(){
		// 아이디를 입력하는 input요소 얻어오기
		const $userId = $("#enroll-form [name=userId]");
		// name이 userId인 요소가 menuber.jsp에서도 존재하므로, 확실하게 어디에 속해있는지 설정해줘야함
		
		// 비동기 요청 보내기
		$.ajax({
			url : "<%= contextPath %>/idCheck.me",
			data : { checkId : $userId.val() },
			success : function(result){
				console.log(result);

				// 이미 존재하는 아이디인 경우
				if(result == $userId.val()){
					alert("이미 존재하거나 회원탈퇴한 아이디입니다.");
					$userId.focus();
				}
				// 사용 가능한 경우
				else {
					if(confirm("사용가능한 아이디입니다. 사용하시겠습니까?")){
						// 아이디값 수정할 수 없게 막기
						$userId.prop('readonly', true);
						// 회원가입 버튼 활성화
						$("#join").prop('disabled', false);
					}else{
						$userId.val("");
						$userId.focus();
					}
				}
			},
			error : function(){
				console.log("아이디 중복체크 실패")
			}
		})
	}
	</script>
</body>
</html>