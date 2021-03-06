package kh.semi.mtt.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kh.semi.mtt.board.model.service.BoardService;
import kh.semi.mtt.board.model.vo.BoardVo;
import kh.semi.mtt.common.function.PagingController;
import kh.semi.mtt.common.function.PagingVo;
import kh.semi.mtt.notice.model.service.NoticeService;




/**
 * Servlet implementation class BoardReadAllControllerServlet
 */
@WebServlet("/BoardReadAll")
public class BoardReadAllControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BoardService service = new BoardService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardReadAllControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		int currentPage = 1;
		int filter = 0;
		
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
		totalCnt = countBoard();
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
		startRnum = totalCnt - (currentPage - 1) * pageSize; 
		endRnum = startRnum - pageSize + 1;
		if (endRnum < 1) {
			endRnum = 1;
		}
		//검색기능 미완
		String search = request.getParameter("inputsearch");
		exec(request, response, search);

		//
		System.out.println("rnum:" + startRnum + "~" + endRnum);
		ArrayList<BoardVo> result = service.readAllBoard(endRnum, startRnum,filter, search);
		System.out.println(result);
		request.setAttribute("boardreadall", result);
		request.setAttribute("startPage", startPage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totalpageCnt", totalpageCnt);
		System.out.println("boardreadall: "+result);
		request.getRequestDispatcher("WEB-INF/view/board/board.jsp").forward(request, response);
	
	}

		private int countBoard() {
			int result = service.countBoard();
			return result;
		}
		private HttpServletRequest exec(HttpServletRequest request, HttpServletResponse response, String search) {
			int filter = 0;
			HttpServletRequest resultRequest = null;
			int totalCnt = new NoticeService().countNotice();
			PagingVo setVo = new PagingVo(10, 5, request.getParameter(""), request.getParameter("page"), totalCnt);
			PagingVo pageVo = new PagingController().setPagingValue(setVo);
			System.out.println("pageVo:" + pageVo);

			pageVo.setSearch(search);
			ArrayList<BoardVo> result = service.readAllBoard(pageVo.getStartRnum(), pageVo.getEndRnum(),filter, pageVo.getSearch());
			System.out.println(result);
			
			request.setAttribute("boardreadall", result);
			request.setAttribute("startPage", pageVo.getStartPage());
			request.setAttribute("endPage", pageVo.getEndPage());
			request.setAttribute("totalpageCnt", pageVo.getTotalpageCnt());
			request.setAttribute("currentPage", pageVo.getCurrentPage());
			
			return request;
		}


//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
//	}
}
