<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<body>
	<% 
	int no = Integer.parseInt(request.getParameter("no"));
	
	//차량 수량
	int qty = Integer.parseInt(request.getParameter("qty"));
	//이미지를 가져옴
	String img = request.getParameter("img");
%>
	<div style="text-align: center;">
		<form action="RentcarMain.jsp?center=CarReserveResult.jsp"
			method="post">
			<table width="1000">
				<tr height="100">
					<td align="center" colspan="3"><font size="6" color="gray">
							옵션 선택 </font></td>
				</tr>
				<tr>
					<!-- colspan은 가로셀끼리 병합하는 것이고, rowspan은 세로 셀끼리 병합하는 것 -->
					<!-- 차량 사진 옆에 정보들이 떠야하기때문에 세로병합인 rowspan을 사용 -->
					<td rowspan="7" width="500" align="center"><img alt=""
						src="img/<%=img %>" width="450"></td>
					<td width="250" align="center">대여기간</td>
					<td width="250" align="center"><select name="dday">
							<option value="1">1일</option>
							<option value="2">2일</option>
							<option value="3">3일</option>
							<option value="4">4일</option>
							<option value="5">5일</option>
							<option value="6">6일</option>
							<option value="7">7일</option>
					</select></td>
				</tr>
				<tr>
					<td width="250" align="center">대여일</td>
					<td width="250" align="center"><input type="date" name="rday"
						size="15"></td>
				<tr>
					<td width="250" align="center">보험적용</td>
					<td width="250" align="center"><select name="usein">
							<option value="1">적용 (1일 1만원)</option>
							<option value="2">미적용</option>
					</select></td>
				</tr>

				<tr>
					<td width="250" align="center">wifi 적용</td>
					<td width="250" align="center"><select name="usewifi">
							<option value="1">적용 (1일 1만원)</option>
							<option value="2">미적용</option>
					</select></td>
				</tr>

				<tr>
					<td width="250" align="center">네비게이션 적용</td>
					<td width="250" align="center"><select name="usenavi">
							<option value="1">적용 (무료)</option>
							<option value="2">미적용</option>
					</select></td>
				</tr>


				<tr>
					<td width="250" align="center">베이비시트 적용</td>
					<td width="250" align="center"><select name="useseat">
							<option value="1">적용 (1일 1만원)</option>
							<option value="2">미적용</option>
					</select></td>
				</tr>

				<tr>
					<td align="center" colspan="2"><input type="hidden" name="no"
						value="<%=no %>"> <input type="hidden" name="qty"
						value="<%=qty %>"> <input type="submit" value="차량예약하기"></td>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>