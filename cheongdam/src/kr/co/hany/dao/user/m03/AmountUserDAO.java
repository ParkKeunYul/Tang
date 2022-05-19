package kr.co.hany.dao.user.m03;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class AmountUserDAO extends DefaultDAO{
	
	public String NAMEPSACE = "AmountUserDAO.";
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list", param);
	}
	
	public int listCount(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"listCount", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"view", param);
	}
	
	
	public boolean add_order_card( CommonMap param) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			int select_next_seqno  = (Integer)sqlSession.selectOne(NAMEPSACE+"select_next_seqno");
			param.put("seqno", select_next_seqno);
			param.put("order_seqno", select_next_seqno);
			
			
			sqlSession.insert(NAMEPSACE+"add_card", param);
			sqlSession.insert(NAMEPSACE+"add_point", param);
			
			
			txManager.commit(status);
			return false;
		}catch (Exception e) {
			e.printStackTrace();
			txManager.rollback(status);
			return false;
		}
	}
	
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> point_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"point_list", param);
	}
	
	public int point_listCount(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"point_listCount", param);
	}
	
	public Map<String, Object> point_all(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"point_all", param);
	}
	
	
}
