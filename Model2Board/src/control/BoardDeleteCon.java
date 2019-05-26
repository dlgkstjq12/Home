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
 * Servlet implementation class BoardDeleteCon
 */
@WebServlet("/BoardDeleteCon.do")
public class BoardDeleteCon extends HttpServlet {

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

		// 글삭제이기 때문에 글 번호 값을 입력받는다.
		int num = Integer.parseInt(request.getParameter("num"));

		// 데이터베이스에 접근하여 하나의 게시글을 리턴하는 메소드
		BoardDAO bdao = new BoardDAO();

		// 빈 클래스 타입으로 리턴
		BoardBean bean = bdao.getOneUpdateBoard(num); // 조회수를 증가시키지 않는 메소드를 사용함

		request.setAttribute("bean", bean);

		RequestDispatcher dis = request.getRequestDispatcher("BoardDeleteForm.jsp");
		dis.forward(request, response);

	}
}
