<%@page import="my.boo.bookDao"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
prod_update_proc.jsp<br><br>

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
	
	String old_pimage = mr.getParameter("old_pimage");
	System.out.println("p_u_p.jsp old_pimage:" + old_pimage); // 기존이미지.jpg
	
	File dir = new File(uploadDir);
	
	if(pimage2 != null){ // 
		if(old_pimage != null) { // 
			File delFile = new File(dir,old_pimage);
			
			if(delFile.exists()){ // 
				if(delFile.delete()){
					 
	%>
					<script type="text/javascript">
						alert("이미지 화일 삭제 성공");
					</script>
	<%
		}
			
		}
			}
		}
		
		
		
	    		bookDao pdao = bookDao.getInstance();
		int cnt = pdao.updatebook(mr);
		//////
		//////
		String msg = "", url = "";
		if (cnt > 0) {
			msg = "상품 수정 성공";
			url = "prod_list.jsp";
		} else {
			msg = "상품 수정 실패";
			url = "prod_update.jsp";
		}
	%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>  



