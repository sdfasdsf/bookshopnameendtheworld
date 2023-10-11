<%@page import="my.boo.bookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.boo.bookDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 	myshop\display\mall.jsp<br><br> -->
    <img src = "asdf.png" align = "left" width =10% height= 100%> 
<img src ="imagine.jpg" alt="사진이 읎 읎다고" width = 79% align = "center">
    <img src = "asdf.png" align = "right" width = 10% height = 100%> 
<%@ include file="top1.jsp"%>

 
 <h3>Welcome to My Mall</h3>
   
<%
	bookDao pdao = bookDao.getInstance();
	String[] spec = {"오늘 new","7일","한달이내","한달이후"};
	DecimalFormat  df = new DecimalFormat("###,###");
	
	for(int i=0;i<spec.length;i++){  
		ArrayList<bookBean> plist = pdao.getSelectBySpec(spec[i]);
%>
		<hr color=cyan width="80%">
		<font color=red size=3><%=spec[i] %></font>
		<hr color=cyan width="80%">
<%		
		if(plist.size() == 0){
			out.println("<b>"+spec[i]+"책이 없습니다.</b>"); 
		}
		else{
%>
			<table align="center" width="100%" background="imagine.jpg">
				<tr>
			<%
				int count = 0;
			
				for(bookBean pb : plist){
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
		
		
		
	}
%>   
   
  <%@ include file="mall_bottoma.jsp"%>

