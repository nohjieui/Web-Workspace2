<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<input type="text" id="sender" size="10" placeholder="보내는 이름">
	<input type="text" id="receiver" size="10" placeholder="받는사람 이름">
	<input type="text" id="msg" placeholder="전송할 메세지 입력">
	<button onclick="sendMsg();">전송</button>
	
	<div id="msgContainer">
	
	</div>
	
	<script>
		// 웹소켓 서버에 연결
		// WebSocket 객체 생성하기 학원 : 192.168.30.174 / 집 : 192.168.0.16
		// const socket = new WebSocket("ws://ip:port/<%= request.getContextPath() %>/chatting.do");
		const socket = new WebSocket("ws://192.168.30.174:8082/<%= request.getContextPath() %>/chatting.do");
		const socket = new WebSocket("ws://192.168.30.174:8082/<%= request.getContextPath() %>/chatting2.do");
		// https://ip:포트번호/~~
		// http -> ws:~
		// https -> wss:~
		
		// socket 설정하기
		// 1. 접속 후 실행되는 이벤트 핸들러 등록
		socket.onopen = function(e){
			console.log("접속 성공");
			console.log(e);
		}
		
		// 2. 웹소켓 서버에서 sendText, sendObject메소드를 실행하면 실행되는 함수
		socket.onmessage = function(e) {
			console.log("메세지 수신");
			// 수신된 데이터를 받으려면 이벤트객체(e)의 data속성을 이용해야함
			console.log(e);
			console.log(e.data);
			
			/* /chatting.do */
// 			let msg = e.data.split(",");
// 			if(msg[0] == $("#sender").val()){
// 				$("#msgContainer").append( $("<p>").text("<"+msg[0]+">"+msg[2]).css("text-align","left") );
// 			}else{
// 				$("#msgContainer").append( $("<p>").text("<"+msg[1]+">"+msg[2]).css("text-align","right") );
// 			}

			/* /chatting2.do */
			// Object형태의 String데이터를 객체로 변환해주기(JSONObject)
			console.log(JSON.parse(e.data));
			
			let msg = JSON.parse(e.data);
			if(msg["sender"] == $("#sender").val()){
				$("#msgContainer").append( $("<p>").text("<"+msg["sender"]+">"+msg["msg"]).css("text-align", "left") );
			}else{
				$("#msgContainer").append( $("<p>").text("<"+msg["sender"]+">"+msg["msg"]).css("text-align", "right") );
			}
			
		}
		
		// 3. 웹소켓 서버에서 메세지를 전송하는 함수
		const sendMsg = () => {
			// 전송할 메세지 전처리
			// 전처리한 메세지를 전송하는 방법 : socket.send(데이터);
			// 천처리를 어떻게? 객체화 시켜줄것임 -> 발송자, 수신자, 메세지내용 형태로
			/* /chatting.do */
// 			socket.send( $("#sender").val() + "," + $("#receiver").val() + "," + $("#msg").val() );
			
			/* /chatting2.do */
// 			let msg = {
// 						sender : $("#sender").val(),
// 						receiver : $("#receiver").val(),
// 						msg : $("#msg").val()
// 						};
			let msg = new Message($("#sender").val(), $("#receiver").val(), $("#msg").val());
			
			// socket.send(msg.toString()); // [object Object] : toString()오버라이딩
			socket.send(JSON.stringify(msg));
		};
		
		function Message(sender, receiver, msg){
			// this = {}
			
			this.sender = sender;
			this.receiver = receiver;
			this.msg = msg;
			
			// return this;
		}
	
	</script>
</body>
</html>