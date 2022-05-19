package kr.co.hany.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class ScLoginCheckInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
	   
		String url = request.getServletPath();
		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect(request.getContextPath() +"/school/login"); 
			return false;
		}
		else{
			Map<String, Object> schoolSession = (Map<String, Object>)session.getAttribute("schoolSession");
			if (schoolSession == null) {
				response.sendRedirect(request.getContextPath() +"/school/login"); 
				return false;
			}else{
				return true;
			}
		}
	//	 return true;
	}
}
