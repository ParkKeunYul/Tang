package kr.co.hany.dao.admin.delivery;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface BaseDAO {
	
	public List<Map<String, Object>> select(@Param("param")CommonMap param);
	
	public int select_total(@Param("param")CommonMap param);
	
	
	public void update_col(@Param("param")CommonMap param);
	public void add(@Param("param")CommonMap param);
	
	public void update_sel_yn_all(@Param("param")CommonMap param);
	
	public int select_base(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> free_select(@Param("param")CommonMap param);
	public void free_update_col(@Param("param")CommonMap param);
}



