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
@WebServlet("/BoardReWriteCon.do")
public class BoardReWriteCon extends HttpServlet {

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

		// 한글타입이 아니기 때문에 한글처리는 안해도됨
		// 답글쓰기 같은 경우는 시퀀스가 있기때문에 자동으로 부여되서
		// 궂이 num값을 받아서 할 필요가 없다
		// Integer.pareInt는 문자를 int형식으로 변환할때 사용
		int ref = Integer.parseInt(request.getParameter("ref"));
		int re_step = Integer.parseInt(request.getParameter("re_step"));
		int re_level = Integer.parseInt(request.getParameter("re_level"));

		// 글관련 정보들을 다른페이지로 넘겨주기 위해서 담아놓는다.
		request.setAttribute("ref", ref);
		request.setAttribute("re_step", re_step);
		request.setAttribute("re_level", re_level);

		// BoardReWriteForm.jsp파일에 request, response에 담아놓은 자료들을 넘겨준다.
		RequestDispatcher dis = request.getRequestDispatcher("BoardReWriteForm.jsp");
		dis.forward(request, response);
	}
}