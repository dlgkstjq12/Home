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
		request.setCharacterEncoding("EUC-KR"); //한글 처리

		//취미 부분은 별도로 읽어들여 다시 빈클래스에 저장

		String[] hobby = request.getParameterValues("hobby");
		//배열에 있는 내용을 하나의 스트림으로 저장
		String texthobby = "";

		for (int i = 0; i < hobby.length; i++) {
			texthobby += hobby[i] + " "; //취미를 배열을 사용해 하나씩 출력해서 texthobby에 넣는다.
		}
	%>

	<!-- useBean을 이용하여 한꺼번에 데이터를 받아옴 -->
	<!-- 맵핑 시키시오 -->
	<jsp:useBean id="mbean" class="ch11.MemberBean">
		<jsp:setProperty name="mbean" property="*" />
	</jsp:useBean>

	<%
		mbean.setHobby(texthobby); //기존 취미는 주소번지가 저장되기에 위에 배열의 내용을 하나의 스트림으로 저장한 변수를 다시 입력

		MemberDAO mdao = new MemberDAO(); //insert 메소드를 사용하기 위해 MemberDAO 객체 생성
		mdao.insertMember(mbean); //insert메소드를 호출해 mbean에 저장된 값을 넘겨주면 그 값이 데이터베이스에 저장된다.
	%>

	오라클에 접속 완료 ~

</body>
</html>
