<%@page import="model.BoardDAO"%>
<%@page import="model.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

	<%
		BoardDAO bdao = new BoardDAO();
		//String �����̱� ������ ����Ŭ������ ����ؼ� Ÿ���� ��ȯ�Ѵ�.
		int num = Integer.parseInt(request.getParameter("num"));

		//�ϳ��� �Խñ��� �����ؾ��ϱ� ������ (getOneUpdateBoard�޼ҵ带 ����ص� �ȴ�.)
		BoardBean bean = bdao.getOneUpdateBoard(num);
	%>
	<center>
		<h2>�Խñ� ����</h2>
		<!-- �н����� ���� �ѱ�⶧���� post��� ��� -->
		<form action="BoardDeleteProc.jsp" method="post">
			<table width="600" border="1" bgcolor="skyblue">
				<tr height="40">
					<td width="120" align="center">�ۼ���</td>
					<td width="180" align="center"><%=bean.getWriter()%></td>

					<td width="120" align="center">�ۼ���</td>
					<td width="180" align="center"><%=bean.getReg_date()%></td>
				</tr>

				<tr height="40">
					<td width="120" align="center">����</td>
					<td align="center" colspan="3"><%=bean.getSubject()%></td>
				</tr>

				<tr height="40">
					<td width="120" align="center">�н�����</td>
					<!-- �н������ �����޾ƾߵǱ⶧���� �󿡼� �����ʴ´�.-->
					<td align="Left" colspan="3"><input type="password"
						name="password" size="60"></td>
				</tr>


				<tr height="40">
					<td align="center" colspan="4"><input type="hidden" name="num"
						value="<%=num%>">
					<!-- ó�����Ͽ� num���� �״�� �Ѱ��ش� (�����ϱ� ���ؼ�) --> <input type="submit"
						value="�ۻ���"> &nbsp;&nbsp; <input type="button"
						onclick="location.href='BoardList.jsp'" value="��Ϻ���"></td>
				</tr>


			</table>
		</form>
	</center>
</body>
</html>