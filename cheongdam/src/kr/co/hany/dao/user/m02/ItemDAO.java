package kr.co.hany.dao.user.m02;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class ItemDAO extends DefaultDAO{

	public String NAMEPSACE = "ItemDAO.";
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_pouch(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_pouch", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_box(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_box", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_sty(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_sty", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> select_setting(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"select_setting", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_joje(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_joje", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_bokyong(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_bokyong", param);
	}
	
	public int exist_setting(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"exist_setting", param);
	}
	
	public boolean updateSetting(CommonMap param){
		try {
			sqlSession.update(NAMEPSACE+"updateSetting", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean updateBaseYn(CommonMap param) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			sqlSession.update(NAMEPSACE+"updateBaseN", param);
			sqlSession.update(NAMEPSACE+"updateBaseY", param);
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
	public Map<String, Object> select_joje_view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"select_joje_view", param);
	}
	
	public boolean update_joje(CommonMap param) {
		try {
			sqlSession.update(NAMEPSACE+"update_joje",param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean add_joje(CommonMap param) {
		try {
			sqlSession.insert(NAMEPSACE+"add_joje",param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean del_joje(CommonMap param) {
		try {
			sqlSession.delete(NAMEPSACE+"del_joje",param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	
	public boolean updateBokBaseYn(CommonMap param) {
		TransactionStatus status = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			sqlSession.update(NAMEPSACE+"updateBokBaseN", param);
			sqlSession.update(NAMEPSACE+"updateBokBaseY", param);
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
	public Map<String, Object> select_bok_view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"select_bok_view", param);
	}
	
	
	public boolean update_bok(CommonMap param) {
		try {
			sqlSession.update(NAMEPSACE+"update_bok",param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean add_bok(CommonMap param) {
		try {
			sqlSession.insert(NAMEPSACE+"add_bok",param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean del_bok(CommonMap param) {
		try {
			sqlSession.delete(NAMEPSACE+"del_bok",param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> private_box(Map<String, Object> setting)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"private_box", setting);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> private_pouch(Map<String, Object> setting)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"private_pouch", setting);
	}
	
}
