<%@page import="model.BoardBean"%>
<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<%
    int num=Integer.parseInt(request.getParameter("num").trim()); //리스트 파일에서 넘겨준  num값을 받는다. num이 테이블의 기본키이기 때문에 num으로 정보를 확인할수 있기 때문
    //공백제거후 정수형으로 바뀜 (정수형으로 바꾸면 숫자를 넣기가 쉽기 때문에)
    
    //데이터베이스 접근
    BoardDAO bdao = new BoardDAO();
    //boardbean 타입으로 하나의 게시글을 리턴 받는다.
    BoardBean bean = bdao.getOneBoard(num);
    
%>
	<center>
		<h2>게시글 보기</h2>
		<!-- 빈클레스가 가지고있는 값들을 뿌려준다. -->
		<table width="600" border="1" bgcolor="skyblue">
			<tr height="40">
				<td align="center" width="120">글 번호</td>
				<td align="center" width="180"><%=bean.getNum() %></td>


				<td align="center" width="120">조회수</td>
				<td align="center" width="180"><%=bean.getReadcount() %></td>
			</tr>

			<tr height="40">
				<td align="center" width="120">작성자</td>
				<td align="center" width="180"><%=bean.getWriter() %></td>

				<td align="center" width="120">작성일</td>
				<td align="center" width="180"><%=bean.getReg_date() %></td>
			<tr height="40">
				<td align="center" width="120" colspan="2">이메일</td>
				<td align="center" width="180" colspan="2"><%=bean.getEmail() %></td>
			</tr>

			<tr height="40">
				<td align="center" width="120">제목</td>
				<td align="center" colspan="3"><%=bean.getSubject() %></td>
			</tr>

			<tr height="80">
				<td align="center" width="120">글 내용</td>
				<td align="center" colspan="3"><%=bean.getContent() %></td>
			</tr>

			<tr height="40">
				<td align="center" colspan="4"><input type="button"
					value="답글쓰기"
					onclick="location.href='BoardReWriteForm.jsp?num=<%=bean.getNum()%>&ref=<%=bean.getRef()%>&re_step=<%=bean.getRe_step()%>&re_level=<%=bean.getRe_level()%>'">
					<!-- 부모글의 ref, revel, num값을 다 알고 있어야된다.(리플달기이기 때문) --> <!-- 위에처럼 num값만 넘겨서 할수도 있다.
        int num = Integer.parseInt(request.getParameter("num").trim());
        BoardDAO bdao = new BoardDAO();
        BoardBean bean = bdao.getOneBoard(num); --> <input type="button"
					value="수정하기"
					onclick="location.href = 'BoardUpdateForm.jsp?num=<%=bean.getNum()%>'">
					<input type="button" value="삭제하기"
					onclick="location.href = 'BoardDeleteForm.jsp?num=<%=bean.getNum()%>'">
					<input type="button" value="목록보기"
					onclick="location.href = 'BoardList.jsp?num=<%=bean.getNum()%>'">
		</table>
	</center>
</body>
</html>
