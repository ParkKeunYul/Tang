package kr.co.hany.dao.user.m05;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.ibm.icu.util.Calendar;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class MyCartDAO extends DefaultDAO{
	
	public String NAMEPSACE = "MyCartDAO.";
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> bundle_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"bundle_list", param);
	}
	
	
	public boolean cancel_bunch(CommonMap param) {
		try {
			sqlSession.update(NAMEPSACE+"cancel_bunch", param);			
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean add_bunch(CommonMap param) {
		try {
			sqlSession.update(NAMEPSACE+"add_bunch", param);			
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean del_cart(CommonMap param) {
		try {
			sqlSession.delete(NAMEPSACE+"del_cart", param);			
			sqlSession.delete(NAMEPSACE+"del_cart_yakjae", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_ordering_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_ordering_list", param);
	}
	
	
	public int select_order_price_sum(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"select_order_price_sum", param);
	}
	
	public boolean add_bank_order(CommonMap param
								 ,String[] cart_seqno) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			for(int i = 0; i < cart_seqno.length ; i++) {
				int p_order_seqno = (Integer)sqlSession.selectOne(NAMEPSACE+"getOrderMaxSeqno");
				
				param.put("cart_seqno"   , cart_seqno[i]);
				param.put("p_order_seqno", p_order_seqno);
				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmssSSS"); 
				Calendar calendar = Calendar.getInstance();
				String order_no =  dateFormat.format(calendar.getTime()) + ""+ i;
				param.put("order_no"   , order_no);
				
				param.put("order_ing", "1"); // 접수대기
				
				
				param.put("order_delivery_price", 0);
				param.put("member_sale", 0);
				param.put("order_total_price", 0);
				param.put("bunch"   , "n");
				
				sqlSession.insert(NAMEPSACE+"add_order", param);
				sqlSession.insert(NAMEPSACE+"add_order_yakjae", param);
			}// for i
			
			//txManager.rollback(status);
			txManager.commit(status);
			return true;
		}catch (Exception e) {
			txManager.rollback(status);
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean add_plus_bank_order( CommonMap param
			 					 	   ,String[] cart_seqno) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			int delivery_price     	 = param.getInt("delivery_price", 0);
			int member_sale          = param.getInt("member_sale", 0);
			
			int a_p_order_seqno = 0; 
			
			int bunch_num = 1;
			for(int i = 0; i < cart_seqno.length ; i++) {
				int p_order_seqno = (Integer)sqlSession.selectOne(NAMEPSACE+"getOrderMaxSeqno");
				
				if(i == 0) {
					a_p_order_seqno = p_order_seqno;
				}
				
				
				param.put("cart_seqno"   , cart_seqno[i]);
				param.put("p_order_seqno", p_order_seqno);
				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmssSSS"); 
				Calendar calendar = Calendar.getInstance();
				String order_no =  dateFormat.format(calendar.getTime()) + ""+ i;
				param.put("order_no"   , order_no);
				
				
				param.put("order_ing", "1"); // 접수대기
				param.put("order_delivery_price", (delivery_price+member_sale)/ 2);
				param.put("member_sale"         , member_sale/2);
				param.put("order_total_price"   , delivery_price/2);
				param.put("bunch"   , a_p_order_seqno);
				param.put("bunch_num"   , bunch_num);
				
				
				sqlSession.insert(NAMEPSACE+"add_order", param);
				sqlSession.insert(NAMEPSACE+"add_order_yakjae", param);
				
				bunch_num++;
			}// for i
			
			
			//txManager.rollback(status);
			txManager.commit(status);
			return true;
		}catch (Exception e) {
			txManager.rollback(status);
			e.printStackTrace();
			return false;
		}
	}//add_plus_bank_order
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_pay_result_list(Map<String, Object> info)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_pay_result_list", info);
	}
	
}
