<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<!-- �н������ num�� �ޱ� ������ �ѱ۱��� ������ ���� ���ص��ȴ�. -->

	<%
		//�ΰ����� ���� �ޱ⶧���� ������� ����ص� ������, request�� ����ߴ�. (�н������ �ѹ��� �޴´�.)
		String pass = request.getParameter("password");
		int num = Integer.parseInt(request.getParameter("num"));

		//�����ͺ��̽� ����
		BoardDAO bdao = new BoardDAO();
		String password = bdao.getPass(num);

		//���� �н����尪�� delete form���� �ۼ��� �н����带 ��
		if (pass.equals(password)) {
			//�н����尡 �Ѵ� ���ٸ�
			bdao.deleteBoard(num);

			//�����Ѵ��� BoardList.jsp�� �̵���
			response.sendRedirect("BoardList.jsp");

		} else {
	%>
	<script>
		//�н����尡 Ʋ���� �ٷ� ���������� ���ư��Բ� script �ڵ� �ۼ�
		alert("�н����尡 Ʋ���� ���� �Ҽ� �����ϴ�. �н����带 Ȯ�����ּ���.");
		history.go(-1);
	</script>
	<%
		}
	%>
</body>
</html>