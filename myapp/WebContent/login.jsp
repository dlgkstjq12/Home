<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
	String id = (String)session.getAttribute("idkey");
%>
<html>
<body>
<h1>Servlet ¼¼¼Ç</h1>
<%
	if(id!=null)
	{
		
	
%>
<%=id%>´Ô ¹Ý°©½À´Ï´Ù.<p/>
<a href='logout.jsp'>·Î±×¾Æ¿ô</a>
<% 
}else{
%>
<form method = "post" action = "loginServlet"> <!-- ¼­ºí¸´ loginservlet¸¦ ¿äÃ» -->
id : <input name = "id"><br/>
pwd : <input type = "password" name = "pwd"><br/>
<input type = "submit" value = "·Î±×ÀÎ">
</form>
<%} %>
</body>
</html>