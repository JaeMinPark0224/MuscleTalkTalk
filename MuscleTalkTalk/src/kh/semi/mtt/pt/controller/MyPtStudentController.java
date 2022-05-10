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
 * Servlet implementation class MyPtStudentController
 */
@WebServlet("/myptstudent")
public class MyPtStudentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyPtStudentController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/myptstudent 들어옴");
		MemberVo vo = (MemberVo)request.getSession().getAttribute("ssMvo");
		System.out.println(vo);
		if(vo == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		if(vo.getMemberTrainer().equals("F")) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		
		String pageStr = request.getParameter("page");
		int pageInt = 0;
		if(pageStr == null) {
			response.sendRedirect("myptstudent?page=1");
			return;
		} else {
			try {
				pageInt = Integer.parseInt(pageStr);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		
		int pageSize = 10;
		int pageBlock = 5;
		
		int startPage = 0;
		int endPage = 0;
		int startRnum = 0;
		int endRnum = 0;
		
		int totalCnt = new PtCalendarService().countReservation(vo.getTrainerNo());
		
		int totalpageCnt = (totalCnt / pageSize) + (totalCnt % pageSize == 0 ? 0 : 1);
		if (pageInt % pageBlock == 0) {
			startPage = ((pageInt / pageBlock) - 1) * pageBlock + 1;
		} else {
			startPage = (pageInt / pageBlock) * pageBlock + 1;
		}
		endPage = startPage + pageBlock - 1;
		if (endPage > totalpageCnt) {
			endPage = totalpageCnt;
		}
		startRnum = (pageInt - 1) * pageSize + 1;
		endRnum = startRnum + pageSize - 1;
		if (endRnum > totalCnt) {
			endRnum = totalCnt;
		}
		
		ArrayList<PtCalendarVo> ptCalVoList = new PtCalendarService().readMyStudent(vo.getTrainerNo(), startRnum, endRnum);
		request.setAttribute("ptCalVoList", ptCalVoList);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("startRnum", startRnum);
		request.setAttribute("endRnum", endRnum);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("totalpageCnt", totalpageCnt);
		request.setAttribute("pageInt", pageInt);		
		request.getRequestDispatcher("WEB-INF/view/ptpage/myptstudent.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}

}
