<%@page import="java.util.Vector"%>
<%@page import="ch11.MemberDAO"%>
<%@page import="ch11.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

	<!-- 1.데이터 베이스에서 모든 회원의 정보를 가져옴  2. table태그를 이용하여 화면에 회원들의 정보를 출력-->

	<%
        //회원들의 정보가 얼마나 저장되어있는지 모르기에 (배열은 길이가 고정되어 있기 때문에 List나 벡터를 쓴다.) (List,벡터는 가변길이를 지원)
        MemberDAO mdao = new MemberDAO();
        Vector<MemberBean> vec = mdao.allSelectMember();
        //MemberBean클래스를 안넣어주면 기본적으로 벡터는 오브젝트 클래스이기때문에 다시 캐스팅을 해주어야한다.
    %>

	<center>
		<h2>모든 회원 보기</h2>
		<table width="800" border="1">
			<tr height="50">
				<td align="center" width="150">아이디</td>
				<td align="center" width="250">이메일</td>
				<td align="center" width="200">전화번호</td>
				<td align="center" width="200">취미</td>
			</tr>
			<%
                for (int i = 0; i < vec.size(); i++) {
                    MemberBean bean = vec.get(i); //벡터에 담긴 빈클래스를 하나씩 추출
            %>
			<tr height="50">
				<td align="center" width="150"><a
					href="MemberInfo.jsp?id=<%=bean.getId()%>"> <!-- MemberInfo.jsp로 얻은 Id를 넘겨준다. -->
						<%=bean.getId()%></a></td>
				<td align="center" width="250"><%=bean.getEmail()%></td>
				<td align="center" width="200"><%=bean.getTel()%></td>
				<td align="center" width="200"><%=bean.getHobby()%></td>
			</tr>

			<%
                }
            %>
		</table>
	</center>
</body>
</html>
