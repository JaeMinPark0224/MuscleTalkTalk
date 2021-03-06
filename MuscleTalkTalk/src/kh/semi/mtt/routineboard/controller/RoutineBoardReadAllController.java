package kh.semi.mtt.routineboard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.semi.mtt.routineboard.model.service.RoutineBoardService;
import kh.semi.mtt.routineboard.model.vo.RoutineBoardVo;

/**
 * Servlet implementation class RoutineBoardInsertController
 */
@WebServlet("/routineboardreadall")
public class RoutineBoardReadAllController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RoutineBoardService service = new RoutineBoardService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RoutineBoardReadAllController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int currentPage = 1;
		
		String currentPageStr = request.getParameter("page");
		try {
			if(currentPageStr !=null && !currentPageStr.equals(""))
			currentPage = Integer.parseInt(currentPageStr);
		}catch (NumberFormatException e) {
			e.printStackTrace();
		}

		final int pageSize = 13; // 한페이지에 보여줄 행
		final int pageBlock = 3; // 페이징에 나타날 페이지수
		int startPage = 0;
		int endPage = 0;
		int startRnum = 0;
		int endRnum = 0;

		int totalCnt = 0; // 총 글수
		totalCnt = countRoutineBoard();
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
		//검색기능 미완
		String search_ = request.getParameter("s");
		String search = "";
		if(search_ != null) {
			search = search_; 
		}
		//
		System.out.println("rnum:" + startRnum + "~" + endRnum);
		ArrayList<RoutineBoardVo> result = service.readAllRoutineBoard(startRnum, endRnum);
		System.out.println(result);
		request.setAttribute("routineboardreadall", result);
		request.setAttribute("startPage", startPage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totalpageCnt", totalpageCnt);
		System.out.println("routineboardreadall: "+result);
		
		
		request.getRequestDispatcher("WEB-INF/view/routineboard/routineboard.jsp").forward(request, response);
		
		
	}
	private int countRoutineBoard() {
		int result = service.countRoutineBoard();
		return result;
	}

	
	
	
	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
//	}

}
