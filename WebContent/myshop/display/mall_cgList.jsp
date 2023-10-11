<%@page import="my.boo.bookDao"%>
<%@page import="my.boo.bookBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_cgList.jsp -->
    <img src = "asdf.png" align = "left" width =10% height= 100%> 
<img src ="imagine.jpg" alt="사진이 읎 읎다고"  align = "center">
    <img src = "asdf.png" align = "right" width = 10% height = 100%> 


<%@ include file="top1.jsp" %>

<%
	String code = request.getParameter("code");
	String cgname = request.getParameter("cgname");
	out.print(code +"," + cgname); // man, 남성복 
	//pcategory_fk = code + pcode;
%>
   <hr color=green width="80%">
		<font color=red size=3><%=cgname %></font>
	<hr color=green width="80%">

<%
	bookDao pdao = bookDao.getInstance(); 
	ArrayList<bookBean> plists =  pdao.getSelectByCategory(code);
	DecimalFormat  df = new DecimalFormat("###,###");
	
		if(plists.size() == 0){ 
			out.println("<b>"+cgname+"상품 없습니다.</b>"); 
		}
		else{
%>
			<table align="center" width="100%">
				<tr>
			<%
				int count = 0;
			
				for(bookBean pb : plists){
					count++;
					String pimage = pb.getPimage();
					String pname = pb.getPname();
					int price = pb.getPrice();
					int point = pb.getPoint();
					int pnum = pb.getPnum();
					
					String imgPath = request.getContextPath() + "/myshop/images/"+pimage;
					%>
						<td align="center">
						<a href="mall_prodView.jsp?pnum=<%=pnum%>">
							<img src="<%=imgPath%>" width="80" height="60"><br>
						</a>
							<%=pname %><br>
							<font color=red><%=df.format(price) %></font>원<br>
							<font color=blue><%=point %></font>point<br>	 		 		
						</td>
					<%
					if(count%3==0){ // 
						out.println("</tr><tr>");
						
					}
				}
			%>					
				
				</tr>
			
			</table>
<%			
		
		
	}
%>   





<%@ include file="mall_bottoma.jsp" %> 

