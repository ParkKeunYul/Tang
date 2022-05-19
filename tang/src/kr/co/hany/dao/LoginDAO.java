package kr.co.hany.dao;

import java.util.Map;

import kr.co.hany.util.CommonMap;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LoginDAO {
	// 관리자 
	public Map<String, Object> adminIdCheck(@Param("param") CommonMap param);
	
	// 사용자
	public Map<String, Object> userIdCheck(@Param("param") CommonMap param);
	
	public Map<String, Object> userSubIdCheck(@Param("param") CommonMap param);
	
	public Map<String, Object> select_user_info(@Param("param") CommonMap param);

	
	public void addInfo(Map<String, Object> info);
}
