<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<!-- 파일 업로드를 위한 클래스 import -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!-- 파일 업로드 시 덮어쓰기 방지를 위해 임포트한 클래스 -->
<%@ page import="java.util.*, java.io.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<%
		String saveFolder = "C:/Tom"; //로드 파일의 실제경로
		String encType = "EUC-KR"; //인코딩 타입
		int maxSize = 5 * 1024 * 1024; //파일의 최대 크기 지정

		try {
			MultipartRequest multi = null; //NULL을 초기값으로 선언
			multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());//객체 생성
			Enumeration params = multi.getParameterNames(); //Enumeration은 여러 요소들이 배열형태로 구성되어 있는 클래스(파라미터의 이름들을 반환받는 변수)

			while (params.hasMoreElements()) //params.hasMoreElements()메소드를 사용해 포함된 요소들이 있는지 검사하고 요소들이 포함되어 있는 동안만 반복
			{
				String name = (String) params.nextElement();
				String value = multi.getParameter(name);
				out.println(name + "=" + value + "<br/>"); //name, value 변수에 담긴값을 브라우저 출력
			}

			Enumeration files = multi.getFileNames();

			while (files.hasMoreElements()) //java.util.Enumeration 인터페이스에 있는 메소드. 요소가 있는지 없는지 체크함
			{
				String name = (String) files.nextElement(); //Enumeration에 요소가 있을 때 요소를 추출하는 메소드. 오브젝트 타입으로 반환하기 때문에 
															//String 타입으로 변환후 변수에 저장한다.

				String filename = multi.getFilesystemName(name);
				String original = multi.getFilesystemName(name);
				String type = multi.getContentType(name);
				File f = multi.getFile(name); //File메소드의 반환값은 File타입이다. 얻어진 File 객체를 통해서 업로드된 파일의 정보를 알수있다.

				out.println("파라미터 이름 : " + name + "</br>"); //반복수행이 되면서 변수에 담긴 값들을 하나씩 출력
				out.println("실제 파일 이름 : " + original + "</br>");
				out.println("저장된 파일 이름 : " + filename + "</br>");
				out.println("파일 타입 : " + type + "</br>");

				if (f != null) {
					out.println("크기 : " + f.length() + "바이트");
					out.println("<br>");
				}

			}

		} catch (IOException ioe) //업로드 할 파일이 지정한 최대 크기보다 크거나 페이지를 읽을 때 문제가 발생할 경우 처리하는 예외처리
		{
			System.out.println(ioe);
		} catch (Exception ex) //그 외에 발생하는 예외처리
		{
			System.out.println(ex);
		}
	%>