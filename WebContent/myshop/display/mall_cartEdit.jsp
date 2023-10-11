<%@page import="my.boo.bookBean"%>
<%@page import="my.boo.bookDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_cartList.jsp에서 수정 클릭 -> mall_cartEdit.jsp -->

<jsp:useBean id="mallCart" class="my.boo.boker.CartaBean" scope="session"/>

<%
	int pnum=Integer.parseInt(request.getParameter("pnum"));
	int oqty=Integer.parseInt(request.getParameter("oqty"));
	
	bookDao pdao = bookDao.getInstance();
	ArrayList<bookBean> lists = pdao.getOneSelectByPnum(pnum);
	
	if(lists.get(0).getPqty() < oqty){
%>
		<script type="text/javascript">
			alert("수량 초과");
			//history.go(-1);
			location.href="mall_cartList.jsp";
		</script>				
<%		
	}
	
	//  주문수량 장바구니에서 수정
	mallCart.setEdit(pnum,oqty);
	
	//response.sendRedirect("mall_cartList.jsp");
%>
	<script type="text/javascript">
			location.href="mall_cartList.jsp";
	</script>		







