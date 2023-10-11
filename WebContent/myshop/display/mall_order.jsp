
<%@page import="my.boo.bookBean"%>
<%@page import="java.util.Vector"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- mall_prodView.jsp 즉시 구매하기 이미지 클릭 -> mall_order.jsp -->
<!-- mall_cartList.jsp 주문하기 클릭 -> mall_order.jsp -->

<%@ include file="top1.jsp"%> 

<%
	boolean flag = (boolean)application.getAttribute("flag");
	System.out.println("mall_order.jsp 위 flag : " + flag);
%>
<jsp:useBean id="mallCart" class="my.boo.boker.CartaBean" scope="session"/>

<%
if(memid.equals("admin")){
%>
	<script type="text/javascript">
		alert("관리자는 주문 할 수 없습니다.");
		history.back();
	</script>
<%	
}

int pnum=Integer.parseInt(request.getParameter("pnum"));
int oqty=Integer.parseInt(request.getParameter("oqty"));
System.out.println("mall_order.jsp "+pnum+","+oqty);

if(pnum != 0 && oqty != 0){ 
	if(flag == true){
		mallCart.addbook(pnum, oqty); // 즉시 구매하기 클릭 
	}
}

%>

<table width=90% class="outline" align=center border="1">
		<tr class=m2>
			<td colspan=6 align=center><h4>결재 내역서 보기</h4></td>
		</tr> 
		<tr class=m1>
			<th width="40%">상품명</th>
			<th width="20%">수량</th>
			<th width="40%">금액</th>
		</tr>
		
<%
	DecimalFormat df=new DecimalFormat("###,###");
	
	int totalPrice = 0;
	
	Vector<bookBean> cv = mallCart.getAllbook();
	
	for(bookBean pb : cv){
%>
		<tr>
			<td align="center"><%=pb.getPname()%></td>
			<td align="right"><%=pb.getPqty()%>개</td>
			<td align="right"><%=df.format(pb.getTotalPrice())%>원</td>
		</tr>	
<%		
		totalPrice += pb.getTotalPrice();
	}
%>		
	<tr class=m1>
		<td colspan=3 align=center><b>결재하실 총액은</b>:
			<font color=red><%=df.format(totalPrice)%>원<br></font>		
		</td>
	</tr>	
	</table>
	
	<input type="button" value="결재하기" onclick="location.href='../display/mall_calculate.jsp'">	
<table>
<tr>
<td>
<%= session.getAttribute("memno") %>
</td>
</tr>
</table>

<%
	application.setAttribute("flag", false);
	flag = (boolean)application.getAttribute("flag");
	System.out.println("mall_order.jsp 아래 flag : " + flag);
%>
<% System.out.println(session.getAttribute("memno"));%>
<%@ include file="mall_bottoma.jsp"%>











