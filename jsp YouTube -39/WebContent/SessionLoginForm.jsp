<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>세션 로그인</h2>
		<!-- 쿠키는 아이디를 저장해서 읽어들일수 있지만 세션은 그럴수 없다. -->
		<form action="SessionLoginProc.jsp" method="post">
			<table width="400" border="1">

				<!-- 테이블을 생성 -->
				<tr height="50">
					<td width="150">아이디</td>
					<td width="250"><input type="text" name="id"></td>
				</tr>

				<tr height="50">
					<td width="150">패스워드</td>
					<td width="250"><input type="password" name="pass"></td>
				</tr>

				<tr height="50">
					<td colspan="2" align="center"><input type="submit"
						value="로그인"></td>
				</tr>
			</table>
		</form>
	</center>

</body>
</html>
