<%@page import="ch11.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<%
	request.setCharacterEncoding("EUC-KR");
%>

	<jsp:useBean id="mbean" class="ch11.MemberBean">
		<!-- ������ �ִ� �����͸� ���� �������� null�� ���� ������ ������ ����. -->
		<jsp:setProperty name="mbean" property="*" />
		<!-- ���� null�� ����, null�� �� �ڷḦ ���°��� �ƴϱ� ������ ������ ����. -->
	</jsp:useBean>
	<% 
	String id = request.getParameter("id");

	MemberDAO mdao = new MemberDAO(); //�޼ҵ带 ȣ���ϱ� ���� ��ü ����
	String pass = mdao.getPass(id); //String Ÿ������ ����Ǿ��ִ� �н����带 ������ (�����ͺ��̽����� ������ pass ���� ����)

	//�����ϱ����ؼ� �ۼ��� �н����尪�� ���� �����ͺ��̽����� ������ �н����� ���� ��
	
	if(mbean.getPass1().equals(pass)) //���� �н������ �����ͺ��̽��� �н��� ���ٸ� member���̺��� ����
	{
		//MemberDAO Ŭ������ ȸ������ �޼ҵ带 ȣ��
		mdao.updateMember(mbean);
		response.sendRedirect("MemberList.jsp"); //�������Ʈ ���Ϸ� �Ѿ��.
	}
	else
	{
%>
	<script type="text/javascript">
	 alert("�н����尡 ���� �ʽ��ϴ�. �ٽ� Ȯ���� �ּ���") 
	 history.go(-1);
	 </script>
	<% 	
	}
%>
</body>
</html>