package kr.co.hany.controller.user;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hany.dao.admin.board.BannerDAO;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.PageUtil;
import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;


public class UserDefaultController {
	static public Logger logger = Logger.getLogger(UserDefaultController.class);
	
	@Autowired
	public HttpServletRequest request;
	@Autowired
	public SqlSession sqlSession;
	
	@Autowired
	BannerDAO bannerDao;
	
	public  Map<String, Object> userSession = null;
	public  CommonMap param;
	
	public List<Map<String, Object>> bannerList = null;
	
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
		/*System.out.println("menu");
		System.out.println("menu");
		System.out.println("menu");
		System.out.println("menu");
		System.out.println("menu");
		System.out.println("menu");*/
		return menu;			
	}
	
	
	@SuppressWarnings("unchecked")
	@ModelAttribute("userInfo")
	public Map<String, Object> memberInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*System.out.println("memberInfo");
		System.out.println("memberInfo");
		System.out.println("memberInfo");
		System.out.println("memberInfo");*/
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
	
	@ModelAttribute("bannerList")
	public List<Map<String, Object>> bannerList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try {
			bannerList = bannerDao.user_list(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return bannerList;
	}
	
	
}
