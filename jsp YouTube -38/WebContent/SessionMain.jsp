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
	//Center ���� �������ֱ� ���ؼ� request ��ü�� �̿��Ͽ� center���� �޾ƿ�
	String center = request.getParameter("center");

	//ó�� SessionMain.jsp�� �����ϸ� null���� ����Ǳ⿡ nulló���� ����
	if(center == null)
	{
		center = "Center.jsp";
	}

%>
<center>
	<table border = "1" width = "800">
	<!--top -->
	<tr height = "150">
		<td align = "center" colspan = "2">
		<jsp:include page = "Top.jsp" />
		</td>
	</tr>
	
	<!-- Left -->
	<tr height = "400">
		<td align = "center" width = "200">
		<jsp:include page ="Left.jsp"/>
		</td>
		
	<!-- Center -->
		<td align = "center" width = "200">
		<jsp:include page = "<%=center %>"/>
		</td>
		</tr>
		
	<!-- Bottom -->
	<tr height = "100">
		<td align = "center" colspan = "2">
		<jsp:include page = "Bottom.jsp"/>
		</td>
	</tr>

	</table>
</center>
</body>
</html>