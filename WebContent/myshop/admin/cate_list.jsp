
<%@page import="my.boo.goryDAO"%>
<%@page import="my.boo.goryBean"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
myshop/admin/cate_list.jsp<br>

<%@ include file = "top1.jsp"%>
	
	<td colspan="6" valign="top">
		
		<table border="1" width="500">
			<caption><b>카테고리 목록</b></caption>
			<tr bgcolor="yellow">
				<th width="10%">번호</th>
				<th width="30%">카테고리 코드</th>
				<th width="50%">카테고리명</th>
				<th width="10%">삭제</th>
			</tr>
	<%
		goryDAO cdao = goryDAO.getInstance();
		ArrayList<goryBean> lists = cdao.getAllCategory(); 
		
		if(lists.size() == 0){
	%>
			<tr><td colspan="4" align="center">등록된 카테고리 없습니다.</td></tr> 
	<%
		}
		
		for( int i=0;i<lists.size();i++ ){
			goryBean cb = lists.get(i);
			
	%>		
			<tr>
				<td align="right"><%=cb.getCnum() %></td>
				<td align="center"><%=cb.getCode() %></td>
				<td align="center"><%=cb.getCname() %></td>
				<td align="center"><a href="cate_delete.jsp?cnum=<%=cb.getCnum() %>">삭제</a></td>
			</tr>	
	<%			
		} // for
	%>	
		
		
		
		</table>
		
	</td>

<%@ include file = "bottom.jsp"%>