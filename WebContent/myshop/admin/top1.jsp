<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
	#panel1, #panel2{
		background-color: green;
		border : 1px solid #c3c3c3;
		padding : 5px;
		text-align: center;
	}
	#panel2{
		display:none;
	}
</style>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
	$(function(){
		 
		$('#panel1').click(function(){
			$('#panel2').slideToggle('slow',function(){
				$('#panel2 table').css('border','3px solid red');
			});
		});
		
	});
	
</script>
<body>
<font size=6>관리자(사서의 관리자화면)</font> <br>
<a href="main.jsp"><font size=3>로그아웃</font></a>
<a href="<%=request.getContextPath() %>/main.jsp"><font size=3>메인홈</font></a>
<font size=3>로그아웃</font>
  
    
	<div id="panel1">Click</div>
	<div id="panel2">
<table background ="imagine.jpg" width="100%" height="100">
	<tr height="40">
	<td>
	마스터코드 총칭 관리자모드</td>
		<td align="center" >
			<a href="<%=request.getContextPath() %>/myshop/admin/cate_input.jsp"> 장르 등록</a> 
		</td>
		
		<td align="center">
			<a href="<%=request.getContextPath() %>/myshop/admin/cate_list.jsp">장르 목록</a> 
		</td>
		
		<td align="center">
			<a href="<%=request.getContextPath() %>/myshop/admin/prod_input.jsp">작품 등록</a> 
		</td>
		
		<td align="center">
			<a href="<%=request.getContextPath() %>/myshop/admin/prod_list.jsp">상품 목록</a> 
		</td>
		
		<td align="center">
			<a href="<%=request.getContextPath() %>/myshop/admin/shopping_list.jsp">내용구입 내역</a> 
		</td>
		
		<td align="center">
			<a href="<%=request.getContextPath() %>/myshop/display/mall.jsp">사용자 홈</a> 
		</td>
		<td>
		<a href="<%=request.getContextPath() %>/myshop/list/list.jsp">계시판 관리</a> 
		</td>
	</tr>
	</table>
</div>
</body>