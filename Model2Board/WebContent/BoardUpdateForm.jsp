<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>�Խñ� ����</h2>

		<form action="BoardUpdateProcCon.do" method="post">
			<table width="600" border="1">
				<tr height="40">

					<td width="160" align="center">�ۼ���</td>
					<td width="60" align="center">${bean.writer }</td>

					<td width="160" align="center">�ۼ���</td>
					<td width="220" align="center">${bean.reg_date }</td>
				</tr>

				<tr height="40">
					<td width="170" align="center">����</td>
					<td width="430" colspan="3">&nbsp; <input type="text"
						name="subject" value="${bean.subject }" size="60"></td>
				</tr>

				<tr height="40">
					<td width="200" align="center">�н�����</td>
					<td width="400">&nbsp; <input type="password" name="password"
						size="30"></td>
				</tr>

				<tr height="40">
					<td width="170" align="center">�۳���</td>
					<td width="430" colspan="3"><textarea rows="10" cols="60"
							name="content" align="left">${bean.content }</textarea></td>
				</tr>

				<tr height="40">
					<td colspan="4" align="center"><input type="hidden" name="num"
						value="${bean.num }"> <!-- �н����带 �������� �ѱ�� �ѹ��� db�� ������ �ʿ� ���� �ٷ� �н����尡 �´��� Ʋ������ Ȯ���� �� �ִ�. -->
						<input type="hidden" name="pass" value="${bean.password }">
						<input type="submit" value="�ۼ���"> &nbsp;&nbsp; <input
						type="button" onclick="location.href='BoardListCon.do'"
						value="��ü�ۺ���"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>