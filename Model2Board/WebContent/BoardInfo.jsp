<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>�Խñ� ����</h2>

		<table width="600" border="1">
			<tr height="40">
				<td align="center" width="120">�� ��ȣ</td>
				<td align="center" width="180">${bean.num }</td>
				<td align="center" width="120">��ȸ��</td>
				<td align="center" width="180">${bean.readcount }</td>
			</tr>

			<tr height="40">
				<td align="center" width="120">�ۼ���</td>
				<td align="center" width="180">${bean.writer }</td>
				<td align="center" width="120">�ۼ���</td>
				<td align="center" width="180">${bean.reg_date}</td>
			</tr>

			<tr height="40">
				<td align="center" width="120" colspan="2">�̸���</td>
				<td align="center" width="180" colspan="2">${bean.email }</td>
			</tr>

			<tr height="40">
				<td align="center" width="120">����</td>
				<td align="center" colspan="3">${bean.subject }</td>
			</tr>

			<tr height="80">
				<td align="center" width="120">�� ����</td>
				<td align="center" colspan="3">${bean.content }</td>
			</tr>


			<!-- ��۾���� �Խñ� ��ȣ �׷���� �� �Ѱ��־�� �Ѵ�. �Խñ��� ��ȣ�� �ٲ�� ���� -->
			<tr height="40">
				<td align="center" colspan="4"><input type="button"
					value="��۾���"
					onclick="location.href='BoardReWriteCon.do?num=${bean.num }&ref=${bean.ref }&re_step=${bean.re_step }&re_level=${bean.re_level }'">
					<!-- �θ���� ref, revel, num���� �� �˰� �־�ߵȴ�.(���ôޱ��̱� ����) --> <!-- ����ó�� num���� �Ѱܼ� �Ҽ��� �ִ�.
        int num = Integer.parseInt(request.getParameter("num").trim());
        BoardDAO bdao = new BoardDAO();
        BoardBean bean = bdao.getOneBoard(num); --> <input type="button"
					value="�����ϱ�"
					onclick="location.href = 'BoardUpdateCon.do?num=${bean.num}'">
					<input type="button" value="�����ϱ�"
					onclick="location.href = 'BoardDeleteCon.do?num=${bean.num }'">
					<input type="button" value="��Ϻ���"
					onclick="location.href = 'BoardListCon.do'">
		</table>
	</center>





</body>
</html>