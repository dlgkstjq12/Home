<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>

		<h2>���� �α��� ó�� 1</h2>

		<% 
    request.setCharacterEncoding("EUC-KR"); //�ѱ� ������ �����ϱ� ���� ���ڼ� ����
 
    //����ڷκ��� �����͸� �о���δ�.
    String id = request.getParameter("id"); //id�� pass�� ���� ������ ����
    String pass = request.getParameter("pass");
    
    //���̵�� �н����带 ����
    session.setAttribute("id", id);
    session.setAttribute("pass", pass);
    
    //������ �����ð� ����
    session.setMaxInactiveInterval(60*2); //2�а� ���̵� ������
    
    response.sendRedirect("SessionMain.jsp");
    
%>

	</center>

</body>
</html>

