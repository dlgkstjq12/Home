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

//게시글 정보를 처리하는 서블릿
@WebServlet("/BoardInfoControl.do")
public class BoardInfoControl extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		rePro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		rePro(request, response);
	}

	protected void rePro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// num을 포장클래스를 이용해 타입변환을 시켜서 num에 넣는다. (게시글 번호)
		int num = Integer.parseInt(request.getParameter("num"));

		// 데이터베이스에 접근
		BoardDAO bdao = new BoardDAO();
		// 하나의 게시글에 대한 정보를 리턴
		BoardBean bean = bdao.getOneBoard(num);

		request.setAttribute("bean", bean);

		// view (jsp를 의미한다) 쪽으로 데이터를 넘겨준다.
		// BoardInfo.jsp로 request, response를 전달
		RequestDispatcher dis = request.getRequestDispatcher("BoardInfo.jsp");
		dis.forward(request, response);
		
	}

}
