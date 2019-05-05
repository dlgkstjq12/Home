<%@page import="ch11.MemberBean"%>
<%@page import="ch11.MemberDAO"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<%
		String id = request.getParameter("id");
		MemberDAO mdao = new MemberDAO();
		MemberBean mbean = mdao.oneSelectMember(id);
	%>

	<center>
		<h2>회원 정보 수정 하기</h2>

		<table width="400" border="1">
			<form action="MemberUpdateProc.jsp" method="post">
			<tr height="50">
				<td align="center" width="150">아이디</td>
				<td width="250"><%=mbean.getId()%></td>
			</tr>

			<tr height="50">
				<td align="center" width="150">이메일</td>
				<td width="250"><input type="email" name="email"
					value="<%=mbean.getEmail()%>"></td>
			</tr>
			<!-- 이메일의 값을 바꾸는 것이므로 value값에 getEmail()을 넣는다.-->

			<tr height="50">
				<td align="center" width="150">전화</td>
				<td width="250"><input type="tel" name="tel"
					value="<%=mbean.getTel()%>"></td>

			</tr>

			<tr height="50">
				<td align="center" width="150">패스워드</td>
				<td width="250"><input type="password" name="pass1"></td>
				<!-- 패스워드를 입력하고 결과가 맞아야만 정보 수정 가능 -->
				</td>
			</tr>


			<tr height="50">
				<td align="center" colspan="2">
					<!-- submit은 폼데이터시에만 쓸수 있음 (데이터를 보낼때) --> <input type="hidden"
					name="id" value="<%=mbean.getId()%>"> <!--hidden은 안보이게 넘기는것 즉,아이디 값을 안보이게 넘긴다는 것 -->
					<input type="submit" value="회원 수정하기"> &nbsp;&nbsp;
					</form>
					<button onclick="location.href='MemberList.jsp'">회원 전체 보기
					</button> <!-- 회원 전체보기 페이지로 돌아감 -->
				</td>
				</center>
		</table>
</body>
</html>