
<%@page import="my.book.ReaderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String userid = request.getParameter("userid");  
	
	ReaderDAO dao = ReaderDAO.getInstance();
	boolean check = dao.searchID(userid);  
	String str="";
	if(check){ // true
		str = "NO";
		out.print(str);
	}else{ // false
		str = "YES";
		out.print(str);
	}
%>

