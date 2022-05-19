package kr.co.hany.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.hany.util.PageUtil;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle( HttpServletRequest request
							 ,HttpServletResponse response
							 ,Object handler) throws Exception {
	   
		String url = request.getServletPath();
		HttpSession session = request.getSession(false);
		if (session == null) {
			//response.sendRedirect(request.getContextPath() +"/admin/login.do");
			PageUtil.scriptAlert(response, "로그인이 필요한 서비스입니다.", request.getContextPath() +"/admin/login.do");
			
			return false;
		}
		else{
			Map<String, Object> adminSession = (Map<String, Object>)session.getAttribute("adminSession");
			if (adminSession == null) {
				PageUtil.scriptAlert(response, "로그인이 필요한 서비스입니다.", request.getContextPath() +"/admin/login.do"); 
				return false;
			}else{
				return true;
			}
		}
	//	 return true;
	}
}
