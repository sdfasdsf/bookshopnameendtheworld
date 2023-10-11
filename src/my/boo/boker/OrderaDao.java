package my.boo.boker;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import my.boo.bookBean;


public class OrderaDao {

	//dbcp
	private DataSource ds;
	Connection conn = null;
	PreparedStatement pstmt = null ;
	ResultSet rs = null;
	
	public OrderaDao() {
		try {
			Context initContext = new InitialContext(); 

			Context envContext = 
					(Context)initContext.lookup("java:/comp/env");

			ds = (DataSource)envContext.lookup("jdbc/OracleDB");

			conn = ds.getConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}//

	public int insertOrdera(int no, Vector<bookBean> cv){

		String sql = "insert into ordera(orderId,memno,pnum,qty,amount) " + 
				"values(oldbooks.nextval,?,?,?,?)";
		int cnt = -1;
		try {
			for(int i=0;i<cv.size();i++) {
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, no);
				pstmt.setInt(2,cv.get(i).getPnum());
				pstmt.setInt(3,cv.get(i).getPqty());
				pstmt.setInt(4,cv.get(i).getTotalPrice());
				cnt += pstmt.executeUpdate();
				System.out.println( "title:"+cnt);
				

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				/*
				if(conn != null) {
					conn.close();
				}
				 */
			}catch(Exception e) {

			}
		}
		return cnt;
	}//insertOrders
	
	public Vector<OrderaBean> getOrderaList(String memid){
		
		Vector<OrderaBean> lists = new Vector<OrderaBean>();
		
		String sql = "select m.name mname, m.id mid, p.pname ppname, o.qty oqty, o.amount oamount  " + 
					" from (readers m join orders o on m.no = o.memno) join book p on o.pnum = p.pnum " +
					" where m.id = ?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, memid);			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				String mname = rs.getString("mname");
				String mid = rs.getString("mid");
				String ppname = rs.getString("ppname");
				int oqty = rs.getInt("oqty");
				int oamount = rs.getInt("oamount");
				
				OrderaBean ob = new OrderaBean();
				ob.setMname(mname);
				ob.setMid(mid);
				ob.setPname(ppname);
				ob.setQty(oqty);
				ob.setAmount(oamount);
				
				lists.add(ob);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				/*
				if(conn != null) {
					conn.close();
				}
				 */
			}catch(Exception e) {

			}
		}
		
		return lists;
				
	}

}



