package my.list;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;






public class ListDao {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl"  ;
	String username="jspid" ; 
	String password="jsppw" ;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	private static ListDao dao;

	public static ListDao getInstance() {
		if(dao == null) {
			dao = new ListDao();
		}
		return dao;
	}

	private ListDao() {
		System.out.println("ListDao()");

		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	} // ������

	public void getConnection(){  
		try {
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}   
	}//getConnection

	public int getArticleCount(){

		getConnection();

		String sql = "select count(*) as cnt from list"; // 100

		int x = 0;

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(Exception e) {

			}
		}
		
		return x;
		
	}//getArticleCount()

	public ArrayList<ListBean> getArticles(int start, int end){ 
		
		getConnection();
		ArrayList<ListBean> lists = new ArrayList<ListBean>();
		
		String sql = "select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip " ;		        
		sql += "from (select rownum as rank, num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from (select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from list  ";
		sql += "order by ref desc, re_step asc )) ";
		sql += "where rank between ? and ? ";	
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ListBean article= new ListBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip")); 
				
				lists.add(article);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(Exception e) {

			}
		}
		
		return lists;
		
	}//getArticles
	
	public int insertArticle(ListBean article){ // ���۾��� 
		getConnection();
		int cnt = -1;
		String sql = "insert into list(num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip) " + 
		"values(list_seq.nextval,?,?,?,?,?,list_seq.currval,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt(6, 0); // re_step
			pstmt.setInt(7, 0); // re_level
			pstmt.setString(8, article.getContent());
			pstmt.setString(9, article.getIp());
			cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(Exception e) {

			}
		}
		return cnt;
		
	}//insertArticle
	
	public ListBean getArticle(int num){
		getConnection();
		
		String sql_update = "update list set readcount = readcount+1 where num=?";
		
		String sql = "select * from list where num=?";
		ListBean article = null;
		try {
			pstmt = conn.prepareStatement(sql_update);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new ListBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));     
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(Exception e) {

			}
		}
		return article;
		
	}// getArticle
	
	public int deleteArticle(int num,String passwd){
		getConnection();
		
		String sql = "select passwd from list where num=?";
		String sql_delete = "delete from list where num=?";
		int cnt = -1;
		try {
			pstmt = conn.prepareStatement( sql 	);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String dbpasswd = rs.getString("passwd"); // 
				if(dbpasswd.equals(passwd) ) {
					pstmt = conn.prepareStatement( sql_delete);
					pstmt.setInt(1, num);
					cnt = pstmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(Exception e) {

			}
		}
		return cnt;
		
	}// deleteArticle
	
	public int replyArticle(ListBean article){ // ��۾���
		//ref,re_step,re_level : �θ��
		//subject,writer,passwd.. : ����
		getConnection();
		int cnt = -1;
		String sql_update = "update list set re_step = re_step+1 where ref=? and re_step > ?";
		String sql_insert = "insert into list(num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip) " + 
				"values(list_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
				
		try {
			pstmt = conn.prepareStatement(sql_update);
			pstmt.setInt(1, article.getRef());
			pstmt.setInt(2, article.getRe_step());
			pstmt.executeUpdate();
			int ref = article.getRef();
			int re_step = article.getRe_step() + 1;
			int re_level = article.getRe_level() + 1 ;
			
			
			pstmt = conn.prepareStatement(sql_insert);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt(6, ref); // re_step
			pstmt.setInt(7, re_step); // re_step
			pstmt.setInt(8, re_level); // re_level
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(Exception e) {

			}
		}
		return cnt;
		
	}//
	
	public ListBean updateGetArticle(int num){ // updateForm�� ����� ���� ȣ��
		
		getConnection();
		
		String sql = "select * from list where num=?";
		ListBean article = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				article = new ListBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));     
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(Exception e) {

			}
		}
		
		return article;
		
	}//
	
	public int updateArticle(ListBean article){
		System.out.println("updateArticle :" + article.getWriter());
		getConnection();
		int cnt = -1;
		String sql = "select passwd from List where num=?";
		String sql_update = "update list set writer=?, subject=?, email=?, content=? where num=?";
		try {
			pstmt = conn.prepareStatement( sql );
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String dbpasswd = rs.getString("passwd");
				
				if(dbpasswd.equals(article.getPasswd())){
					pstmt = conn.prepareStatement( sql_update );
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getEmail());
					pstmt.setString(4, article.getContent());
					pstmt.setInt(5, article.getNum());
					cnt = pstmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(Exception e) {

			}
		}
		return cnt;
	}//updateArticle
}











