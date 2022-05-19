package kr.co.hany.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hany.common.Const;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.ParamUtil;


import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminDefaultController {
	static public Logger logger = Logger.getLogger(AdminDefaultController.class);
	
	@Autowired
	public HttpServletRequest request;
	@Autowired
	public SqlSession sqlSession;
	public  Map<String, Object> adminSession = null;
	public  Map<String, Object> menuSession = null;
	public  CommonMap param;
	
	public void setParam(CommonMap param) {
		this.param = param;
	}


	@PostConstruct
	public void init() {
	}
	
	
	@ModelAttribute("menu")
	public Map<String, Object> menu(HttpServletRequest request, HttpServletResponse response,HttpSession session){
		Map<String, Object> menu = new HashMap<String, Object>();
		// 현재 메뉴
		String url = request.getServletPath();
		param = new CommonMap(request);
		menu = PageUtil.menu(url,param);
		String num=param.getString("menu_num","");
		String sub_num=param.getString("sub_num","");
		
		if(!num.equals("")){
			session.setAttribute("menu_num", num);
			if(!sub_num.equals("")){
				session.setAttribute("sub_num", sub_num);
			}
		}
		
		return menu;			
	}
	
	
	@SuppressWarnings("unchecked")
	@ModelAttribute("adminInfo")
	public Map<String, Object> memberInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    HttpSession session = request.getSession(false);
	   	if(session != null) {
	   		adminSession = (Map<String, Object>)session.getAttribute("adminSession");
	   		if(adminSession!=null){
	   			logger.info("level_name= ");
	   		}else{
	   			System.out.println("login session xxx");
	   			return null;
	   		}
	   	}else{
	   		return null;
	   	}
	   	Date now = new Date();
	   	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	   	
	   	adminSession.put("pp", sf.format(now));
	   	
	   	return adminSession;
	}
	
	@SuppressWarnings("unchecked")
	@ModelAttribute("menuInfo")
	public Map<String, Object> menuadminInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
	   try{
		   HttpSession session = request.getSession(false);
		   	if(session != null) {
		   		menuSession = (Map<String, Object>)session.getAttribute("menuSession");
		   	}
	   }catch (Exception e) {
		   System.out.println("menu session XX");
	   }
	   return menuSession;
	}
}
