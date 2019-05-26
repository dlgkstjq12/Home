<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>게시글 쓰기</h2>
		<!-- 컨트롤러가 읽어들이게끔 페이지 이동시킴 -->
		<form action="BoardWriteProcCon.do" method="post">
			<table width="600" border="1" bordercolor="gray" bgcolor="skyblue">
				<!-- bordercolor는 선색깔 지정 -->
				<tr height="40">
					<td align="center" width="150">작성자</td>
					<!-- ref는 데이터베이스에서 처리하기 때문에 따로 받지 않는다. -->
					<td width="450"><input type="text" name="writer" size="60"></td>
				</tr>

				<tr height="40">
					<td align="center" width="150">제목</td>
					<td width="450"><input type="text" name="subject" size="60"></td>
				</tr>

				<tr height="40">
					<td align="center" width="150">이메일</td>
					<td width="450"><input type="text" name="email" size="60"></td>
				</tr>

				<tr height="40">
					<td align="center" width="150">비밀번호</td>
					<td width="450"><input type="password" name="password"
						size="61"></td>
				</tr>

				<tr height="40">
					<td align="center" width="150">글내용</td>
					<td width="450"><textarea rows="10" cols="50" name="content"></textarea></td>
				</tr>

				<tr height="40">
					<td align="center" colspan="2"><input type="submit"
						value="글쓰기"> &nbsp;&nbsp; <input type="reset" value="다시작성">
						&nbsp;&nbsp;
						<button onclick="location.href='BoardListCon.do'">전체 게시글 보기</button>
						<!-- 클릭하면 BoardList.jsp페이지로 넘어가는 버튼--></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>
