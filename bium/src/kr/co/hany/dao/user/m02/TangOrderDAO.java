package kr.co.hany.dao.user.m02;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.sound.sampled.Port.Info;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.ibm.icu.util.Calendar;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.StringUtil;

@Repository
public class TangOrderDAO extends DefaultDAO{

	public String NAMEPSACE = "TangOrderDAO.";
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> pre_yajkae_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"pre_yajkae_list", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> cart_view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"cart_view", param);
	}
	
	public int select_next_seqno() {
		return (Integer)sqlSession.selectOne(NAMEPSACE+"getMaxSeqno");
	}
	
	
	public boolean saveCart(CommonMap param
						   ,List<Map<String, Object>> yakjae_list) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			param.put("c_pouch_text", param.get("c_pouch_type"));
			param.put("c_box_text"  , param.get("c_box_type"));
			param.put("c_stpom_text", param.get("c_stpom_type"));
			param.put("c_chup_price", param.get("order_yakjae_price"));
			param.put("c_chup_ea_g" , param.get("c_chup_g"));
			param.put("c_chup_ea_1" , param.get("c_chup_ea"));
			
			param.put("view_yn" 	  , param.getString("view_yn", "n"));
			param.put("bunch" 		  , param.getString("bunch", "n"));
			param.put("cart_complete" , param.getString("cart_complete", "n"));
			param.put("order_delivery_price_check" , param.getString("order_delivery_price_check", "n"));
			
			
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmssSSS"); 
			Calendar calendar = Calendar.getInstance();
	         
			
			param.put("order_no", dateFormat.format(calendar.getTime()));
	        System.out.println(dateFormat.format(calendar.getTime()));
			
			sqlSession.insert(NAMEPSACE+"save_cart", param);
			
			for(int i = 0; i<yakjae_list.size(); i++) {
				Map<String, Object> info = yakjae_list.get(i);
				info.put("p_seqno"  , param.getString("seqno"));
				info.put("id"       , param.getString("id"));
				info.put("mem_seqno", param.getString("mem_seqno"));
				
				info.put("p_from"   , info.get("yak_from"));
				info.put("p_joje"   , info.get("my_joje"));
				info.put("yak_price", info.get("yak_danga"));
				info.put("p_danga"  ,  StringUtil.objToStr(info.get("danga"), "").replaceAll("원", ""));
				
				info.put("total_yakjae", StringUtil.ObjectToInt(info.get("my_joje"))  *  param.getInt("c_chup_ea") );
				
				System.out.println(info);
				
				sqlSession.insert(NAMEPSACE+"save_cart_yakjae", info);
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
	
	public boolean updateCart( CommonMap param
						      ,List<Map<String, Object>> yakjae_list) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			param.put("c_pouch_text", param.get("c_pouch_type"));
			param.put("c_box_text"  , param.get("c_box_type"));
			param.put("c_stpom_text", param.get("c_stpom_type"));
			param.put("c_chup_price", param.get("order_yakjae_price"));
			param.put("c_chup_ea_g" , param.get("c_chup_g"));
			param.put("c_chup_ea_1" , param.get("c_chup_ea"));
			
			
			sqlSession.insert(NAMEPSACE+"update_cart", param);
			sqlSession.delete(NAMEPSACE+"del_cart_yakjae", param);
			
			for(int i = 0; i<yakjae_list.size(); i++) {
				Map<String, Object> info = yakjae_list.get(i);
				info.put("p_seqno"  , param.getString("cart_seqno"));
				info.put("id"       , param.getString("id"));
				info.put("mem_seqno", param.getString("mem_seqno"));
				
				info.put("p_from"   , info.get("yak_from"));
				info.put("p_joje"   , info.get("my_joje"));
				info.put("yak_price", info.get("yak_danga"));
				info.put("p_danga"  ,  StringUtil.objToStr(info.get("danga"), "").replaceAll("원", ""));
				
				info.put("total_yakjae", StringUtil.ObjectToInt(info.get("my_joje"))  *  param.getInt("c_chup_ea") );
				
				sqlSession.insert(NAMEPSACE+"save_cart_yakjae", info);
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
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> cart_yajkae_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"cart_yajkae_list", param);
	}
	
	public void update_cart_price( CommonMap param
								  ,List<Map<String, Object>> list){
		
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try{
			for(int i = 0; i < list.size(); i++) {
				Map<String, Object> info = list.get(i);
				info.put("id"        , param.getString("id"));
				info.put("cart_seqno", param.getString("cart_seqno"));
				
				double p_joje    = Double.parseDouble( info.get("p_joje")+"" );
				double yak_danga = Double.parseDouble( info.get("yak_danga")+"" );
				
				
				info.put("yak_price", yak_danga);
				info.put("p_danga"  , (Math.ceil( p_joje *  yak_danga)+"").replace(".0", ""));
				
				sqlSession.update(NAMEPSACE+"update_cart_yakjae_danga", info);
				
			}//for
			
			sqlSession.update(NAMEPSACE+"update_cart_price", param);
			
			//txManager.rollback(status);
			txManager.commit(status);
		}catch (Exception e) {
			e.printStackTrace();
			txManager.rollback(status);
		}
		
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_yakjae_change_danga(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_yakjae_change_danga", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> dic_yajkae_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"dic_yajkae_list", param);
	}
	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> order_view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"order_view", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> preorder_yajkae_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"preorder_yajkae_list", param);
	}
	
}
