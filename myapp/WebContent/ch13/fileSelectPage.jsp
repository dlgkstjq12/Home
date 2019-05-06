<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%!
	public String getParam(HttpServletRequest request, String paramName) //이전에 입력했던 값들을 보전하기 위한 메소드
	{
		if(request.getParameter(paramName)!=null)  //페이지가 처음 실행될때 request.getParameter()로 받아오는 값이 없기 때문에
		{											//이 부분이 null이 아닌지 체크
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