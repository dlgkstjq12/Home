<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<%
		//�α׾ƿ� Ŭ���� �Ķ���͸� ���ؼ� �α׾ƿ��������� �ľ�
		String logout = request.getParameter("logout");

		if (logout != null) {
			//id�� null���� �ο�
			session.setAttribute("id", null);
			//���� ������ ����
			session.setMaxInactiveInterval(0);
		}

		//������ ���Ͽ� id�� �о���δ�.
		String id = (String) session.getAttribute("id");
		//�α����� �Ǿ� ���� �ʴٸ� session���� null�� �ȴ�. �׷��� nulló���� ������Ѵ�.
		if (id == null) {
			id = "�մ�";
		}
	%>

	<!-- Top -->
	<center>
		<table width="800">
			<tr height="100">
				<!-- �ΰ��̹��� -->
				<td colspan="2" align="center" width="200"><img alt=""
					src="img/logo.jpg" width="200" height="200"> <!-- �׸����� �������� �ڵ� --></td>
				<td colspan="5" align="center"><font size="10">���� ķ��</font></td>
			</tr>
			<tr height="50">
				<td width="100" align="center">��Ʈ</td>
				<td width="100" align="center">����</td>
				<td width="100" align="center">�ı��</td>
				<td width="100" align="center">ħ��</td>
				<td width="100" align="center">���̺�</td>
				<td width="100" align="center">ȭ�Դ�</td>
				<td width="200" align="center">
					<%
						if (id.equals("�մ�")) //���̵� �մ԰� ���ٸ� (�α����� �ȵȻ��´� �α��� �ؾߵ�)
						{
					%> <%=id%>��
					<button
						onclick="location.href='SessionMain.jsp?center=SessionLoginForm.jsp'">�α���</button>
					<%
						} else {
					%> <%=id%>��
					<button onclick="location.href='SessionMain.jsp?logout=1'">�α׾ƿ�</button>
					<%
						}
					%>
				</td>
		</table>
	</center>
</body>
</html>