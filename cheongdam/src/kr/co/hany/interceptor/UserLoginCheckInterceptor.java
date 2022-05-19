package kr.co.hany.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;

public class UserLoginCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle( HttpServletRequest request
							 ,HttpServletResponse response
							 ,Object handler) throws Exception {
	   
		String url = request.getServletPath();
		HttpSession session = request.getSession(false);
		if (session == null) {
			//response.sendRedirect(request.getContextPath() +"/main.do");
			PageUtil.scriptAlert(response, "로그인이 필요한 서비스입니다.", request.getContextPath() +"/main.do");
			return false;
		}
		else{
			Map<String, Object> userSession = (Map<String, Object>)session.getAttribute("userSession");
			if (userSession == null) {
				//response.sendRedirect(request.getContextPath() +"/main.do"); 
				PageUtil.scriptAlert(response, "로그인이 필요한 서비스입니다.", request.getContextPath() +"/main.do");
				return false;
			}else{
				String member_level = StringUtil.objToStr(userSession.get("member_level"), "0") ;
				if("0".equals(member_level)) {
					if("/m05/01.do".equals(request.getServletPath()) || "/m/m05/01.do".equals(request.getServletPath()) || 
					   "/m05/05_pop.do".equals(request.getServletPath()) || "/m/m05/05_pop.do".equals(request.getServletPath()) ||
					   "/m05/04_pop.do".equals(request.getServletPath()) || "/m/m05/04_pop.do".equals(request.getServletPath()) ||
					   "/m05/04.do".equals(request.getServletPath()) || "/m/m05/04.do".equals(request.getServletPath())    ) {
						return true;
					}else {
						PageUtil.scriptAlert(response, "정회원 서비스입니다.", request.getContextPath() +"/main.do");
						return false;
					}
				}else {
					return true;
				}
			}
		}
	//	 return true;
	}
}
