<%@page import="my.boo.bookDao"%>
<%@page import="my.boo.bookBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 	int pnum = Integer.parseInt(request.getParameter("pnum")); %>
<script type="text/javascript">
	function goCart(pnum){
		//alert("goCart");
		oqty = document.f.oqty.value;
		if(oqty < 1) {
			alert("1보다 큰 수를 입력하세요");
			return;
		}
		location.href="<%=request.getContextPath() %>/myshop/display/mall_cartAdd.jsp?pnum="+pnum+"&oqty="+oqty;       
	}
	
	function goOrder(pnum){
		//alert("goOrder");
		document.f.action="<%=request.getContextPath() %>/myshop/display/mall_order.jsp?pnum="+pnum;
		document.f.submit();
	}
</script>    


<!-- mall_prodView.jsp -->
    <img src = "asdf.png" align = "left" width =10% height= 100%> 
<img src ="imagine.jpg" alt="사진이 읎 읎다고"  align = "center">
    <img src = "asdf.png" align = "right" width = 10% height = 100%> 


<%@ include file = "top1.jsp"%>
<%
/* ServletContext application = new ServletContext() */
application.setAttribute("flag", true); // flag = true
System.out.println("mall_prodView.jsp flag:" + application.getAttribute("flag"));

	
	bookDao pdao = bookDao.getInstance();
	ArrayList<bookBean> plists = pdao.getOneSelectByPnum(pnum); 
	 
	String pimage = plists.get(0).getPimage(); 
	String imgPath = request.getContextPath()+"/myshop/images/"+pimage;
	DecimalFormat df = new DecimalFormat("###,###");
	
%>

<table width="100%" border="0" class=outline>
	<tr class="m1">
		<td colspan=2 align="center">
			<font color=green size=3>
				<b>[<%= plists.get(0).getPname()%>] 상품정보</b>
			</font>
		</td>
	</tr>
	
	<tr align="center">
		<td class="m3">
			<img src="<%=imgPath %>" width="200" height="200">
		</td>
		
		<td  class="m3">
			<form name="f" method="post">
				작품번호 : <%=plists.get(0).getPnum() %> <br>
				작품이름 : <%=plists.get(0).getPname() %> <br>
				작품가격 : <font color=red><%=df.format(plists.get(0).getPrice()) %></font> <br>
				작품포인트 : <font color=red><%=plists.get(0).getPoint() %></font> <br>
				작품갯수:<input type="text" name="oqty" size="2" value="1">개<br><br>
				<table width="90%" align="center">
					<tr>
						<td>대여권담기
							<a href="javascript:goCart(<%= pnum%>)">
								<img src="즉시구입.jpg" width="90" height="35">
							</a>
						</td>
						
						<td>즉시 쓰기
							<a href="javascript:goOrder(<%= pnum%>)">
								<img src="즉시 구매.jpg" width="90" height="35">
							</a>
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr>
	
	<tr height="200" valign="top">
		<td colspan="2">
			<b>상품 상세 설명</b><br>
			<%= plists.get(0).getPcontents()%>
		</td>
	</tr>
</table>







<%@ include file = "mall_bottoma.jsp"%>








