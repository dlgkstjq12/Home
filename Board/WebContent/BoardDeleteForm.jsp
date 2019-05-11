<%@page import="model.BoardDAO"%>
<%@page import="model.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

	<%
		BoardDAO bdao = new BoardDAO();
		//String 형식이기 때문에 포장클래스를 사용해서 타입을 변환한다.
		int num = Integer.parseInt(request.getParameter("num"));

		//하나의 게시글을 리턴해야하기 때문에 (getOneUpdateBoard메소드를 사용해도 된다.)
		BoardBean bean = bdao.getOneUpdateBoard(num);
	%>
	<center>
		<h2>게시글 삭제</h2>
		<!-- 패스워드 값을 넘기기때문에 post방식 사용 -->
		<form action="BoardDeleteProc.jsp" method="post">
			<table width="600" border="1" bgcolor="skyblue">
				<tr height="40">
					<td width="120" align="center">작성자</td>
					<td width="180" align="center"><%=bean.getWriter()%></td>

					<td width="120" align="center">작성일</td>
					<td width="180" align="center"><%=bean.getReg_date()%></td>
				</tr>

				<tr height="40">
					<td width="120" align="center">제목</td>
					<td align="center" colspan="3"><%=bean.getSubject()%></td>
				</tr>

				<tr height="40">
					<td width="120" align="center">패스워드</td>
					<!-- 패스워드는 직접받아야되기때문에 빈에서 받지않는다.-->
					<td align="Left" colspan="3"><input type="password"
						name="password" size="60"></td>
				</tr>


				<tr height="40">
					<td align="center" colspan="4"><input type="hidden" name="num"
						value="<%=num%>">
					<!-- 처리파일에 num값을 그대로 넘겨준다 (삭제하기 위해서) --> <input type="submit"
						value="글삭제"> &nbsp;&nbsp; <input type="button"
						onclick="location.href='BoardList.jsp'" value="목록보기"></td>
				</tr>


			</table>
		</form>
	</center>
</body>
</html>