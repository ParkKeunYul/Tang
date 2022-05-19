package kr.co.hany.dao.admin.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface TangDAO {

	public List<Map<String, Object>> select_order(@Param("param")CommonMap param);
	
	public Map<String, Object> select_view(@Param("param")CommonMap param);
	
	public int select_total(@Param("param")CommonMap param);
	
	public void update_payment(@Param("param")CommonMap param);
	
	public void update_order(@Param("param")CommonMap param);
	
	public void update_col(@Param("param")CommonMap param);
	
	public List<Map<String, Object>> order_view_bunch(@Param("param")CommonMap param);
	public List<Map<String, Object>> order_view_yakjae(@Param("param")CommonMap param);
	
	public Map<String, Object> order_view_one(@Param("param")CommonMap param);
	
	public void update_d_info(@Param("param")CommonMap param);
	
	public void add_order_del(@Param("param")CommonMap param);
	public void del_order(@Param("param")CommonMap param);
	
	public void update_card_cancel(@Param("param")CommonMap param);
	
	public void batch_pay(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> select_order_excel(@Param("param")CommonMap param);
	
	public void update_talk_send(@Param("param")CommonMap param)throws Exception;
	
}
