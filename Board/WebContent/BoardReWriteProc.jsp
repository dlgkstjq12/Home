<%@page import="model.BoardDAO"%>
<%@page import="javax.print.attribute.ResolutionSyntax"%>
<%@page import="model.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<% 
    request.setCharacterEncoding("EUC-KR");
%>
	<!-- ������ �ѹ��� �޾ƿ��� ��Ŭ������ ����ϵ��� ��-->
	<jsp:useBean id="Boardbean" class="model.BoardBean">
		<jsp:setProperty name="Boardbean" property="*" />
	</jsp:useBean>

	<% 
    //�����ͺ��̽� ��ü ����
    BoardDAO bdao = new BoardDAO();
    bdao.reWriteBoard(Boardbean);
    
    //�亯 �����͸� ��� ������ ��ü �Խñ� ���⸦ ����
    response.sendRedirect("BoardList.jsp");
%>
</body>
</html>
