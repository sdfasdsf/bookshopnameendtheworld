<%@page import="my.boo.goryBean"%>
<%@page import="my.boo.goryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
myshop/admin/prod_input.jsp<br>

<%@ include file = "top1.jsp"%>
	
<td colspan="6">
	<form name="myform" action="prod_input_proc.jsp" method="post" enctype="multipart/form-data"> 
		<table width="600" class=outline>
			<caption valign="top"><b>상품등록</b></caption>
			<tr>
				<th class=m2>카테고리</th>
				<td>
					<select name="pcategory_fk">
	<%
		goryDAO cdao = goryDAO.getInstance();
		ArrayList<goryBean> lists = cdao.getAllCategory(); 
		if(lists.size()== 0){
			out.print("<option value=''>카테고리 없음</option>");			
		}
		else{
			for(int i=0;i<lists.size();i++){
				goryBean cb = lists.get(i);
				String code = cb.getCode();
				String cname = cb.getCname();
	%>
				<option value="<%=code%>"><%=cname%>[<%=code%>]</option>
	<%				
			} // for
		} // else
	%>											
					</select>
				</td>
			</tr>
	
			<tr>
				<th class=m2>상품명</th>
				<td>
					<input type="text" name="pname" value="이름">
				</td>
			</tr>
			
			<tr>
				<th class=m2>상품코드</th>
				<td>
					<input type="text" name="pcode" value="이름">
				</td>
			</tr>
			
			<tr>
				<th class=m2>배부사</th>
				<td>
					<input type="text" name="pcompany" value="이름">
				</td>
			</tr>
			
			<tr>
				<th class=m2>작품표지이미지</th>
				<td>
					<input type="file" name="pimage">
				</td>
			</tr>
			
			<tr>
				<th class=m2>텍본 판매제한수</th>
				<td>
					<input type="text" name="pqty" value="3">
				</td>
			</tr>
			
			<tr>
				<th class=m2>상품가격</th>
				<td>
					<input type="text" name="price" value="100">
				</td>
			</tr>
			
			<tr>
				<th class=m2>상품스펙</th>
				<td>
					<select name="pspec">
						<option value="오늘 new">::오늘 new::</option>       
						<option value="7일">7일이내</option>
						<option value="한달이내">::한달이내::</option>
						<option value="한달이후">::한달이후::</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th class=m2>상품소개</th>
				<td>
					<textarea rows="5" cols="50" name="pcontents" style="resize:none;"></textarea>
				</td>
			</tr>
			
			<tr>
				<th class=m2>상품포인트</th>
				<td>
					 <input type=text name="point" value="222">
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center"  class=m1> 
					<input type="submit" value="상품등록">
					<input type="reset" value="취소">
				</td>
			</tr>
			
		</table>
	
	
	</form>
	
</td>

<%@ include file = "bottom.jsp"%>















