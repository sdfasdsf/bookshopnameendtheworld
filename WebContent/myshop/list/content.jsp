<%@page import="my.list.ListBean"%>
<%@page import="my.list.ListDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jsp" %>          
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
content.jsp<br><br>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pn = Integer.parseInt(request.getParameter("pageNum"));
	
	ListDao dao = ListDao.getInstance();
	ListBean article = dao.getArticle(num);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	System.out.println("num:" + article.getNum());
	System.out.println("ref:" + article.getRef());
	System.out.println("re_step:" + article.getRe_step());
	System.out.println("re_level:" + article.getRe_level());
	int ref = article.getRef();
	int re_step = article.getRe_step();
	int re_level = article.getRe_level();
	
%>

<body bgcolor="<%=bodyback_c %>">
	<table width="500" border="1" cellspacing="0" bgcolor="<%=bodyback_c %>">
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c %>">글번호</td>
		    <td align="center" width="125"> <%=article.getNum() %></td>
		    <td align="center" width="125" bgcolor="<%=value_c %>">조회수</td>
		    <td align="center" width="125"> <%=article.getReadcount() %></td>
		</tr>
		
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c %>">작성자</td>
		    <td align="center" width="125"> <%=article.getWriter() %></td>
		    <td align="center" width="125" bgcolor="<%=value_c %>">작성일</td>
		    <td align="center" width="125"> <%= sdf.format(article.getReg_date()) %></td>
		</tr>
		
		<tr height="30">
		    <td align="center" width="125" bgcolor="<%=value_c %>">글제목</td>
		    <td align="center" width="375" colspan="3"> <%=article.getSubject() %></td>
		</tr>
		<tr  height="30">
		    <td align="center" width="125" bgcolor="<%=value_c %>">글내용</td>
		    <td align="left" width="375" colspan="3"><%=article.getContent() %>  
		    </td>
		</tr>
  		
  		<tr height="30">      
    		<td colspan="4"  align="right" bgcolor="<%=value_c %>"> 
			  <input type="button" value="글수정" onClick="location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pn%>'">
			   &nbsp;&nbsp;&nbsp;&nbsp;
			  
			  <input type="button" value="글삭제" onClick="location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pn%>'">
			   &nbsp;&nbsp;&nbsp;&nbsp;
		      
		      <input type="button" value="답글쓰기" onClick="location.href='replyForm.jsp?ref=<%=article.getRef()%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
			   &nbsp;&nbsp;&nbsp;&nbsp;
      
       		  <input type="button" value="글목록" onClick="location.href='list.jsp?pageNum=<%=pn%>'">
   			</td>
  		</tr>
	</table>

</body>





