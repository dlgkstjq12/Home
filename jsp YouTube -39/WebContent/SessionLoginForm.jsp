<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>���� �α���</h2>
		<!-- ��Ű�� ���̵� �����ؼ� �о���ϼ� ������ ������ �׷��� ����. -->
		<form action="SessionLoginProc.jsp" method="post">
			<table width="400" border="1">

				<!-- ���̺��� ���� -->
				<tr height="50">
					<td width="150">���̵�</td>
					<td width="250"><input type="text" name="id"></td>
				</tr>

				<tr height="50">
					<td width="150">�н�����</td>
					<td width="250"><input type="password" name="pass"></td>
				</tr>

				<tr height="50">
					<td colspan="2" align="center"><input type="submit"
						value="�α���"></td>
				</tr>
			</table>
		</form>
	</center>

</body>
</html>
