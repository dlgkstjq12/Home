<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%!
	public String getParam(HttpServletRequest request, String paramName) //������ �Է��ߴ� ������ �����ϱ� ���� �޼ҵ�
	{
		if(request.getParameter(paramName)!=null)  //�������� ó�� ����ɶ� request.getParameter()�� �޾ƿ��� ���� ���� ������
		{											//�� �κ��� null�� �ƴ��� üũ
			return request.getParameter(paramName);
			
		}
		else
		{
			return "";
		}
	
	}


%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

</body>
</html>