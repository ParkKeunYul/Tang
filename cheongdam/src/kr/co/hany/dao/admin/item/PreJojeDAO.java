package kr.co.hany.dao.admin.item;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface PreJojeDAO {

	public List<Map<String, Object>> month_member_list(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> month_ea_list(@Param("param")CommonMap param);
	
	
	public void update_print_ea(@Param("param")CommonMap param)throws Exception;
	
	public void add_print_ea(@Param("param")CommonMap param)throws Exception;
	
	public int duple_cnt(@Param("param")CommonMap param)throws Exception;
	
	public Map<String, Object> select_sign(@Param("param")CommonMap param);
}
