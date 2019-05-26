<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- �Խñ� �����ÿ� ��й�ȣ�� ������ Ȯ�θ޽��� ��� -->
<c:if test = "${msg == '������ �Ϸ�Ǿ����ϴ�.' }">
	<script type="text/javascript">
		alert("�Խñ��� �����Ǿ����ϴ�.");
	</script>
</c:if>

<!-- �Խñ� �����ÿ� ��й�ȣ�� Ʋ������ ���â ��� -->
<c:if test = "${msg == '��й�ȣ�� Ʋ�Ƚ��ϴ�.' }">
	<script type="text/javascript">
		alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
	</script>
</c:if>

<c:if test = "${msg == 2 }">
	<script type="text/javascript">
		alert("������ ��й�ȣ�� Ʋ�Ƚ��ϴ�.");
	</script>
</c:if>

<body>
	<center>
		<h2>��ü �Խñ� ����</h2>
		<table width="700" border="1" bordercolor="skyblue">
			<tr height="40">
				<td colspan="5" align="right">
					<button onclick="location.href='BoardWriteForm.jsp'">�۾���</button>
				</td>
			</tr>

			<tr height="40">
				<td width="50" align="center">��ȣ</td>
				<td width="320" align="center">����</td>
				<td width="100" align="center">�ۼ���</td>
				<td width="150" align="center">�ۼ���</td>
				<td width="80" align="center">��ȸ��</td>
			</tr>
			<!-- $�ȿ� number�� ����ϸ� ��� number�� ��µǱ� ������ forEach������ number�� ��� 1�� ���ҽ��Ѿ� �Ѵ�. -->
			<c:set var="number" value="${number}" />
			<c:forEach var="bean" items="${v}">


				<tr height="40">
					<td width="50" align="left">${number }</td>
					<td width="50" align="left">
						<!-- �鿩���� ���� --> <!-- ù��° (1) �� �鿩������ �ʿ䰡 ����. --> <!-- ������ ������ ����ϱ� ���� ���� -->
						<c:if test="${bean.re_step > 1 }">
							<c:forEach var="j" begin="1" end="${(bean.re_step-1)*5}">
                &nbsp;
            </c:forEach>
						</c:if> <!-- ��ư�� �������� ������ �ǰԲ� a�±׸� �Ǵ� --> <a
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
			<!-- ������ ī���͸� �ҽ��� �ۼ��Ѵ� -->
			<c:if test="${count > 0 }">
			<c:set var="pageCount"
        value = "${count / pageSize +(count%pageSize == 0 ? 0: 1)}"/>
        <c:set var="startPage" value="${1 }" />

				<c:if test="${currentPage %10 != 0 }">
					<!-- ��ƮŸ������ ��ȯ�ϱ� ���� ����Ŭ������ integer�� ����Ѵ�. -->
					<!-- ����� ���������� ���Ϲ޾ƾ� �ϱ⿡ fmt�±׸� ���
        fmt�� �ھ��±װ� �ƴϱ� ������ ���ʿ��� �±׶��̺귯���� �߰��ؾ��Ѵ�.-->
					<fmt:parseNumber var="result" value="${currentPage/10 }"
						integerOnly="true" />
					<c:set var="startPage" value="${result*10+1 }" />
				</c:if>

				<!-- c:if���� else�� ����� �� ���� ������ �̹�����  currentPage %10 == 0 �̶�� ���� �־��־�� �Ѵ�.-->

				<c:if test="${currentPage %10 == 0 }">
					<!-- ��ƮŸ������ ��ȯ�ϱ� ���� ����Ŭ������ integer�� ����Ѵ�. -->
					<!-- ����� ���������� ���Ϲ޾ƾ� �ϱ⿡ fmt�±׸� ���
        fmt�� �ھ��±װ� �ƴϱ� ������ ���ʿ��� �±׶��̺귯���� �߰��ؾ��Ѵ�.-->
					<c:set var="startPage" value="${(result-1)*10+1 }" />
				</c:if>

				<!-- ȭ�鿡 ������ ������ ó�� ���ڸ� ǥ�� -->
				<c:set var="pageBlock" value="${10 }" />
				<c:set var="endPage" value="${startPage+pageBlock-1 }" />
				<c:if test="${endPage > pageCount }">
					<c:set var="endPage" value="${pageCount }" />
				</c:if>

				<!-- 10���� �������� ũ�� "����" �̶�� ��ũ�� ���� �ľ��ϴ� ���� (if)-->
				<c:if test="${startPage > 10 }">
					<a href='BoardListCon.do?pageNum=${startPage-10 }'>[����]</a>
				</c:if>

				<!-- ����¡ ó�� -->
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<a href='BoardListCon.do?pageNum=${i}'>[${i}]</a>
				</c:forEach>

				<!-- ���� -->
				<c:if test="${endPage<pageCount}">
					<a href='BoardListCon.do?pageNum=${startPage+10 }'>[����]</a>
				</c:if>
			</c:if>
	</center>
</body>
</html>
