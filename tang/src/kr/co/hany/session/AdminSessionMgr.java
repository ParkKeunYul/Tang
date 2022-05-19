package kr.co.hany.session;

import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

public class AdminSessionMgr {
	private AdminSessionManager adminsession = null;
    protected Map<String, Object> adminInfo = null;
    
    
    public AdminSessionMgr(HttpServletRequest request) throws ServletException{
    	adminInfo = getAdminInfo(request);
	}

    public Map<String, Object> getAdminInfo(HttpServletRequest request){
    	adminsession = new AdminSessionManager();
    	adminInfo = (Map<String, Object>)adminsession.getSession(request);       
        return adminInfo;   
    }

    public Map<String, Object> getSession(HttpServletRequest request){
        return adminInfo;
    }

    public void setSession(Map<String, Object> admin, HttpServletRequest request){
    	adminsession = new AdminSessionManager();
    	adminsession.setSession(admin, request);
    }
    
    public void setLoginOut(HttpServletRequest request){
    	adminsession = new AdminSessionManager();
    	adminsession.setLoginOut(request);
	}
}
