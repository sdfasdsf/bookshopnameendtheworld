<%@page import="my.list.ListDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
deleteForm.jsp -> deletePro.jsp<br><br>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String passwd = request.getParameter("passwd");
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	ListDao dao = ListDao.getInstance();
	
	int cnt = dao.deleteArticle(num,passwd); // 15번, 패스워드
	/*  15번 passwd만 select == passwd => 삭제 1
	15번 passwd만 select != passwd => 삭제 0 */ 
	
	if(cnt>0){
		
		int count = dao.getArticleCount(); // 전체 레코드 갯수 리턴 
		System.out.println("count:" + count);
		int pageSize = 10; // 조건?참:거짓
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		
		if(pageNum > pageCount){ // 2 > 1
			response.sendRedirect("list.jsp?pageNum="+(pageNum-1));
		}
		else{ // 2 < 10
			response.sendRedirect("list.jsp?pageNum="+pageNum);
		}
		
	}
	else{
%>
	<script type="text/javascript">
		alert("비번이 맞지 않습니다.");
		history.go(-1);
	</script>	
<%
		//response.sendRedirect("deleteForm.jsp?num="+num);
	}
%>


