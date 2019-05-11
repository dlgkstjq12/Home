<%@page import="java.util.Vector"%>
<%@page import="model.BoardDAO"%>
<%@page import="model.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>


	<center>
		<h2>전체 게시글 보기</h2>
		<!-- 게시글 보기에 카운터링을 설정하기위한 변수들을 선언 -->

		<%
			//10개씩 끊어서 화면에 보여주기
			//화면에 보여질 게시글의 개수를 지정
			int pageSize = 10;

			//현재 카운터를 클릭한 번호값을 읽어옴 (예를들어 1을 클릭하면 1~10개 까지 나오고, 2를 클릭하면 11~20개 까지 나오도록 하는것)

			String pageNum = request.getParameter("pageNum");
			//만약 처음 boardlist.jsp를 클릭하거나 수정 삭제 등 다른 게시글에서 이 페이지로 넘어오면 pageNum값이 없기에 null 처리를 해줌
			//다른페이지에서 num을 넘긴적이 없기때문에 최초의 list페이지를 보여주어야 한다.

			if (pageNum == null) {
				pageNum = "1";
			}
			int count = 0; //전체 글의 갯수를 저장
			int number = 0; //페이지 넘버링 변수

			//현재 보고자 하는 페이지 숫자를 저장 (원래 String 타입이이었으니 타입변환을 시킨다.)
			int currentPage = Integer.parseInt(pageNum);

			//전체 게시글의 내용을 jsp쪽으로 가져와야함
			//길이를 정확히 알 수 없기 때문에 가변길이인 벡터로 받는다.
			BoardDAO bdao = new BoardDAO();

			//전체 게시글의 갯수를 읽어들이는 메소드 호출 (카운터링할려면 전체 게시글의 숫자가 필요하기 때문)
			count = bdao.getAllCount();

			//현재 페이지에 보여줄 시작번호를 설정(최신글을 보여주기 위해서. 예를 들면 77번째글이 최신이면 77부터 67번째까지의 게시글을 첫페이지에 보여줌)
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = currentPage * pageSize;

			//최신글 10개를 기준으로 게시글을 리턴 받아주는 메소드 호출
			Vector<BoardBean> vec = bdao.getAllBoard(startRow, endRow);

			//테이블에 표시할 번호를 지정
			number = count - (currentPage - 1) * pageSize;
		%>

		<table width="700" border="1" bgcolor="skyblue">
			<tr height="40">
				<td align="right" colspan="5">
					<!-- 버튼을 클릭하면 BoardWriteForm.jsp파일로 넘어간다.--> <input type="button"
					value="글쓰기" onclick="location.href='BoardWriteForm.jsp'">
				</td>
			</tr>
			<tr height="40">

				<td width="50" align="center">번호</td>
				<td width="320" align="center">제목</td>
				<td width="100" align="center">작성자</td>
				<td width="150" align="center">작성일</td>
				<td width="80" align="center">조회수</td>
			</tr>
			<%
				for (int i = 0; i < vec.size(); i++) {
					BoardBean bean = vec.get(i); //벡터에 저장되어있는 bean클래스를 하나씩 추출
			%>
			<tr height="40">
				<!-- 리스트 맨위의 숫자가 가장크고 밑으로 내려오면 감소되기때문에 숫자를 감소시켜서 표시한다. -->
				<td width="50" align="center"><%=number--%></td>
				<!-- 숫자가 하나씩 올라가게 하기위해서 i+1을 해준다 -->
				<!-- getNum()을 쓰면 순서가 복잡해지기 때문 -->
				<td width="320" align="center"><a
					href="BoardInfo.jsp?num=<%=bean.getNum()%>"
					style="text-decoration: none"> <!-- 리플 옆에 선을 사라지게 만드는 코드 --> <%
 	//답변 들여쓰기를 하기위한 for문
 		if (bean.getRe_step() > 1) {
 			for (int j = 0; j < (bean.getRe_step() - 1) * 5; j++) {
 %>&nbsp; <%
 	}

 		}
 %> <%=bean.getSubject()%></a></td>
				<!-- BoardInfo.jsp파일(정보를 확인하기 위한파일)에 Num값을 넘겨준다 -->
				<td width="100" align="center"><%=bean.getWriter()%></td>
				<td width="150" align="center"><%=bean.getReg_date()%></td>
				<td width="80" align="center"><%=bean.getReadcount()%></td>
			</tr>
			<%
				}
			%>

		</table>
		<p>
			<!-- 페이지 카운터링 소스를 작성 -->
			<%
				if (count > 0) {
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1); //카운터링 숫자를 얼마까지 보여줄건지 결정

					//시작 페이지 숫자를 설정
					int startPage = 1;

					if (currentPage % 10 != 0) {
						startPage = (int) (currentPage / 10) * 10 + 1;

					} else {
						startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
					}

					int pageBlock = 10; //카운터링 처리 숫자
					int endPage = startPage + pageBlock - 1; //화면에 보여질 페이지의 마지막 숫자

					if (endPage > pageCount)
						endPage = pageCount;

					//이전이라는 링크를 만들건지 파악
					if (startPage > 10) {
			%>
			<a href="BoardList.jsp?pageNum=<%=startPage - 10%>"> [이전] </a>
			<%
				}

					//페이징 처리
					for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="BoardList.jsp?pageNum=<%=i%>"> [<%=i%>]
			</a>
			<%
				}

					//다음이라는 링크를 만들건지 파악
					if (endPage < pageCount) {
			%>
			<a href="BoardList.jsp?pageNum=<%=startPage + 10%>"> [다음] </a>
			<%
				}

				}
			%>
		
	</center>
</body>
</html>
