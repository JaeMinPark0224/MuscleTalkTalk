<%@ include file="/WEB-INF/view/csslink2.jsp" %>
<%@page import="kh.semi.mtt.board.model.vo.BoardVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>템플릿 테스트</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ include file="/WEB-INF/view/font.jsp" %>

<style>
section{
font-family:'THEmpgtM';
}
a{
      text-decoration: none;
      color: black;
}
a:visited {
      text-decoration: none;
      color: black;
}
a:link{
      text-decoration: none;
      color: black;
} 
.menu>ul>li {
	display: list-item;
	text-align: center;
	padding-top: 12px;
}
#board_main {
	padding-top: 65px;
	padding-bottom: 15px;
	margin-left: 65px;
	font-weight: bold;
	display: inline-block;
	margin-bottom: 0;
	font-size: 15px;
}

#board_table {
	margin: 20px auto;
	width: 650px;
	font-size: 12px;
}

.table_line {
	background: gray;
	background-clip: content-box;
	height: 1px !important;
}

#table_title {
	height: 38px;
	line-height: 38px;
}

.table_content {
	height: 50px;
	line-height: 50px;
}

.table_content :first-child {
	width: 60px;
	padding-left: 10px;
	box-sizing: border-box;
}
#btn_read_all, #btn_read_all_report{
        width: 130px;
        height: 30px;
        font-size: 12px;
        color: white;
        background-color: #4B4DB2;
        border: 1px solid #4B4DB2;
        line-height: 30px;
    }
#btn_read_all:hover, #btn_read_all_report:hover{
	color: #4B4DB2;
	background-color: white;
	border: 1px solid #4B4DB2;
}
.btn_readall_readallreport{
	text-align: right;
    float: right;
    margin-right: 65px;
    display: inline-block;
    margin-bottom: 0;
    position: absolute;
    bottom: 0;
    right: 0;
}
.board_top{
	position: relative;
}

.Pageing {
	text-align: center;
	display: inline-blick;
}

.Pageing a {
	border: 1px solid #4B4DB2;
}

.Pageingclick {
	background-color: #4B4DB2;
}

.Page {
	width: 30px;
	height: 30px;
	box-sizing: content-box;
}
.page_serch{
	display: inline-blick;
	overflow: hidden;
	margin-right: 65px;
	position: relative;
}
.search_board{
	display: inline-block;
	float: right;
	position: relative;
	margin-right: 65px;
}
#btn_search {
	height: 27px;
	width: 63px;
	font-size: 12px;
	padding: 12px auto;
	float: right;
	cursor: pointer;
	position: absolute;
	bottom:0;
	right:0;
}

#input_search {
	height: 24px;
	width: 203px;
	margin-top: 2.5px;
	margin-right: 10px;
	float: right;
	font-size: 12px;
}

#input_search::placeholder {
	font-size: 12px;
}

</style>
<script>

	$(function() {
		$("#btn_read_all_report").click(function(){
			console.log("btn_read_all_report CLICK");
			$.ajax({
				url:"adminboard",
				type:"post",
				data:{filters: "4"},
				dataType:"json",
				success: function(result){
					console.log(result);
				},
				error: function(result){
					console.log("ajax 오류");
				}
			});
		});
	});
	
</script>
</head>
<body>
	<%
		BoardVo vo = (BoardVo) request.getAttribute("bvo");
	%>
	<%@ include file="/WEB-INF/view/template.jsp" %>
	<section id="section1">
		<div class="board_top">
			<div id="board_main">게시물 관리</div>
			<div class="btn_readall_readallreport">
	            <button type="button"  id="btn_read_all">전체 게시물 조회</button>
	            <button type="button"  id="btn_read_all_report">신고 게시물 조회</button>
	        </div>
		</div>
		<table id="board_table">
			<tr>
				<td colspan="5" class="table_line"></td>
			</tr>
			<tr id="table_title">
				<td class="first_col"></td>
				<td style="width: 50%;">&nbsp;&nbsp;&nbsp;&nbsp;제목</td>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;등록일</td>
				<td>조회수</td>
				<td>&nbsp;게시판명</td>
			</tr>
			<tr>
				<td colspan="5" class="table_line"></td>
			</tr>
			<c:forEach items="${boardreadall}" var="vo">
				<tr class="table_content">
					<td><a href="boardread?bno=${vo.boardNo}">${vo.boardNo }</a></td>
					<td><a href="boardread?bno=${vo.boardNo }">${vo.boardTitle }</a></td>
					<td>${vo.boardDate }</td>
					<td>&nbsp;&nbsp;&nbsp;${vo.boardCount }</td>
					<td>
						<c:if test="${vo.boardCategoryNumber == 1}">
							자유게시판
						</c:if>
						<c:if test="${vo.boardCategoryNumber == 2}">
							루틴게시판
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div class="page_search">
			<div class="Pageing">
					<c:if test="${startPage > 1 }">
						<a class="Page" href="BoardReadAll?page=${startPage-1 }">이전</a>&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					<c:forEach begin="${startPage }" end="${endPage }" var="p">
						<a class="Page" id="xxx" href="BoardReadAll?page=${p }">${p }</a>&nbsp;&nbsp;&nbsp;&nbsp;
					</c:forEach>
					<c:if test="${endPage < totalpageCnt}">
						<a class="Page" href="BoardReadAll?page=${endPage+1 }">다음</a>
					</c:if>
			</div>
				<div class="search_board">
					<form>
						<input id="input_search" type="text" name="s" value=""
							placeholder="검색어입력">
						<button type="submit" id="btn_search">검색</button>
					</form>
				</div>
		</div>
	
	</section>
	<section id="section2">
		<div class="profile">
			<img src="">
			<div id="camera">
				<img src="<%=request.getContextPath()%>/cssfolder/images/camera.png">
			</div>
		</div>
		<div class="my_info">
			<div>Admin</div>
			<div>admin 2</div>
		</div>
		<div class="logout">
			<button>로그아웃</button>
		</div>
		<div class="menu">
			<ul>
				<li id="li_1">대시보드</li>
				<li id="li_2">게시물 관리</li>
				<li id="li_3">댓글 관리</li>
				<li id="li_4">공지사항 관리</li>
				<li id="li_5">회원 관리</li>
				<li id="li_6">트레이너 관리</li>
				<li id="li_7">문의 확인</li>
			</ul>
		</div>
	</section>
	
	<%@ include file="/WEB-INF/view/footer.jsp" %>
	
	
</body>
</html>