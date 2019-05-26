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
// �۾��� ó�� ���� ����
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

		// �ѱ�Ÿ���� �ƴϱ� ������ �ѱ�ó���� ���ص���
		// ��۾��� ���� ���� �������� �ֱ⶧���� �ڵ����� �ο��Ǽ�
		// ���� num���� �޾Ƽ� �� �ʿ䰡 ����
		// Integer.pareInt�� ���ڸ� int�������� ��ȯ�Ҷ� ���
		int ref = Integer.parseInt(request.getParameter("ref"));
		int re_step = Integer.parseInt(request.getParameter("re_step"));
		int re_level = Integer.parseInt(request.getParameter("re_level"));

		// �۰��� �������� �ٸ��������� �Ѱ��ֱ� ���ؼ� ��Ƴ��´�.
		request.setAttribute("ref", ref);
		request.setAttribute("re_step", re_step);
		request.setAttribute("re_level", re_level);

		// BoardReWriteForm.jsp���Ͽ� request, response�� ��Ƴ��� �ڷ���� �Ѱ��ش�.
		RequestDispatcher dis = request.getRequestDispatcher("BoardReWriteForm.jsp");
		dis.forward(request, response);
	}
}