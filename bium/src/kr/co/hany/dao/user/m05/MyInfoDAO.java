package kr.co.hany.dao.user.m05;

import org.springframework.stereotype.Repository;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class MyInfoDAO extends DefaultDAO{

	public String NAMEPSACE = "MyInfoDAO.";
	
	public void updateInfo(CommonMap param)throws Exception{
		sqlSession.update(NAMEPSACE+"updateInfo", param);
	}
	
}
