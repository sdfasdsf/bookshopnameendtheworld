<%@page import="my.boo.boker.OrderaBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
myshop/admin/shopping_list.jsp<br>

<%@ include file = "top1.jsp"%>

<jsp:useBean id="order" class="my.boo.boker.OrderaDao" scope="session" />


	<%
		DecimalFormat df = new DecimalFormat("###,###");
		int total = 0;
		Vector<OrderaBean> lists = new Vector<OrderaBean>();
		String memid = request.getParameter("memid");
		if(memid != null){ // 
			lists = order.getOrderaList(memid);  
		}
	%>
	<td colspan="6" valign="top">
		<table border="1" width="800px">
			<tr>
				<td colspan="5" align="center">
					<form action="shopping_list.jsp" method="post">
						조회할 회원 아이디 입력:
						<input type="text" name="memid" value="hong">
						<input type="submit" value="내역 조회">
					</form> 
				</td>
			</tr>
			
			<tr bgcolor="#D5D5D5" align="center"> 
				<td>고객명</td>
				<td>아이디</td>
				<td>상품명</td>
				<td>수량</td>
				<td>금액</td>
			</tr>
			
			<%
			for( OrderaBean ob : lists ){ 
				%>
				<tr>
					<td align="center"><%=ob.getMname() %></td>
					<td align="center"><%=ob.getMid() %></td>
					<td align="center"><%=ob.getPname() %></td>
					<td align="right"><%=ob.getQty() %></td>
					<td align="right">￦<%=df.format(ob.getAmount()) %></td>
				</tr>
				<%
				
				total += ob.getAmount();
			} // for
			%>
			
			<tr>
				<td colspan="4" align="center">총합</td>
				<td align="right">￦<%=df.format(total) %></td>
			</tr>
		</table>
	</td>

<%@ include file = "bottom.jsp"%>

