<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

	<!-- 세션을 이용한 로그인 처리 -->
	<!-- 세션으로 받아온 값은 오브젝트 타입이기 때문에 String 타입으로 컨버팅 한다. -->

	<%
        String id = (String) session.getAttribute("id");
 
        //로그인이 되어있지 않다면 id에 "GUEST"값을 준다
        if (id == null) {
            id = "GUEST";
        }
    %>

	<table width="1000" bordercolor="white">
		<tr height="70">
			<td colspan="4"><a href="RentcarMain.jsp"
				style="text-decoration: none"> <!-- 이미지를 불러오기위한 태그 작성 --> <img
					alt="" src="img/RENT.jpg" height="150" width="250">
			</a></td>
			<td align="center" width="200"><%=id%> 님 <%
				if(id.equals("GUEST")){ %>
				<button
					onclick="location.href='RentcarMain.jsp?center=MemberLogin.jsp'">
					로그인</button> <%
				}else{%>
				<button onclick="location.href='MemberLogout.jsp'">로그아웃</button> <% 
				}
				
			%></td>
		</tr>
		<!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 -->
		<tr height="50">
			<td align="center" width="200" bgcolor="pink"><font
				color="white" size="5"> <a
					href="RentcarMain.jsp?center=CarReserveMain.jsp"
					style="text-decoration: none"> 예 약 하 기 </a></font></td>

			<td align="center" width="200" bgcolor="pink">
				<!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="5"><a
					href="#" style="text-decoration: none"> 예 약 확 인</a></font>
			</td>

			<td align="center" width="200" bgcolor="pink">
				<!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="5"><a
					href="#" style="text-decoration: none"> 자 유 게 시 판 </a></font>
			</td>

			<td align="center" width="200" bgcolor="pink">
				<!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="5"><a
					href="#" style="text-decoration: none"> 이 벤 트 </a></font>
			</td>

			<td align="center" width="200" bgcolor="pink">
				<!-- 글자를 누르면 화면이 넘어갈수 있도록 a태그를 걸어줌 --> <font color="white" size="5"><a
					href="#" style="text-decoration: none"> 고 객 센 터 </a></font>
			</td>
		</tr>

	</table>
</body>
</html>
