package com.kh.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.MyFileRenamePolicy;
import com.kh.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;

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

		ArrayList<Category> list = new BoardService().selectCategoryList();
		
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("views/board/boardEnrollForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// enctype이 multipart/form-date로 전송되었는지 확인
		if(ServletFileUpload.isMultipartContent(request)){
		
			// 1. 전송되는 파일을 처리할 작업 내용(전송되는 파일의 용량제한, 전달된 파일을 저장할 경로)
			// 1_1. 전송파일 용량제한
			int maxSize = 1024 * 1024 * 10;
			
			// 1_2. 전달된 파일을 저장할 서버의 폴더경로 알아내기(String savePath)
			String savePath = request.getSession().getServletContext().getRealPath("/resources/board_upfiles/");
			
			// 2. 전달된 파일명 수정 및 서버에 업로드 작업
			MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			// 3. DB에 기록할 데이터들을 뽑아서 Attachment 객체에 담기, Board 객체에 각각 담아주기
			String category = multi.getParameter("category");
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
			
			String boardWriter = ((Member)request.getSession().getAttribute("loginUser")).getUserNo()+"";
			
			// Board 타입 객체로 만들기
			Board b = new Board();
			b.setCategory(category);
			b.setBoardTitle(title);
			b.setBoardContent(content);
			b.setBoardWriter(boardWriter);
			
			Attachment at = null;
			
			// 첨푸파일이 있을경우 원본명 반환, 없을경우 null반환
			if(multi.getOriginalFileName("upfile") != null) {
				at = new Attachment();
				at.setOrignName(multi.getOriginalFileName("upfile"));
				at.setChangeName(multi.getFilesystemName("upfile"));
				at.setFilePath("resources/board_upfiles/");
			}
			
			// 4. 서비스 요청
			int result = new BoardService().insertBoard(b, at);
			
			if(result > 0) { // 성공적으로 작성 => 최신 글 목록으로 이동
				request.getSession().setAttribute("alertMsg", "게시글 작성 성공");
				response.sendRedirect(request.getContextPath()+"/list.bo?currentPage=1");
			}else { // 실패시에는 -> 첨부파일이 있었을 경우 이미 업로드된 첨부파일을 삭제해주기(용량만 차지함)
				
				if(at != null) {
					new File(savePath+at.getChangeName()).delete();
				}
				request.setAttribute("errorMsg", "게시글 작성 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}			
		}else {
			request.setAttribute("errorMsg", "전송방식이 잘못되었습니다.");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
	}

}
