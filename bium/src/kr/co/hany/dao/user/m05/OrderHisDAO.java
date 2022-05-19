package kr.co.hany.dao.user.m05;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class OrderHisDAO extends DefaultDAO{

	public String NAMEPSACE = "OrderHisDAO.";
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list", param);
	}
	
	public int listCount(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"listCount", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> yak_view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"yak_view", param);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> yak_view_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"yak_view_list", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> tang_view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"tang_view", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> tang_yakjae_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"tang_yakjae_list", param);
	}
	
	
	public boolean order_cancel(CommonMap param){
		try {
			sqlSession.update(NAMEPSACE+"order_cancel", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
