package kh.semi.mtt.ptcalendar.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import static kh.semi.mtt.common.jdbc.JdbcTemplate.*;

import kh.semi.mtt.payment.model.dao.PaymentDao;
import kh.semi.mtt.ptcalendar.model.dao.PtCalendarDao;
import kh.semi.mtt.ptcalendar.model.vo.PtCalendarVo;

public class PtCalendarService {
	private PtCalendarDao dao = new PtCalendarDao();
	
	public ArrayList<PtCalendarVo> readAllReservation(int ptNo) {
		ArrayList<PtCalendarVo> ptCalList = null;
		Connection conn = null;
		conn = getConnection();
		
		ptCalList = dao.readAllReservation(conn, ptNo);
		System.out.println("PtCalendarService readAllReservation()매소드 결과: " + ptCalList);
		
		close(conn);
		return ptCalList;
	}
	
	public int insertReservation(int ptCalendarNo, int memberNo) {
		int result = 0;
		Connection conn = null;
		conn = getConnection();
		
		result = dao.insertReservation(conn, ptCalendarNo, memberNo);
		System.out.println("PtCalendarService insertReservation()매소드 결과: " + result);
		
		close(conn);
		return result;
	}
	
	public ArrayList<PtCalendarVo> readMyStudent(int trainerNo, int startRnum, int endRnum) {
		ArrayList<PtCalendarVo> ptCalList = null;
		Connection conn = null;
		conn = getConnection();
		
		ptCalList = dao.readMyStudent(conn, trainerNo, startRnum, endRnum);
		System.out.println("PtCalendarService readMyStudent()매소드 결과: " + ptCalList);
		
		close(conn);
		return ptCalList;
	}
	
	public int countReservation(int trainerNo) {
		int result = 0;
		Connection conn = null;
		conn = getConnection();
		
		result = dao.countReservation(conn, trainerNo);
		System.out.println("PtCalendarService countReservation()매소드 결과: " + result);
		
		close(conn);
		return result;
	}
	
	public int reviewReservation(int memberNo, int ptNo) {
		int result = 0;
		Connection conn = null;
		conn = getConnection();
		
		result = dao.reviewReservation(conn, memberNo, ptNo);
		System.out.println("PtCalendarService reviewReservation()매소드 결과: " + result);
		
		close(conn);
		return result;
	}
	
	public int updateReservation(int prevPtCalendarNo, int ptCalendarNo, int memberNo) {
		int result = 0;
		Connection conn = null;
		conn = getConnection();
		setAutocommit(conn, false);
		result = dao.updatePrevReservation(conn, prevPtCalendarNo);
		if (result != 1) {
			rollback(conn);
			return 0;
		}
		result = dao.insertReservation(conn, ptCalendarNo, memberNo);
		if (result != 1) {
			rollback(conn);
			return 0;
		}
		result = new PaymentDao().updatePayment(conn, prevPtCalendarNo, ptCalendarNo);
		if (result != 1) {
			rollback(conn);
			return 0;
		}
		commit(conn);
		System.out.println("PtCalendarService updateReservation()매소드 결과: " + result);
		
		close(conn);
		return result;
	}
	
	public ArrayList<PtCalendarVo> readMyReservation(int memberNo) {
		ArrayList<PtCalendarVo> ptCalList = null;
		Connection conn = null;
		conn = getConnection();
		
		ptCalList = dao.readMyReservation(conn, memberNo);
		System.out.println("PtCalendarService readMyReservation()매소드 결과: " + ptCalList);
		
		close(conn);
		return ptCalList;
	}
	
	public ArrayList<PtCalendarVo> readTrainerReservation(int trainerNo) {
		ArrayList<PtCalendarVo> ptCalList = null;
		Connection conn = null;
		conn = getConnection();
		
		ptCalList = dao.readTrainerReservation(conn, trainerNo);
		System.out.println("PtCalendarService readTrainerReservation()매소드 결과: " + ptCalList);
		
		close(conn);
		return ptCalList;
	}
	
	public PtCalendarVo readOneReservation(int ptCalendarNo) {
		PtCalendarVo ptCalList = null;
		Connection conn = null;
		conn = getConnection();
		
		ptCalList = dao.readOneReservation(conn, ptCalendarNo);
		System.out.println("PtCalendarService readOneReservation()매소드 결과: " + ptCalList);
		
		close(conn);
		return ptCalList;
	}
	
}
