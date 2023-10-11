<%@page import="my.boo.bookBean"%>
<%@page import="my.boo.bookDao"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
prod_update.jsp<br><br>

<%@ include file="top1.jsp" %>
  
<td colspan=6 align=center valign=top>
<%
int pnum= Integer.parseInt(request.getParameter("pnum"));

bookDao pdao = bookDao.getInstance();
ArrayList<bookBean> lists = pdao.getOneSelectByPnum(pnum);
%>

<form name="myform" action="prod_update_proc.jsp" method="POST" 
				enctype="multipart/form-data">
<table border=0 class=outline width=600>
<CAPTION ALIGN="TOP">상품수정</CAPTION>
	<tr>
		<th class="m2">카테고리</th>
		<td align=left>
			<input type=text name="pcategory_fk" value="<%=lists.get(0).getPcategory_fk()%>" disabled >
			<input type=hidden name="pcategory_fk" value="<%=lists.get(0).getPcategory_fk()%>">	
		</td>
	</tr>
	<tr>
		<th class="m2">상품번호</th>
		<td align=left><b><%=lists.get(0).getPnum()%></b>
		<input type=hidden name="pnum" value="<%=lists.get(0).getPnum()%>">
		</td>
	</tr>
	<tr>
		<th class="m2">상품명</th>
		<td align=left>
		<input type=text name="pname" value="<%=lists.get(0).getPname()%>">
		</td>
	</tr>
	<tr>
		<th class="m2">제조회사</th>
		<td align=left>
		<input type=text name="pcompany" value="<%=lists.get(0).getPcompany()%>">
		</td>
	</tr>
	<tr>
		<th class="m2">상품이미지</th>
		<td align=left>
<%
		String imgFolder = request.getContextPath() + "/myshop/images";
		String configFolder = config.getServletContext().getRealPath("/myshop/images");
%>
		<img src="<%=imgFolder %>/<%=lists.get(0).getPimage() %>" width="100" height="100">	
		
		<input type="file" name="pimage"> <!-- 새 이미지 담길 장소 -->
		
<%
	if(lists.get(0).getPimage() != null){ // DB테이블에 있다면  
		File existFile = new File(configFolder,lists.get(0).getPimage());
		if(existFile.exists()){ // 웹서버 폴더에 있다면
%>
			<input type="text" name="old_pimage" value="<%=lists.get(0).getPimage() %>"> <!-- old_pimage=이전이미지.jpg -->
<%
		}else{ 
			pdao.updatePimage(pnum); // pnum에 해당하는 이미지만 pimage = null
		}
		
	}
%>		
		
		  
		</td>
	</tr>
	<tr>
		<th class="m2">상품 수량</th>
		<td align=left>
		<input type=text name="pqty" value="<%=lists.get(0).getPqty()%>" maxlength=8>
		</td>
	</tr> 
	<tr>
		<th class="m2">상품 가격</th>
		<td align=left>
		<input type=text name="price" value="<%=lists.get(0).getPrice()%>" maxlength=8>
		</td>
	</tr>
	<tr>
		<th class="m2">상품 스펙</th>
		<td align=left>
			<select name="pspec">
				<option value="오늘 new" <% if(lists.get(0).getPspec().equals("오늘 new")) {%> selected <% } %>>::오늘 new::</option>
				<option value="7일" <% if(lists.get(0).getPspec().equals("7일")) {%> selected <% } %>> 7일</option>
				<option value="한달이내" <% if(lists.get(0).getPspec().equals("한달이내")) {%> selected <% } %>> 한달이내</option>
				<option value="한달이후" <% if(lists.get(0).getPspec().equals("한달이후")) {%> selected <% } %>> 한달이후</option>
			</select>
		</td>
	</tr>
	<tr>
		<th class="m2">상품 소개</th>
		<td align=left>
		<textarea name="pcontents" rows=5 cols=50  style="resize: none;"><%=lists.get(0).getPcontents()%></textarea>
		</td>
	</tr>
	<tr>
		<th class="m2">상품 포인트</th>
		<td align=left>
			<input type=text name="point" value="<%=lists.get(0).getPoint() %>"></td>
	</tr>
	<tr>	
		<td colspan=2 class="m1">
			<input type=submit value="상품 수정">
			<input type=reset value="취 소">
		</td>
	</tr>
</table>
</form> 
</td>
<%@ include file="bottom.jsp" %>  


