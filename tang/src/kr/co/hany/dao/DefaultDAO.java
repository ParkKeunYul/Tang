package kr.co.hany.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

public class DefaultDAO {

	@Autowired
	@Resource(name="sqlSession")
	public SqlSession sqlSession;
	
	@Autowired
	public DataSourceTransactionManager txManager;

}
