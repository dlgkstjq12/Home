<%@page import="db.CarListBean"%>
<%@page import="java.util.Vector"%>
<%@page import="db.RentcarDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>

		<!-- 데이터베이스에 연결하여 최신순 자동차 3대만 뿌려주는 데이터를 가져옴 -->

		<%
			RentcarDAO rdao = new RentcarDAO();
			//벡터를 이용하여 자동차데이터를 저장함
			Vector<CarListBean> v = rdao.getSelectCar();
		%>

		<table width="1000">
			<tr height="100">
				<td align="center" colspan="3"><font size="6" color="gray">최신형
						자동차</font></td>
			</tr>


			<tr height="240">
				<!-- 벡터에 저장된 이미지를 하나씩 출력해야하기 때문에 for문을 돌리고, 그 값들을 빈클래스 변수에 넣어준다. -->
				<%
					for (int i = 1; i < v.size(); i++) {
						CarListBean bean = v.get(i);
				%>
				<td width="333" align="center">
					<!-- 이미지는 벡터의 0번지에 해당되는걸 가져온다. for문을 돌려 td를 출력해야 한다.--> <!-- 확장자는 이미지안에 있으므로 궂이 적지 않아도 된다. -->
					<!-- 이미지를 누르면 바로 상세정보로 넘어갈수 있도록 하기위해  <a>태그를 걸고, No에 대한 상세정보가 출력되도록 하고
        이름을 사진밑에 출력하도록 한다. --> <a
					href="RentcarMain.jsp?center=CarReserveInfo.jsp?no=<%=bean.getNo()%>"> <img alt=""
						src="img/<%=bean.getImg()%>" width="300" height="220">
				</a>
					<p>
						차량명 :
						<%=bean.getName()%>
				</td>


				<%
					}
				%>
			
		</table>

		<p>
			<font size="4" color="gray"> 차량 검색 하기 </font><br> <br> <br>
			<!-- 종류를 선택하고 검색을 하면 종류라는 데이터들 가지고 넘어가야하기 때문에 form형식을 사용한다. -->
		<form action="RentcarMain.jsp?center=CarCategoryList.jsp"
			method="post">
			<font size="3" color="gray"> <b>차량 검색 하기</b>
			</font>&nbsp;&nbsp; <select name="category">
				<option value="1">소형</option>
				<option value="2">중형</option>
				<option value="3">대형</option>
			</select>&nbsp;&nbsp; <input type="submit" value="검색"> &nbsp;&nbsp;

		</form>
		<button
			onclick="location.href='RentcarMain.jsp?center=CarAllList.jsp'">전체
			검색</button>

	</center>
</body>

</html>
