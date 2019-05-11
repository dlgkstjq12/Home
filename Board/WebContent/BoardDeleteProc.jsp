<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<!-- 패스워드랑 num만 받기 때문에 한글깨짐 방지는 따로 안해도된다. -->

	<%
		//두가지의 값만 받기때문에 유즈빈을 사용해도 되지만, request를 사용했다. (패스워드와 넘버를 받는다.)
		String pass = request.getParameter("password");
		int num = Integer.parseInt(request.getParameter("num"));

		//데이터베이스 연결
		BoardDAO bdao = new BoardDAO();
		String password = bdao.getPass(num);

		//기존 패스워드값과 delete form에서 작성한 패스워드를 비교
		if (pass.equals(password)) {
			//패스워드가 둘다 같다면
			bdao.deleteBoard(num);

			//응답한다음 BoardList.jsp로 이동함
			response.sendRedirect("BoardList.jsp");

		} else {
	%>
	<script>
		//패스워드가 틀리면 바로 전페이지로 돌아가게끔 script 코드 작성
		alert("패스워드가 틀려서 삭제 할수 없습니다. 패스워드를 확인해주세요.");
		history.go(-1);
	</script>
	<%
		}
	%>
</body>
</html>