package kr.co.hany.dao.admin.base;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface LoginhisDAO {
	
	public List<Map<String, Object>> select_login_his(@Param("param")CommonMap param);
	
	public int select_total(@Param("param")CommonMap param);
}
