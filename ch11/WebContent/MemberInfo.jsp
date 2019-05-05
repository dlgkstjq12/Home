<%@page import="ch11.MemberBean"%>
<%@page import="ch11.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
</head>
<body>
	<!-- memberlist에서 넘긴 id를 받아줌  1.데이터베이스에서 한 사람의 정보를 가져옴   2. table 태그를 이용하여 화면에 회원의 정보 출력 -->

	<%
		String id = request.getParameter("id");

		MemberDAO mdao = new MemberDAO();
		MemberBean mbean = mdao.oneSelectMember(id);
	%>

	<center>
		<h2>회원 정보 보기</h2>

		<table width="400" border="1">

			<tr height="50">
				<td align="center" width="150">아이디</td>
				<td width="250"><%=mbean.getId()%></td>
			<tr height="50">
				<td align="center" width="150">이메일</td>
				<td width="250"><%=mbean.getEmail()%></td>
			<tr height="50">
				<td align="center" width="150">전화</td>
				<td width="250"><%=mbean.getTel()%></td>
			<tr height="50">
				<td align="center" width="150">취미</td>
				<td width="250"><%=mbean.getHobby()%></td>
			<tr height="50">
				<td align="center" width="150">직업</td>
				<td width="250"><%=mbean.getJob()%></td>
			<tr height="50">
				<td align="center" width="150">나이</td>
				<td width="250"><%=mbean.getAge()%></td>
			<tr height="50">
				<td align="center" width="150">정보</td>
				<td width="250"><%=mbean.getInfo()%></td>
			</tr>

			<tr height="50">
				<td align="center" colspan="2">
					<!-- submit은 폼데이터시에만 쓸수 있음 (데이터를 보낼때) -->
					<button
						onclick="location.href='MemberUpdateForm.jsp?id=<%=mbean.getId()%>'">회원수정</button>
					<!-- onclick는 다른페이지로 이동 -->
					<button
						onclick="location.href='MemberDeletForm.jsp?id=<%=mbean.getId()%>'">회원삭제</button>
					<!-- 빈클래스의 id를 페이지 이동시에 같이 넘긴다. -->
					<button
						onclick="location.href='MemberList.jsp?id=<%=mbean.getId()%>'">목록보기</button>
					<button
						onclick="location.href='MemberJoin.jsp?id=<%=mbean.getId()%>'">회원가입</button>
				</td>
			</tr>

			</center>
		</table>
</body>
</html>