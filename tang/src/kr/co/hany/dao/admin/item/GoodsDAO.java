package kr.co.hany.dao.admin.item;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface GoodsDAO {
	
	public List<Map<String, Object>> select(@Param("param")CommonMap param);
	public int select_total(@Param("param")CommonMap param);
	public void update_col(@Param("param")CommonMap param);
	
	public int select_next_seqno();
	
	
	public void add(@Param("param")CommonMap param);
	public void mod(@Param("param")CommonMap param);
	
	
	public Map<String, Object> select_one(@Param("param")CommonMap param);
}