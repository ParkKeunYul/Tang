package kr.co.hany.dao.user.m05;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class MyDictionDAO extends DefaultDAO{

	public String NAMEPSACE = "MyDictionDAO.";
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list", param);
	}
	
	public int listCount(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"listCount", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_main(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_main", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"view", param);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_group_yakjae(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_group_yakjae", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list_yakjae(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list_yakjae", param);
	}
	
	public int listCount_yakjae(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"listCount_yakjae", param);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> add_yakjae_multi(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"add_yakjae_multi", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> add_yakjae_multi_new(CommonMap param)throws Exception{
		return  (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"add_yakjae_multi_new", param);
	}
	
	
	
	public boolean updateMydic(CommonMap param
			                  ,List<Map<String, Object>> list) {
		
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			sqlSession.update(NAMEPSACE+"update_mydic", param);
			sqlSession.delete(NAMEPSACE+"delete_mydic_yakjae", param);
			
			for(int i = 0; i < list.size(); i++) {
				System.out.println(list.get(i));
				Map<String, Object> info = list.get(i);
				
				info.put("my_seqno", param.get("my_seqno"));
				info.put("id"      , param.get("id"));
				
				sqlSession.insert(NAMEPSACE+"add_mydic_yakjae" , info);
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
	
	
	public boolean addMydic(CommonMap param
						    ,List<Map<String, Object>> list) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			int mydic_seqno  = (Integer)sqlSession.selectOne("DictionDAO.max_mydic_seqno");
			param.put("seqno"  , mydic_seqno);
			System.out.println("mydic_seqno = "+ mydic_seqno);
			
			sqlSession.insert(NAMEPSACE+"add_mydic", param);
			for(int i = 0; i < list.size(); i++) {
				System.out.println(list.get(i));
				Map<String, Object> info = list.get(i);
				
				info.put("my_seqno", param.get("seqno"));
				info.put("id"      , param.get("id"));
				
				
				sqlSession.insert(NAMEPSACE+"add_mydic_yakjae" , info);
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
	
	public boolean delMydic(CommonMap param) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			
			sqlSession.delete(NAMEPSACE+"del_mydic" , param);
			sqlSession.delete(NAMEPSACE+"del_mydic_yakjae" , param);
			
			//txManager.rollback(status);
			txManager.commit(status);			
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			txManager.rollback(status);
			return false;
		}
	}
	
}
