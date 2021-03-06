package kh.semi.mtt.inquiry.model.service;

import static kh.semi.mtt.common.jdbc.JdbcTemplate.*;
import java.sql.Connection;
import java.util.ArrayList;

import kh.semi.mtt.board.model.dao.BoardDao;
import kh.semi.mtt.board.model.vo.BoardVo;
import kh.semi.mtt.comment.model.vo.CommentVo;
import kh.semi.mtt.inquiry.model.dao.InquiryDao;
import kh.semi.mtt.inquiry.model.vo.InquiryVo;

public class InquiryService {
	private InquiryDao dao = new InquiryDao();
	
	public ArrayList<InquiryVo> readOneMemberInquiry(int startRnum, int endRnum, String memberId){
		Connection conn = null;
		conn = getConnection();
		
		ArrayList<InquiryVo> result = dao.readOneMemberInquiry(conn, startRnum, endRnum, memberId);
		close(conn);
		return result;
	}
	
	public InquiryVo readinquiry(String memberId, String inquiryTitle) {
		Connection conn = null;
		conn = getConnection();
		
		InquiryVo ivo = dao.readinquiry(conn, memberId, inquiryTitle);
		close(conn);
		return ivo;
	}
	
	public InquiryVo readInquiryAdmin(String inquiryTitle, int inquiryNo) {
		Connection conn = null;
		conn = getConnection();
		
		InquiryVo ivo = dao.readInquiryAdmin(conn, inquiryNo);
		close(conn);
		return ivo;
	}
	
	
	public int insertInquiry(int memberNo, String inqTitle, String inqContent) {
		Connection conn = null;
		conn = getConnection();
		
		int result = dao.insertInquiry(conn, memberNo, inqTitle, inqContent);
		close(conn);
		return result;
	}
	
	
	// 한 명의 회원 문의 카운트 (서유빈)
	public int countInquiry_member(String memberId) {
		Connection conn = null;
		conn = getConnection();
				
		int result = dao.countInquiry_member(conn, memberId);
		close(conn);
		return result;
	}
		
	//문의전부읽기 이진정
	public ArrayList<InquiryVo> readAllInquiry(int startRnum, int endRnum, String memberId){
		Connection conn = null;
		conn = getConnection();
		
		ArrayList<InquiryVo> result = dao.readAllInquiry(conn, startRnum, endRnum, memberId);
		close(conn);
		return result;
	}
	
	//답변하기 이진정
	public int answerInquiry( InquiryVo vo) {
		Connection conn = null;
		conn = getConnection();
		
		int result = dao.answerInquiry(conn, vo);
		close(conn);
		return result;
	}
	
	//문의 갯수새기 (이진정)
	public int countInquiry() {
		Connection conn = null;
		conn = getConnection();
		int result = dao.countInquiry(conn);
		close(conn);
		return result;
	}
}
