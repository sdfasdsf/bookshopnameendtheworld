<%@page import="my.list.ListDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
writePro.jsp<br><br>
<%
	request.setCharacterEncoding("UTF-8");
	//String writer = request.getParameter("writer");
%>
<!-- 매개변수 없는 생성자가 반드시 있어야 한다. -->
<jsp:useBean id="article" class="my.list.ListBean"/>
<jsp:setProperty property="*" name="article"/>
<%-- <jsp:useBean id="dao" class="board.BoardDao"/> --%>

<%
	//new Timestamp(System.currentTimeMillis()); // 393848599586
	article.setReg_date( new Timestamp(System.currentTimeMillis()) );
	
	//request.getRemoteAddr()
	article.setIp(request.getRemoteAddr());
	
	ListDao dao = ListDao.getInstance();
	int cnt = dao.insertArticle(article); 
	if(cnt>0){
		response.sendRedirect("list.jsp");
	} else{
		response.sendRedirect("writeForm.jsp");
	}
%>





