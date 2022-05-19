package kr.co.hany.dao.user.m02;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.ibm.icu.util.Calendar;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.StringUtil;

@Repository
public class FastTangOrderDAO extends DefaultDAO{

	public String NAMEPSACE = "FastTangOrderDAO.";
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_fast(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_fast", param);
	}
	
	public int select_fast_count(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"select_fast_count", param);
	}
	
	public boolean add_order( CommonMap param
							 ,Map<String, Object> view)throws Exception{
		
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			int delivery_price     	 = param.getInt("delivery_price", 0);
			int member_sale          = param.getInt("member_sale", 0);
			int a_p_order_seqno      = 0; 
			int bunch_num            = 1;
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmssSSS"); 
			Calendar calendar           = Calendar.getInstance();
			String order_no             =  dateFormat.format(calendar.getTime()) + "1"; 
			param.put("order_no"       , order_no);
			
			param.put("cart_seqno"          , -9999);
			param.put("order_ing"           , "1");
			param.put("order_delivery_price", 0);
			param.put("order_sale_per      ", param.getString("sale_per"));
			param.put("member_sale"         , param.getString("sale_price"));
			param.put("order_total_price"   , param.getString("Amt"));
			
			
			
			if("13".equals( StringUtil.objToStr(view.get("c_tang_check"), "") )){
				param.put("c_tang_check13"   , "y");
			}
			else if("14".equals( StringUtil.objToStr(view.get("c_tang_check"), "") )){
				param.put("c_tang_check14"   , "y");
			}
			else if("15".equals( StringUtil.objToStr(view.get("c_tang_check"), "") )){
				param.put("c_tang_check15"   , "y");
			}
			else if("16".equals( StringUtil.objToStr(view.get("c_tang_check"), "") )){
				param.put("c_tang_check16"   , "y");
			}
			
			param.put("bunch_num"   , 1);
			
			int p_order_seqno = (Integer)sqlSession.selectOne("MyCartDAO.getOrderMaxSeqno");
			param.put("bunch"   , a_p_order_seqno);
			param.put("p_order_seqno"   , p_order_seqno);
			
			sqlSession.insert(NAMEPSACE+"add_order", param);
			sqlSession.insert(NAMEPSACE+"add_order_yakjae", param);
			
			txManager.commit(status);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			txManager.rollback(status);
			return false;
		}		
	}
}
