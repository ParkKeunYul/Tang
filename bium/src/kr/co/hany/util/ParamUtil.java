package kr.co.hany.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class ParamUtil {
	
	public static Map<String, Object> getParam(HttpServletRequest request){
		Map<String, Object> param  = new HashMap<String, Object>();
		Enumeration nValue = request.getParameterNames();
		while (nValue.hasMoreElements()) {
			String name = (String)nValue.nextElement();
			if(nullChk(request.getParameter(name).toString())){
				param.put(name.toLowerCase(), request.getParameter(name));
		//		System.out.println(name + " : [" +request.getParameter(name)+"]");
				
				if(name.toLowerCase().equals("search_value")){ //검색값 인코딩 처리
			//		param.put("encodeSV", StringUtil.setSearchValue(param));
				}
				if(name.toLowerCase().equals("title")){ //검색값 인코딩 처리
					param.put("title", StringUtil.convertString(request.getParameter(name)));
				}
				
			}
			
		}
		return param;
	//	return StringUtil.convertContents(param);
	}
	
	
	public static boolean nullChk(String s) {
		if(s != null && !s.isEmpty()) {
			return true;
		}
		return false;
	}
	
	
	public static int getIntValue(Object o , int rep){
		try{
			return Integer.parseInt(o.toString()); 
		}catch (Exception e) {
			return rep;
		}
	}
	
	
	public static String getURL(String Menu ,Map<String, Object> param){
		String url = "";
		try{
			url = Menu+"&page="+param.get("page")+"&pagelistno="+param.get("pagelistno")+"&seq="+param.get("seq");
			String search_value = ParamUtil.getSerach_value(param.get("search_value"));
			
			if(search_value != null && !search_value.equals("")){
				search_value = Encode(search_value);
				url  += "&search_title="+param.get("search_title")+"&search_value="+search_value;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}
	
	public static String getSerach_value(Object o ){
		try{
			return o.toString().trim();
		}catch (Exception e) {
			return "";
		}
	}
	
	public static String ISO8859(String s)throws Exception{
		String newS = null;
		if(s != null && !s.equals("")){
			newS = new String(s.getBytes("ISO-8859-1"),"utf-8");
		}
		return newS;
	}
	
	public static String Encode(String s)throws Exception{
		String newS = null;
		if(s != null && !s.equals("")){
			newS = URLEncoder.encode(s, "utf-8");
		}
		return newS;
	}
	
	public static String Decode(String s)throws Exception{
		String newS = null;
		if(s != null && !s.equals("")){
			newS = URLDecoder.decode(s, "utf-8");
		}
		return newS;
	}
	
	public static String ISO8859_Encode(String s)throws Exception{
		String newS = null;
		if(s != null && !s.equals("")){
			newS = new String(s.getBytes("ISO-8859-1"),"utf-8");
			newS = URLEncoder.encode(newS, "utf-8");
		}
		return newS;
	}
	
	//페이징값 search값
	public static String pagingValue(CommonMap param){
		String sValue = "&page="+param.get("page");
		       sValue+= "&pagelistno="+param.get("pagelistno");
		String search_value = ParamUtil.getSerach_value(param.get("search_value"));
		try{
			if(search_value != null && !search_value.equals("")){
				search_value = Encode(search_value);
				sValue  += "&search_title="+param.get("search_title")+"&search_value="+search_value;
			}
			
			String search_flag = ParamUtil.getSerach_value(param.get("search_flag"));
			if(!search_flag.equals("")  ){
				sValue +="&search_flag="+search_flag;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return sValue;
	}
}
