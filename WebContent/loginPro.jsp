<%@page import="my.book.ReaderDAO"%>
<%@page import="my.book.ReaderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
loginPro.jsp<br><br>  
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id") ;
	String password = request.getParameter("password") ; 
	
	String msg="", url="";
	ReaderDAO mdao = ReaderDAO.getInstance();
	ReaderDTO mdto = mdao.getreaderInfo(id,password);
	
	if(mdto != null){ 
		msg = "가입한 회원입니다.";
		String _id = mdto.getId();
		int _no = mdto.getNo(); 
		
		if(_id.equals("admin")){ // 관리자
			url = request.getContextPath()+"/myshop/admin/main.jsp";	
		}
		else{ // 일반사용자
			url = request.getContextPath()+"/myshop/display/mall.jsp";
		}
		
		session.setAttribute("memid", _id); // memid:admin kim park
		session.setAttribute("memno", _no); // memno:2
	}
	else{
		msg = "가입하지 않은 회원입니다.";
		url = "main.jsp";
	
	}
	
%>	
   
<script type="text/javascript">
	alert("<%=msg%>"); 
	location.href="<%= url%>"
</script>
 
ㅎㄽㄱ