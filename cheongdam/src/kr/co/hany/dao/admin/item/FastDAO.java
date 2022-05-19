package kr.co.hany.dao.admin.item;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.co.hany.util.CommonMap;

public interface FastDAO {

	public List<Map<String, Object>> list(@Param("param")CommonMap param);
	public int list_total(@Param("param")CommonMap param);
	
	
	public int select_next_seqno();
	public void add(@Param("param")CommonMap param)throws Exception;
	public void mod(@Param("param")CommonMap param)throws Exception;
	
	
	public Map<String, Object> view(@Param("param")CommonMap param);
	
	public void add_yakjae(@Param("param")Map<String, Object> param)throws Exception;
	public void del_yakjae(@Param("param")CommonMap param)throws Exception;
	
	
	public List<Map<String, Object>> detail_yakjae(@Param("param")CommonMap param);
	
	
	
	public void del(@Param("param")CommonMap param)throws Exception;
	 
	
}
