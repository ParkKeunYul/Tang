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
					   "/m05/04.do".equals(request.getServletPath()) || "/m/m05/04.do".equals(request.getServletPath())  || 
					   "/m04/03.do".equals(request.getServletPath()) || "/m04/02.do".equals(request.getServletPath())  || 
					   "/m04/03_proc.do".equals(request.getServletPath()) || "/m04/03_view.do".equals(request.getServletPath()) || 
					   "/m04/03_write.do".equals(request.getServletPath()) 
					) {
						return true;
					}else {
						PageUtil.scriptAlert(response, "정회원, 가맹점 회원 전용 서비스입니다.", request.getContextPath() +"/main.do");
						return false;
					}
				}else if("2".equals(member_level)|| "1".equals(member_level)){
					if("/m99/01.do".equals(request.getServletPath()) || "/m99/01_view.do".equals(request.getServletPath())) {						
						PageUtil.scriptAlert(response, "가맹점 회원 전용 서비스입니다.", request.getContextPath() +"/m03/01.do");
						return false;
					}else if( "/m04/12.do".equals(request.getServletPath())  || "/m04/12_view.do".equals(request.getServletPath()) ||
							  "/m04/11.do".equals(request.getServletPath())  || "/m04/11_view.do".equals(request.getServletPath())      ){
						PageUtil.scriptAlert(response, "가맹점 회원 전용 서비스입니다. 자료실을 이용하세요.", request.getContextPath() +"/m04/13.do");
						return false;
					}
					return true;
				}else {
					return true;
				}
			}
		}
	//	 return true;
	}
}
