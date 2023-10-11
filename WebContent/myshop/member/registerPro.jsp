<%@page import="my.book.ReaderDAO"%>
<%@page import="my.book.ReaderDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
myshop/member/registerPro.jsp<br><br>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- my.member.MemberDTO mdao = new my.member.MemberDTO() -->
<jsp:useBean id="mdto" class="my.book.ReaderDTO"/>
<jsp:setProperty property="*" name="mdto"/>
<%-- <jsp:useBean id="mdao" class="my.member.MemberDAO"/> --%>
<%
	ReaderDAO mdao = ReaderDAO.getInstance();
	int cnt = mdao.insertData(mdto);  
	String msg = "", url=""; 
	if(cnt>0){
		msg = "가입 성공";
		url = request.getContextPath() + "/main.jsp";
		//http://localhost:8080/Minimall/main.jsp
		
	}else{
		msg = "가입 실패";
		//url = request.getContextPath() + "/myshop/member/register.jsp";
		url = "register.jsp"; 
		//http://localhost:8080/Minimall/myshop/member/register.jsp
	}
%>
<script type="text/javascript">
	alert("<%=msg%>" + "했습니다.");
	location.href="<%=url%>"; 
</script>





