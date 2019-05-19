<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

	<%
		String center = request.getParameter("center");
		//처음 실행시에는 center 값이 넘어오지 않기에 반드시  null처리를 해야한다.
		//처리를 하지않으면 에러가 발생될수 있다.

		if (center == null) {
			center = "Center.jsp"; //디폴트 center값을 부여(첫 화면에는 center이 뜨도록 한다는 말)    
		}
	%>
	<center>
		<table width="1000">

			<!-- Top 부분 -->
			<tr height="140" align="center">
				<!-- include page를 사용하여서 main페이지에서 각 페이지가 호출될수 있도록 한다. -->
				<td align="center" width="1000"><jsp:include page="Top.jsp" /></td>
			</tr>

			<!-- Center 부분 -->
			<!-- Top랑,Bottom은 화면이 넘어가더라도 바뀌지 않지만 center은 계속 바뀌기 때문에 center값을 준다 -->

			<tr height="100" align="center">
				<td align="center" width="1000"><jsp:include
						page="<%=center%>" /></td>
			</tr>

			<!-- Bottom 부분 -->
			<tr height="140" align="center">
				<td align="center" width="1000"><jsp:include page="Bottom.jsp" /></td>
			</tr>

		</table>
	</center>
</body>
</html>
