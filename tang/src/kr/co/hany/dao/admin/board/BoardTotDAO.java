package kr.co.hany.dao.admin.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface BoardTotDAO {

	public List<Map<String, Object>> list(@Param("param")CommonMap param);
	
	public int listCount(@Param("param")CommonMap param);	
	
	public int getMaxSeq();
	
	public void plus_ref_level (@Param("param")CommonMap param);
	
	public void insert(@Param("param")CommonMap param);
	
	public void update(@Param("param")CommonMap param);
	
	public void del(@Param("param")CommonMap param);
	
	public void update_notice_yn(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> del_list(@Param("param")CommonMap param);
	
	public Map<String, Object> view(@Param("param")CommonMap param);
	
	public void increaseHit(@Param("param")CommonMap param);
}
