package kr.co.hany.dao.user.m05;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.handler.Result;
import kr.co.hany.util.CommonMap;

@Repository
public class MyInfoDAO extends DefaultDAO{

	public String NAMEPSACE = "MyInfoDAO.";
	
	public void updateInfo(CommonMap param)throws Exception{
		sqlSession.update(NAMEPSACE+"updateInfo", param);
	}
	
	
	public List<Map<String, Object>> duple_sub_id(CommonMap param){
		Result result = new Result();
		List<Map<String, Object>>  list = result.resultList;
		
		sqlSession.select(NAMEPSACE+"duple_sub_id",param,result );
		return list;
	}//duple_sub_id
	
	
	public boolean add_sub_member(CommonMap param)throws Exception{
		try {
			sqlSession.insert(NAMEPSACE+"add_sub_member", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}//add_sub_member
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> sub_list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"sub_list", param);
	}
	
	public int sub_listCount(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"sub_listCount", param);
	}
	
	public void sub_update_col(CommonMap param){		
		sqlSession.update(NAMEPSACE+"sub_update_col", param);
			
	}//add_sub_member
	
	public boolean del_sub_id(CommonMap param)throws Exception{
		try {
			sqlSession.update(NAMEPSACE+"del_sub_id", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}//add_sub_member
	
	
	public boolean private_save(CommonMap param){
		try {
			sqlSession.update(NAMEPSACE+"private_save", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		
	}//add_sub_member
	
}


