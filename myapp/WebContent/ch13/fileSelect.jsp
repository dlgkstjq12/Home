<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<form name="frmName" method="post" enctype="multipart/form-data"
		action="viewPage.jsp">
		<!-- ������ �����ؼ� ���ε��ϱ� ���� �ʿ��� form �±׿� input �±׸� ���� -->
		user<br /> <input name="user"><br /> title<br /> <input
			name="title"><br /> file<br /> <input type="file"
			name="uploadFile"><br />
		<!-- ������ ���ε��ϱ� ���� input type�� file�� ���� -->
		<input type="submit" value="UPLOAD"><br />
	</form>
</body>
</html>