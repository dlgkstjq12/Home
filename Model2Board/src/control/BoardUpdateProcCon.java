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
//�Խñ� ���� ó�� ����
//�Խñ� ������ �� ��й�ȣ�� �Է��ؼ� ��й�ȣ�� ������ �Խñ��� ������ �� �ִ�.
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
		// �ѱ� ó��
		request.setCharacterEncoding("euc-kr");

		// ������ �Ѿ�� �����͸� �޾���
		// ��й�ȣ�� �޾Ƽ� db�� ����� ��й�ȣ�� �´��� Ȯ���ؼ�
		// �Խñ� ���� ����
		int num = Integer.parseInt(request.getParameter("num"));
		String password = request.getParameter("password"); // ����ڷκ��� �Է¹��� �н�����
		String pass = request.getParameter("pass"); // ���� �����ͺ��̽��� ����Ǿ� �ִ� �н����� ��
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");

		// password���� pass���� ���ؼ� ������ �Խñ� �����ϰ���.
		if (password.equals(pass)) {// �н����尡 ���ٸ� �����͸� ����

			BoardDAO bdao = new BoardDAO();
			// �н������ �񱳸� �ϸ� �Ǳ� ������ ���� �ѱ����� �ʰ�, ������ �ڷḸ �ѱ�
			// �ֳ��ϸ� �� �����Ҷ��� �н����带 �ٲٴ°� �ƴ϶� ����, ���븸 �ٲ�� ���̱� ����
			bdao.updateBoard(num, subject, content);
			// ������ �Ϸ�Ǿ����ÿ� �����ϰ� �Խù� ����Ʈ �������� �̵���Ų��.
			request.setAttribute("msg", "������ �Ϸ�Ǿ����ϴ�.");
			RequestDispatcher dis = request.getRequestDispatcher("BoardListCon.do");
			dis.forward(request, response);
		} else {
			// ��й�ȣ�� Ʋ�ȴٸ� ���� �������� �̵��ϰ� ����
			request.setAttribute("msg", "��й�ȣ�� Ʋ�Ƚ��ϴ�.");
			RequestDispatcher dis = request.getRequestDispatcher("BoardListCon.do");
			dis.forward(request, response);

		}
	}

}
