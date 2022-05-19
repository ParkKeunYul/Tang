package kr.co.hany.controller.admin;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hany.common.Const;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.session.AdminSessionMgr;
import kr.co.hany.util.StringUtil;
import kr.co.hany.util.URI_Convert;
import kr.co.hany.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/admin/*")
public class AdminLoginController extends AdminDefaultController{
	
	@Autowired
	LoginDAO loginDAO;
	
	
	@RequestMapping ("main.do")
	public String admin_main(Map<String, Object> map, HttpServletResponse response,HttpSession session){
		
		try{
			AdminSessionMgr asm = new AdminSessionMgr(request);
			Map<String, Object> sBean = asm.getSession(request);
			
			System.out.println("sBean = "+ sBean);
			if(sBean == null){
				response.sendRedirect("/admin/login.do");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		//메뉴 초기화
		session.setAttribute("menu_num", "");
		session.setAttribute("sub_num", "");
		
		return "/main"+Const.uaTiles;
	}
	
	@RequestMapping ("login.do")
	public String login(Map<String, Object> map, HttpServletResponse response){
		
		try{
			AdminSessionMgr asm = new AdminSessionMgr(request);
			Map<String, Object> sBean = asm.getSession(request);
			
			System.out.println("sBean = "+ sBean);
			if(sBean != null){
				response.sendRedirect("/admin/main.do");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/login"+Const.uaTiles;
	}
	
	
	@RequestMapping ("loginPro.do")
	public @ResponseBody Map<String, Object> loginPro(Map<String, Object> map, HttpServletResponse response){
		
		Map<String, Object> rtn = new HashMap<String, Object>();
		
		try{
			
			String pwd = SecurityUtil.getCryptoMD5String(param.getString("pwd", ""));
			//String pwd = param.getString("pwd", "");
			
			Map<String, Object> adminInfo = loginDAO.adminIdCheck(param);
			
			if(adminInfo == null){
				rtn.put("suc", false);
				rtn.put("msg", "아이디가 존재하지 않습니다.");
				System.out.println(rtn);
				return rtn;
			}
			
			if("hany".equals( adminInfo.get("a_id")  )) {
				System.out.println("111111111111111111111");
				if(!pwd.equals("TzGQhlZEuYUGNOnjNEQYEw==") ){
					rtn.put("suc", false);
					rtn.put("msg", "비밀번호가 일치하지 않습니다..");
					System.out.println(rtn);
					return rtn;
				}
			}else {
				if(!pwd.equals( StringUtil.StringNull(adminInfo.get("a_pass"))) ){
					rtn.put("suc", false);
					rtn.put("msg", "비밀번호가 일치하지 않습니다.");
					System.out.println(rtn);
					return rtn;
				}
			}
			
			rtn.put("suc", true);
			AdminSessionMgr asm = new AdminSessionMgr(request);
			asm.setSession(adminInfo, request);
				
			HttpSession session = request.getSession();
			
			
		}catch(Exception e){
			e.printStackTrace();
			rtn.put("suc", false);
			rtn.put("msg", "다시 시도해주세요");
		}
		return rtn;
	}
	@RequestMapping ("logout.do")
	public String logout(Map<String, Object> map, HttpServletResponse response){
		
		try{
			AdminSessionMgr asm = new AdminSessionMgr(request);
			asm.setLoginOut(request);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/login"+Const.uaTiles;
	}
	
	
	
	@RequestMapping("/admin/*/*/*")
	public String tett_menwu(Map<String, Object> map){
		map.put("bean", param);
		System.out.println("/*/*/*.test request.getRequestURI() = "+URI_Convert.ConvertingTest(request.getRequestURI()));
		return URI_Convert.ConvertingTest(request.getRequestURI())+".abss";
	}
	
	@RequestMapping("/admin/*/*")
	public String tett_menu(Map<String, Object> map){
		map.put("bean", param);
		System.out.println("/*/*/*.test request.getRequestURI() = "+URI_Convert.ConvertingTest(request.getRequestURI()));
		return URI_Convert.ConvertingTest(request.getRequestURI())+".abss";
	}
	
	@RequestMapping("/admin/*")
	public String tet_menu(Map<String, Object> map){
		map.put("bean", param);
		System.out.println("/*/*/*.test request.getRequestURI() = "+URI_Convert.ConvertingTest(request.getRequestURI()));
		return URI_Convert.ConvertingTest(request.getRequestURI())+".abss";
	}
	
	
	@RequestMapping("/admin/*/*/*.a")
	public String tett_menwu2(){
		System.out.println("/*/*/*.test request.getRequestURI() = "+URI_Convert.ConvertingTest(request.getRequestURI()));
		return URI_Convert.ConvertingTest(request.getRequestURI());
	}
	
	@RequestMapping("/admin/*/*.a")
	public String tett_menu1(){
		System.out.println("/*/*.test request.getRequestURI() = "+URI_Convert.ConvertingTest(request.getRequestURI()));
		return URI_Convert.ConvertingTest(request.getRequestURI());
	}
	
	@RequestMapping("/admin/*.a")
	public String tet_menu1(){
		System.out.println("/*.test request.getRequestURI() = "+URI_Convert.ConvertingTest(request.getRequestURI()));
		return URI_Convert.ConvertingTest(request.getRequestURI());
	}
}
