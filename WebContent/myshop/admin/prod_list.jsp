
<%@page import="my.boo.bookBean"%>
<%@page import="my.boo.bookDao"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">
	function checkDel(pnum,pimage){ // 2,남성정장.jpg
		var answer = confirm("정말 삭제하시겠습니까?"); // answer
		if(answer){
			location.href = "prod_delete.jsp?pnum="+pnum+"&pimage="+pimage;//prod_delete.jsp?pnum=5&pimage=남성정장.jpg
		}
	}
</script>    
myshop/admin/prod_list.jsp<br>
 
<%@ include file = "top1.jsp"%>
	
	<td colspan="6" valign="top">
		<table width="95%" class=outline>
			<caption><b>상품목록</b></caption>
			<tr>
				<th class=m2>번호</th>
				<th class=m2>상품코드</th>
				<th class=m2>상품명</th>
				<th class=m2>이미지</th>
				<th class=m2>가격</th>
				<th class=m2>제조사</th>
				<th class=m2>수량</th>
				<th class=m2>수정|삭제</th>  
			</tr>
		<%
			bookDao pdao = bookDao.getInstance();
			ArrayList<bookBean> lists =  pdao.getbookAll();
			
			if(lists.size()==0){
				out.println("<tr><td colspan=8>등록된 상품이 없습니다.</td></tr>");
			}
			
			for(bookBean pb : lists){
%>
				<tr>
					<td align="center"><%=pb.getPnum() %></td>
					<td align="center"><%=pb.getPcategory_fk() %></td>
					<td align="center"><%=pb.getPname() %></td>
				<%
				//pb.getPimage();//남성정장.jpg
				String conpath = request.getContextPath(); 
				System.out.println("conpath:"+conpath);// /Minimall
				
				String conpath2 = request.getContextPath() + "/myshop/images/" + pb.getPimage();
				System.out.println("conpath2:"+conpath2);
				///Minimall/myshop/images/남성정장.jpg
				
				%>
					<td>
					<a href="prod_view.jsp?pnum=<%=pb.getPnum()%>">
						<img src="<%= conpath2%>" width=40 height=40>
					</a>
					</td>
					
					<td align="right"><%=pb.getPrice() %></td>
					<td align="center"><%=pb.getPcompany()%></td>
					<td align="right"><%=pb.getPqty() %></td> 
					<td align="center">
						<a href="prod_update.jsp?pnum=<%=pb.getPnum()%>">수정</a> | 
						<a href="javascript:checkDel('<%=pb.getPnum()%>' , '<%=pb.getPimage()%>'  )">삭제</a> 
					</td>
				</tr>
<%				
			}//for
		%>
		
		
		</table>
	</td>

<%@ include file = "bottom.jsp"%>