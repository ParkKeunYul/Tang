package kr.co.hany.dao.user;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class MainDAO extends DefaultDAO{

	public String NAMEPSACE = "MainDAO.";
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> goodslist(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"goodslist", param);
	}	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> noticeList(CommonMap param)throws Exception{
		System.out.println("1111111111");
		System.out.println("1111111111");
		System.out.println("1111111111");
		System.out.println("1111111111");
		System.out.println("1111111111");
		System.out.println("1111111111");
		
		return sqlSession.selectList(NAMEPSACE+"noticeList", param);
	}
}
