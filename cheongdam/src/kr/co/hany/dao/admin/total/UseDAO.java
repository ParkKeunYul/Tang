package kr.co.hany.dao.admin.total;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface UseDAO {
	public List<Map<String, Object>> select(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> select_use(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> select_add(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> select_all(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> select_use_mon(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> select_add_mon(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> price_total(@Param("param")CommonMap param);
}

