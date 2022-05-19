package kr.co.hany.controller.user;


import java.util.List;
import java.util.Map;

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
	
	@RequestMapping ("/main.do")
	public String main(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
			
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
		//return "/main"+Const.uTiles;
		return "/main"+Const.uuTiles;
	}//main
	
	
	@RequestMapping ("/login_proc.do")
	public @ResponseBody Map<String, Object> duple_id( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			param.put("real_id", param.getString("id"));
			
			
			String password = SecurityUtil.getCryptoMD5String(param.getString("password", ""));
			
			
			Map<String, Object> info = null;
			
			System.out.println(param.get("master_type"));
			
			if("1".equals(param.get("master_type"))) {
				info = loginDao.userIdCheck(param);
			}else{
				info = loginDao.userSubIdCheck(param);
			}
			
			
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
			if(!"1".equals(param.get("master_type"))) {
				
				param.put("mem_seqno"    , info.get("mem_seqno"));
				param.put("mem_sub_seqno", info.get("seqno"));
				param.put("mem_sub_grade", info.get("grade"));
				
				info = loginDao.select_user_info(param);
				
				info.put("real_grade", info.get("mem_sub_grade"));
				
			}else{
				info.put("real_grade", "0");
			}
			info.put("real_id"   , param.getString("real_id"));
			
			
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
	
	
	@RequestMapping({"/m01/*.do" , "/m03/*.do" , "/m04/*.do" , "/m05/*.do" , "/m06/*.do", "/m02/*.do"})
	public String tett_menu(Map<String, Object> map) throws Exception{
		map.put("bean", param);
		//System.out.println("/*/*.bss request.getRequestURI() = "+URI_Convert.ConvertingTest(request.getRequestURI()));
		return URI_Convert.ConvertingTest(request.getRequestURI())+Const.uTiles;
	}
	
}
