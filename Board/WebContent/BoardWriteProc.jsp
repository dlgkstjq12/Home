<%@page import="model.BoardDAO"%>
<%@page import="model.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

	<% 
    request.setCharacterEncoding("EUC-KR"); //�ѱ۱��� ���� ���ڼ� ����
%>
	<!-- �����Ͽ��� �Խñ� �ۼ��� �����͸� �ѹ��� �о���� -->
	<!-- use���� ����Ͽ� �ڹٺ��� ���, id�� ��Ŭ������ ��Ī�ϴ� ���� ������ -->
	<!-- �����Ͽ� �ִ� ������ �޴´�. -->
	<!-- �����Ͽ� ���� ������ null�� ���´� null������ ���� �͵��� �����ͺ��̽����� ���� �����̴� ����x -->

	<jsp:useBean id="Boardbean" class="model.BoardBean">
		<jsp:setProperty name="Boardbean" property="*" />
	</jsp:useBean>

	<%
    //�����ͺ��̽� ������ ��Ŭ������ �Ѱ���
    BoardDAO bdao = new BoardDAO();
    
    //������ ���� �޼ҵ带 ȣ��
    bdao.insertBoard(Boardbean);
    
    //�Խñ� ������ ��ü �Խñ� ����
    response.sendRedirect("BoardList.jsp");
 
%>




</body>
</html>
