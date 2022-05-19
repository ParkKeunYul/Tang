package kr.co.hany.controller.user;


import java.util.HashMap;
import java.util.Map;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.PageUtil;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;


public class UserNoneDefaultController {
	static public Logger logger = Logger.getLogger(UserNoneDefaultController.class);
	
	@Autowired
	public SqlSession sqlSession;
	public  Map<String, Object> userSession = null;
	public  CommonMap param;
	
	public void setParam(CommonMap param) {
		this.param = param;
	}


	@PostConstruct
	public void init() {
	}
	
	
	@ModelAttribute("menu")
	public Map<String, Object> menu(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> menu = new HashMap<String, Object>();
		// 현재 메뉴
		String url = request.getServletPath();
		param = new CommonMap(request);
		menu = PageUtil.user_menu(url,param);
		return menu;			
	}
	
	
	@SuppressWarnings("unchecked")
	@ModelAttribute("userInfo")
	public Map<String, Object> memberInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    HttpSession session = request.getSession(false);
	   	if(session != null) {
	   		userSession = (Map<String, Object>)session.getAttribute("userSession");
	   		if(userSession!=null){
	   		//	logger.info("level_name= ");
	   		}else{
	   		//	System.out.println("home session xxx");
	   			return null;
	   		}
	   	}else{
	   		return null;
	   	}
	   	return userSession;
	}
	
	
}
