<%@page import="ch11.MemberBean"%>
<%@page import="ch11.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
</head>
<body>
	<!-- memberlist���� �ѱ� id�� �޾���  1.�����ͺ��̽����� �� ����� ������ ������   2. table �±׸� �̿��Ͽ� ȭ�鿡 ȸ���� ���� ��� -->

	<%
		String id = request.getParameter("id");

		MemberDAO mdao = new MemberDAO();
		MemberBean mbean = mdao.oneSelectMember(id);
	%>

	<center>
		<h2>ȸ�� ���� ����</h2>

		<table width="400" border="1">

			<tr height="50">
				<td align="center" width="150">���̵�</td>
				<td width="250"><%=mbean.getId()%></td>
			<tr height="50">
				<td align="center" width="150">�̸���</td>
				<td width="250"><%=mbean.getEmail()%></td>
			<tr height="50">
				<td align="center" width="150">��ȭ</td>
				<td width="250"><%=mbean.getTel()%></td>
			<tr height="50">
				<td align="center" width="150">���</td>
				<td width="250"><%=mbean.getHobby()%></td>
			<tr height="50">
				<td align="center" width="150">����</td>
				<td width="250"><%=mbean.getJob()%></td>
			<tr height="50">
				<td align="center" width="150">����</td>
				<td width="250"><%=mbean.getAge()%></td>
			<tr height="50">
				<td align="center" width="150">����</td>
				<td width="250"><%=mbean.getInfo()%></td>
			</tr>

			<tr height="50">
				<td align="center" colspan="2">
					<!-- submit�� �������ͽÿ��� ���� ���� (�����͸� ������) -->
					<button
						onclick="location.href='MemberUpdateForm.jsp?id=<%=mbean.getId()%>'">ȸ������</button>
					<!-- onclick�� �ٸ��������� �̵� -->
					<button
						onclick="location.href='MemberDeletForm.jsp?id=<%=mbean.getId()%>'">ȸ������</button>
					<!-- ��Ŭ������ id�� ������ �̵��ÿ� ���� �ѱ��. -->
					<button
						onclick="location.href='MemberList.jsp?id=<%=mbean.getId()%>'">��Ϻ���</button>
					<button
						onclick="location.href='MemberJoin.jsp?id=<%=mbean.getId()%>'">ȸ������</button>
				</td>
			</tr>

			</center>
		</table>
</body>
</html>