<%@page import="db.CarListBean"%>
<%@page import="java.util.Vector"%>
<%@page import="db.RentcarDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<!-- 카테고리 분류값을 받아와서 소형,중형, 대형에 따라 화면에 출력함 -->
	<%
		int category = Integer.parseInt(request.getParameter("category"));
		String temp = "";
		if (category == 1)
			temp = "소형";
		else if (category == 2)
			temp = "중형";
		else if (category == 3)
			temp = "대형";
	%>
	<center>
		<table width="1000">
			<tr height="100">
				<td align="center" colspan="3"><font size="6" color="gray">
						<%=temp%>자동차
				</font></td>
			</tr>
			<%
				//카테고리 분류값을 받아온다. (검색의 기준으로 삼아야하기 때문)
				//CarRserveMain페이지 에서 //select 옵션으로 준 값들을 가져온다.
				//소형=1, 중형=2 등등등
				//request.getParameter 값은 다 string 타입이기때문에 포장클래스를 사용해 타입변환을 한다.

				System.out.println("category");

				//DB연결을 위해 객체를 생성
				RentcarDAO rdao = new RentcarDAO();

				//값이 유동적이기 때문에 벡터로 받고, 파라미터로 받은 category (분류값들)를 매개값으로 준다.
				Vector<CarListBean> v = rdao.getCategoryCar(category);

				//tr을 3개씩 보여주고 다시 tr을 실행할 수 있도록 하는 변수 선언
				int j = 0;
				for (int i = 0; i < v.size(); i++) {
					//벡터에 저장되어 있는 빈 클래스를 추출
					CarListBean bean = v.get(i);
					//3번마다 0이 돌아온다는 뜻. 즉 3번에 한번 실행하도록 하는 구문
					if (j % 3 == 0) {
			%>
			<tr height="220">
				<%
					}
				%>
				<td width="333" align="center"><a
					href="RentcarMain.jsp?center=CarReserveInfo.jsp?no=<%=bean.getNo()%>">
						<img alt="" src="img/<%=bean.getImg()%>" width="300" height="200">
				</a>
					<p>
						<font size="3" color="gray"><b>차량명 : <%=bean.getName()%>
						</b> </font></td>



				<%
					j = j + 1; //j값을 증가하여 하나의 행에 총3개의 차량정보를 보여주기 위해서 증가
					}
				%>
			
		</table>
	</center>
</body>
</html>