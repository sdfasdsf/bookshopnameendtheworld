package my.boo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class goryDAO {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl"  ;
	String username="jspid" ; 
	String password="jsppw" ;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	private static goryDAO dao;

	public static goryDAO getInstance() {
		if(dao == null) {
			dao = new goryDAO();
		}
		return dao;
	}
	
	private goryDAO() {
		try {
			Class.forName(driver);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}//

	public void getConnection(){

		try {
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}   
	} // getConnection

	public int insertCategory(goryBean cbean){
		getConnection();
		int cnt = -1;
		String sql="insert into gory values(catseq.nextval,?,?)";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, cbean.getCode());
			pstmt.setString(2, cbean.getCname());
			
			cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			}catch(Exception e) {
				
			}
		}
		
		return cnt;
		
	}//insertCategory
	
	public ArrayList<goryBean> getAllCategory(){
		getConnection();
		ArrayList<goryBean> lists = new ArrayList<goryBean>();
		String sql = "select * from gory order by cnum asc";
		try {
			pstmt=conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				goryBean cbean = new goryBean();
				cbean.setCnum(rs.getInt("cnum"));
				cbean.setCode(rs.getString("code"));
				cbean.setCname(rs.getString("cname"));
				lists.add(cbean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close();
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			}catch(Exception e) {
				
			}
		}
		return lists;
		
	}//getAllCategory()
	
	public int categoryDelete(int cnum){
		getConnection();
		int cnt = -1 ;
		String sql = "delete from gory where cnum=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			}catch(Exception e) {
				
			}
		}
		return cnt;
	}
}







