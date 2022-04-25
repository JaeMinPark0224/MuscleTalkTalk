<%@page import="kh.semi.mtt.notice.model.vo.NoticeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice Read</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
<%
	NoticeVo vo = (NoticeVo)request.getAttribute("nvo");
	/* if(vo!=null){ */
%>
	<p><%= vo.getNotiTitle() %></p>
	<p><%= vo.getNotiContent() %></p>
<%-- <%
if(vo.getbFilePath() != null && ! vo.getbFilePath().equals("")){
%>	
	<img src = "<%= request.getContextPath() %>/<%=vo.getbFilePath() %>" width="300">
<%} %>	
	<hr>
	<c:if test= "${not empty bvo.bFilePath}">
	<img src="${pageContext.request.contextPath}/${bvo.bFilePath}" width="300">
	</c:if>
	<hr> --%>
 	<button onclick="location.href='noticeupdate?noticeNo=${nvo.noticeNo}'">수정</button> 
 	<button onclick="location.href='noticedelete?noticeNo=${nvo.noticeNo}'">삭제</button> 
	


</body>
</html>