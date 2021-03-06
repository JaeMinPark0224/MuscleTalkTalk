package kh.semi.mtt.comment.model.dao;

import static kh.semi.mtt.common.jdbc.JdbcTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kh.semi.mtt.comment.model.vo.CommentVo;
import kh.semi.mtt.member.model.vo.AdminVo;
import kh.semi.mtt.member.model.vo.MemberVo;

public class CommentDao {
	
	private Statement stmt = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	
	public int writeBoardReComment(Connection conn, CommentVo vo,MemberVo mvo) {
		// TODO: member 로그인 완료 후 수정
		int memberNo = 13;
		int result = 0;
		
		String sql = "insert into tb_comment (COMMENT_NO, BOARD_NO, MEMBER_NO, COMMENT_DATE, COMMENT_EDIT_DATE, COMMENT_CONTENT)" + " values"
				+ "((select nvl(max(COMMENT_NO),0)+1 from tb_comment)" + ",?"
				+ ",?" + ",sysdate,sysdate,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 지정
			pstmt.setInt(1, vo.getBoardNo()); 
			pstmt.setInt(2, mvo.getMemberNo());
			pstmt.setString(3, vo.getCommentContent());

			// sql문 실행
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	public int writeRoutineBoardReComment(Connection conn, CommentVo vo,MemberVo mvo) {
		// TODO: member 로그인 완료 후 수정
		int memberNo = 13;
		int result = 0;
		
		String sql = "insert into tb_comment (COMMENT_NO, routine_board_no, MEMBER_NO, COMMENT_DATE, COMMENT_EDIT_DATE, COMMENT_CONTENT)values"
				+ "	((select nvl(max(COMMENT_NO),0)+1 from tb_comment),?"
				+ "	,?,sysdate,sysdate,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 지정
			pstmt.setInt(1, vo.getRoutineboardNo()); 
			pstmt.setInt(2, mvo.getMemberNo());
			pstmt.setString(3, vo.getCommentContent());

			// sql문 실행
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	
	public ArrayList<CommentVo> readRoutineBoardReComment(Connection conn, int routineboardNo){
		ArrayList<CommentVo> rvolist = null;
		String sql = "		select rownum r, t1.* from(select comment_no, routine_board_no, member_nickname, comment_content, comment_date, comment_edit_date "
				+ "				from tb_comment \r\n"
				+ "				join tb_member on tb_comment.member_no = tb_member.member_no "
				+ "				where routine_board_no = ? order by comment_date desc) t1 "
				+ "				order by r desc";
		
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, routineboardNo);
				rs = pstmt.executeQuery();
				rvolist = new ArrayList<CommentVo>();
				
				while(rs.next()) { 
					CommentVo vo = new CommentVo();
					vo.setBoardNo(rs.getInt("routine_BOARD_NO"));
					vo.setCommentContent(rs.getNString("COMMENT_CONTENT"));
					vo.setCommentNo(rs.getInt("COMMENT_NO"));
					vo.setCommentDate(rs.getTimestamp("COMMENT_DATE"));
					vo.setCommentEditDate(rs.getTimestamp("COMMENT_EDIT_DATE"));
					vo.setMemberNickname(rs.getString("MEMBER_NICKNAME"));
					vo.setRownum(rs.getInt("r"));
					rvolist.add(vo);  
				} 
			} catch (SQLException e) {
			
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
			
			return rvolist;
		}
		
	
	
	
	

	
	public ArrayList<CommentVo> readBoardReComment(Connection conn, int boardNo){
		ArrayList<CommentVo> volist = null;
//		String sql = "select * from tb_comment where BOARD_NO = ?";  //이 테이블에서 b_no는 fk임
//		select comment_no, board_no, member_nickname, comment_content, comment_date, comment_edit_date
//	    from tb_comment join tb_member on tb_comment.member_no = tb_member.member_no where board_no = 1;
		String sql = "select rownum r, t1.* from(select comment_no, board_no, member_nickname, comment_content, comment_date, comment_edit_date "
				+ "from tb_comment "
				+ "join tb_member on tb_comment.member_no = tb_member.member_no "
				+ "where board_no = ? order by comment_date desc) t1 "
				+ "order by r desc";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			rs = pstmt.executeQuery();
			volist = new ArrayList<CommentVo>();
			
			while(rs.next()) { // fk임 -결과가 1개이상 반복문 사용
				CommentVo vo = new CommentVo();
				vo.setBoardNo(rs.getInt("BOARD_NO"));
				vo.setCommentContent(rs.getNString("COMMENT_CONTENT"));
				vo.setCommentNo(rs.getInt("COMMENT_NO"));
				vo.setCommentDate(rs.getTimestamp("COMMENT_DATE"));
				vo.setCommentEditDate(rs.getTimestamp("COMMENT_EDIT_DATE"));
				vo.setMemberNickname(rs.getString("MEMBER_NICKNAME"));
				vo.setRownum(rs.getInt("r"));
				volist.add(vo);  //리턴 변수에 값 채우기
			} 
		} catch (SQLException e) {
		
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return volist;
	}
	
	public ArrayList<CommentVo> readAllComment(Connection conn, int startRnum, int endRnum, String search){
		ArrayList<CommentVo> volist = null;
		String sql = "select * "
				+ "    from(select rownum r, tta.*"
				+ "        from (select tc.*, member_nickname "
				+ "            from tb_comment tc"
				+ "            left outer join tb_member tm on tc.member_no = tm.member_no"
				+ "            order by comment_no desc) tta)"
				+ "            where r between ? and ?"
				+ "            order by r desc";
		if(search != null ) {
			sql = "select * "
				+ "    from(select rownum r, tta.*"
				+ "        from (select tc.*, member_nickname "
				+ "            from tb_comment tc"
				+ "            left outer join tb_member tm on tc.member_no = tm.member_no"
				+ "            order by comment_no desc) tta)"
				+ "            where r between ? and ?"
				+ "	and (comment_content like ?"
				+ " or member_nickname like ?)"
				+ "            order by r desc";
		}
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRnum);
			pstmt.setInt(2, endRnum);
			if(search != null) {
				pstmt.setString(3, "%"+search+"%");
				pstmt.setString(4, "%"+search+"%");
			}
			rs = pstmt.executeQuery();
			if (rs != null) {
				volist = new ArrayList<CommentVo>();
				
				while (rs.next()) {
					CommentVo vo = new CommentVo();
					vo.setBoardNo(rs.getInt("BOARD_NO"));
					vo.setRoutineboardNo(rs.getInt("routine_board_no"));
					vo.setCommentContent(rs.getNString("COMMENT_CONTENT"));
					vo.setCommentNo(rs.getInt("COMMENT_NO"));
					vo.setCommentDate(rs.getTimestamp("COMMENT_DATE"));
					vo.setCommentEditDate(rs.getTimestamp("COMMENT_EDIT_DATE"));
					vo.setMemberNickname(rs.getString("MEMBER_NICKNAME"));
					vo.setRownum(rs.getInt("r"));
					volist.add(vo);  //리턴 변수에 값 채우기
					
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return volist;
	}
	
	public int countComment(Connection conn) {
		int result = 0;
		String sql = "select count(*) count from tb_comment";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("count"); // 별칭 없이 1 이라고해도됨(1번컬럼)
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return result;
		
	}
	
	//dashboard 숫자세기 (진정)
	public ArrayList<AdminVo> dashboardComment(Connection conn){
		ArrayList<AdminVo> volist = null;
		String sql = "select count(*) dcnt, sysdate Dateval from tb_comment where comment_date <= sysdate"
				+ "    union select count(*) dcnt, sysdate-1 Dateval from tb_comment where comment_date <= sysdate - 1"
				+ "    union select count(*) dcnt, sysdate-2 Dateval from tb_comment where comment_date <= sysdate - 2"
				+ "    union select count(*) dcnt, sysdate-3 Dateval from tb_comment where comment_date <= sysdate - 3"
				+ "    union select count(*) dcnt, sysdate-4 Dateval from tb_comment where comment_date <= sysdate - 4"
				+ "    union select count(*) dcnt, sysdate-5 Dateval from tb_comment where comment_date <= sysdate - 5"
				+ "    order by Dateval desc";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs != null) {
				volist = new ArrayList<AdminVo>();
				while(rs.next()) {
					AdminVo vo = new AdminVo();
					vo.setDcnt(rs.getInt("dcnt"));
					vo.setDateval(rs.getDate("dateval"));
					volist.add(vo);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return volist;
	}
}
