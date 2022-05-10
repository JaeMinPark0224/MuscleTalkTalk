package kh.semi.mtt.mypage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.mtt.board.model.service.BoardService;
import kh.semi.mtt.board.model.vo.BoardVo;
import kh.semi.mtt.inquiry.model.service.InquiryService;
import kh.semi.mtt.member.model.vo.MemberVo;
import kh.semi.mtt.reservation.model.service.ReservationService;
import kh.semi.mtt.reservation.model.vo.ReservationVo;

/**
 * Servlet implementation class MemberReadReservationList
 */
@WebServlet("/memberreadreservationlist")
public class MemberReadReservationList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberReadReservationList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberVo ssMvo = (MemberVo)request.getSession().getAttribute("ssMvo");
		int memberNo = ssMvo.getMemberNo();
		int currentPage = 1;

		String currentPageStr = request.getParameter("page");
		try {
			if(currentPageStr !=null && !currentPageStr.equals("")) {
				currentPage = Integer.parseInt(currentPageStr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		final int pageSize = 8; // 한페이지에 보여줄 행
		final int pageBlock = 4; // 페이징에 나타날 페이지수
		int startPage = 0;
		int endPage = 0;
		int startRnum = 0;
		int endRnum = 0;
		
		int totalCnt = 0; // 회원의 총 게시물 수
		totalCnt = countReservation_member(memberNo);
		System.out.println("총" + totalCnt);
		
		// Paging 처리
		int totalpageCnt = (totalCnt / pageSize) + (totalCnt % pageSize == 0 ? 0 : 1);
		if (currentPage % pageBlock == 0) {
			startPage = ((currentPage / pageBlock) - 1) * pageBlock + 1;
		} else {
			startPage = (currentPage / pageBlock) * pageBlock + 1;
		}
		endPage = startPage + pageBlock - 1;
		if (endPage > totalpageCnt) {
			endPage = totalpageCnt;
		}
		System.out.println("page:" + startPage + "~" + endPage);

		// rownum 처리
		startRnum = (currentPage - 1) * pageSize + 1;
		endRnum = startRnum + pageSize - 1;
		if (endRnum > totalCnt) {
			endRnum = totalCnt;
		}
		
		System.out.println("rnum:" + startRnum + "~" + endRnum);
		ArrayList<ReservationVo> volist = new ReservationService().readOneMemberReservation(startRnum, endRnum, memberNo);
		System.out.println(volist);
		request.setAttribute("memberreservation", volist);
		request.setAttribute("startPage", startPage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totalpageCnt", totalpageCnt);
		
		request.getRequestDispatcher("WEB-INF/view/testsyb/mypage_reservationList_read.jsp").forward(request, response);
	}
	private int countReservation_member(int memberNo) {
		int result = new ReservationService().countReservation_member(memberNo);
		return result;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}

}
