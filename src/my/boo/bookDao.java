package my.boo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.oreilly.servlet.MultipartRequest;




public class bookDao {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl"  ;
	String username="jspid" ; 
	String password="jsppw" ;

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	private static bookDao das;

	public static bookDao getInstance() {
		if(das == null) {
			das = new bookDao();
		}
		return das;
	}

	private bookDao() {
		try {
			Class.forName(driver);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}//bookDao()

	public void getConnection(){

		try {
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}   
	} // getConnection()

	public int insertbook(MultipartRequest mr){
		getConnection();
		int cnt = -1;

		String pname = mr.getParameter("pname");

		String pcategory_fk = mr.getParameter("pcategory_fk");
		pcategory_fk += mr.getParameter("pcode");
		System.out.println("pcategory_fk:"+pcategory_fk);
		//pcategory_fk = pcategory_fk + pcode

		String pcompany=mr.getParameter("pcompany");
		String pimage=mr.getFilesystemName("pimage");

		String pqty=mr.getParameter("pqty");
		String price=mr.getParameter("price");
		String pspec=mr.getParameter("pspec");
		String pcontents=mr.getParameter("pcontents");
		String point=mr.getParameter("point");

		String sql = "insert into book values(catprod.nextval,?,?,?,?,?,?,?,?,?,?)";

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pname);
			pstmt.setString(2,pcategory_fk);
			pstmt.setString(3,pcompany);
			pstmt.setString(4,pimage);
			pstmt.setString(5,pqty);
			pstmt.setString(6,price);
			pstmt.setString(7,pspec);
			pstmt.setString(8,pcontents);
			pstmt.setString(9,point);

			Date d = new Date(); // 2020 08 14 11:31:26
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(d);
			pstmt.setString(10,today);

			cnt = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null)
					pstmt.close();
				if(conn!=null)
					conn.close();
			}catch(SQLException e) {

			}
		}

		return cnt;



	}//insertbook


	public ArrayList<bookBean> getbookAll(){
		getConnection();
		ArrayList<bookBean> lists = new ArrayList<bookBean>();
		String sql = "select * from book order by pnum";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			lists = makeArrayList(rs);

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();

				if(pstmt!=null)
					pstmt.close();

				if(conn!=null)
					conn.close();
			}catch(SQLException e) {

			}
		}
		return lists;


	}// getbooktAll

	public ArrayList<bookBean> makeArrayList(ResultSet rs){

		ArrayList<bookBean> lists = new ArrayList<bookBean>();

		try {
			while(rs.next()) {
				int pnum=rs.getInt("pnum");
				String pname=rs.getString("pname");
				String pcategory_fk=rs.getString("pcategory_fk");
				String pcompany=rs.getString(4);
				String pimage=rs.getString(5);
				int pqty=rs.getInt(6);
				int price=rs.getInt(7);
				String pspec=rs.getString(8);
				String pcontents=rs.getString(9); 
				int point=rs.getInt(10);
				String pinputdate = rs.getString(11);

				bookBean dto = new bookBean(
						pnum,pname,pcategory_fk,
						pcompany,pimage,pqty,price,pspec,
						pcontents,point,pinputdate,0,0,0);

				lists.add(dto);			
			} // while

		} catch (SQLException e) {
			e.printStackTrace();
		}//try
		finally {
			try {
				if(rs!=null)
					rs.close();

				if(pstmt!=null)
					pstmt.close();

				if(conn!=null)
					conn.close();
			}catch(SQLException e) {

			}
		}

		return lists;

	}// makeArrayList

	// �󼼺���, ����form, ��ǰ�󼼺���, ��ٱ��� ���,mall_cartEdit.jsp
	public ArrayList<bookBean> getOneSelectByPnum(int pnum){
		getConnection();

		ArrayList<bookBean> lists = null;
		String sql = "select * from book where pnum=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs=pstmt.executeQuery();

			lists = makeArrayList(rs);

		} catch (SQLException e) { 
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();

				if(pstmt!=null)
					pstmt.close();

				if(conn!=null)
					conn.close();
			}catch(SQLException e) {

			}
		}
		return lists; 

	}//getOneSelectByPnum

	public int deletebook(int pnum){
		getConnection();
		String sql = "delete from book where pnum=?";
		int cnt = -1 ;
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			cnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();

				if(conn!=null)
					conn.close();
			}catch(SQLException e) {

			}
		}

		return cnt;
	}//deletebook
	
	
	public int updatebook(MultipartRequest mr){
		getConnection();
		int cnt = -1;
		String sql ="update book set pname=?, pcategory_fk=?, " +
				"pcompany=?, pimage=?, pqty=?, price=?, pspec=?,pcontents=?,"+
				"point=? where pnum=?"; 

		try {
			pstmt = conn.prepareStatement(sql);
			String pname = mr.getParameter("pname");
			String pcategory_fk = mr.getParameter("pcategory_fk");
			String pcompany = mr.getParameter("pcompany");
			String pimage = mr.getFilesystemName("pimage");
			String old_pimage = mr.getParameter("old_pimage"); // �����̹���.jpg
			System.out.println("dao pimage:"+pimage);
			System.out.println("dao old_pimage:"+old_pimage);
			if(pimage == null) {
				pimage = old_pimage;
			}
			String pqty=mr.getParameter("pqty");
			String price=mr.getParameter("price");
			String pspec=mr.getParameter("pspec");
			String pcontents=mr.getParameter("pcontents");
			String point=mr.getParameter("point");
			String pnum=mr.getParameter("pnum");

			pstmt.setString(1,pname);
			pstmt.setString(2,pcategory_fk);
			pstmt.setString(3,pcompany);
			pstmt.setString(4,pimage);
			pstmt.setInt(5, Integer.parseInt(pqty));
			pstmt.setInt(6, Integer.parseInt(price));
			pstmt.setString(7,pspec);
			pstmt.setString(8,pcontents);
			pstmt.setInt(9, Integer.parseInt(point));
			pstmt.setInt(10, Integer.parseInt(pnum));

			cnt = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();

				if(conn!=null)
					conn.close();
			}catch(SQLException e) {

			}
		}

		return cnt;


	}//updateProduct

	public void updatePimage(int pnum) {
		getConnection();
		PreparedStatement pstmt = null ;		

		String sql = "update book set pimage=null where pnum=?";

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();

				if(conn!=null)
					conn.close();
			}catch(SQLException e) {

			}
		}


	}//

	//"HIT","NEW","BEST","NORMAL"
	public ArrayList<bookBean> getSelectBySpec(String spec){

		getConnection();
		ArrayList<bookBean> lists = null;

		String sql = "select * from book where pspec=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, spec);			
			rs=pstmt.executeQuery();
			lists = makeArrayList(rs);

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();

				if(pstmt!=null)
					pstmt.close();

				if(conn!=null)
					conn.close();
			}catch(SQLException e) {

			}

			return lists;
		}
	}//getSelectBySpec

	public ArrayList<bookBean>  getSelectByCategory(String code){
		getConnection();
		ArrayList<bookBean> lists = null;

		String sql = "select * from book where pcategory_fk like ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, code+"%"); // man%			
			rs=pstmt.executeQuery();
			lists = makeArrayList(rs);

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();

				if(pstmt!=null)
					pstmt.close();

				if(conn!=null)
					conn.close();
			}catch(SQLException e) {

			}

			return lists;
		}
	}
}





