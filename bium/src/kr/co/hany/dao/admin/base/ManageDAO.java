package kr.co.hany.dao.admin.base;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface ManageDAO {
	
	public List<Map<String, Object>> select_manage(@Param("param")CommonMap param);
	
	public int select_total(@Param("param")CommonMap param);
	
	public void delete_manage(@Param("param")CommonMap param);
		
	public void add_manage(@Param("param")CommonMap param);
	
	public void mod_manage(@Param("param")CommonMap param);
	
	public Map<String, Object> select_manage_one(@Param("param")CommonMap param);
	
	
}
