package kr.co.hany.dao.user.m03;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class AskDAO  extends DefaultDAO{
	public String NAMEPSACE = "AskDAO.";
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list", param);
	}
	
	public int listCount(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"listCount", param);
	}
	
	
	
}
