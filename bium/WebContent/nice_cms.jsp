<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="kr.co.hany.util.CommonMap"%>
<%@page import="kr.co.hany.dao.LoginDAO"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%

LoginDAO loginDao; 

CommonMap param = new CommonMap(request);

Map<String, Object> userSession = (Map<String, Object>)session.getAttribute("userSession");


System.out.println("NicePayController start");
System.out.println(param);
System.out.println("NicePayController end");



String authResultCode = param.getString("AuthResultCode");
String authResultMsg  = param.getString("AuthResultMsg");
String MallUserID     = param.getString("MallUserID");
String nextAppURL     = param.getString("NextAppURL");
String txTid    	  = param.getString("TxTid");
String authToken      = param.getString("AuthToken");
String payMethod      = param.getString("PayMethod");
String mid            = param.getString("MID");
String moid           = param.getString("Moid");
String amt            = param.getString("Amt");
String reqReserved    = param.getString("ReqReserved");
String netCancelURL   = param.getString("NetCancelURL");


String UserKey   = param.getString("UserKey");



String ResultCode 	= ""; String ResultMsg 	= ""; String PayMethod 	= "";
String GoodsName 	= ""; String Amt 		= ""; String TID 		= "";


param.put("id", MallUserID);

Map<String, Object> info = loginDao.userIdCheck(param);
/* 
변수1 : 상품명
변수2 : 배송번호
변수3 : 택배사 --- 롯데택배
변수4 : 배송주소

API Key는 PQKZR4K4TWR0511 입니다.

 */
try {
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println(param);
	
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println("cms pay session user session check = "+ userSession);
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");
	System.out.println("<<<<==================================>>>>");

	
	if(userSession == null) {
		System.out.println(param);
		System.out.println(param.getString("EasyBankName"));
		System.out.println("세션생성");
		request.getSession().setAttribute("userSession", info);
	}else {
		System.out.println("======================");
		System.out.println("ex userssesson " + userSession);
		System.out.println("======================");
	}
	
	System.out.println("all create user start");
	request.getSession().setAttribute("userSession", info);
	System.out.println("all create user end");
	
	System.out.println("**************************************************");
	System.out.println("cms pay session user session check = "+ userSession);
	System.out.println("**************************************************");
	
}catch (Exception e) {
	e.printStackTrace();
	System.out.println("error ");
	System.out.println("user session create start");
	System.out.println("info =  " + info);
	request.getSession().setAttribute("userSession", info);
	System.out.println("user session create end");
	System.out.println("error ");
}


if(!"0000".equals(authResultCode)) {
	map.put("sc_msg", authResultMsg);
	map.put("sc_close", "y");				
	return "/easyPayScript"+Const.uuTiles;
}

String resultJsonStr = "";
if("0000".equals(authResultCode)) {
	
	DataEncrypt sha256Enc 	= new DataEncrypt();
	String merchantKey 		= Const.NP_CMS_encodeKey;
	String ediDate			= getyyyyMMddHHmmss();
	String signData 		= sha256Enc.encrypt(authToken + mid + amt + ediDate + merchantKey);
	
	StringBuffer requestData = new StringBuffer();
	requestData.append("TID=").append(txTid).append("&");
	requestData.append("AuthToken=").append(authToken).append("&");
	requestData.append("MID=").append(mid).append("&");
	requestData.append("Amt=").append(amt).append("&");
	requestData.append("EdiDate=").append(ediDate).append("&");
	requestData.append("CharSet=").append("utf-8").append("&");
	requestData.append("SignData=").append(signData);
	
	
	resultJsonStr = connectToServer(requestData.toString(), nextAppURL);

	HashMap resultData = new HashMap();
	boolean paySuccess = false;
	
	System.out.println("CMS PAY INFO START");
	System.out.println("resultJsonStr = "+ resultJsonStr);
	System.out.println("CMS PAY INFO END");
	
	
	if("9999".equals(resultJsonStr)){
		/*
		*************************************************************************************
		* <망취소 요청>
		* 승인 통신중에 Exception 발생시 망취소 처리를 권고합니다.
		*************************************************************************************
		*/
		StringBuffer netCancelData = new StringBuffer();
		requestData.append("&").append("NetCancel=").append("1");
		String cancelResultJsonStr = connectToServer(requestData.toString(), netCancelURL);
		
		HashMap cancelResultData = jsonStringToHashMap(cancelResultJsonStr);
		ResultCode = (String)cancelResultData.get("ResultCode");
		ResultMsg = (String)cancelResultData.get("ResultMsg");
	}else{
		resultData = jsonStringToHashMap(resultJsonStr);
		
		System.out.println("resultData = "+ resultData);
		System.out.println("resultData = "+ resultData);
		System.out.println("resultData = "+ resultData);
		System.out.println("resultData = "+ resultData);
		System.out.println("resultData = "+ resultData);
		
		ResultCode 	= (String)resultData.get("ResultCode");	// 결과코드 (정상 결과코드:3001)
		ResultMsg 	= (String)resultData.get("ResultMsg");	// 결과메시지
		PayMethod 	= (String)resultData.get("PayMethod");	// 결제수단
		GoodsName   = (String)resultData.get("GoodsName");	// 상품명
		Amt       	= (String)resultData.get("Amt");		// 결제 금액
		TID       	= (String)resultData.get("TID");		// 거래번호
		
		/*
		*************************************************************************************
		* <결제 성공 여부 확인>
		*************************************************************************************
		*/
		if(ResultCode.equals("0000")) {
			
			
			Map<String, Object> cmsInfo = new HashMap<String, Object>();
			cmsInfo.put("authResultCode", authResultCode);
			cmsInfo.put("authResultMsg", authResultMsg);
			cmsInfo.put("MallUserID", MallUserID);
			cmsInfo.put("nextAppURL", nextAppURL);
			cmsInfo.put("txTid", txTid);
			cmsInfo.put("authToken", authToken);
			cmsInfo.put("payMethod", payMethod);
			cmsInfo.put("mid", mid);
			cmsInfo.put("moid", moid);
			cmsInfo.put("amt", amt);
			cmsInfo.put("netCancelURL", netCancelURL);
			cmsInfo.put("TID", TID);
			
			cmsInfo.put("EasyBankName",    (String)resultData.get("EasyBankName"));
			cmsInfo.put("EasyBanKAccount", (String)resultData.get("EasyBanKAccount"));
			cmsInfo.put("AuthCode",        (String)resultData.get("AuthCode"));
			cmsInfo.put("AuthDate",        (String)resultData.get("AuthDate"));
			cmsInfo.put("Signature",       (String)resultData.get("Signature"));
			
			
			cmsInfo.put("mem_seqno", info.get("seqno"));
			
			/*
			HttpSession session  = request.getSession(false);
			session.setAttribute("cmsYakSession", cmsInfo);
			*/
			
			
			System.out.println(cmsInfo);
			System.out.println("=====================CMS CREATE==========");
			request.getSession().setAttribute("cmsYakSession", cmsInfo);
			System.out.println("=====================CMS CREATE VIEW==========");
			System.out.println(request.getSession().getAttribute("cmsYakSession"));
			System.out.println("===========================================");
			
			
			
			System.out.println("COOKIE START");
			System.out.println((String)resultData.get("AuthCode"));
			System.out.println((String)resultData.get("AuthDate"));
			setCookie(response, "AuthCode" , "", 0);
			setCookie(response, "AuthDate" , "", 0);
			setCookie(response, "AuthCode", (String)resultData.get("AuthCode"), 60*60*24*365);
			setCookie(response, "AuthDate", (String)resultData.get("AuthDate"), 60*60*24*365);
			setCookie(response, "test2", "dadadaaaaaaaaaaa", 60*60*24*365);
			System.out.println("COOKIE END");
			
			System.out.println("=====SAVE PAY INFO START====");
			loginDao.saveCmsPayInfo(cmsInfo);
			
			System.out.println("=====SAVE PAY INFO END====");
			
			
			if(!"".equals(UserKey) && UserKey != null) {
				info.put("cms_key", UserKey);
				loginDao.updateCmsKey(info);
			}
			
			
		}else {
			
			map.put("sc_msg", ResultMsg);
			map.put("sc_close", "y");				
			return "/easyPayScript"+Const.uuTiles;
		}
	}
	
}

%>
<%!
private static HashMap jsonStringToHashMap(String str) throws Exception{
	HashMap dataMap = new HashMap();
	JSONParser parser = new JSONParser();
	try{
		Object obj = parser.parse(str);
		JSONObject jsonObject = (JSONObject)obj;

		Iterator<String> keyStr = jsonObject.keySet().iterator();
		while(keyStr.hasNext()){
			String key = keyStr.next();
			Object value = jsonObject.get(key);
			
			dataMap.put(key, value);
		}
	}catch(Exception e){
		
	}
	return dataMap;
}

public String connectToServer(String data, String reqUrl) throws Exception{
	HttpURLConnection conn 		= null;
	BufferedReader resultReader = null;
	PrintWriter pw 				= null;
	URL url 					= null;
	
	int statusCode = 0;
	StringBuffer recvBuffer = new StringBuffer();
	try{
		url = new URL(reqUrl);
		conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setConnectTimeout(3000);
		conn.setReadTimeout(5000);
		conn.setDoOutput(true);
		
		pw = new PrintWriter(conn.getOutputStream());
		pw.write(data);
		pw.flush();
		
		statusCode = conn.getResponseCode();
		resultReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		for(String temp; (temp = resultReader.readLine()) != null;){
			recvBuffer.append(temp).append("\n");
		}
		
		if(!(statusCode == HttpURLConnection.HTTP_OK)){
			throw new Exception();
		}
		
		return recvBuffer.toString().trim();
	}catch (Exception e){
		return "9999";
	}finally{
		recvBuffer.setLength(0);
		
		try{
			if(resultReader != null){
				resultReader.close();
			}
		}catch(Exception ex){
			resultReader = null;
		}
		
		try{
			if(pw != null) {
				pw.close();
			}
		}catch(Exception ex){
			pw = null;
		}
		
		try{
			if(conn != null) {
				conn.disconnect();
			}
		}catch(Exception ex){
			conn = null;
		}
	}
}

public void setCookie(HttpServletResponse res, String key , String value, int age){
	Cookie cookie = new Cookie(key,value);
	cookie.setMaxAge(age);
	cookie.setPath(request.getContextPath());
	//cookie.setDomain("biumherb.co.kr");
	res.addCookie(cookie);
}


%>
</body>
</html>