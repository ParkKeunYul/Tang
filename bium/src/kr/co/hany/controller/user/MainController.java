package kr.co.hany.controller.user;


import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.hany.common.Const;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.user.MainDAO;
import kr.co.hany.session.AdminSessionMgr;
import kr.co.hany.session.UserSessionManager;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.util.URI_Convert;

@Controller
public class MainController extends UserDefaultController{
	

	@Autowired
	LoginDAO loginDao;
	
	@Autowired
	MainDAO mainDao;
	
	public void setCookie(HttpServletResponse res, String key , String value, int age){
		Cookie cookie = new Cookie(key,value);
		cookie.setMaxAge(age);
		cookie.setPath(request.getContextPath());
		//cookie.setDomain("biumherb.co.kr");
		res.addCookie(cookie);
	}
	
	@RequestMapping ("/main.do")
	public String main(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
			setCookie(response, "test", "dadada", 60*60*24*365);
			
			map.put("nlist", mainDao.noticeList(param));
			
			String url = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				param.put("y_cnt", "2");
				map.put("goodslist", mainDao.goodslist(param));
				
				return "/m/main"+Const.mmTiles;
			}
			
			param.put("y_cnt", "3");
			map.put("goodslist", mainDao.goodslist(param));
			param.put("pop_type", "all");
			map.put("all_list", mainDao.list(param));
			
			try {
				String pop_id = StringUtil.objToStr(userSession.get("id"), "");
				if(!"".equals(pop_id)) {
					param.put("pop_type", "indi");
					param.put("pop_id"  , userSession.get("id"));
					map.put("indi_list", mainDao.list(param));
				}
			}catch (Exception e) {}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/main"+Const.uuTiles;
	}//main
	
	@RequestMapping ("/m06/login.do")
	public String login(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/main"+Const.uTiles;
		return "/m06/login"+Const.uuTiles;
	}//main
	
	
	@RequestMapping ("/login_proc.do")
	public @ResponseBody Map<String, Object> duple_id( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String password = SecurityUtil.getCryptoMD5String(param.getString("password", ""));
			
			
			Map<String, Object> info = loginDao.userIdCheck(param);
			if(info == null) {
				rtn.put("suc", false);		
				rtn.put("msg", "잘못된 계정 정보입니다.");
				return rtn;
			}
			
			String DbPassword = StringUtil.objToStr( info.get("password") , "" );
			if(!DbPassword.equals(password)) {
				rtn.put("suc", false);		
				rtn.put("msg", "비밀번호가 일치하지 않습니다.");
				return rtn;
			}
			
			String member_level = StringUtil.objToStr( info.get("member_level") , "" );
			/*if("0".equals(member_level)) {
				rtn.put("suc", false);		
				rtn.put("msg", "관리자 승인이 필요합니다.");
				return rtn;
			}*/
		
			UserSessionManager usm = new UserSessionManager();
			usm.setSession(info, request);
			
			HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
	        String ip = req.getHeader("X-FORWARDED-FOR");
	        if (ip == null)
	            ip = req.getRemoteAddr();
			
			info.put("user_ip", ip);
			info.put("user_br", StringUtil.getBrowserInfo(request));
			
			loginDao.addInfo(info);
			
			rtn.put("suc", true);
			rtn.put("url", "/main.do");
		}catch (Exception e) {
			e.printStackTrace();
			rtn.put("check_id", 0);
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("logout.do")
	public String logout(Map<String, Object> map, HttpServletResponse response){
		
		try{
			UserSessionManager usm = new UserSessionManager();
			usm.setLoginOut(request);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/main.do";
	}
	/*
	
	@RequestMapping ("/m/m06/login.do")
	public String mlogin(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/main"+Const.uTiles;
		return "/m/m06/login"+Const.mTiles;
	}//main
	*/
	@RequestMapping({"/m01/*.do" , "/m03/*.do" , "/m04/*.do" , "/m05/*.do" , "/m06/*.do", "/m02/*.do"})
	public String pc_menu(Map<String, Object> map) throws Exception{
		map.put("bean", param);
		//System.out.println("/*/*.bss request.getRequestURI() = "+URI_Convert.ConvertingTest(request.getRequestURI()));
		return URI_Convert.ConvertingTest(request.getRequestURI())+Const.uTiles;
	}
	
	@RequestMapping({"/m/m01/*.do" , "/m/m03/*.do" , "/m/m04/*.do" , "/m/m05/*.do" , "/m/m06/*.do", "/m/m02/*.do"})
	public String m_menu(Map<String, Object> map) throws Exception{
		System.out.println("m");
		map.put("bean", param);		
		System.out.println("/*/*.m request.getRequestURI() = "+URI_Convert.ConvertingTest(request.getRequestURI()));
		
		return URI_Convert.ConvertingTest(request.getRequestURI())+Const.mTiles;
	}
	
	
	
}
