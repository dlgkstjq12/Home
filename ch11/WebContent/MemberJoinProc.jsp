<%@page import="ch11.MemberDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

	<%
		request.setCharacterEncoding("EUC-KR"); //�ѱ� ó��

		//��� �κ��� ������ �о�鿩 �ٽ� ��Ŭ������ ����

		String[] hobby = request.getParameterValues("hobby");
		//�迭�� �ִ� ������ �ϳ��� ��Ʈ������ ����
		String texthobby = "";

		for (int i = 0; i < hobby.length; i++) {
			texthobby += hobby[i] + " "; //��̸� �迭�� ����� �ϳ��� ����ؼ� texthobby�� �ִ´�.
		}
	%>

	<!-- useBean�� �̿��Ͽ� �Ѳ����� �����͸� �޾ƿ� -->
	<!-- ���� ��Ű�ÿ� -->
	<jsp:useBean id="mbean" class="ch11.MemberBean">
		<jsp:setProperty name="mbean" property="*" />
	</jsp:useBean>

	<%
		mbean.setHobby(texthobby); //���� ��̴� �ּҹ����� ����Ǳ⿡ ���� �迭�� ������ �ϳ��� ��Ʈ������ ������ ������ �ٽ� �Է�

		MemberDAO mdao = new MemberDAO(); //insert �޼ҵ带 ����ϱ� ���� MemberDAO ��ü ����
		mdao.insertMember(mbean); //insert�޼ҵ带 ȣ���� mbean�� ����� ���� �Ѱ��ָ� �� ���� �����ͺ��̽��� ����ȴ�.
	%>

	����Ŭ�� ���� �Ϸ� ~

</body>
</html>
