<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<img src ="imagine.jpg" alt="사진이 읎 읎다고" width=100% height=50%>

<%@ include file="top1.jsp"%>
findid.jsp <br>

<form action="findidPro.jsp" method="post">
	<table align="center">
		<tr>
			<td bgcolor="yellow" align="center">이름</td>
			<td> <input type="text" name="name" value="어드민"> </td>
		</tr>
		
		<tr>
			<td bgcolor="#61DBF0" align="center">널찾기위한 번호</td>
			<td> 
				<input type="text" name="rrn1" maxlength="6" size="6" value="111111"> 
					-
				<input type="text" name="rrn2" maxlength="7" size="7" value="2222222"> 
			
			</td>
		</tr>
		
		<tr>
			<td colspan="2" bgcolor="yellow" align="center">
				<input type="submit" value="아이디찾기">
			</td>
		</tr>
	</table>
</form>










