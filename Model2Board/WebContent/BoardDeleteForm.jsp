<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>게시글 삭제</h2>

		<form action="BoardDeleteProcCon.do" method="post">
			<table width="600" border="1">


				<tr height="40">
					<td width="200" align="center">패스워드</td>
					<td width="400">&nbsp; <input type="password" name="password"
						size="60"></td>
				</tr>

				<tr height="40">
					<td colspan="4" align="center"><input type="hidden" name="num"
						value="${bean.num }"> <!-- 패스워드를 히든으로 넘기면 한번더 db에 연결할 필요 없이 바로 패스워드가 맞는지 틀리는지 확인할 수 있다. -->
						<input type="hidden" name="pass" value="${bean.password }">

						<input type="submit" value="글삭제"> &nbsp;&nbsp; <input
						type="button" onclick="location.href='BoardListCon.do'"
						value="전체글보기"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>