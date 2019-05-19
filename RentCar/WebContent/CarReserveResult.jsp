<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
		String id = (String) session.getAttribute("id");

		//null값과 비교할시에는 GUEST값이 나와버리므로 
		//null 대신에 GUEST와 비교한다.
		//비교한후에 참이면 (로그인이 안되었으면) 로그인페이지로 이동하게함
		if (id == null) {
	%>

	<script>
		//예약할시에 로그인이 안되어있을경우 출력되는 메시지
		alert("로그인후 예약이 가능합니다.");
		//로그인이 안되어있을경우 로그인 페이지로 이동
		location.href = 'RentcarMain.jsp?center=MemberLogin.jsp';
	</script>

	<%
		}
		//날짜 비교 (현재 날짜보다 앞에 날짜는 선택 못하게 하기.. )
		Date d1 = new Date();
		Date d2 = new Date();
		//날짜를 2016-4-4 로 포맷해주는 클래스 선언, month은 대문자 M을 사용
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		//d1은 yyyy-MM-dd 형식으로 변경된다.
		d1 = sdf.parse(rbean.getRday());
		//d2는 yyyy-MM-dd 형식으로 변경된다.
		d2 = sdf.parse(sdf.format(d2));

		//날짜 비교 메소드를 사용가능 date 클래스 사용

		int compare = d1.compareTo(d2);
		//예약하려는 날짜보다 현재 날짜가 크다면 -1을 반환
		//예약하려는 날짜와 현재 날짜가 같다면 0을 반환
		//예약하려는 날짜가 더 크다면 1을 리턴함

		if (compare < 0) {
			//오늘보다 이전 날짜 선택시 예약이 안되게끔 해야함
	%>

	<script>
		alert("현재 시스템 날짜보다 이전 날짜는 선택할 수 없음");
		history.go(-1);//이전 단계로 이동하시오.
	</script>

	<%
		}
	%>


</body>
</html>