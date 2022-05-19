package kr.co.hany.session;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.hany.dao.LoginDAO;
import kr.co.hany.util.CommonMap;

public class UserSessionManager {
	private HttpSession session = null;
	private Map<String, Object> userSession = null;
	
	
	public void setSession(Map<String, Object> user, HttpServletRequest request){
		session = request.getSession();
		session.setMaxInactiveInterval(60*60*24);
		session.setAttribute("userSession", user);
	}    
		
	@SuppressWarnings("unchecked")
	public Map<String, Object> getSession(HttpServletRequest request){
		session = request.getSession();
		this.userSession = (Map<String, Object>)session.getAttribute("userSession");
		
		return this.userSession;
	}
	
	public void setLoginOut(HttpServletRequest request){
		session = request.getSession(); 
		session.removeAttribute("userSession");
	}
	
		
}
