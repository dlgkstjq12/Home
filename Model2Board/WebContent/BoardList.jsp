<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 게시글 수정시에 비밀번호가 맞으면 확인메시지 출력 -->
<c:if test = "${msg == '수정이 완료되었습니다.' }">
	<script type="text/javascript">
		alert("게시글이 수정되었습니다.");
	</script>
</c:if>

<!-- 게시글 수정시에 비밀번호가 틀렸을시 경고창 출력 -->
<c:if test = "${msg == '비밀번호가 틀렸습니다.' }">
	<script type="text/javascript">
		alert("비밀번호가 틀렸습니다.");
	</script>
</c:if>

<c:if test = "${msg == 2 }">
	<script type="text/javascript">
		alert("삭제시 비밀번호가 틀렸습니다.");
	</script>
</c:if>

<body>
	<center>
		<h2>전체 게시글 보기</h2>
		<table width="700" border="1" bordercolor="skyblue">
			<tr height="40">
				<td colspan="5" align="right">
					<button onclick="location.href='BoardWriteForm.jsp'">글쓰기</button>
				</td>
			</tr>

			<tr height="40">
				<td width="50" align="center">번호</td>
				<td width="320" align="center">제목</td>
				<td width="100" align="center">작성자</td>
				<td width="150" align="center">작성일</td>
				<td width="80" align="center">조회수</td>
			</tr>
			<!-- $안에 number을 사용하면 계속 number만 출력되기 때문에 forEach문으로 number을 계속 1씩 감소시켜야 한다. -->
			<c:set var="number" value="${number}" />
			<c:forEach var="bean" items="${v}">


				<tr height="40">
					<td width="50" align="left">${number }</td>
					<td width="50" align="left">
						<!-- 들여쓰기 구문 --> <!-- 첫번째 (1) 은 들여쓰기할 필요가 없다. --> <!-- 공백을 여러개 출력하기 위한 구문 -->
						<c:if test="${bean.re_step > 1 }">
							<c:forEach var="j" begin="1" end="${(bean.re_step-1)*5}">
                &nbsp;
            </c:forEach>
						</c:if> <!-- 버튼을 눌렀을때 실행이 되게끔 a태그를 건다 --> <a
						href="BoardInfoControl.do?num=${bean.num }">${bean.subject } </a>

					</td>
					<td width="50" align="left">${bean.writer }</td>
					<td width="50" align="left">${bean.reg_date }</td>
					<td width="50" align="left">${bean.readcount }</td>
				</tr>
				<c:set var="number" value="${number-1 }" />
			</c:forEach>
		</table>
		<p>
			<!-- 페이지 카운터링 소스를 작성한다 -->
			<c:if test="${count > 0 }">
			<c:set var="pageCount"
        value = "${count / pageSize +(count%pageSize == 0 ? 0: 1)}"/>
        <c:set var="startPage" value="${1 }" />

				<c:if test="${currentPage %10 != 0 }">
					<!-- 인트타입으로 변환하기 위해 포장클래스인 integer을 사용한다. -->
					<!-- 결과를 정수형으로 리턴받아야 하기에 fmt태그를 사용
        fmt는 코어태그가 아니기 때문에 위쪽에서 태그라이브러리를 추가해야한다.-->
					<fmt:parseNumber var="result" value="${currentPage/10 }"
						integerOnly="true" />
					<c:set var="startPage" value="${result*10+1 }" />
				</c:if>

				<!-- c:if문은 else를 사용할 수 없기 때문에 이번에는  currentPage %10 == 0 이라는 값을 넣어주어야 한다.-->

				<c:if test="${currentPage %10 == 0 }">
					<!-- 인트타입으로 변환하기 위해 포장클래스인 integer을 사용한다. -->
					<!-- 결과를 정수형으로 리턴받아야 하기에 fmt태그를 사용
        fmt는 코어태그가 아니기 때문에 위쪽에서 태그라이브러리를 추가해야한다.-->
					<c:set var="startPage" value="${(result-1)*10+1 }" />
				</c:if>

				<!-- 화면에 보여질 페이지 처리 숫자를 표현 -->
				<c:set var="pageBlock" value="${10 }" />
				<c:set var="endPage" value="${startPage+pageBlock-1 }" />
				<c:if test="${endPage > pageCount }">
					<c:set var="endPage" value="${pageCount }" />
				</c:if>

				<!-- 10보다 페이지가 크면 "이전" 이라는 링크를 걸지 파악하는 구문 (if)-->
				<c:if test="${startPage > 10 }">
					<a href='BoardListCon.do?pageNum=${startPage-10 }'>[이전]</a>
				</c:if>

				<!-- 페이징 처리 -->
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<a href='BoardListCon.do?pageNum=${i}'>[${i}]</a>
				</c:forEach>

				<!-- 다음 -->
				<c:if test="${endPage<pageCount}">
					<a href='BoardListCon.do?pageNum=${startPage+10 }'>[다음]</a>
				</c:if>
			</c:if>
	</center>
</body>
</html>
