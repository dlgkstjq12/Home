<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<!-- �� ���� ó���̱� ������ ����, �н�����, �۳���, ���ڸ� �޾Ƶ��ȴ�. -->
	<!-- �����ͺ��̽��κ��� ��й�ȣ�� �޾ƿ� ��й�ȣ�� ������ �����Ҽ� �ְ�, Ʋ���� �����ϴ� ���� -->
	<%
		request.setCharacterEncoding("EUC-KR");
	%>
	<!-- ����� �����͸� �о���̴� �� Ŭ���� ���� -->
	<jsp:useBean id="boardbean" class="model.BoardBean">
		<jsp:setProperty name="boardbean" property="*" />
	</jsp:useBean>
	<%
		//������ ���̽��� ����
		BoardDAO bdao = new BoardDAO();
		//�ش� �Խñ��� �н����� ���� ����
		String pass = bdao.getPass(boardbean.getNum());//num�� �������� �н����尪 ����

		//���� �н����尪�� update�� �ۼ��ߴ� password ���� ������ ��
		if (pass.equals(boardbean.getPassword())) {
			//������ �����ϴ� �޼ҵ� ȣ��
			bdao.updateBoard(boardbean);
			//������ �Ϸ�Ǹ� ��ü �Խñ� ����
			response.sendRedirect("BoardList.jsp");
		} else {//�н����尡 Ʋ���ٸ�
	%>
	<script type="text/javascript">
		alert("�н����尡 ��ġ ���� �ʽ��ϴ�. �ٽ� Ȯ���� ������ �ּ���.")
		history.go(-1); //�Ѵܰ� �������� �ǵ��ư���
	</script>
	<%
		}
	%>






</body>
</html>