package kr.co.hany.session;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AdminSessionManager {
	
	private HttpSession session = null;
	private Map<String, Object> adminSession = null;
	
	public void setSession(Map<String, Object> admin, HttpServletRequest request){
		session = request.getSession();
		session.setAttribute("adminSession", admin);
	}    
		
	public Map<String, Object> getSession(HttpServletRequest request){
		session = request.getSession();
		this.adminSession = (Map<String, Object>)session.getAttribute("adminSession");
		return this.adminSession;
	}
	
	public void setLoginOut(HttpServletRequest request){
		session = request.getSession(); 
		session.removeAttribute("adminSession");
	}
}
