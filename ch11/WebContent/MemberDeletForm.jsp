<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>


	<center>
		<h2>ȸ�� ���� �ϱ�</h2>

		<table width="400" border="1">
			<form action="MemberDeleteProc.jsp" method="post">
				<tr height="50">

					<td align="center" width="150">���̵�</td>
					<td width="250"><%=request.getParameter("id")%></td>
				</tr>
			<tr height="50">
				<td align="center" width="150">�н�����</td>
				<td width="250"><input type="password" name="pass1"></td>
				<!-- �н����带 �Է��ϰ� ����� �¾ƾ߸� ���� ���� ���� -->
				</td>
			</tr>


			<tr height="50">
				<td align="center" colspan="2">
					<!-- submit�� �������ͽÿ��� ���� ���� (�����͸� ������) --> <input type="hidden"
					name="id" value="<%=request.getParameter("id")%>"> <!--hidden�� �Ⱥ��̰� �ѱ�°� ��,���̵� ���� �Ⱥ��̰� �ѱ�ٴ� �� -->
					<input type="submit" value="ȸ�� �����ϱ�"> &nbsp;&nbsp;
			</form>
			<button onclick="location.href='MemberList.jsp'">ȸ�� ��ü ����</button>
			<!-- ȸ�� ��ü���� �������� ���ư� -->
			</td>
			</tr>

		</table>
	</center>




</body>
</html>