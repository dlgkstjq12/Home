<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>


	<center>
		<h2>회원 삭제 하기</h2>

		<table width="400" border="1">
			<form action="MemberDeleteProc.jsp" method="post">
				<tr height="50">

					<td align="center" width="150">아이디</td>
					<td width="250"><%=request.getParameter("id")%></td>
				</tr>
			<tr height="50">
				<td align="center" width="150">패스워드</td>
				<td width="250"><input type="password" name="pass1"></td>
				<!-- 패스워드를 입력하고 결과가 맞아야만 정보 삭제 가능 -->
				</td>
			</tr>


			<tr height="50">
				<td align="center" colspan="2">
					<!-- submit은 폼데이터시에만 쓸수 있음 (데이터를 보낼때) --> <input type="hidden"
					name="id" value="<%=request.getParameter("id")%>"> <!--hidden은 안보이게 넘기는것 즉,아이디 값을 안보이게 넘긴다는 것 -->
					<input type="submit" value="회원 삭제하기"> &nbsp;&nbsp;
			</form>
			<button onclick="location.href='MemberList.jsp'">회원 전체 보기</button>
			<!-- 회원 전체보기 페이지로 돌아감 -->
			</td>
			</tr>

		</table>
	</center>




</body>
</html>