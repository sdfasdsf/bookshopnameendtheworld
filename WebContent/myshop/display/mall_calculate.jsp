<%@page import="my.boo.bookBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_order.jsp 결재하기 클릭 => mall_calculate.jsp -->

<jsp:useBean id="mallCart" class="my.boo.boker.CartaBean" scope="session" />
<jsp:useBean id="order" class="my.boo.boker.OrderaDao" scope="session" />

<%
	String msg = "", url="";
	Vector<bookBean> cv = mallCart.getAllbook();

	int no = (Integer)session.getAttribute("memno");
	
	int cnt = order.insertOrdera(no,cv);
	
	if(cnt >= 0){
		msg = "주문 성공";
		url = request.getContextPath() + "/myshop/display/mall.jsp"; // mall.jsp
		 
		mallCart.removeAllbook();
%>
		<script type="text/javascript">
			alert("<%=msg%>");
			var answer = confirm("계속 하시겠습니까"); // 확인, 취소
			if(answer){ // 확인
				location.href="<%=url%>";
			}else{ // 취소
				location.href="<%=request.getContextPath()%>/logout.jsp";
			}
				
		</script>
<%		
	} else{
		msg = "주문 실패";
		url = request.getContextPath() + "/myshop/display/mall.jsp"; // mall.jsp
		
	}

%>	





