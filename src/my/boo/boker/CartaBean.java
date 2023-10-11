package my.boo.boker;

import java.util.ArrayList;
import java.util.Vector;
import my.boo.bookBean;
import my.boo.bookDao;
public class CartaBean {
	
	private Vector<bookBean> clist;

	public CartaBean() {
		System.out.println("CartaBean()");
		clist = new Vector<bookBean>(); // ��ٱ���
	}

	public void addbook(int pnum,int oqty){ 
		bookDao pdao = bookDao.getInstance();
		ArrayList<bookBean> alist = pdao.getOneSelectByPnum(pnum);

		for(int i=0;i<clist.size();i++) {//�ش� ��ǰ�� ��ٱ��Ͽ� �̹� ������� ��
			int cpnum = clist.get(i).getPnum();
			if(pnum == cpnum) { // 
				int cqty = clist.get(i).getPqty(); 
				clist.get(i).setPqty(cqty + oqty);
				clist.get(i).setTotalPrice(clist.get(i).getPrice() *(cqty + oqty) );
				clist.get(i).setTotalPoint(clist.get(i).getPoint() *(cqty + oqty) );
				return;
			}
		}

		// �� ��ǰ�� ��
		alist.get(0).setPqty(oqty);
		int totalPrice =  alist.get(0).getPrice() * oqty;
		int totalPoint =  alist.get(0).getPoint() * oqty;
		alist.get(0).setTotalPrice(totalPrice);
		alist.get(0).setTotalPoint(totalPoint);

		clist.add(alist.get(0));

		for(int i=0;i<clist.size();i++) {
			System.out.println(clist.get(i).getPnum()+"," + 
					clist.get(i).getPname() +"," + 
					clist.get(i).getPqty() +"," +
					clist.get(i).getTotalPrice() );
		}//for
		System.out.println("------------");
	}//
	public Vector<bookBean> getAllbook(){
		return clist;
	}//
	public void setEdit(int pnum,int oqty){// 3�� ��ǰ, �ֹ����� 2���� ����

		for( bookBean pb : clist) {
			if(pb.getPnum() == pnum) {

				if(oqty == 0) {
					clist.removeElement(pb);
					break;
				}
				else {
					pb.setPqty(oqty);
					int price = pb.getPrice() * oqty;
					int point = pb.getPoint() * oqty;

					pb.setTotalPrice(price);
					pb.setTotalPoint(point);

					break;
				}
			}
		}
	}//setEdit
	
	public void removebook(int pnum){
		
		for( bookBean pb : clist) {
			if(pb.getPnum() == pnum) {
				clist.removeElement(pb);
				break;
			}
		}
	}//removeProduct
	
	public void removeAllbook() {
		clist.removeAllElements();
	}
	
}
