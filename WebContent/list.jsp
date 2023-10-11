<%@page import="my.list.ListBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.list.ListDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="color.jsp" %> 
<style type="text/css">
body {
    width: 100%;
    text-align : center;
}
table {
    margin: 0 auto;
}   
</style>   
<link href="style.css" rel="stylesheet" type="text/css">

<%
int pageSize = 10; //  
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0 ; 
	int number = 0;
	 
	
 	ArrayList<ListBean> lists = null;
	ListDao dao = ListDao.getInstance(); 
	count = dao.getArticleCount(); // 전체 레코드 갯수 리턴 
	System.out.println("count:" + count);
	if(count > 0){ 
		lists = dao.getArticles(startRow,endRow);// 1~10 11~20
	}
	
	number = count - (currentPage-1) * pageSize; // 37-(2-1)*10=27
	
%>
<body >
<b>글목록(전체 글 : <%= count%>)</b>
<table width="700"  border="1">
	<tr height="30">
		<td align="right" bgcolor="yellow">
			<a href="writeForm.jsp">글쓰기</a>
		</td>
	</tr>
</table>

<%
	if(count == 0){
%>
	<table width="700"  border="1">
		<tr height="30">
			<td>게시판에 저장된 글이 없습니다.</td>
		</tr>
	</table>
<%		
	} else{
		   
%>
	<table width="700" align="center" border="1">
		<tr height="30" bgcolor="#5CD1E5">
			<td align="center" width="50">번호</td>
			<td align="center" width="250">제 목</td>
			<td align="center" width="100">작성자</td>
			<td align="center" width="150">작성일</td>
			<td align="center" width="50">조회</td>
			<td align="center" width="100">IP</td>
		</tr>
<%
		//for(BoardBean article : lists){
		for(int i=0;i<lists.size();i++){
			ListBean article = lists.get(i);
%>
			<tr height="30">
				<td align="center"><%=number-- %></td>
				<td align="left"> 
				<%
					int wid = 0;
					if(article.getRe_level() > 0){ // 답글
						wid = article.getRe_level() * 20; // 답글:20, 답글의답글:40
					
				%>
						<img src="images/level.gif" width="<%=wid %>" height="16">
						<img src="images/re.gif">
				<%
					}
					else{ // 원글
				%>
						<img src="images/level.gif" width="<%=wid %>" height="16">
				<%
					}
				%>
					<a href="content.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage%>"><%=article.getSubject() %></a>
					<%
						if(article.getReadcount() >= 10){ 
					%>
						<img src="images/hot.gif">
					<%
						}
					%>
				</td>
				<td align="center"> <%=article.getWriter() %></td>
				<td align="center"> <%=article.getReg_date() %></td>
				<td align="center"> <%=article.getReadcount() %></td>
				<td align="center"> <%=article.getIp() %></td>
			</tr>
<%			  
		} // for
%>
	
	</table>
<%		
	} // else
%>

<%
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		
		int pageBlock = 10;
		
		int startPage = ((currentPage - 1) / pageBlock * pageBlock) +1 ;
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount)
			endPage = pageCount;
		
		if(startPage > 10){
%>
			<a href="list.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<%			
		}
		
		for(int i=startPage;i<=endPage;i++){
%>
			<a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
<%			
		}
		if(endPage < pageCount) {
%>
			<a href="list.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%			
		}
	}
%>





</body>



