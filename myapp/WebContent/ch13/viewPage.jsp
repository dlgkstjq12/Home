<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<!-- ���� ���ε带 ���� Ŭ���� import -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!-- ���� ���ε� �� ����� ������ ���� ����Ʈ�� Ŭ���� -->
<%@ page import="java.util.*, java.io.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<%
		String saveFolder = "C:/Tom"; //�ε� ������ �������
		String encType = "EUC-KR"; //���ڵ� Ÿ��
		int maxSize = 5 * 1024 * 1024; //������ �ִ� ũ�� ����

		try {
			MultipartRequest multi = null; //NULL�� �ʱⰪ���� ����
			multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());//��ü ����
			Enumeration params = multi.getParameterNames(); //Enumeration�� ���� ��ҵ��� �迭���·� �����Ǿ� �ִ� Ŭ����(�Ķ������ �̸����� ��ȯ�޴� ����)

			while (params.hasMoreElements()) //params.hasMoreElements()�޼ҵ带 ����� ���Ե� ��ҵ��� �ִ��� �˻��ϰ� ��ҵ��� ���ԵǾ� �ִ� ���ȸ� �ݺ�
			{
				String name = (String) params.nextElement();
				String value = multi.getParameter(name);
				out.println(name + "=" + value + "<br/>"); //name, value ������ ��䰪�� ������ ���
			}

			Enumeration files = multi.getFileNames();

			while (files.hasMoreElements()) //java.util.Enumeration �������̽��� �ִ� �޼ҵ�. ��Ұ� �ִ��� ������ üũ��
			{
				String name = (String) files.nextElement(); //Enumeration�� ��Ұ� ���� �� ��Ҹ� �����ϴ� �޼ҵ�. ������Ʈ Ÿ������ ��ȯ�ϱ� ������ 
															//String Ÿ������ ��ȯ�� ������ �����Ѵ�.

				String filename = multi.getFilesystemName(name);
				String original = multi.getFilesystemName(name);
				String type = multi.getContentType(name);
				File f = multi.getFile(name); //File�޼ҵ��� ��ȯ���� FileŸ���̴�. ����� File ��ü�� ���ؼ� ���ε�� ������ ������ �˼��ִ�.

				out.println("�Ķ���� �̸� : " + name + "</br>"); //�ݺ������� �Ǹ鼭 ������ ��� ������ �ϳ��� ���
				out.println("���� ���� �̸� : " + original + "</br>");
				out.println("����� ���� �̸� : " + filename + "</br>");
				out.println("���� Ÿ�� : " + type + "</br>");

				if (f != null) {
					out.println("ũ�� : " + f.length() + "����Ʈ");
					out.println("<br>");
				}

			}

		} catch (IOException ioe) //���ε� �� ������ ������ �ִ� ũ�⺸�� ũ�ų� �������� ���� �� ������ �߻��� ��� ó���ϴ� ����ó��
		{
			System.out.println(ioe);
		} catch (Exception ex) //�� �ܿ� �߻��ϴ� ����ó��
		{
			System.out.println(ex);
		}
	%>