<%@page import="my.boo.goryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
myshop/admin/cate_delete.jsp<br>

<%
	int cnum=Integer.parseInt(request.getParameter("cnum"));

    goryDAO cdao = goryDAO.getInstance();
	int cnt = cdao.categoryDelete(cnum);
	 
	String msg="", url="cate_list.jsp";
	if(cnt>0){
		msg="카테고리 삭제 성공!";
	}else{
		msg="카테고리 삭제 실패!";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>

