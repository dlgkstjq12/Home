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
	<!-- 데이터 한번에 받아오는 빈클래스를 사용하도록 함-->
	<jsp:useBean id="Boardbean" class="model.BoardBean">
		<jsp:setProperty name="Boardbean" property="*" />
	</jsp:useBean>

	<% 
    //데이터베이스 객체 생성
    BoardDAO bdao = new BoardDAO();
    bdao.reWriteBoard(Boardbean);
    
    //답변 데이터를 모두 저장후 전체 게시글 보기를 설정
    response.sendRedirect("BoardList.jsp");
%>
</body>
</html>
