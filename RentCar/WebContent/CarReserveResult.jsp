<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<!-- 한글이 넘어올수도 있기 때문에 문자셋설정을 다시한다. -->

	<% 
	request.setCharacterEncoding("euc-kr");
%>
	<!-- 한번에 빈클래스에 있는 값들을 받아야되서 useBean 사용 -->
	<jsp:useBean id="rbean" class="db.CarReserveBean">
		<jsp:setProperty name="rbean" property="*" />
	</jsp:useBean>

	<% 
	//로그인한 아이디가 페이지가 변경되어도 유지가 되어야하기 때문에 세션으로 받는다.
	//받는 아이디는 오브젝트 타입이기 때문에 String 타입으로 타입변환을 시켜준다.
	String id = (String)session.getAttribute("id");
	

	//null값과 비교할시에는 GUEST값이 나와버리므로 
	//null 대신에 GUEST와 비교한다.
	//비교한후에 참이면 (로그인이 안되었으면) 로그인페이지로 이동하게함
	if(id==null)
	{
%>

	<script>//예약할시에 로그인이 안되어있을경우 출력되는 메시지
		alert("로그인후 예약이 가능합니다.");
	//로그인이 안되어있을경우 로그인 페이지로 이동
		location.href='RentcarMain.jsp?center=MemberLogin.jsp';
	</script>
	
	<%
	}

%>


</body>
</html>