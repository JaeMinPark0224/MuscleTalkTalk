<%@ include file="/WEB-INF/view/font.jsp"%>
<%@ include file="/WEB-INF/view/csslink3_mp.jsp"%>
<%@page import="kh.semi.mtt.member.model.vo.MemberVo"%>
<%@page import="kh.semi.mtt.inquiry.model.vo.InquiryVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 상세 조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	body{
	    width: 1200px;
	    margin: 0 auto;
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
	#member_info_read{
		margin-bottom: 100px;
	}
</style>
<style>
	#section1{
            margin-left: 210px;
            background-color: white;
            border-radius: 10px 10px 0 0;
            width: 780px;
            float: left;
            font-size: 12px;
            font-family:'THEmpgtM';
        }
	#mp_main_text{
            margin: 63px 0px 60px 63px;
            font-size: 15px;
            font-family:'THEmpgtB';
            color: rgb(51, 51, 51);
            line-height: 20px;
            overflow: hidden;
            width: 650px;
        }
        #ul_list{
            width: 660px;
            margin-left: 130px;
            line-height: 15px;
        }
        .iq_menu{
            float: left;
            clear: both;
            font-family:'THEmpgtB';
            text-align: center;
            margin: 30px 45px 20px 10px;
            width: 50px;
            text-align: left;
        }
        #i_title{
        	float: left;
            clear: both;
            font-family:'THEmpgtB';
            text-align: center;
        	margin: 30px 45px 0px 10px;
        	width: 50px;
            text-align: left;
        }
        .iq_info{
            float: left;
            font-family:'THEmpgtR';
            text-align: center;
            width: 400px;
            margin: 30px 5px 45px 5px;
            letter-spacing: 0.5px;
            text-align: left;
        }
        #br{
            clear: both;
            width: 465px;
            padding: 15px;
            border-top: 1px solid lightgray;
            margin-left: 10px;
        }
        #ok_btn{
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
        input::placeholder{
        	font-family:'THEmpgtM';
            font-size: 10.5px;
        }
        #inquiry{
        	text-decoration: underline;
        }
</style>
</head>
<body>
<c:if test="${empty ssMvo}">
	<jsp:forward page="/WEB-INF/view/member/login.jsp"></jsp:forward>
</c:if>
<% InquiryVo ivo = (InquiryVo)request.getAttribute("ivo"); %>
<%@ include file="/WEB-INF/view/template.jsp"%>
		<section id="section1">
            <div id="mp_main_text">
                <p style="height: 20px; width: 150px; float: left;">
                    문의 상세 조회
                </p>
            </div>
            <div>
                <ul id="ul_list">
                    <li id="i_title">문의 제목</li>
                    <li class="iq_info">${ivo.inquiryTitle}</li>
                    <li class="iq_menu">문의 내용</li>
                    <li class="iq_info">${ivo.inquiryContent}</li>
                    <div id="br"></div>
                    <li class="iq_menu">답변</li>
                    <c:if test="${not empty ivo.inquiryAnswer}">
						<li class="iq_info">${ivo.inquiryAnswer}</li>
					</c:if>
					<c:if test="${empty ivo.inquiryAnswer}">
						<li class="iq_info">아직 등록된 답변이 없습니다.</li>
					</c:if>
                </ul>
            </div>
            <input type="button" value="확인" id="ok_btn">
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
	$("#ok_btn").click(function(){
		location.href="memberinquiry";
	})
</script>
</body>
</html>