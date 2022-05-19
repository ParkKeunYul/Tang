package kr.co.hany.dao.user.m03;

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
public class YakCartDAO  extends DefaultDAO{
	public String NAMEPSACE = "YakCartDAO.";
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list", param);
	}
	
	
	public int unuse_goods_cart(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"unuse_goods_cart", param);
	}
	
	public boolean del_cart(CommonMap param) {
		try {
			sqlSession.delete(NAMEPSACE+"del_cart", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean mod_cart(CommonMap param) {
		try {
			sqlSession.delete(NAMEPSACE+"mod_cart", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean add_order_card( CommonMap param
								  ,List<Map<String, Object>> list) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			param.put("r_tel"       , param.get("r_tel01")+"-"+param.get("r_tel02")+"-"+param.get("r_tel03"));
			param.put("r_handphone" , param.get("r_handphone01")+"-"+param.get("r_handphone02")+"-"+param.get("r_handphone03"));
			param.put("r_address"   , param.get("r_address01")+" "+param.get("r_address02"));
			
			param.put("o_tel"       , param.get("o_tel01")+"-"+param.get("o_tel02")+"-"+param.get("o_tel03"));
			param.put("o_handphone" , param.get("o_handphone01")+"-"+param.get("o_handphone02")+"-"+param.get("o_handphone03"));
			param.put("o_address"   , param.get("o_address01")+" "+param.get("o_address02"));
			
			param.put("bill_handphone", param.getString("bill_handphone01")+"-"+param.getString("bill_handphone02")+"-"+ param.getString("bill_handphone03"));
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmssSSS"); 
			Calendar calendar 		    = Calendar.getInstance();
			String order_no             =  dateFormat.format(calendar.getTime());
			
			
			for(int i = 0; i< list.size(); i++) {
				Map<String, Object> info = list.get(i);
				
				
				param.put("order_no"    , order_no);
				param.put("order_num"   , order_no+"_"+(i+1));
				param.put("cart_seqno"  , info.get("seqno"));
				param.put("goods_seq"   , info.get("p_seq"));
				param.put("goods_code"  , info.get("p_code"));
				param.put("goods_name"  , info.get("p_name"));
				param.put("ea"          , info.get("ea"));
				param.put("price"       , info.get("goods_tot"));
				param.put("goods_price" , info.get("p_price"));
				param.put("mem_sub_seqno" , info.get("mem_sub_seqno"));
				param.put("order_id"    , param.getString("id"));
				
				
				
				if(i>=1) {
					param.put("delivery_price"    , 0);
				}
				
				sqlSession.insert(NAMEPSACE+"add_card", param);
				
			}// for i
			
			//txManager.rollback(status);
			txManager.commit(status);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			txManager.rollback(status);
			return false;
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_pay_result_list(Map<String, Object> info)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_pay_result_list", info);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_immedi_pay_result_list(Map<String, Object> info)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_immedi_pay_result_list", info);
	}
	
}
