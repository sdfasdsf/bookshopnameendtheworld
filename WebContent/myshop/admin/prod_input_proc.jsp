
<%@page import="my.boo.bookDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
prod_input_proc.jsp<br><br>
<%
request.setCharacterEncoding("UTF-8");
String pname = request.getParameter("pname");
System.out.println("pname:" + pname); // null
%>
<%-- <jsp:useBean id=""></jsp:useBean> --%>
<!-- C:\JSP_ysy\.metadata\.plugins\org.eclipse.wst.server.core\tmp5\wtpwebapps\Minimall\myshop\images -->

<%

	MultipartRequest mr = null;
	int maxSize = 1024 * 1024 * 5;
	String encType = "UTF-8";
	
	ServletContext sc = config.getServletContext();
	String uploadDir = sc.getRealPath("/myshop/images");
	
	System.out.println("uploadDir:"+uploadDir);
	// C:\JSP_ysy\.metadata\.plugins\org.eclipse.wst.server.core\tmp5\wtpwebapps\Minimall\
	// C:\JSP_ysy\.metadata\.plugins\org.eclipse.wst.server.core\tmp5\wtpwebapps\Minimall\myshop\images
	
	// request:
	// uploadDir : 
	// maxSize : 
	mr = new MultipartRequest(request,
							uploadDir,
							maxSize,
							encType,
							new DefaultFileRenamePolicy());
	
	
	String pn = mr.getParameter("pname");
	System.out.println("pn:" + pn); // null
	
	String pimage = mr.getParameter("pimage");
	System.out.println("pimage:" + pimage); // null
	
	String pimage2 = mr.getFilesystemName("pimage");
	System.out.println("pimage2:" + pimage2);
	
	bookDao pdao = bookDao.getInstance();
	int cnt = pdao.insertbook(mr);
	
	String msg="", url=""; 
	if(cnt>0){
		msg = "상품 등록 성공";
		url = "prod_list.jsp";
	}
	else{
		msg = "상품 등록 실패";
		url = "prod_input.jsp";
	}
		
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>  











