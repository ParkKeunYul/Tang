package kr.co.hany.dao.admin.item;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface DicDAO {

	public List<Map<String, Object>> select_group(@Param("param")CommonMap param);
	public int select_group_total(@Param("param")CommonMap param);	
	
	public int flag_group(@Param("param")CommonMap param);
	public String select_max_groupcode(@Param("param")CommonMap param);
	public void group_add(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> select_name(@Param("param")CommonMap param);
	public int select_name_total(@Param("param")CommonMap param);
	public String select_name_max();
	public void name_add(@Param("param")CommonMap param);
	public void name_mod(@Param("param")CommonMap param);
	public Map<String, Object> select_name_one(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> select_all(@Param("param")CommonMap param);
	public int select_all_total(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> select_detail_price(@Param("param")CommonMap param);
	public int select_detail_price_total(@Param("param")CommonMap param);
	
	
	public void price_update_stan(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> select_price_group(@Param("param")CommonMap param);
	public int select_price_group_total(@Param("param")CommonMap param);
	public int flag_price_dic_yakjae(@Param("param")CommonMap param);
	public void price_item_update(@Param("param")CommonMap param);
	public void price_item_delete(@Param("param")CommonMap param);
	public void price_item_add(@Param("param")CommonMap param);
}
