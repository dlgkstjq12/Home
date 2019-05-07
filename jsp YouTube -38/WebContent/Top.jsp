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

	//세션을 통하여 id를 읽어들인다.
	String id = (String)session.getAttribute("id");
	//로그인이 되어 있지 않다면 session값이 null이 된다. 그래서 null처리를 해줘야한다.
	if(id == null)
	{
		id = "손님";
	}

%>

	<!-- Top -->
	<center>
		<table width="800">
			<tr height="100">
				<!-- 로고이미지 -->
				<td colspan="2" align="center" width="260"><img alt=""
					src="img/logo.jpg" width="200" height="200">
				<!-- 그림파일 가져오는 코드 --></td>
				<td colspan="5" align="center"><font size="10">낭만 캠핑</font></td>
			</tr>
			<tr height="50">
				<td width="110" align="center">텐트</td>
				<td width="110" align="center">의자</td>
				<td width="110" align="center">식기류</td>
				<td width="110" align="center">침낭</td>
				<td width="110" align="center">테이블</td>
				<td width="110" align="center">화롯대</td>
				<td width="110" align="center"><%=id %></td>
		</table>
	</center>
</body>
</html>