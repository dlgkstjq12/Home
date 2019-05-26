<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>게시글 수정</h2>

		<form action="BoardUpdateProcCon.do" method="post">
			<table width="600" border="1">
				<tr height="40">

					<td width="160" align="center">작성자</td>
					<td width="60" align="center">${bean.writer }</td>

					<td width="160" align="center">작성일</td>
					<td width="220" align="center">${bean.reg_date }</td>
				</tr>

				<tr height="40">
					<td width="170" align="center">제목</td>
					<td width="430" colspan="3">&nbsp; <input type="text"
						name="subject" value="${bean.subject }" size="60"></td>
				</tr>

				<tr height="40">
					<td width="200" align="center">패스워드</td>
					<td width="400">&nbsp; <input type="password" name="password"
						size="30"></td>
				</tr>

				<tr height="40">
					<td width="170" align="center">글내용</td>
					<td width="430" colspan="3"><textarea rows="10" cols="60"
							name="content" align="left">${bean.content }</textarea></td>
				</tr>

				<tr height="40">
					<td colspan="4" align="center"><input type="hidden" name="num"
						value="${bean.num }"> <!-- 패스워드를 히든으로 넘기면 한번더 db에 연결할 필요 없이 바로 패스워드가 맞는지 틀리는지 확인할 수 있다. -->
						<input type="hidden" name="pass" value="${bean.password }">
						<input type="submit" value="글수정"> &nbsp;&nbsp; <input
						type="button" onclick="location.href='BoardListCon.do'"
						value="전체글보기"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>