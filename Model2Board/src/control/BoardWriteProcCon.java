package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardBean;
import model.BoardDAO;

/**
 * Servlet implementation class BoardWriteProcCon
 */
// 글쓰기 처리 서블릿 선언
@WebServlet("/BoardWriteProcCon.do")
public class BoardWriteProcCon extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		reqPro(request, response);
	}

	protected void reqPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("euc-kr");
		// 빈 클래스로 데이터를 읽어들인다.
		BoardBean bean = new BoardBean();

		// 5개의 값을 빈 클래스에 저장시킨다.
		bean.setWriter(request.getParameter("writer"));
		bean.setSubject(request.getParameter("subject"));
		bean.setEmail(request.getParameter("email"));
		bean.setPassword(request.getParameter("password"));
		bean.setContent(request.getParameter("content"));

		BoardDAO bdao = new BoardDAO();
		// insert메소드에 매개값으로 빈클래스가 가지고있는 값들을 넣어준다.
		bdao.insertBoard(bean);

		// BoardListCon.do로 request, response를 전달한다.
		RequestDispatcher dis = request.getRequestDispatcher("BoardListCon.do");
		dis.forward(request, response);
	}
}
