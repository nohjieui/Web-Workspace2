package com.kh.member.model.service;

import java.sql.Connection;

import com.kh.common.JDBCTemplate;
import com.kh.member.model.dao.MemberDao;
import com.kh.member.model.vo.Member;
import static com.kh.common.JDBCTemplate.*;

public class MemberService {
	
	public int insertMember(Member m) {
		
		Connection conn = getConnection();
		
		int result = new MemberDao().insertMember(conn, m);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}
	
	public Member loginMember(String userId, String userPwd) {
		
		Connection conn = getConnection();
		
		Member m = new MemberDao().loginMember(conn, userId, userPwd);
		
		close(conn);
		
		return m;
	}
	
	public String selectId(String checkId) {
		
		Connection conn = getConnection();
		
		String id = new MemberDao().selectId(conn, checkId);
		
		close(conn);
		
		return id;
	}
	
	public Member updateMember(Member m) {
		
		Connection conn = getConnection();
		int result = new MemberDao().updateMember(conn, m);
		
		Member updateMem = null;
		
		if(result > 0) { // 성공
			commit(conn);
			
			updateMem = new MemberDao().selectMember(conn, m.getUserId());
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return updateMem;
	}

}
