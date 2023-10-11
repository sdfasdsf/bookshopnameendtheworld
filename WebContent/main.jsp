<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
	<head>

<title>더워 </title>
		<meta charset="UTF-8" />
		<style type="text/css">
		body { 
				font:12px "맑은 고딕",돋움,arial; 
				margin:0px;
				}
				#bookImg {
				margin:0px 295px;
				text-align:right;
				}
</style>		

<img src ="imagine.jpg" alt="사진이 읎 읎다고" width=100% height=50%>

<%@ include file="top1.jsp"%>

	<form action="loginPro.jsp" method="post">
		<table  height=120 align="left">
			<tr>
				<td bgcolor="yellow" align="center">아이디</td>
				<td><input type="text" name="id" value="admin"></td>
			</tr>
			<tr>
				<td bgcolor="yellow" align="center">비번</td>
				<td><input type="password" name="password" value="1234"></td>
			</tr>
			<tr>
				<td colspan=2 bgcolor="#FFCC00">
					
					<input type="submit" value="로그인"> 
					
					<input type="button" value="회원 가입"
					onclick="location.href='<%=request.getContextPath()%>/myshop/member/register.jsp'">
					
					<input type="button" value="아이디 찾기"
					onclick="location.href='<%=request.getContextPath()%>/findid.jsp'">
					
					<input type="button" value="비번 찾기"
					onclick="location.href='<%=request.getContextPath()%>/findpwd.jsp'">
				</td>
			</tr>
		</table>
	</form>
	
	    <%@ include file="list.jsp" %> 