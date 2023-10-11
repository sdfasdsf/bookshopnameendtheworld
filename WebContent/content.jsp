<%@page import="my.list.ListBean"%>
<%@page import="my.list.ListDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
String msg="", url="";
	
	if(true){
		msg = "가입하지 않은 회원입니다.";
		url = "main.jsp";
	}
	
	
	
	%>
	
	<script type="text/javascript">
	alert("<%=msg%>"); 
	location.href="<%= url%>"
</script>
 