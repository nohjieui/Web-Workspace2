package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class BoardListController
 */
@WebServlet("/list.bo")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 페이징 처리
		// 각각의 변수에 데이터를 모두 집어넣은 후에 PageInfo 객체로 만들것임
		int listCount;		// 현재 게시판의 총 게시글 갯수
		int currentPage;	// 현재 페이지(사용자가 요청한 페이지)
		int pageLimit;		// 페이지 하단에 보여질 페이징바의 페이지 최대 갯수
		int boardLimit; 	// 한 페이지에 보여질 게시글의 최대 갯수
		
		int maxPage; 		// 가장 마지막 페이지가 몇번 페이지인지(총 페이지 수)
		int startPage; 		// 페이지 하단에 보여질 페이징바의 시작 수
		int endPage; 		// 페이지 하단에 보여질 페이징바의 끝 수

		// * listCount : 총 게시글 갯수 --> Board 테이블 안에 저장되어있는 행의 갯수
		listCount = new BoardService().selectListCount();
		
		// * currentPage : 현재 페이지(사용자가 요청한 페이지)
		currentPage = Integer.parseInt(request.getParameter("currentPage") == null ? "1" : request.getParameter("currentPage"));
		
		// * pageLimit : 페이지 하단에 보여질 페이징바의 페이지 최대 갯수(패이지 목록들 몇개단위로 출력할건지)
		pageLimit = 10;
		
		// * boardLimit : 한 페이지에 보여질 게시글의 최대 갯수(게시글 몇개 단위씩)
		boardLimit = 10;

		// * maxPage : 가장 마지막 페이지가 몇번 페이지인지(총 페이지 수)
		maxPage = (int)Math.ceil((double)listCount / boardLimit);
		
		// * startPage : 페이지 하단에 보여질 페이징바의 시작 수
		startPage = (currentPage -1) / pageLimit * pageLimit +1;

		// * endPage : 페이지 하단에 보여질 페이징바의 끝 수
		endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 페이지 정보들을 하나의 공간에 담아서 보내기
		// 페이지 정보를 담을 vo클래스를 사용
		// -> 공지사항이나, 사진게시판 등 다양한 게시판에서 공통적으로 사용할 vo객체이기 때문에 common패키지에 만듬
		
		// 1. 페이징바 만들때 필요한 객체
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
		
		// 2. 현재 사용자가 요청한 페이지(currentPage)에 보여질 게시글 리스트 요청하기
		// 내가 원하는 페이지의 게시글 목록만 가져오기 위해 selectList() 매개변수로 pi객체 넣어줌
		ArrayList<Board> list = new BoardService().selectList(pi);
		
		request.setAttribute("pi", pi);
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("views/board/boardListView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
