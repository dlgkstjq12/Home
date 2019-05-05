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
		<!-- 기존에 있는 데이터만 들어가고 나머지는 null로 들어가기 때문에 문제가 없다. -->
		<jsp:setProperty name="mbean" property="*" />
		<!-- 또한 null이 들어가도, null이 된 자료를 빼는것이 아니기 때문에 문제가 없다. -->
	</jsp:useBean>
	<% 
	String id = request.getParameter("id");

	MemberDAO mdao = new MemberDAO(); //메소드를 호출하기 위해 객체 생성
	String pass = mdao.getPass(id); //String 타입으로 저장되어있는 패스워드를 가져옴 (데이터베이스에서 가져온 pass 값이 저장)

	//수정하기위해서 작성한 패스워드값과 기존 데이터베이스에서 가져온 패스워드 값을 비교
	
	if(mbean.getPass1().equals(pass)) //기존 패스워드와 데이터베이스의 패스가 같다면 member테이블을 수정
	{
		//MemberDAO 클래스의 회원수정 메소드를 호출
		mdao.updateMember(mbean);
		response.sendRedirect("MemberList.jsp"); //멤버리스트 파일로 넘어간다.
	}
	else
	{
%>
	<script type="text/javascript">
	 alert("패스워드가 맞지 않습니다. 다시 확인해 주세요") 
	 history.go(-1);
	 </script>
	<% 	
	}
%>
</body>
</html>