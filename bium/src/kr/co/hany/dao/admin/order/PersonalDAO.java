package kr.co.hany.dao.admin.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface PersonalDAO {

	public List<Map<String, Object>> select(@Param("param")CommonMap param);
	
	public int select_total(@Param("param")CommonMap param);
	
	public void add(@Param("param")CommonMap param)throws Exception;
	
	public void mod(@Param("param")CommonMap param)throws Exception;
	
	public void del(@Param("param")CommonMap param)throws Exception;
	
	public void update_col(@Param("param")CommonMap param)throws Exception;
	
	
	public Map<String, Object> view(@Param("param")CommonMap param);
	
	public int detail_count(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> select_detail(@Param("param")CommonMap param);
	
	
	public void confirm_admin(@Param("param")CommonMap param)throws Exception;
}
