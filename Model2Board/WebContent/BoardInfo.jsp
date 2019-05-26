<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<center>
		<h2>게시글 보기</h2>

		<table width="600" border="1">
			<tr height="40">
				<td align="center" width="120">글 번호</td>
				<td align="center" width="180">${bean.num }</td>
				<td align="center" width="120">조회수</td>
				<td align="center" width="180">${bean.readcount }</td>
			</tr>

			<tr height="40">
				<td align="center" width="120">작성자</td>
				<td align="center" width="180">${bean.writer }</td>
				<td align="center" width="120">작성일</td>
				<td align="center" width="180">${bean.reg_date}</td>
			</tr>

			<tr height="40">
				<td align="center" width="120" colspan="2">이메일</td>
				<td align="center" width="180" colspan="2">${bean.email }</td>
			</tr>

			<tr height="40">
				<td align="center" width="120">제목</td>
				<td align="center" colspan="3">${bean.subject }</td>
			</tr>

			<tr height="80">
				<td align="center" width="120">글 내용</td>
				<td align="center" colspan="3">${bean.content }</td>
			</tr>


			<!-- 답글쓰기는 게시글 번호 그룹등을 다 넘겨주어야 한다. 게시글의 번호가 바뀌기 때문 -->
			<tr height="40">
				<td align="center" colspan="4"><input type="button"
					value="답글쓰기"
					onclick="location.href='BoardReWriteCon.do?num=${bean.num }&ref=${bean.ref }&re_step=${bean.re_step }&re_level=${bean.re_level }'">
					<!-- 부모글의 ref, revel, num값을 다 알고 있어야된다.(리플달기이기 때문) --> <!-- 위에처럼 num값만 넘겨서 할수도 있다.
        int num = Integer.parseInt(request.getParameter("num").trim());
        BoardDAO bdao = new BoardDAO();
        BoardBean bean = bdao.getOneBoard(num); --> <input type="button"
					value="수정하기"
					onclick="location.href = 'BoardUpdateCon.do?num=${bean.num}'">
					<input type="button" value="삭제하기"
					onclick="location.href = 'BoardDeleteCon.do?num=${bean.num }'">
					<input type="button" value="목록보기"
					onclick="location.href = 'BoardListCon.do'">
		</table>
	</center>





</body>
</html>