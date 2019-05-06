<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<form name="frmName" method="post" enctype="multipart/form-data"
		action="viewPage.jsp">
		<!-- 파일을 전송해서 업로드하기 위해 필요한 form 태그와 input 태그를 지정 -->
		user<br /> <input name="user"><br /> title<br /> <input
			name="title"><br /> file<br /> <input type="file"
			name="uploadFile"><br />
		<!-- 파일을 업로드하기 위해 input type을 file로 지정 -->
		<input type="submit" value="UPLOAD"><br />
	</form>
</body>
</html>