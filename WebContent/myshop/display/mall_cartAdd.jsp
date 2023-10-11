<%@page import="my.boo.bookBean"%>
<%@page import="my.boo.bookDao"%>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_cartAdd.jsp -->

<%
int pnum=Integer.parseInt(request.getParameter("pnum"));
	int oqty=Integer.parseInt(request.getParameter("oqty"));
	
%>
<!-- my.shop.mall.CartBean mallCart = new my.shop.mall.CartBean() -->
<jsp:useBean id="mallCart" class="my.boo.boker.CartaBean" scope="session"/>
<%

	bookDao pdao = bookDao.getInstance();
	ArrayList<bookBean> list = pdao.getOneSelectByPnum(pnum);
	
	mallCart.addbook(pnum,oqty);
	
	response.sendRedirect("mall_cartList.jsp");
%>







