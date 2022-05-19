package kr.co.hany.dao.admin.base;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface MemberDAO {
	
	public List<Map<String, Object>> select_member(@Param("param")CommonMap param);
	
	public int select_total(@Param("param")CommonMap param);
	
	public void update_col(@Param("param")CommonMap param);
	
	
	
	public Map<String, Object> view(@Param("param")CommonMap param);
	
	public void mod(@Param("param")CommonMap param);
	
	public void addSetting(@Param("param")CommonMap param);
	
	public int check_setting(@Param("param")CommonMap param);
	
	public void delSetting(@Param("param")CommonMap param);
	
	public void out_member(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> select_out_member(@Param("param")CommonMap param);
	
	public int select_out_total(@Param("param")CommonMap param);
	
	public void restore_member(@Param("param")CommonMap param);
	
	
	public Map<String, Object> select_member_point(@Param("param")CommonMap param);
	
}
