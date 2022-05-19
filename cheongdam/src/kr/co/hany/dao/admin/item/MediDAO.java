package kr.co.hany.dao.admin.item;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface MediDAO {

	public List<Map<String, Object>> select_group(@Param("param")CommonMap param);
	public int select_group_total(@Param("param")CommonMap param);	
	
	public int flag_group(@Param("param")CommonMap param);
	public int select_max_groupcode(@Param("param")CommonMap param);
	public void group_add(@Param("param")CommonMap param);
	
	
	
	public List<Map<String, Object>> select_name(@Param("param")CommonMap param);
	public int select_name_total(@Param("param")CommonMap param);
	public int select_name_max();
	public void name_add(@Param("param")CommonMap param);
	public void name_mod(@Param("param")CommonMap param);
	public Map<String, Object> select_name_one(@Param("param")CommonMap param);
	
	public void update_col_yak(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> select_all(@Param("param")CommonMap param);
	public int select_all_total(@Param("param")CommonMap param);
	
	public void update_col_group(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> select_dic_yakjae(@Param("param")CommonMap param);
	
	
	public void update_dic_yakjae(@Param("param")CommonMap param);
	
	
	public void movie_yakjae_info(@Param("param")CommonMap param);
	public void del_yakjae(@Param("param")CommonMap param);
	
	public void movie_yak_group_info(@Param("param")CommonMap param);
	public void del_yakjae_group(@Param("param")CommonMap param);
		
}
