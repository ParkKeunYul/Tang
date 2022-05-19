package kr.co.hany.util;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {
	
	public static void setCookie( HttpServletResponse response
			                     ,Map<String, Object> param
			                     ,String cookiePath
			                     ,int maxAge
			                     ,String cookieName){
		
		try{
			Cookie cookie = new Cookie(cookieName, StringUtil.StringNull(param.get("id")) );
			cookie.setMaxAge(maxAge);
			cookie.setPath(cookiePath);
//			cookie.setDomain("http://www.seniorbridge.or.kr");
			response.addCookie(cookie);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getCooKieValue(HttpServletRequest request
			                            ,String cookieName){
		
		String v = "";
		try{
			Cookie[] cookies = request.getCookies();
			if(cookies != null){
				for(int i = 0; i< cookies.length; i++){
					if(cookies[i].getName().equals(cookieName)){
						v = cookies[i].getValue();
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}


}
