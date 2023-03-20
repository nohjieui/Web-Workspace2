package com.kh.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.MemberService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class MyPageController
 */
@WebServlet("/update.me")
public class MyPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyPageController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUser") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용가능한 서비스입니다.");
			response.sendRedirect(request.getContextPath());
		}
		else {
			request.getRequestDispatcher("views/member/myPage.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		// 2) 요청시 전달값들을 뽑아서 변수 및 객체에 담기
		String userId = request.getParameter("userId"); // 필수값
		String userName = request.getParameter("userName"); // 필수값
		String phone = request.getParameter("phone"); // 빈문자열이 전달될 수도 있음
		String email = request.getParameter("email"); // 빈문자열이 전달될 수도 있음
		String address = request.getParameter("address"); // 빈문자열이 전달될 수도 있음
		String grade = request.getParameter("grade"); // null값이 전달될 수 있음
		
		Member m = new Member(userId, userName, phone, email, address, grade);
		
		// 3) 정보수정 요청 처리
		Member updateMem = new MemberService().updateMember(m);
		
		// 4) 돌려받은 처리 결과를 가지고 사용자가 보게 될 응답뷰를 지정
		if(updateMem == null) { // 실패
			request.setAttribute("errorMsg", "회원정보 수정에 실패했습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		
		}else { // 성공
			// 변경된 회원정보를 session영역에 다시 한번 저장
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", updateMem); // 같은 키값은 존재할 수 없음(덮어씌우기 가능)
			session.setAttribute("alertMsg", "성공적으로 회원정보를 수정했습니다.");
			
			response.sendRedirect(request.getContextPath());
		}
	}

}
