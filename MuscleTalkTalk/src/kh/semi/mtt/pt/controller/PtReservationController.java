package kh.semi.mtt.pt.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.mtt.member.model.vo.MemberVo;
import kh.semi.mtt.pt.model.service.PtService;
import kh.semi.mtt.pt.model.vo.PtVo;
import kh.semi.mtt.ptcalendar.model.service.PtCalendarService;
import kh.semi.mtt.ptcalendar.model.vo.PtCalendarVo;

/**
 * Servlet implementation class PtReservationController
 */
@WebServlet("/ptreservation")
public class PtReservationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PtReservationController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberVo mVo = (MemberVo)request.getSession().getAttribute("ssMvo");
		if(mVo == null) {
			response.sendRedirect(request.getContextPath());
			return;
		}
		String ptNoStr = request.getParameter("ptNo");
		int ptNo = -1;
		try {
			ptNo = Integer.parseInt(ptNoStr);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		PtVo pVo = new PtService().readPt(ptNo);
		ArrayList<PtCalendarVo> ptCalList = null;
		ptCalList = new PtCalendarService().readAllReservation(ptNo);
		request.setAttribute("ptCalList", ptCalList);
		request.setAttribute("pVo", pVo);
		request.getRequestDispatcher("WEB-INF/view/ptpage/ptcalendar.jsp").forward(request, response);
	}

}
