package kr.co.hany.session;

import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

public class SessionMgr {
	private UserSessionManager usersession = null;
    protected Map<String, Object> userInfo = null;
    
    public SessionMgr(HttpServletRequest request) throws ServletException{
    	userInfo = getUserInfo(request);
	}

    public Map<String, Object> getUserInfo(HttpServletRequest request){
    	usersession = new UserSessionManager();
        userInfo = (Map<String, Object>)usersession.getSession(request);       
        return userInfo;   
    }

    public Map<String, Object> getSession(HttpServletRequest request){
        return userInfo;
    }

    public void setSession(Map<String, Object> user, HttpServletRequest request){
    	usersession = new UserSessionManager();
        usersession.setSession(user, request);
    }
    
    public void setLoginOut(HttpServletRequest request){
    	usersession = new UserSessionManager();
    	usersession.setLoginOut(request);
	}
}
