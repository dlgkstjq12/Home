<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>답변글 입력하기</h2>
		<%
            //게시글 읽기에서 답변글쓰기를 클릭하면 넘겨주는 데이터들을 받아줌
            int num = Integer.parseInt(request.getParameter("num"));
            int ref = Integer.parseInt(request.getParameter("ref"));
            int re_step = Integer.parseInt(request.getParameter("re_step"));
            int re_level = Integer.parseInt(request.getParameter("re_level"));
        %>
		<form action="BoardReWriteProc.jsp" method="post">
			<!-- 답변글 처리 페이지로 자료를 전달 -->
			<table width="600" border="1" bordercolor="gray" bgcolor="skyblue">

				<tr height="40">
					<td width="150" align="center">작성자</td>
					<td width="450"><input type="text" name="writer" size="60"></td>
				</tr>

				<tr height="40">
					<td width="150" align="center">제목</td>
					<td width="450"><input type="text" name="subject" value="[답변]"
						size="60"></td>
				</tr>

				<tr height="40">
					<td width="150" align="center">이메일</td>
					<td width="450"><input type="email" name="email" size="60"></td>
				</tr>

				<tr height="40">
					<td width="150" align="center">비밀번호</td>
					<td width="450"><input type="password" name="password"
						size="60"></td>
				</tr>

				<tr height="40">
					<td width="150" align="center">글내용</td>
					<td width="450"><textarea rows="10" cols="60" name="content"></textarea></td>
				</tr>
				<!-- form에서 사용자로부터 입력 받지 않고 데이터를 넘김 -->
				<tr height="40">
					<!-- 각 데이터에 맞는 버튼을 만들어준다. -->
					<td align="center" colspan="2"><input type="hidden" name="ref"
						value="<%=ref%>"> <input type="hidden" name="re_step"
						value="<%=re_step%>"> <input type="hidden" name="re_level"
						value="<%=re_level%>"> <input type="submit" value="답글쓰기완료">
						&nbsp;&nbsp; <input type="reset" value="취소"> &nbsp;&nbsp;
						<input type="button" onclick="location.href='BoardList.jsp'"
						value="전체글보기"></td>
					<!-- 리스트 화면으로 돌아가는 버튼 -->
				</tr>

			</table>
		</form>
	</center>
</body>
</html>
