package kr.co.hany.dao.admin.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface BannerDAO {
	
	public List<Map<String, Object>> list(@Param("param")CommonMap param);	
	
	public int listCount(@Param("param")CommonMap param);
	
	public int getMaxSeq();
	
	public void insert(@Param("param")CommonMap param)throws Exception;
	
	public void update_col(@Param("param")CommonMap param)throws Exception;
	
	public void update(@Param("param")CommonMap param)throws Exception;
	
	public List<Map<String, Object>> del_list(@Param("param")CommonMap param);
	
	public void del(@Param("param")CommonMap param);

	
	public List<Map<String, Object>> user_list(@Param("param")CommonMap param);
}
