<%@page import="my.list.ListBean"%>
<%@page import="my.list.ListDao"%>
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
	int num = Integer.parseInt(request.getParameter("num")); // 16
	String pageNum = request.getParameter("pageNum");
	
	// dao객체 얻어오기
	ListDao dao = ListDao.getInstance();
	ListBean article =  dao.updateGetArticle(num); 
	
%>
<%@ include file="color.jsp" %>  
updateForm.jsp<br><br>
<b>글수정</b>
<body bgcolor="<%=bodyback_c %>">
<form method="post" name="writeform" action="updatePro.jsp?pageNum=<%=pageNum %>"  onsubmit="return writeSave()">
	<table border="1" width="450" align="center" cellspacing="0">
		<tr>
			<td align="right" colspan="2" bgcolor="<%=value_c %>">	 
				<a href="list.jsp">글목록</a>
			</td>
		</tr>
		
		<tr>
			<td width="100" align="center" bgcolor="<%=value_c %>">이름</td>
			<td><input type="text" size="30" maxlength="10"	
					name="writer" value="<%=article.getWriter()%>">
				<input type="hidden" name="num" value="<%= article.getNum()%>"> 
			</td>
		</tr>
		
		<tr>
			<td width="100" align="center" bgcolor="<%=value_c %>">제 목</td>
			<td width="350" align="left">					
				<input type="text" size="50" maxlength="50" 
					name="subject"	value="<%=article.getSubject()%>">
			</td>
		</tr>
				
		<tr>
			<td width="100"  align="center" bgcolor="<%=value_c %>">Email</td>
			<td width="350">
				<input type="text" size="50" maxlength="30"	name="email" 
					value="<%=article.getEmail()%>">
			</td>
		</tr>
				
		<tr>
			<td width="100"  align="center" bgcolor="<%=value_c %>">내 용</td>
			<td width="350">
				<textarea name="content" id="abc" rows="13" cols="50"><%=article.getContent()%></textarea>
				
			</td>
		</tr>
		
		<tr>
			<td width="100"  align="center" bgcolor="<%=value_c %>">비밀번호</td>
			<td width="350">
				<input type="password" size="10" maxlength="12"	
					name="passwd">
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