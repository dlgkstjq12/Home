<%@page import="java.util.Vector"%>
<%@page import="model.BoardDAO"%>
<%@page import="model.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>


	<center>
		<h2>��ü �Խñ� ����</h2>
		<!-- �Խñ� ���⿡ ī���͸��� �����ϱ����� �������� ���� -->

		<%
			//10���� ��� ȭ�鿡 �����ֱ�
			//ȭ�鿡 ������ �Խñ��� ������ ����
			int pageSize = 10;

			//���� ī���͸� Ŭ���� ��ȣ���� �о�� (������� 1�� Ŭ���ϸ� 1~10�� ���� ������, 2�� Ŭ���ϸ� 11~20�� ���� �������� �ϴ°�)

			String pageNum = request.getParameter("pageNum");
			//���� ó�� boardlist.jsp�� Ŭ���ϰų� ���� ���� �� �ٸ� �Խñۿ��� �� �������� �Ѿ���� pageNum���� ���⿡ null ó���� ����
			//�ٸ����������� num�� �ѱ����� ���⶧���� ������ list�������� �����־�� �Ѵ�.

			if (pageNum == null) {
				pageNum = "1";
			}
			int count = 0; //��ü ���� ������ ����
			int number = 0; //������ �ѹ��� ����

			//���� ������ �ϴ� ������ ���ڸ� ���� (���� String Ÿ�����̾����� Ÿ�Ժ�ȯ�� ��Ų��.)
			int currentPage = Integer.parseInt(pageNum);

			//��ü �Խñ��� ������ jsp������ �����;���
			//���̸� ��Ȯ�� �� �� ���� ������ ���������� ���ͷ� �޴´�.
			BoardDAO bdao = new BoardDAO();

			//��ü �Խñ��� ������ �о���̴� �޼ҵ� ȣ�� (ī���͸��ҷ��� ��ü �Խñ��� ���ڰ� �ʿ��ϱ� ����)
			count = bdao.getAllCount();

			//���� �������� ������ ���۹�ȣ�� ����(�ֽű��� �����ֱ� ���ؼ�. ���� ��� 77��°���� �ֽ��̸� 77���� 67��°������ �Խñ��� ù�������� ������)
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = currentPage * pageSize;

			//�ֽű� 10���� �������� �Խñ��� ���� �޾��ִ� �޼ҵ� ȣ��
			Vector<BoardBean> vec = bdao.getAllBoard(startRow, endRow);

			//���̺� ǥ���� ��ȣ�� ����
			number = count - (currentPage - 1) * pageSize;
		%>

		<table width="700" border="1" bgcolor="skyblue">
			<tr height="40">
				<td align="right" colspan="5">
					<!-- ��ư�� Ŭ���ϸ� BoardWriteForm.jsp���Ϸ� �Ѿ��.--> <input type="button"
					value="�۾���" onclick="location.href='BoardWriteForm.jsp'">
				</td>
			</tr>
			<tr height="40">

				<td width="50" align="center">��ȣ</td>
				<td width="320" align="center">����</td>
				<td width="100" align="center">�ۼ���</td>
				<td width="150" align="center">�ۼ���</td>
				<td width="80" align="center">��ȸ��</td>
			</tr>
			<%
				for (int i = 0; i < vec.size(); i++) {
					BoardBean bean = vec.get(i); //���Ϳ� ����Ǿ��ִ� beanŬ������ �ϳ��� ����
			%>
			<tr height="40">
				<!-- ����Ʈ ������ ���ڰ� ����ũ�� ������ �������� ���ҵǱ⶧���� ���ڸ� ���ҽ��Ѽ� ǥ���Ѵ�. -->
				<td width="50" align="center"><%=number--%></td>
				<!-- ���ڰ� �ϳ��� �ö󰡰� �ϱ����ؼ� i+1�� ���ش� -->
				<!-- getNum()�� ���� ������ ���������� ���� -->
				<td width="320" align="center"><a
					href="BoardInfo.jsp?num=<%=bean.getNum()%>"
					style="text-decoration: none"> <!-- ���� ���� ���� ������� ����� �ڵ� --> <%
 	//�亯 �鿩���⸦ �ϱ����� for��
 		if (bean.getRe_step() > 1) {
 			for (int j = 0; j < (bean.getRe_step() - 1) * 5; j++) {
 %>&nbsp; <%
 	}

 		}
 %> <%=bean.getSubject()%></a></td>
				<!-- BoardInfo.jsp����(������ Ȯ���ϱ� ��������)�� Num���� �Ѱ��ش� -->
				<td width="100" align="center"><%=bean.getWriter()%></td>
				<td width="150" align="center"><%=bean.getReg_date()%></td>
				<td width="80" align="center"><%=bean.getReadcount()%></td>
			</tr>
			<%
				}
			%>

		</table>
		<p>
			<!-- ������ ī���͸� �ҽ��� �ۼ� -->
			<%
				if (count > 0) {
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); //ī���͸� ���ڸ� �󸶱��� �����ٰ��� ����

					//���� ������ ���ڸ� ����
					int startPage = 1;

					if (currentPage % 10 != 0) {
						startPage = (int) (currentPage / 10) * 10 + 1;

					} else {
						startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
					}

					int pageBlock = 10; //ī���͸� ó�� ����
					int endPage = startPage + pageBlock - 1; //ȭ�鿡 ������ �������� ������ ����

					if (endPage > pageCount)
						endPage = pageCount;

					//�����̶�� ��ũ�� ������� �ľ�
					if (startPage > 10) {
			%>
			<a href="BoardList.jsp?pageNum=<%=startPage - 10%>"> [����] </a>
			<%
				}

					//����¡ ó��
					for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="BoardList.jsp?pageNum=<%=i%>"> [<%=i%>]
			</a>
			<%
				}

					//�����̶�� ��ũ�� ������� �ľ�
					if (endPage < pageCount) {
			%>
			<a href="BoardList.jsp?pageNum=<%=startPage + 10%>"> [����] </a>
			<%
				}

				}
			%>
		
	</center>
</body>
</html>
