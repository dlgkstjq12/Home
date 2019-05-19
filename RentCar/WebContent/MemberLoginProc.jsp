<%@page import="db.RentcarDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<% 
	//로그인 처리 페이지, 한글깨짐 방지

	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	//회원 아이디와 패스워드가 일치하는지 비교한다.
	RentcarDAO rdao = new RentcarDAO();
	
	//해당 회원이 있는지 여부를 숫자로 반환받는다.
	int result = rdao.getMember(id,pass);
	
	if(result==0)
	{
%>

	<script>//예약할시에 로그인이 안되어있을경우 출력되는 메시지
		alert("회원 아이디 또는 패스워드가 틀립니다.");
	//로그인이 안되어있을경우 로그인 페이지로 이동
		location.href='RentcarMain.jsp?center=MemberLogin.jsp';
	</script>

	<%
	}else
	{
		//로그인 처리가 되었다면 세션에 담아야 화면이 넘어갈때 유지된다.
		session.setAttribute("id", id);
		response.sendRedirect("RentcarMain.jsp");
	}
	
	

%>


</body>
</html>