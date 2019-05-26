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

//�Խñ� ������ ó���ϴ� ����
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

		// num�� ����Ŭ������ �̿��� Ÿ�Ժ�ȯ�� ���Ѽ� num�� �ִ´�. (�Խñ� ��ȣ)
		int num = Integer.parseInt(request.getParameter("num"));

		// �����ͺ��̽��� ����
		BoardDAO bdao = new BoardDAO();
		// �ϳ��� �Խñۿ� ���� ������ ����
		BoardBean bean = bdao.getOneBoard(num);

		request.setAttribute("bean", bean);

		// view (jsp�� �ǹ��Ѵ�) ������ �����͸� �Ѱ��ش�.
		// BoardInfo.jsp�� request, response�� ����
		RequestDispatcher dis = request.getRequestDispatcher("BoardInfo.jsp");
		dis.forward(request, response);
		
	}

}
