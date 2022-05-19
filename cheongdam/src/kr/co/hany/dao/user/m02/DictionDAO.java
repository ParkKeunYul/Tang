package kr.co.hany.dao.user.m02;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class DictionDAO extends DefaultDAO{

	public String NAMEPSACE = "DictionDAO.";
	
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
	public List<Map<String, Object>> sublist(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"sublist", param);
	}
	
	
	public int mydic_count(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"mydic_count", param);
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean addMyDic(CommonMap param){
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			List<Map<String, Object>> list = sqlSession.selectList(NAMEPSACE+"temp_dic_list", param);
			for(int i = 0; i<list.size() ;i++) {
				Map<String, Object> info = list.get(i);
				info.put("id", param.get("id"));
				
				int mydic_seqno = (Integer)sqlSession.selectOne(NAMEPSACE+"max_mydic_seqno");
				info.put("mydic_seqno", mydic_seqno);
				info.put("s_code", info.get("s_code"));
				info.put("b_code", info.get("b_code"));
				
				
				System.out.println("mydic_seqno ="+ mydic_seqno);
				sqlSession.insert(NAMEPSACE+"add_my_dic", info);
				sqlSession.insert(NAMEPSACE+"add_my_dic_yak", info);
				
			}// for i
			
			//txManager.rollback(status);
			txManager.commit(status);
		}catch (Exception e) {
			e.printStackTrace();
			txManager.rollback(status);
			return false;
		}
		return true;
	}
}
