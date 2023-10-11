package my.book;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReaderDAO {
	
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:orcl"  ;
		String username="jspid" ; 
		String password="jsppw" ;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		private static ReaderDAO dao;
		
		public static ReaderDAO getInstance() {
			if(dao == null) {
				dao = new ReaderDAO();
			}
			return dao;
		}
		
		private ReaderDAO() {
			try {
				Class.forName(driver);
				
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
		
		public void getConnection(){
			
			try {
				conn = DriverManager.getConnection(url, username, password);
			} catch (SQLException e) {
				e.printStackTrace();
			}   
		} // getConnection
		
		public boolean searchID(String userid){
			
			getConnection();
			String sql = "select id from readers where id=?";
			boolean flag = false;
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,userid);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					flag = true; // 
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
			
			return flag;
			
		}// searchID
		
		public int insertData(ReaderDTO dto){
			getConnection();
			
			String sql = 
					"insert into readers(no, name, id, password, rrn1, rrn2, email, hp1, hp2, hp3, joindate) ";
			sql += "values(memseq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " ;
			int cnt = -1;
			try {
				pstmt = conn.prepareStatement(sql) ;
				pstmt.setString(1, dto.getName()) ;
				pstmt.setString(2, dto.getId()) ;
				pstmt.setString(3, dto.getPassword()) ;
				pstmt.setString(4, dto.getRrn1()) ; 
				pstmt.setString(5, dto.getRrn2()) ; 
				pstmt.setString(6, dto.getEmail()) ; 
				pstmt.setString(7, dto.getHp1()) ;
				pstmt.setString(8, dto.getHp2()) ;
				pstmt.setString(9, dto.getHp3()) ;
				pstmt.setString(10, dto.getJoindate()) ; 
				
				cnt = pstmt.executeUpdate() ;
				
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
		}//
		
		public ReaderDTO getreaderByrrn(String name,String rrn1,String rrn2){
			getConnection();
			 
			String sql = "select * from readers where name=? and rrn1=? and rrn2=?";
			ReaderDTO mdto = null;
			
			try {
				pstmt = conn.prepareStatement(sql) ;
				pstmt.setString(1, name) ;
				pstmt.setString(2, rrn1) ;
				pstmt.setString(3, rrn2) ;
				
				rs = pstmt.executeQuery() ; 
				
				if(rs.next()) {
					
					mdto = getReaderBean(rs);
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
			return mdto;
			
			
		} //
		
		public ReaderDTO getReaderByIdAndName(String id, String name,String rrn1,String rrn2){
			
			getConnection();
			 
			String sql = "select * from readers where id=? and name=? and rrn1=? and rrn2=?";
			ReaderDTO mdto = null;
			
			try {
				pstmt = conn.prepareStatement(sql) ;
				pstmt.setString(1, id) ;
				pstmt.setString(2, name) ;
				pstmt.setString(3, rrn1) ;
				pstmt.setString(4, rrn2) ;
				
				rs = pstmt.executeQuery() ; 
				
				if(rs.next()) {
					
					mdto = getReaderBean(rs);
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
			return mdto;
			
		} // getreaderByIdAndName
		
		private ReaderDTO getReaderBean(ResultSet rs) { // idã��, pwã��, �α���
			
			ReaderDTO mdto = new ReaderDTO();
			try {
				mdto.setNo(rs.getInt("no"));
				mdto.setName(rs.getString("name")) ;
				mdto.setId(rs.getString("id"));
				mdto.setPassword(rs.getString("password"));
				mdto.setRrn1(rs.getString("rrn1")) ;
				mdto.setRrn2(rs.getString("rrn2")) ;
				mdto.setEmail(rs.getString("email")) ;
				mdto.setHp1(rs.getString("hp1")) ;
				mdto.setHp2(rs.getString("hp2"));
				mdto.setHp3(rs.getString("hp3"));
				mdto.setJoindate(rs.getString("joindate")) ;
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			return mdto;
		} //
		
		public ReaderDTO getreaderInfo(String id, String password){
			getConnection();
			
			String sql = "select * from readers where id=? and password=? ";
			ReaderDTO mdto = null;
			
			try {
				pstmt = conn.prepareStatement(sql) ;
				pstmt.setString(1, id) ;
				pstmt.setString(2, password) ;
				
				rs = pstmt.executeQuery() ; 
				
				if(rs.next()) {
					
					mdto = getReaderBean(rs);
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
			
			return mdto;
			
		}
		
		public ReaderDTO getreaderInfot(String id ){
			getConnection();
			
			String sql = "select * from readers where id=? ";
			ReaderDTO mdto = null;
			
			try {
				pstmt = conn.prepareStatement(sql) ;
				pstmt.setString(1, id) ;
				
				
				rs = pstmt.executeQuery() ; 
				
				if(rs.next()) {
					
					mdto = getReaderBean(rs);
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
			
			return mdto;
			
		}
		
		
	}





