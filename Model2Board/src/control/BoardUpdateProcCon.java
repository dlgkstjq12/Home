package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardDAO;

/**
 * Servlet implementation class BoardUpdateProcCon
 */
//게시글 수정 처리 서블릿
//게시글 수정할 때 비밀번호를 입력해서 비밀번호가 맞으면 게시글을 수정할 수 있다.
@WebServlet("/BoardUpdateProcCon.do")
public class BoardUpdateProcCon extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 한글 처리
		request.setCharacterEncoding("euc-kr");

		// 폼에서 넘어온 데이터를 받아줌
		// 비밀번호를 받아서 db에 저장된 비밀번호와 맞는지 확인해서
		// 게시글 수정 가능
		int num = Integer.parseInt(request.getParameter("num"));
		String password = request.getParameter("password"); // 사용자로부터 입력받은 패스워드
		String pass = request.getParameter("pass"); // 실제 데이터베이스에 저장되어 있는 패스워드 값
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");

		// password값과 pass값을 비교해서 맞으면 게시글 수정하게함.
		if (password.equals(pass)) {// 패스워드가 같다면 데이터를 수정

			BoardDAO bdao = new BoardDAO();
			// 패스워드는 비교만 하면 되기 때문에 따로 넘기지는 않고, 나머지 자료만 넘김
			// 왜냐하면 글 수정할때는 패스워드를 바꾸는게 아니라 제목, 내용만 바뀌는 것이기 때문
			bdao.updateBoard(num, subject, content);
			// 수정이 완료되었을시에 실행하고 게시물 리스트 페이지로 이동시킨다.
			request.setAttribute("msg", "수정이 완료되었습니다.");
			RequestDispatcher dis = request.getRequestDispatcher("BoardListCon.do");
			dis.forward(request, response);
		} else {
			// 비밀번호가 틀렸다면 이전 페이지로 이동하고 실행
			request.setAttribute("msg", "비밀번호가 틀렸습니다.");
			RequestDispatcher dis = request.getRequestDispatcher("BoardListCon.do");
			dis.forward(request, response);

		}
	}

}
