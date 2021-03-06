<%@ include file="/WEB-INF/view/font.jsp"%>
<%@ include file="/WEB-INF/view/csslink3_mp.jsp"%>
<%@page import="kh.semi.mtt.member.model.vo.MemberVo"%>
<%@page import="kh.semi.mtt.board.model.vo.BoardVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 콘텐츠 조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	body{
	    width: 1200px;
	    margin: 0 auto;
	    color: rgb(51, 51, 51);
	}
	*{
	    text-decoration: none;
	}
	footer > div > ul{
	    margin-left: 20px;
	    padding: 30px;
	    color: gray;
	    line-height: 15px;
	}
	a {
		color: rgb(51, 51, 51);
	}
</style>
<style>
		#mp_main_text{
            margin: 63px 0px 20px 63px;
            font-size: 15px;
            font-family:'THEmpgtB';
            color: rgb(51, 51, 51);
            line-height: 20px;
            overflow: hidden;
            width: 650px;
        }
        input::placeholder{
        	font-family:'THEmpgtM';
            font-size: 10.5px;
        }
        #edit_btn{
            margin: 50px 80px 100px 630px;
            width: 70px;
            height: 30px;
            background-color: rgb(224, 224, 224);
            color: rgb(64, 64, 64);
            font-size: 10.5px;
            font-family:'THEmpgtM';
            border: 0px;
            cursor: pointer;
        }
		#btn_board_read, #btn_comment_read{
            width: 130px;
            height: 30px;
            font-size: 10.5px;
            font-family: 'THEmpgtR';
            color: #4B4DB2;
            background-color: white;
            border: 1px solid #4B4DB2;
            line-height: 30px;
            float: right;
            cursor: pointer;
            text-align: center;
        }
        #btn_board_read{
            margin-right: 10px;
        }
        #btn_board_read:hover, #btn_comment_read:hover{
            color: white;
            background-color: #4B4DB2;
            border: 1px solid #4B4DB2;
            transition: ease 0.3s;
        }
        #board_table{
            width: 650px;
            margin: 20px auto;
            clear: both;
            border-spacing: 25px;
        }
        .tb{
            padding: 14.5px;
            font-size: 11px;
            font-family: 'THEmpgtM';
        }
        .tb_s{
            padding: 14.5px;
            font-size: 11px;
            font-family: 'THEmpgtR';
        }
        .line{
        	border-top: 1px solid rgb(188, 188, 188);
        }
        #table_title{
			font-family:'THEmpgtM';
            font-size: 11.5px;
        }
        #table_content{
            font-family:'THEmpgtR';
            font-size: 11.5px;
        }
        #pageing_all{
            margin: 45px auto 60px auto;
            text-align: center;
            font-family: 'THEmpgtM';
            font-size: 0px;
        }
        .page{
        	background-color: rgb(236, 236, 236);
        	border-radius: 3px;
        	color: rgb(127, 127, 127);
        	padding: 8px 11px 8px 11px;
        	display: inline-block;
        	margin: 0px 2px;
        	font-size: 10.5px;
        }
        #content_list{
        	text-decoration: underline;
        }
        .npage{
        	cursor: pointer;
        }
        input[type=radio]:nth-of-type(1):checked ~ #buttons > label:nth-of-type(1),
        input[type=radio]:nth-of-type(2):checked ~ #buttons > label:nth-of-type(2) {
        	background-color: #4B4DB2;
        	border: 1px solid #4B4DB2;
            color: white;
        }
        input[type=radio]{
        	display: none;
        }        
</style>
<script>
	/* $(function() {
		$.ajax({
			url:"memberreadcontent.ax",
			type:"post",
			data:{member_id: "${ssMvo.memberId}"},
			dataType:"json",
			success: function(result){
				var html = "";
				for(var i = 0; i < result.memberboard.length; i++){
                    var vo = result.memberboard[i];
                    html += '<tr id="table_content" class="tb">';
                    html += '<td style="width: 10%;" class="tb"><a href="boardread?bno='+vo.boardNo+'">'+vo.boardNo+'</a></td>';
                    html += '<td style="width: 43%;" class="tb"><a href="boardread?bno='+vo.boardNo+'">'+vo.boardTitle+'</a></td>';
                    html += '<td style="width: 25%;" class="tb">'+vo.boardDate+'</td>';
                    html += '<td style="width: 22%;" class="tb">'+vo.boardCount+'</td>';
                    html += '</tr>';
                }
				
				var g = "";
 				if(result.startPage > 1){
					g += '<p class="page" id="beforeP">이전</p>&nbsp;&nbsp;&nbsp;&nbsp;';
				}
				var h = "";
				for(var p = result.startPage; p <= result.endPage; p++){
					h += '<p class="page npage">'+p+'</p>&nbsp;&nbsp;&nbsp;&nbsp;';
				}
				
				var i = "";				
				if(result.endPage < result.totalpageCnt){
					i += '<p class="page" id="nextP">다음</p>';
				}	
				
				
				$("#board_table").append(html);
	            $(".pageing").append(h);
	            $(".pageing").append(i);
				$('.npage').click(page_ax);
				$('#nextP').click(next_ax);
				$('#beforeP').click(before_ax);
				return;
			},
			error: function(result){
				console.log("ajax 오류");
			}
		});
	}) */
	
	/* // 페이지 번호 클릭 시
	function page_ax(){
		console.log("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ");
		$.ajax({
			url: "memberreadcontent.ax",
			type:"post",
			data: {page: $(this).html(),
				member_id: "${ssMvo.memberId}"},
			dataType: "json",
			success: function(result){
				console.log("ㄹㅇㅇㄹㄴㄹ");
				var html = "";
				for(var i = 0; i < result.memberboard.length; i++){
		            var vo = result.memberboard[i];
		            html += '<tr id="table_content" class="tb">';
		            html += '<td style="width: 10%;" class="tb"><a href="boardread?bno='+vo.boardNo+'">'+vo.boardNo+'</a></td>';
		            html += '<td style="width: 43%;" class="tb"><a href="boardread?bno='+vo.boardNo+'">'+vo.boardTitle+'</a></td>';
		            html += '<td style="width: 25%;" class="tb">'+vo.boardDate+'</td>';
		            html += '<td style="width: 22%;" class="tb">'+vo.boardCount+'</td>';
		            html += '</tr>';
		        }
				
				$(".tb_last").nextAll().remove();
				$("#board_table").append(html);
				return;
			},
			error: function(result){
				console.log("ajax 오류");
			}
		})
	}
	
	//다음 버튼 클릭 시
	function next_ax(){
		$.ajax({
			url: "memberreadcontent.ax",
			type:"post",
			data: {page: Number($(".npage").eq(3).html())+1,
				member_id: "${ssMvo.memberId}"},
			dataType: "json",
			success: function(result){
				var html = "";
				for(var i = 0; i < result.memberboard.length; i++){
		            var vo = result.memberboard[i];
		            html += '<tr id="table_content" class="tb">';
		            html += '<td style="width: 10%;" class="tb"><a href="boardread?bno='+vo.boardNo+'">'+vo.boardNo+'</a></td>';
		            html += '<td style="width: 43%;" class="tb"><a href="boardread?bno='+vo.boardNo+'">'+vo.boardTitle+'</a></td>';
		            html += '<td style="width: 25%;" class="tb">'+vo.boardDate+'</td>';
		            html += '<td style="width: 22%;" class="tb">'+vo.boardCount+'</td>';
		            html += '</tr>';
		        }
				$(".tb_last").nextAll().remove();
				$("#board_table").append(html);
				
				var g = "";
				g += '<p class="page" id="beforeP">이전</p>&nbsp;&nbsp;&nbsp;&nbsp;';
				
 				var h = "";
 				for(var i = 0; i < 4; i++) {
 					$('.npage').eq(i).html(Number(result.startPage) + i);
 				}
				for(var p = Number($(".npage").eq(3).html())+1; p < result.endPage; p++){
					h += '<p class="page npage">'+p+'</p>&nbsp;&nbsp;&nbsp;&nbsp;';
				}

				if($('#beforeP').length == 0) {					
					$(".pageing").prepend(g);
				}
				// 다음 버튼 없애기 TODO
				
				$('#beforeP').click(before_ax);
				return;
			},
			error: function(result){
				console.log("ajax 오류");
			}
		})
	}
	
	//이전 버튼 클릭 시
	function before_ax(){
		console.log("이전");
		// 이전 버튼 없애기 TODO
		if(Number($(".npage").eq(0).html()) == 1){
			$("#beforeP").remove();
		}
		$.ajax({
			url: "memberreadcontent.ax",
			type:"post",
			data: {page: Number($(".npage").eq(0).html())-1,
				member_id: "${ssMvo.memberId}"},
			dataType: "json",
			success: function(result){
				var html = "";
				for(var i = 0; i < result.memberboard.length; i++){
		            var vo = result.memberboard[i];
		            html += '<tr id="table_content" class="tb">';
		            html += '<td style="width: 10%;" class="tb"><a href="boardread?bno='+vo.boardNo+'">'+vo.boardNo+'</a></td>';
		            html += '<td style="width: 43%;" class="tb"><a href="boardread?bno='+vo.boardNo+'">'+vo.boardTitle+'</a></td>';
		            html += '<td style="width: 25%;" class="tb">'+vo.boardDate+'</td>';
		            html += '<td style="width: 22%;" class="tb">'+vo.boardCount+'</td>';
		            html += '</tr>';
		        }
				$(".tb_last").nextAll().remove();
				$("#board_table").append(html);
				
				var g = "";
				g += '<p class="page" id="beforeP">이전</p>&nbsp;&nbsp;&nbsp;&nbsp;';
				
 				var h = "";
 				for(var i = 0; i < 4; i++) {
 					$('.npage').eq(i).text(Number(result.startPage) + i);
 				}
				for(var p = Number($(".npage").eq(0).html())-1; p < result.endPage; p++){
					h += '<p class="page npage">'+p+'</p>&nbsp;&nbsp;&nbsp;&nbsp;';
				}

				if($('#beforeP').length == 0) {					
					$(".pageing").prepend(g);
				}
				
				// 이전 버튼 없애기 TODO
				if(Number($(".npage").eq(0).html()) == 1){
					$("#beforeP").css("display", 'none');
				}
				
				return;
			},
			error: function(result){
				console.log("ajax 오류");
			}
		})
	}	 */
		
</script>
</head>
<body>
<c:if test="${empty ssMvo}">
	<jsp:forward page="/WEB-INF/view/member/login.jsp"></jsp:forward>
</c:if>
<%@ include file="/WEB-INF/view/template.jsp"%>
		<section id="section1">
            <div id="mp_main_text">
                <p id="b_title" style="height: 20px; width: 150px; float: left;">
                    내 게시물 조회
                </p>
                <input type="radio" name="menu" id="comment_read">
                <input type="radio" name="menu" id="board_read" checked>
                <div id="buttons">
                	<label for="comment_read" id= "btn_comment_read" class="tab_btn">내 댓글 조회</label>
                	<label for="board_read" id= "btn_board_read"  class="tab_btn">내 게시물 조회</label>
            	</div>
            </div>
            <div>
                <table id="board_table">
                    <tr class="tb" class="line">
                        <td colspan="10" class="line"></td>
                    </tr class="tb">
                    <tr id="table_title" class="tb">
                        <td style="width: 10%;" class="tb">번호</td>
                        <td style="width: 43%;" class="tb">제목</td>
                        <td style="width: 25%;" class="tb">등록일</td>
                        <td style="width: 22%;" class="tb" id="cnt">조회수</td>
                    </tr>
	                <tr class="tb tb_last" class="line">
	                    <td colspan="10" class="line"></td>
	                </tr>
	                
	                <!-- 댓글 -->
	                <c:if test="${not empty membercomment}">
	                	<c:forEach items="${membercomment}" var="volist">
							<tr class="table_content">
								<c:if test="${not empty volist.boardNo}">
									<td style="width: 10%;" class="tb_s">${volist.rCnt}</td>
									<td style="width: 43%;" class="tb_s">>${volist.commentContent}</td>
								</c:if>
								<c:if test="${empty volist.boardNo}">
									<td style="width: 10%;" class="tb_s">${volist.rCnt}</td>
									<td style="width: 43%;" class="tb_s">${volist.commentContent}</td>
								</c:if>
								<td style="width: 25%;" class="tb_s">${volist.commentDate}</td>
								<td style="width: 22%;" class="tb_s"></td>
							</tr>
						</c:forEach>
	                </c:if>
	                
	                <!-- 게시물 -->
	                <c:if test="${not empty memberboard}">
		                <c:forEach items="${memberboard}" var="volist">
		                <!-- 승택님 루틴게시판 끝나면 루틴게시물 자유게시물 상세 읽기 <a href>구분지어주기 TODO -->
							<tr class="table_content">
								<td style="width: 10%;" class="tb_s">${volist.boardR}</td>
								<td style="width: 43%;" class="tb_s"><a href="boardread?bno=${volist.boardNo}">${volist.boardTitle}</a></td>
								<td style="width: 25%;" class="tb_s">${volist.boardDate}</td>
								<td style="width: 22%;" class="tb_s">${volist.boardCount}</td>
							</tr>
						</c:forEach>
					</c:if>	
                </table>
            </div>
            <div id="pageing_all">
                <div class="pageing">
                	<p id="p_c">
                		<c:if test="${not empty membercomment}">
                			<c:if test="${startPage > 1 }">
								<a class="page" href="memberCommentRead?page=${startPage-1 }">이전</a>
							</c:if>
							<c:forEach begin="${startPage }" end="${endPage }" var="p">
								<a class="page" href="memberCommentRead?page=${p }">${p }</a>
							</c:forEach>
							<c:if test="${endPage < totalpageCnt}">
								<a class="page" href="memberCommentRead?page=${endPage+1 }">다음</a>
							</c:if>
                		</c:if>
                		<c:if test="${not empty memberboard}">
							<c:if test="${startPage > 1 }">
								<a class="page" href="memberreadcontent?page=${startPage-1 }">이전</a>
							</c:if>
							<c:forEach begin="${startPage }" end="${endPage }" var="p">
								<a class="page" href="memberreadcontent?page=${p }">${p }</a>
							</c:forEach>
							<c:if test="${endPage < totalpageCnt}">
								<a class="page" href="memberreadcontent?page=${endPage+1 }">다음</a>
							</c:if>
						</c:if>
					</p>
                        
                </div>
            </div>
            <%@ include file="/WEB-INF/view/footer.jsp"%>
        </section>
        <section id="section2">
            <div>
                <c:if test="${not empty ssMvo.memberPhoto}">
	            	<img id="prifile" src="${ssMvo.memberPhoto}">
	            </c:if>
	            <c:if test="${empty ssMvo.memberPhoto}">
	            	<img id="prifile" src="<%= request.getContextPath() %>/cssfolder/images/default_pf.png">
	            </c:if>
                <ul>
                    <li id="member_nickname">${ssMvo.memberNickname}</li>
                    <li id="member_id">${ssMvo.memberId}</li>
                </ul>
                <input type="button" name="logout" id="mp_logout" value="로그아웃">
            </div>
            <div>
                <ul id="mypage_menu">
                    <li id="info_edit">프로필 정보 수정</li>
                    <li id="password_edit">비밀번호 변경</li>
                    <li id="content_list">내 콘텐츠 조회</li>
                    <li id="reservation_list">
                    	<c:if test="${ssMvo.memberTrainer == 'F'}">
                    		예약 프로그램 조회
                    	</c:if>
                    	<c:if test="${ssMvo.memberTrainer == 'R'}">
                    		예약 프로그램 조회
                    	</c:if>
                    	<c:if test="${ssMvo.memberTrainer == 'T'}">
                    		예약 프로그램 조회
                    	</c:if>
                    </li>
                    <li id="to_trainer">
                    	<c:if test="${ssMvo.memberTrainer == 'F'}">
                    		트레이너 계정 전환
                    	</c:if>
                    </li>
                    <li id="program_list">
                    	<c:if test="${ssMvo.memberTrainer == 'T'}">
                    		내 프로그램 조회
                    	</c:if>
                    </li>
                    
                    <li id="inquiry">1:1 문의</li>
                    <li id="withdrawal">탈퇴하기</li>
                </ul>
            </div>
        </section>
<script>
	$("#mp_logout").click(function(){
		alert("로그아웃 되었습니다.");
		location.href="logout";
	})
	$("#info_edit").click(function(){
		location.href="memberupdateprofile";
	})
	$("#password_edit").click(function(){
		location.href="memberupdatepassword";
	})
	$("#info_edit").click(function(){
		location.href="memberupdateprofile";
	})
	$("#content_list").click(function(){
		location.href="memberreadcontent";
	})
	$("#inquiry").click(function(){
		location.href="memberinquiry";
	})
	$("#reservation_list").click(function(){
		location.href="memberreadreservationlist";
	})
	$("#program_list").click(function(){
		location.href="myptprogram";
	})
	$("#withdrawal").click(function(){
		location.href="memberwithdrawalcontroller";
	})
	$("#to_trainer").click(function(){
		location.href="memberswitchaccount";
	})
</script>
<script>
	$("#btn_comment_read").click(function(){
		//내 댓글 조회 클릭 시
		$.ajax({
			url:"memberreadcontent.ax",
			type:"post",
			data:{member_id: "${ssMvo.memberId}", page:1, button:2},
			dataType:"json",
			success: function(result){
				var html = "";
				for(var i = 0; i < result.membercomment.length; i++){
                    var vo = result.membercomment[i];
                    html += '<tr id="table_content" class="tb_s">';
                    if (vo.boardNo > 0) {
                    	html += '<td style="width: 10%;" class="tb_s"><a href="boardread?bno='+vo.boardNo+'">'+vo.rCnt+'</a></td>';
                    	html += '<td style="width: 43%;" class="tb_s"><a href="boardread?bno='+vo.boardNo+'">'+vo.commentContent+'</a></td>';
                    } 
                    else if (vo.boardNo == 0) {
                    	<!-- 승택님 루틴게시판 끝나면 루틴게시물 자유게시물 상세 읽기 <a href>구분지어주기 TODO -->
                		html += '<td style="width: 10%;" class="tb_s"><a href="routineboardread?bno='+vo.routineboardNo+'">'+vo.rCnt+'</a></td>';
                		html += '<td style="width: 43%;" class="tb_s"><a href="routineboardread?bno='+vo.routineboardNo+'">'+vo.commentContent+'</a></td>';
                    }
                    html += '<td style="width: 25%;" class="tb_s">'+vo.commentDate+'</td>';
                    html += '<td style="width: 22%;" class="tb_s"></td>';
                    html += '</tr>';
                }
				
				var g = "";
				if(result.startPage > 1){
					g += '<a class="page" href="memberCommentRead?page=${startPage-1 }">이전</a>';
				}
				var h = "";
				for(var p = result.startPage; p <= result.endPage; p++){
					h += '<a class="page" href="memberCommentRead?page='+p+'">'+p+'</a>';
				}
				var i ="";
				if(result.endPage < result.totalpageCnt){
					i += '<a class="Page" href="memberCommentRead?page=${endPage+1 }">다음</a>';
				}
				
				$("#table_title").next().nextAll().remove();
				$("#board_table").append(html);
				$("#p_c").children('.page').remove();
				$("#p_c").append(g);
				$("#p_c").append(h);
				$("#p_c").append(i);
				$("#cnt").hide();
				
				$("#b_title").text("내 댓글 조회");
				return;
			},
			error: function(result){
				console.log("ajax 오류");
			}
		});
	})
	
	$("#btn_board_read").click(function(){
		//내 게시물 조회 클릭 시
		$.ajax({
			url:"memberreadcontent.ax",
			type:"post",
			data:{member_id: "${ssMvo.memberId}", page:1, button:1},
			dataType:"json",
			success: function(result){
				var html = "";
				for(var i = 0; i < result.memberboard.length; i++){
                    var vo = result.memberboard[i];
                    html += '<tr id="table_content" class="tb_s">';
                    <!-- 승택님 루틴게시판 끝나면 루틴게시물 자유게시물 상세 읽기 <a href>구분지어주기 TODO -->
                    html += '<td style="width: 10%;" class="tb_s">'+vo.boardR+'</td>';
                    html += '<td style="width: 43%;" class="tb_s"><a href="boardread?bno='+vo.boardNo+'">'+vo.boardTitle+'</a></td>';
                    html += '<td style="width: 25%;" class="tb_s">'+vo.boardDate+'</td>';
                    html += '<td style="width: 22%;" class="tb_s">'+vo.boardCount+'</td>';
                    html += '</tr>';
                }
				
				var g = "";
				if(result.startPage > 1){
					g += '<a class="page" href="memberreadcontent?page=${startPage-1 }">이전</a>';
				}
				var h = "";
				if(result.memberboard.length > 0){
					for(var p = result.startPage; p <= result.endPage; p++){
						h += '<a class="page" href="memberreadcontent?page='+p+'">'+p+'</a>';
					}	
				}
				var i ="";
				if(result.endPage < result.totalpageCnt){
					i += '<a class="page" href="memberreadcontent?page=${endPage+1 }">다음</a>';
				}
				
				console.log(result);
				$("#table_title").next().nextAll().remove();
				$("#board_table").append(html);
				$("#p_c").children('.page').remove();
				$("#p_c").append(g);
				$("#p_c").append(h);
				$("#p_c").append(i);
				$("#cnt").show();
				
				$("#b_title").text("내 게시물 조회");
				return;
			},
			error: function(result){
				console.log("ajax 오류");
			}
		});
	})
	</script>
</body>
</html>