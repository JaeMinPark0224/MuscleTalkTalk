<%@ include file="/WEB-INF/view/csslink2.jsp" %>
<%@page import="kh.semi.mtt.member.model.vo.TrainerVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin-trainer</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ include file="/WEB-INF/view/font.jsp" %>

<style>
section{
font-family:'THEmpgtM';
}
a, a:visited, a:link{
    color: rgb(94, 94, 94);
}
.menu>ul>li {
	display: list-item;
	text-align: center;
	padding-top: 12px;
}
#li_6 {
	text-decoration: underline;
}
/* #memeber_main {
	padding-top: 65px;
	padding-bottom: 15px;
	margin-left: 65px;
	font-weight: bold;
	display: inline-block;
	margin-bottom: 0;
	font-size: 15px;
} */

#memeber_table {
	margin: 20px auto;
	width: 650px;
	font-size: 12px;
	clear: both;
}
.board_top{
	position: relative;
}
#sort {
	width: 105px;
	height: 30px;
	margin-top: 10px;
	margin-bottom: 0px;
	margin-right: 65px;
	float: right;
	font-size: 12px;
	position: absolute;
	bottom: 0;
	right: 0;
	border-color: rgb(200, 200, 200);
	color: #404299;
	border-radius: 3px;
	font-family: 'THEmpgtM'
}
 #memeber_main {
	padding-top: 65px;
	margin-left: 65px;
	font-weight: bold;
	display: inline-block;
	padding-bottom: 15px;
	font-size: 15px;
} 

#memeber_top_button{
	padding-top: 65px;
	margin-bottom: 0;
	float: right;
	position: absolute;
    bottom: 0;
    right: 0;
}
#write_btn {
	color: white;
	border: 1px solid white;
	background-color: #4B4DB2;
	width: 152px;
	height: 30px;
	line-height: 30px;
	font-size: 12px;
	margin-right: 65px;
	cursor: pointer;

}
#write_btn:hover{
	color: #4B4DB2;
	background-color: white;
	border: 1px solid #4B4DB2;
}

#board_category {
	padding-top: 65px;
	margin-right: 65px;
	float: right;
	font-size: 12px;
}




#btn_search {
	height: 27px;
	width: 63px;
	font-size: 12px;
	padding: 12px auto;
	float: right;
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

#input_search:focus {
	outline: none;
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

.table_content td:first-child {
	width: 60px;
	padding-left: 10px;
	box-sizing: border-box;
}

.search_memeber {
	display: inline-block;
	float: right;
	margin-right: 65px;
}

#pageing_all {
	margin: 45px auto 20px auto;
	text-align: center;
	font-family: 'THEmpgtM';
	font-size: 0px;
}

.page {
	background-color: rgb(236, 236, 236);
	border-radius: 3px;
	color: rgb(127, 127, 127);
	padding: 8px 11px 8px 11px;
	display: inline-block;
	margin: 0px 2px;
	font-size: 10.5px;
}

.npage{
	cursor: pointer;
}

</style>

</head>
<body>
	<%
		TrainerVo vo = (TrainerVo) request.getAttribute("tvo");
	%>
	<%@ include file="/WEB-INF/view/template.jsp" %>
	<section id="section1">
		<div class="board_top">
			<div id="memeber_main">???????????? ??????</div>
			<select id="sort">
				<option class="Filter" name="Filter" value="1">?????????</option>
				<option class="Filter" name="Filter" value="2">?????? ????????????</option>
				<option class="Filter" name="Filter" value="3">???????????? N</option>
			</select>
		</div>
		<table id="memeber_table">
			<tr>
				<td colspan="6" class="table_line"></td>
			</tr>
			<tr id="table_title">
				<td class="first_col" style="width: 10%;"></td>
				<td style="width: 15%;">???????????????</td>
				<td style="width: 15%;">??????????????????</td>
				<td style="width: 20%;">?????????</td>
				<td style="width: 20%;">???????????????(???)</td>
				<td style="width: 20%;">????????????</td>
			</tr>
			<tr>
				<td colspan="6" class="table_line"></td>
			</tr>						 
			<c:forEach var="vo" items="${trainerreadall}">
				<tr class="table_content">
					<td>${vo.rownum}</td>
					<td><a href="admintrainerread?TrainerNo=${vo.trainerNo}">${vo.memberNickname }</a></td>
					<td><a href="admintrainerread?TrainerNo=${vo.trainerNo}">${vo.trainerNo}</a></td>
					<td>${vo.memberJoinDate}</td>
					<td>${vo.sumPrice}</td>
					<td>${vo.trainerConfirm}</td>
				</tr>
			</c:forEach>
		</table>
		<div id="pageing_all">
			<div class="Pageing">
				<p>
					<c:if test="${startPage > 1 }">
						<a class="Page" href="admintrainer?page=${startPage-1 }">??????</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					<c:forEach begin="${startPage }" end="${endPage }" var="p">
						<a class="Page" href="admintrainer?page=${p }">${p }</a>&nbsp;&nbsp;&nbsp;&nbsp;
					</c:forEach>
					<c:if test="${endPage < totalPageCnt }">
						<a class="Page" href="admintrainer?page=${endPage+1 }">??????</a>
					</c:if>
				<p>
			</div>
		</div>
		<div class="search_memeber">
				<button type="button" id="btn_search">??????</button>
				<input id="input_search" type="text" name="searchInput" 
					placeholder="???????????????">
		</div>
		
	</section>
	<section id="section2">
		<div class="profile">
			<c:if test="${not empty ssMvo.memberPhoto}">
            	<img id="prifile" src="${ssMvo.memberPhoto}">
            </c:if>
            <c:if test="${empty ssMvo.memberPhoto}">
            	<img id="prifile" src="<%= request.getContextPath() %>/cssfolder/images/default_pf.png">
            </c:if>
		</div>
		<div class="my_info">
			<div id="member_nickname">${ssMvo.memberNickname}</div>
			<div id="member_id">${ssMvo.memberId}</div>
		</div>
		<div class="logout">
			<input type="button" name="mp_logout" id="mp_logout" value="????????????">
		</div>
		<div class="menu">
			<ul>
				<li id="li_1"><a href="dashboard">????????????</a></li>
				<li id="li_2"><a href="adminboard">????????? ??????</a></li>
				<li id="li_3"><a href="admincomment">?????? ??????</a></li>
				<li id="li_4"><a href="adminnotice">???????????? ??????</a></li>
				<li id="li_5"><a href="adminmember">?????? ??????</a></li>
				<li id="li_6"><a href="admintrainer">???????????? ??????</a></li>
				<li id="li_7"><a href="admininquiry">?????? ??????</a></li>
			</ul>
		</div>
	</section>
	<script>
	$("#btn_search").click(function(){
		console.log("btn_search CLICK");
		$.ajax({
			url:"memeberreadall",
			type:"post",
			data:{inputsearch:$("#input_search").val()},
			dataType:"json",
			success: function(result){
				console.log(result);
				var html = "";
				for(var i = 0; i < result.memeberreadall.length; i++){
                    var vo = result.memeberreadall[i];
                    html += '<tr class="table_content">';
                    html += '<td><a href="memeberread?memeberNo='+vo.memeberNo+'">'+vo.memeberNo+'</a></td>';
                    html += '<td><a href="memeberread?memeberNo='+vo.memeberNo+'">'+vo.notiTitle+'</a></td>';
                    html += '<td>'+vo.notiDate+'</td>';
                    html += '</tr>';
                }
				$("#table_title").next().nextAll().remove();
				$("#memeber_table").append(html);
			},
			error: function(result){
				
			}
		});
	});
	
	for(var i = 0; i < $('.Page').length; i++) {
		if($('.Page').eq(i).text() == '${currentPage}') {
			$('.Page').eq(i).css({
				backgroundColor : '#4B4DB2',
				color : 'white'
			})
		}
	}
	
	$("#mp_logout").click(function(){
    	alert("???????????? ???????????????.");
    	location.href="logout";
    });
	</script>
	<%@ include file="/WEB-INF/view/footer.jsp" %>
	
	
</body>
</html>