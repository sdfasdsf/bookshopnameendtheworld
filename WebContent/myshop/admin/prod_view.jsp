<%@page import="my.boo.bookBean"%>
<%@page import="my.boo.bookDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top1.jsp"%>
<td colspan="6" valign="top">
	<%
		int pnum = Integer.parseInt(request.getParameter("pnum"));
		bookDao pdao = bookDao.getInstance();
		ArrayList<bookBean> lists = pdao.getOneSelectByPnum(pnum);
	%>
	
	<form action="prod_list.jsp" >
		<table class=outline width="600">
			<tr>
				<th width="15%" class="m2">카테고리</th>
				<td width="35%"><b><%=lists.get(0).getPcategory_fk() %></b></td>
				
				<th width="15%" class="m2">상품번호</th>
				<td width="35%"><b><%=lists.get(0).getPnum() %></b></td>
			</tr>
		
			<tr>
				<th width="15%" class="m2">상품명</th>
				<td width="35%"><b><%=lists.get(0).getPname() %></b></td>
				
				<th width="15%" class="m2">제조회사</th>
				<td width="35%"><b><%=lists.get(0).getPcompany() %></b></td>
			</tr>
			
			<tr>
				<th width="15%" class="m2">상품이미지</th>
				<td colspan="3" align="center">
				<%
					String imgPath = request.getContextPath() + "/myshop/images/" + lists.get(0).getPimage();
				%>
				
					<img src="<%=imgPath %>" width="100" height="100">
				
				</td>
			</tr>
			
			<tr>
				<th width="15%" class="m2">상품수량</th>
				<td width="35%"><b><%=lists.get(0).getPqty() %></b></td>
				
				<th width="15%" class="m2">상품가격</th>
				<td width="35%"><b><%=lists.get(0).getPrice() %></b></td>
			</tr>
			
			<tr>
				<th width="15%" class="m2">상품스펙</th>
				<td width="35%"><b><%=lists.get(0).getPspec() %></b></td>
				
				<th width="15%" class="m2">상품포인트</th>
				<td width="35%"><b><%=lists.get(0).getPoint() %></b></td>
			</tr>
			
			<tr>
				<th width="15%" class="m2">상품소개</th>
				<td colspan="3">
					<textarea rows="5" cols="50" style="resize:none"><%=lists.get(0).getPcontents() %></textarea>
				
				</td>
			</tr>
			
			<tr>
				<td colspan="4" align="center" class="m1">
					<input type="submit" value="돌아가기">
				</td>
			</tr>
		</table>
	
	</form>
</td>
<%@ include file = "bottom.jsp"%>








