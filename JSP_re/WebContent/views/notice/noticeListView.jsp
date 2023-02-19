<%@ page import="com.kh.notice.model.vo.Notice, java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 리스트 조회 페이지</title>
<style>
	.list-area{
		border: 1px solid white;
		text-align: center;
	}
	.list-area>tbody>tr:hover{
		background: gray;
		cursor: pointer;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<div class="outer">
		<br>
		<h2 align="center">공지사항</h2>
		<br>
		<% if(loginUser != null && loginUser.getUserId().equals("admin")){ %>
			<div align="right" style="width: 850px">
				<!-- 글작성 url -> servlet 넘긴 후 
					enrollForm.no서블릿은 따로 작업할거 x 
					뷰페이지 보이도록 JSP 위임 -->
				<a href="<%= contextPath %>/enrollForm.no" class="btn btn-secondary" >글작성</a>
			</div>
		<%} %>

		<table class="list-area" align="center">
			<thead>			
				<tr>
					<th>글번호</th>
					<th width="400">글제목</th>
					<th width="100">작성자</th>
					<th>조회수</th>
					<th width="100">작성일</th>
				</tr>
			</thead>
			<tbody>
			<% if(list.isEmpty()){ %>
				<tr>
					<td colspan="5">존재하는 공지사항이 없습니다.</td>
				<tr>			
			<%} else { %>
				<% for(Notice n : list){ %>					
					<tr>
						<td><%= n.getNoticeNo() %></td>
						<td><%= n.getNoticeTitle() %></td>
						<td><%= n.getNoticeWriter() %></td>
						<td><%= n.getCount() %></td>
						<td><%= n.getCreateDate() %></td>
					</tr>
				<%} %>	
			<%} %>
			</tbody>
		</table>
	</div>
</body>
</html>