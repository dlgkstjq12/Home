<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<!-- �ѱ��� �Ѿ�ü��� �ֱ� ������ ���ڼ¼����� �ٽ��Ѵ�. -->

	<% 
	request.setCharacterEncoding("euc-kr");
%>
	<!-- �ѹ��� ��Ŭ������ �ִ� ������ �޾ƾߵǼ� useBean ��� -->
	<jsp:useBean id="rbean" class="db.CarReserveBean">
		<jsp:setProperty name="rbean" property="*" />
	</jsp:useBean>

	<% 
	//�α����� ���̵� �������� ����Ǿ ������ �Ǿ���ϱ� ������ �������� �޴´�.
	//�޴� ���̵�� ������Ʈ Ÿ���̱� ������ String Ÿ������ Ÿ�Ժ�ȯ�� �����ش�.
	String id = (String)session.getAttribute("id");
	

	//null���� ���ҽÿ��� GUEST���� ���͹����Ƿ� 
	//null ��ſ� GUEST�� ���Ѵ�.
	//�����Ŀ� ���̸� (�α����� �ȵǾ�����) �α����������� �̵��ϰ���
	if(id==null)
	{
%>

	<script>//�����ҽÿ� �α����� �ȵǾ�������� ��µǴ� �޽���
		alert("�α����� ������ �����մϴ�.");
	//�α����� �ȵǾ�������� �α��� �������� �̵�
		location.href='RentcarMain.jsp?center=MemberLogin.jsp';
	</script>
	
	<%
	}

%>


</body>
</html>