package kr.co.hany.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/*import org.json.simple.JSONArray;
import org.json.simple.JSONValue;*/

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class StringUtil {
	public static String StringNull(Object o){
		try{
			return o.toString();
		}catch (Exception e) {
			return "";
		}
	}
	
	
	public static String objToStr(Object o , String rep) {
		try{
			return o.toString();
		}catch (Exception e) {
			return rep;
		}
	}
	
	public static int ObjectToInt(Object o){
		try{
			return Integer.parseInt(o.toString());
		}catch (Exception e) {
			return 0;
		}
	}
	
	
	public static String setSearchValue(CommonMap param){
		try{
			return URLEncoder.encode( param.getString("search_value", "") ,"UTF-8");  
		}catch (Exception e) {
			return "";
		}
	}
	
	public static String setSearchValue(CommonMap param, String name){
		try{
			return URLEncoder.encode( param.getString(name, "") ,"UTF-8");  
		}catch (Exception e) {
			return "";
		}
	}
	
	public static Map<String, Object> convertContents(Map<String, Object> param){
		try{
			/*String sContents = StringNull(param.get("contents"));
			if(!sContents.equals("")){
				param.put("contents", sContents.replaceAll(">","&gt;").replaceAll("<","&lt;").replaceAll("'","&quot;") );
			}*/
			
			String sTitle = StringNull(param.get("content"));
			if(!sTitle.equals("")){
				param.put("content", sTitle.replaceAll(">" ,"&gt;").replaceAll("<" ,"&lt;").replaceAll("'" ,"&#39;").replaceAll("\"" ,"&quot;") );
			}
			
			return param;
		}catch (Exception e) {
			return param;
		}
	}
	
	
	
	public static String recoverContents(Object contents){
		String s= StringNull(contents);
		try{
			s = s.replaceAll("&gt;",">").replaceAll("&lt;","<").replaceAll("&quot;","'");
		}catch (Exception e) {
		//	e.printStackTrace();
			s = "";
		}
		return s;
	}
	
	public static String convertString(Object conObject){
		String s= StringNull(conObject);
		try{
			s = s.replaceAll(">" ,"&gt;")
				 .replaceAll("<" ,"&lt;")
				 .replaceAll("'" ,"&#39;")
				 .replaceAll("\"" ,"&quot;");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}
	
	public static String base64Encode(byte[] encodeBytes) {
		BASE64Encoder base64Encoder = new BASE64Encoder();
		ByteArrayInputStream bin = new ByteArrayInputStream(encodeBytes);
		ByteArrayOutputStream bout = new ByteArrayOutputStream();
		byte[] buf = null;

		try {
			base64Encoder.encodeBuffer(bin, bout);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			buf = bout.toByteArray();
			try {
				bout.close();
				bin.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return new String(buf).trim();
	}

	public static byte[] base64Decode(String strDecode) {
		strDecode = StringNull(strDecode);
		BASE64Decoder base64Decoder = new BASE64Decoder();
		ByteArrayInputStream bin = new ByteArrayInputStream(
				strDecode.getBytes());
		ByteArrayOutputStream bout = new ByteArrayOutputStream();
		byte[] buf = null;

		try {
			base64Decoder.decodeBuffer(bin, bout);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			buf = bout.toByteArray();
			try {
				bout.close();
				bin.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return buf;

	}
	
	
	public static String getSeletCode( List<Map<String, Object>> list
			                          ,String code
			                          ,String value) {
		StringBuffer  rtn = new StringBuffer();
		
		
		for(int i = 0; i< list.size(); i++) {
			Map<String, Object> info = list.get(i);
			
			if(i == list.size()-1) {
				rtn.append(info.get(code)+":"+info.get(value));
			}else {
				rtn.append(info.get(code)+":"+info.get(value)+";");
			}
		}
		
		return rtn.toString(); 
	}
	
	public static String getSeletCode( List<Map<String, Object>> list
							          ,String code
							          ,String value
							          ,String not) {
		StringBuffer  rtn = new StringBuffer();
		
		rtn.append(":"+not+";");
		
		for(int i = 0; i< list.size(); i++) {
			Map<String, Object> info = list.get(i);
			
			if(i == list.size()-1) {
				rtn.append(info.get(code)+":"+info.get(value));
			}else {
				rtn.append(info.get(code)+":"+info.get(value)+";");
			}
		}
		return rtn.toString();
	}
	
	public static String getJaSql(String type, String col_nm){
		String qry = "";
		
		if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^(???|???)' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' ))";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' ))";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^(???|???)' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' ))";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) ";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) ";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) ";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^(???|???)' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) ";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) ";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^(???|???)' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) ";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) ";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) ";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) "; 
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???' AND "+col_nm+" < '???' )) ";
		}else if("???".equals(type)) {
			qry = "and ("+col_nm+" RLIKE '^???' OR ( "+col_nm+" >= '???'))";
		}else {
			qry = "";
		}
		return qry;
	}
	
	public static String getJosnParam(String s) {
		try {
			
			if(s.indexOf("[,") == 0) {
				s = s.replace("[,", "");				
				s = s.substring(0 , s.lastIndexOf(']'));				
			}
			
			return s;
		}catch (Exception e) {
			return s;
		}
	}
	
	///@SuppressWarnings("unchecked")
	/*public static List<Map<String, Object>> jsonToArray(String json){
		List<Map<String, Object>> list =  new ArrayList< Map<String, Object> >();
		try{
			
			if(json != null || !"".equals(json)){
				Object obj = JSONValue.parseWithException(json);
				JSONArray array = (JSONArray)obj;
				
				for(int i=0;i<array.size();i++) {
					list.add((Map<String, Object>)array.get(i));
		 	    }
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}*/
	
	
	public static List<Map<String, Object>> jsonToArray(String json){
		List<Map<String, Object>> list =  new ArrayList< Map<String, Object> >();
		try{
			JsonParser jsonParser = new JsonParser();
			JsonArray jsonArray = (JsonArray) jsonParser.parse(json);
			
			for (int i = 0; i < jsonArray.size(); i++) {
				JsonObject aaa = (JsonObject) jsonArray.get(i);
				 HashMap<String, Object> rs = new ObjectMapper().readValue(aaa.toString(), HashMap.class) ;
				 list.add(rs);
			}// for
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public static String getBrowserInfo(HttpServletRequest req) {
		try {
			String browserInfo = req.getHeader("User-Agent"); // ????????? User-Agent ??? ??????
			
			if (browserInfo != null) {
				if (browserInfo.indexOf("Trident") > -1) {
					return "MSIE";
				} else if (browserInfo.indexOf("Chrome") > -1) {
					return "Chrome";
				} else if (browserInfo.indexOf("Opera") > -1) {
					return "Opera";
				} else if (browserInfo.indexOf("iPhone") > -1
						&& browserInfo.indexOf("Mobile") > -1) {
					return "iPhone";
				} else if (browserInfo.indexOf("Android") > -1
						&& browserInfo.indexOf("Mobile") > -1) {
					return "Android";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "????????????";
	}
}
