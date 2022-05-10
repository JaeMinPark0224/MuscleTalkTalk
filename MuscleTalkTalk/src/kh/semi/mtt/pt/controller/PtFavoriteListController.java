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
import kh.semi.mtt.ptfavorite.model.service.PtFavoriteService;
import kh.semi.mtt.ptfavorite.model.vo.PtFavoriteVo;

/**
 * Servlet implementation class PtFavoriteListController
 */
@WebServlet("/favoritelist")
public class PtFavoriteListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PtFavoriteListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/favoritelist doGet 방식 호출");
		MemberVo vo = (MemberVo)request.getSession().getAttribute("ssMvo");
		if(vo == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		
		int memberNo = 0;
		ArrayList<PtFavoriteVo> ptFavoriteVoList = null;
		if(request.getSession().getAttribute("ssMvo") != null) {
			try {
				memberNo = ((MemberVo)request.getSession().getAttribute("ssMvo")).getMemberNo();
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
			ptFavoriteVoList = new PtFavoriteService().readAllPtFavorite(memberNo);
		}
		
		
		String pageStr = request.getParameter("page");
		int pageInt = 0;
		if(pageStr == null) {
			response.sendRedirect("favoritelist?page=1");
			return;
		} else {
			try {
				pageInt = Integer.parseInt(pageStr);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		
		int pageSize = 8;
		int pageBlock = 5;
		
		int startPage = 0;
		int endPage = 0;
		int startRnum = 0;
		int endRnum = 0;
		
		int totalCnt = new PtService().countPtFavorite(memberNo);
		
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
		if (pageInt > endPage && pageInt != 1) {
			if(endPage == 0) {
				endPage = 1;
				response.sendRedirect("favoritelist?page=1");
				return;
			}
			response.sendRedirect("favoritelist?page=" + endPage);
			return;
		}
		startRnum = (pageInt - 1) * pageSize + 1;
		endRnum = startRnum + pageSize - 1;
		if (endRnum > totalCnt) {
			endRnum = totalCnt;
		}
		
		ArrayList<PtVo> ptVoList = new PtService().readAllFavoritePt(startRnum, endRnum, memberNo);
		System.out.println("/favoritelist doGet ptVoList 결과:  " + ptVoList);
		System.out.println("/favoritelist doGet ptFavoriteVoList 결과:  " + ptFavoriteVoList);
		request.setAttribute("ptVoList", ptVoList);
		request.setAttribute("ptFavoriteVoList", ptFavoriteVoList);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("startRnum", startRnum);
		request.setAttribute("endRnum", endRnum);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("totalpageCnt", totalpageCnt);
		request.setAttribute("pageInt", pageInt);
		request.getRequestDispatcher("WEB-INF/view/ptpage/favoritelist.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}

}
