package kr.co.hany.dao.user.m06;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.handler.Result;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.StringUtil;

@Repository
public class MemberJoinDAO extends DefaultDAO{

	public String NAMEPSACE = "MemberJoinDAO.";
	
	
	public List<Map<String, Object>> duple_id(CommonMap param){
		Result result = new Result();
		List<Map<String, Object>>  list = result.resultList;
		
		sqlSession.select(NAMEPSACE+"duple_id",param,result );
		return list;
	}
	

	
	public int select_next_seqno() {
		return StringUtil.ObjectToInt( sqlSession.selectOne(NAMEPSACE+"select_next_seqno")) ;
	}
	
	
	public boolean add_member(CommonMap param){
		
		try {
			sqlSession.insert(NAMEPSACE+"add_member", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	
}
