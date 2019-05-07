<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>

		<h2>세션 로그인 처리 1</h2>

		<% 
    request.setCharacterEncoding("EUC-KR"); //한글 깨짐을 방지하기 위해 문자셋 설정
 
    //사용자로부터 데이터를 읽어들인다.
    String id = request.getParameter("id"); //id와 pass를 각각 변수에 저장
    String pass = request.getParameter("pass");
    
    //아이디와 패스워드를 저장
    session.setAttribute("id", id);
    session.setAttribute("pass", pass);
    
    //세션의 유지시간 설정
    session.setMaxInactiveInterval(60*2); //2분간 아이디를 유지함
    
    response.sendRedirect("SessionMain.jsp");
    
%>

	</center>

</body>
</html>

