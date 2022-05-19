package kr.co.hany.dao.common;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.util.CommonMap;

@Repository
public interface CommonCodeDAO {

	public List<Map<String, Object>> member_grade();
	public List<Map<String, Object>> shop_group();
	public List<Map<String, Object>> delivery_group();
	
	
}
