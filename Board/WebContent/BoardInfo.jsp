<%@page import="model.BoardBean"%>
<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<%
    int num=Integer.parseInt(request.getParameter("num").trim()); //����Ʈ ���Ͽ��� �Ѱ���  num���� �޴´�. num�� ���̺��� �⺻Ű�̱� ������ num���� ������ Ȯ���Ҽ� �ֱ� ����
    //���������� ���������� �ٲ� (���������� �ٲٸ� ���ڸ� �ֱⰡ ���� ������)
    
    //�����ͺ��̽� ����
    BoardDAO bdao = new BoardDAO();
    //boardbean Ÿ������ �ϳ��� �Խñ��� ���� �޴´�.
    BoardBean bean = bdao.getOneBoard(num);
    
%>
	<center>
		<h2>�Խñ� ����</h2>
		<!-- ��Ŭ������ �������ִ� ������ �ѷ��ش�. -->
		<table width="600" border="1" bgcolor="skyblue">
			<tr height="40">
				<td align="center" width="120">�� ��ȣ</td>
				<td align="center" width="180"><%=bean.getNum() %></td>


				<td align="center" width="120">��ȸ��</td>
				<td align="center" width="180"><%=bean.getReadcount() %></td>
			</tr>

			<tr height="40">
				<td align="center" width="120">�ۼ���</td>
				<td align="center" width="180"><%=bean.getWriter() %></td>

				<td align="center" width="120">�ۼ���</td>
				<td align="center" width="180"><%=bean.getReg_date() %></td>
			<tr height="40">
				<td align="center" width="120" colspan="2">�̸���</td>
				<td align="center" width="180" colspan="2"><%=bean.getEmail() %></td>
			</tr>

			<tr height="40">
				<td align="center" width="120">����</td>
				<td align="center" colspan="3"><%=bean.getSubject() %></td>
			</tr>

			<tr height="80">
				<td align="center" width="120">�� ����</td>
				<td align="center" colspan="3"><%=bean.getContent() %></td>
			</tr>

			<tr height="40">
				<td align="center" colspan="4"><input type="button"
					value="��۾���"
					onclick="location.href='BoardReWriteForm.jsp?num=<%=bean.getNum()%>&ref=<%=bean.getRef()%>&re_step=<%=bean.getRe_step()%>&re_level=<%=bean.getRe_level()%>'">
					<!-- �θ���� ref, revel, num���� �� �˰� �־�ߵȴ�.(���ôޱ��̱� ����) --> <!-- ����ó�� num���� �Ѱܼ� �Ҽ��� �ִ�.
        int num = Integer.parseInt(request.getParameter("num").trim());
        BoardDAO bdao = new BoardDAO();
        BoardBean bean = bdao.getOneBoard(num); --> <input type="button"
					value="�����ϱ�"
					onclick="location.href = 'BoardUpdateForm.jsp?num=<%=bean.getNum()%>'">
					<input type="button" value="�����ϱ�"
					onclick="location.href = 'BoardDeleteForm.jsp?num=<%=bean.getNum()%>'">
					<input type="button" value="��Ϻ���"
					onclick="location.href = 'BoardList.jsp?num=<%=bean.getNum()%>'">
		</table>
	</center>
</body>
</html>
