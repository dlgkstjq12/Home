<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>�Խñ� ����</h2>

		<form action="BoardDeleteProcCon.do" method="post">
			<table width="600" border="1">


				<tr height="40">
					<td width="200" align="center">�н�����</td>
					<td width="400">&nbsp; <input type="password" name="password"
						size="60"></td>
				</tr>

				<tr height="40">
					<td colspan="4" align="center"><input type="hidden" name="num"
						value="${bean.num }"> <!-- �н����带 �������� �ѱ�� �ѹ��� db�� ������ �ʿ� ���� �ٷ� �н����尡 �´��� Ʋ������ Ȯ���� �� �ִ�. -->
						<input type="hidden" name="pass" value="${bean.password }">

						<input type="submit" value="�ۻ���"> &nbsp;&nbsp; <input
						type="button" onclick="location.href='BoardListCon.do'"
						value="��ü�ۺ���"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>