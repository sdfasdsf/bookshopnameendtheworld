<%@page import="java.text.DecimalFormat"%>
<%@page import="my.boo.bookBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_cartList.jsp -->
   <img src = "asdf.png" align = "left" width =10% height= 100%> 
<img src ="imagine.jpg" alt="사진이 읎 읎다고" width = 79% align = "center">
    <img src = "asdf.png" align = "right" width = 10% height = 100%> 
<%@ include file="top1.jsp"%>  

<jsp:useBean id="mallCart" class="my.boo.boker.CartaBean" scope="session"/>

<table width=100% border=1 align=center>
	<tr class=m2>
		<td colspan=6 align=center >
			<h4>장바구니 보기</h4> 
		</td>
	</tr>

	<tr class=m1>
		<th width="10%">번호</th>
		<th width="20%">상품명</th>
		<th width="20%">수량</th>
		<th width="20%">단가</th>
		<th width="20%">금액</th>
		<th width="10%">삭제</th>
	</tr>
	
	<%
	DecimalFormat df = new DecimalFormat("###,###");
	int cartTotalPrice=0;
	int cartTotalPoint=0;
	
	Vector<bookBean> cv = mallCart.getAllbook();
	if(cv.size() == 0){
		out.print("<tr><td colspan=6 align=center><b>장바구니에 상품이 없습니다.<b></td></tr></table>");
	}
	else{
		
		for( bookBean pb : cv){
			String pimage = pb.getPimage(); 
			String imgPath = request.getContextPath()+"/myshop/images/" + pimage;
	%>			
			<tr>
				<td align=center> <%=pb.getPnum() %> </td>
				<td align=center>
					<img src="<%=imgPath %>" width="40" height="40"><br>
					<b><%=pb.getPname() %></b>
				</td>
				<td align=center> 
					<form name="f" method="post" action="mall_cartEdit.jsp">
						<input type="text" size="1" name="oqty" value="<%=pb.getPqty() %>">개
						<input type="hidden" name="pnum" value="<%=pb.getPnum() %>"> 
						<input type="submit" value="수정">				
					</form>
				</td>
				<td align=center> 
					<%=df.format(pb.getPrice()) %>원<br>
					[<%=pb.getPoint() %>] point
				</td>
				
				<td align=center> 
					<font color=red>
						<%=df.format(pb.getTotalPrice()) %>원<br>
						[<%=pb.getTotalPoint() %>] point
					</font>
				</td>
				<td align=center> 
					<a href="mall_cartDel.jsp?pnum=<%=pb.getPnum()%>">삭제</a>
				</td>
			
			</tr>	
			
	<%		
			cartTotalPrice += pb.getTotalPrice();
			cartTotalPoint += pb.getTotalPoint();
		}//for
		
		%>
		<tr class=m1>
			<td colspan=4>
			<font color=red>
				<b>대여권 총액</b>
				<%=df.format(cartTotalPrice) %>원
			</font>
				<br>
			<font color=green>	
				<b>총 적립 포인트</b>
				<%=df.format(cartTotalPoint) %> point
			</font>
			</td>
			<td colspan=2>
			<a href="mall_order.jsp?pnum=00&oqty=00">
				[대여권 주문하기]
			</a>
			<a href="mall.jsp">
				[다른 소설 찾기]
			</a>
			</td>
		</tr>
		</table>
		<%
	}//else
	%>
	
<%@ include file = "mall_bottoma.jsp"%>


