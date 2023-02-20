package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Category;

/**
 * Servlet implementation class BoardInsertController
 */
@WebServlet("/insert.bo")
public class BoardInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 카테고리 조회
		ArrayList<Category> list = new BoardService().selectCategoryList();
		
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("views/board/boardEnrollForm.jsp").forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		// String category = request.getParameter("category");
		// String title = request.getParameter("title");
		
		/*
		 * 폼 전송시 일반 방식이 아니라 multipart/form-date로 전송하는 경우
		 * request로부터 값을 뽑아낼 수 없다.
		 * 
		 * multipart라는 객체ㅐ에 값을 이관시켜서 다뤄줘야함
		 */
		
		// enctype이 multipart/form-date로 전송되었는지 확인
		if(ServletFileUpload.isMultipartContent(request)) {
			
			// 파일 업로드를 위한 라이브러리 cos.jar
			
			// 1. 정송되는 파일을 처리할 작업 내용(전송되는 파일의 용량제한, 전달된 파일을 저장할 경로)
			// 1_1. 전송파일 용량제한(int maxSize => byte단위의 값을 기술해야함) 저희는 10Mbyte로 제한할 예정
			/*
			 * byte -> kbyte -> mbyte -> gbyte -> tbyte -> ...
			 * 1kbyte -> 1024kbyte (2의  10승)
			 * 1mbyte -> 1024kbyte -> 1024 * 1024 byte -> (2의 20승)
			 */
			int maxSize = 1024 * 1024 * 10;
			
		}else {
			request.setAttribute("errorMsg", "전송방식이 잘못되었습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

}
