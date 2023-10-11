<%@page import="my.boo.bookDao"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
prod_delete.jsp<br><br>
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String pimage = request.getParameter("pimage");
	System.out.println("pnum:" + pnum);
	System.out.println("pimage:" + pimage); // 남성정장.jpg
	
	ServletContext sc = config.getServletContext();
	String delPath = sc.getRealPath("/myshop/images");
	//C:\JSP_ysy\.metadata\.plugins\org.eclipse.wst.server.core\tmp5\wtpwebapps\Minimall\myshop\images
	
	File dir = new File(delPath); 
	File delFile = new File(dir, pimage);
	
	if(delFile.exists()){
		if(delFile.delete()){
			%>
			<script type="text/javascript">
				alert("이미지 화일 삭제 성공");
			</script>
			<%
			
		}
	}
	
	///////////////////////////////////////////////
	
	bookDao pdao = bookDao.getInstance();
	int cnt = pdao.deletebook(pnum);
	String msg = "", url="";
	if(cnt > 0){ 
		msg = "상품 삭제 성공";
	}
	else{
		msg = "상품 삭제 실패";
	}
	url = "prod_list.jsp";
	
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>

