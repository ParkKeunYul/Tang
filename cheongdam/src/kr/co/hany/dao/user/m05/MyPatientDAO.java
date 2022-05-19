package kr.co.hany.dao.user.m05;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.handler.Result;
import kr.co.hany.util.CommonMap;

@Repository
public class MyPatientDAO extends DefaultDAO{

	public String NAMEPSACE = "MyPatientDAO.";
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list", param);
	}
	
	public int listCount(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"listCount", param);
	}
	
	public boolean addPatient(CommonMap param) {
		try {
			sqlSession.insert(NAMEPSACE+"add_patient", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean modPatient(CommonMap param) {
		try {
			sqlSession.update(NAMEPSACE+"mod_patient", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"view", param);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> orderlist(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"orderlist", param);
	}
	
	public int orderlistCount(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"orderlistCount", param);
	}
	
	
	public int duple_patient(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"duple_patient", param);
	}
	
	public boolean addCartInfo(CommonMap param)throws Exception{
		try {
			sqlSession.selectOne(NAMEPSACE+"addCartInfo", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}		
	}
	
	public int getMaxSeqno(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"getMaxSeqno", param);
	}
	
	public List<Map<String, Object>> duple_chart(CommonMap param){
		Result result = new Result();
		List<Map<String, Object>>  list = result.resultList;
		
		sqlSession.select(NAMEPSACE+"duple_chart",param,result );
		return list;
	}
	
	public boolean del_patient(CommonMap param) {
		try {
			sqlSession.update(NAMEPSACE+"del_patient", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
}
