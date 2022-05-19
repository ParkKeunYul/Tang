package kr.co.hany.dao.admin.total;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface InvenDAO {

	public List<Map<String, Object>> select(@Param("param")CommonMap param);
	public int select_total(@Param("param")CommonMap param);	

	public void add(@Param("param")CommonMap param) throws Exception;
	
	public void update_col(@Param("param")CommonMap param) throws Exception;
	
	public void del(@Param("param")CommonMap param) throws Exception;
}

