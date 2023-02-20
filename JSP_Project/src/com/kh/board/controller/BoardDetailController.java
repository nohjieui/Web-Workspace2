package com.kh.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;

/**
 * Servlet implementation class BoardDetailController
 */
@WebServlet("/detail.bo")
public class BoardDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 클릭했을 때 게시판 글 가져오기
		int bno = Integer.parseInt(request.getParameter("bno"));
		/*
		 * SELECT *
		 * FROM BOARD
		 * WHERE BOARD_NO = ${bno}
		 */
		
		// 조회수 증가용 서비스
		/*
		 * UPDATE BOARD SET
		 * COUNT = COUNT + 1
		 * WHERE BOARD_NO = ${bno}
		 */
		int result = new BoardService().increaseCount(bno);
		
		// 조회수 증가에 성공했을 때
		if(result > 0) {
			Board b = new BoardService().selectBoard(bno);
			request.setAttribute("b", b);
			
			request.getRequestDispatcher("views/board/boardDetailView.jsp").forward(request, response);
		}else {
			request.setAttribute("errorMsg", "게시글 조회 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
