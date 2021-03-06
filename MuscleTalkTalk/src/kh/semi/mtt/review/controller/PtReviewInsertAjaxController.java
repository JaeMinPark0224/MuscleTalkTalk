package kh.semi.mtt.review.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kh.semi.mtt.review.model.service.ReviewService;
import kh.semi.mtt.review.model.vo.ReviewVo;

/**
 * Servlet implementation class PtReviewInsertAjaxController
 */
@WebServlet("/reviewinsert.ax")
public class PtReviewInsertAjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PtReviewInsertAjaxController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/reviewinsert.ax 들어옴");
		PrintWriter out = response.getWriter();
		
		String ptNoStr = request.getParameter("ptNo");
		String memberNoStr = request.getParameter("memberNo");
		String reviewContent = request.getParameter("reviewContent");
		int ptNo = 0;
		int memberNo = 0;
		try {
			ptNo = Integer.parseInt(ptNoStr);
			memberNo = Integer.parseInt(memberNoStr);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		ReviewVo rVo = new ReviewVo();
		rVo.setMemberNo(memberNo);
		rVo.setPtNo(ptNo);
		rVo.setReviewContent(reviewContent);
		rVo.setReviewNo(0);
		int result = new ReviewService().insertReview(rVo);
		if (result == 1 ) {
			rVo = new ReviewService().readOneReview(rVo);
			if(rVo.getMemberPhoto() == null) {
				rVo.setMemberPhoto("null");
			}
		} else {
			out.print("fail");
			out.flush();
			out.close();
			return;
		}
		Gson gobj = new GsonBuilder().setPrettyPrinting().create();
		String jsonOut = gobj.toJson(rVo);
		out.print(jsonOut);
		
		out.flush();
		out.close();
	}

}
