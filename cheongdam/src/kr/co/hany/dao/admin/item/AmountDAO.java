package kr.co.hany.dao.admin.item;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface AmountDAO {

	public List<Map<String, Object>> select(@Param("param")CommonMap param);
	public int select_total();	
	public int select_next_seqno();
	
	public void update_col(@Param("param")CommonMap param);
	public void add(@Param("param")CommonMap param);
	public void mod(@Param("param")CommonMap param);
	public void del(@Param("param")CommonMap param);
	
	public Map<String, Object> select_one(@Param("param")CommonMap param);
	
	
	public List<Map<String, Object>> selectHis(@Param("param")CommonMap param);
	public int selectHis_total(@Param("param")CommonMap param);	
	
	
	public Map<String, Object> selectPayInfo(@Param("param")CommonMap param);
	
	public void card_cancel(@Param("param")CommonMap param);
	public void del_point(@Param("param")CommonMap param);
	
	
	public void point_manage(@Param("param")CommonMap param);
	
	
	
	public List<Map<String, Object>> selectOrder(@Param("param")CommonMap param);
	public int selectOrder_total(@Param("param")CommonMap param);
	
	
}
