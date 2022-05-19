package kr.co.hany.dao.user.m03;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class PerDAO  extends DefaultDAO{
	public String NAMEPSACE = "PerDAO.";
	
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
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> view_detail(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"view_detail", param);
	}
	
	
	public boolean order_com( CommonMap param ) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			sqlSession.update(NAMEPSACE+"com_order", param);
			sqlSession.insert(NAMEPSACE+"add_detail", param);
			
			//txManager.rollback(status);
			txManager.commit(status);
			return true;
		}catch (Exception e) {
			System.out.println("errroror");
			System.out.println("errroror");
			System.out.println("errroror");
			System.out.println("errroror");
			e.printStackTrace();
			txManager.rollback(status);
			return false;
		}	
	}
	
}// PerDAO
