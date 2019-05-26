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
 * Servlet implementation class BoardDeleteProcCon
 */
//�Խñ� ���� ó�� ����
@WebServlet("/BoardDeleteProcCon.do")
public class BoardDeleteProcCon extends HttpServlet {

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

		// ����ڷκ��� �Ѿ�� ������ 3���� �޾��ش�.
		int num = Integer.parseInt(request.getParameter("num"));
		String password = request.getParameter("password");
		String pass = request.getParameter("pass");

		// �н����尡 ���� ��쿡�� �����͸� �����ϰ� ����Ʈȭ���� �����ش�.
		if (password.equals(pass)) {

			BoardDAO bdao = new BoardDAO();
			bdao.deleteBoard(num);

			RequestDispatcher dis = request.getRequestDispatcher("BoardListCon.do");
			dis.forward(request, response);

		} else {

			request.setAttribute("msg", 2);
			RequestDispatcher dis = request.getRequestDispatcher("BoardListcon.do");

		}

	}
}
