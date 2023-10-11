<%@page import="my.book.ReaderDTO"%>
<%@page import="my.book.ReaderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="style.css"  rel="stylesheet" type="text/css">
<style type="text/css">
body {
    width: 100%;
    text-align : center;
}
table {
    margin: 0 auto;
}   
</style>     
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="script.js"></script>
<%

	String contextPath = request.getContextPath();
	String memid = (String)session.getAttribute("memid");
%>

%>
<%@ include file="color.jsp" %>  
writeForm.jsp<br><br>
<b>글쓰기</b>
<body bgcolor="<%=bodyback_c %>">
<form method="post" name="writeform" action="writePro.jsp"  onsubmit="return writeSave()">
	<table border="1" width="450" align="center" cellspacing="0">
		<tr>
			<td align="right" colspan="2" bgcolor="<%=value_c %>">	 
				<a href="list.jsp">글목록</a>
			</td>
		</tr>
		
		<tr>
			<td width="100" align="center" bgcolor="<%=value_c %>">이름</td>
			<td><input type="text"   size="30" maxlength="10"	
					name="writer" value="<%= memid %>">
			</td>
		</tr>
		
		<tr>
			<td width="100" align="center" bgcolor="<%=value_c %>">제 목</td>
			<td width="350" align="left">					
				<input type="text" size="50" maxlength="50" 
					name="subject"	value="어떤글">
			</td>
		</tr>
				
		<tr>
			<td width="100"  align="center" bgcolor="<%=value_c %>">Email</td>
			<td width="350">
				<input type="text" size="50" maxlength="30"	name="email" 
					value="aa@xx.com">
			</td>
		</tr>
				
		<tr>
			<td width="100"  align="center" bgcolor="<%=value_c %>">내 용</td>
			<td width="350">
				<textarea name="content" id="abc" rows="13" cols="50">호호호</textarea>
				
			</td>
		</tr>
		
		<tr>
			<td width="100"  align="center" bgcolor="<%=value_c %>">비밀번호</td>
			<td width="350">
				<input type="password" size="10" maxlength="12"	
					name="passwd" value="1234">
			</td>
		</tr>
		<tr>
			<td colspan=2  align="center" height="30" bgcolor="<%=value_c %>">
				<input type="submit" value="글쓰기">  
				<input type="reset"	value="다시작성"> 
				<input type="button" value="목록보기" onClick="location.href='list.jsp'">
			</td>
		</tr>
	</table>
</form>
</body>