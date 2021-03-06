<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.apache.commons.codec.binary.Hex" %>
<%
request.setCharacterEncoding("utf-8"); 
/*
****************************************************************************************
* <인증 결과 파라미터>
****************************************************************************************
*/
String authResultCode 	= (String)request.getParameter("AuthResultCode"); 	// 인증결과 : 0000(성공)
String authResultMsg 	= (String)request.getParameter("AuthResultMsg"); 	// 인증결과 메시지
String nextAppURL 		= (String)request.getParameter("NextAppURL"); 		// 승인 요청 URL
String txTid 			= (String)request.getParameter("TxTid"); 			// 거래 ID
String authToken 		= (String)request.getParameter("AuthToken"); 		// 인증 TOKEN
String payMethod 		= (String)request.getParameter("PayMethod"); 		// 결제수단
String mid 				= (String)request.getParameter("MID"); 				// 상점 아이디
String moid 			= (String)request.getParameter("Moid"); 			// 상점 주문번호
String amt 				= (String)request.getParameter("Amt"); 				// 결제 금액
String reqReserved 		= (String)request.getParameter("ReqReserved"); 		// 상점 예약필드
String netCancelURL 	= (String)request.getParameter("NetCancelURL"); 	// 망취소 요청 URL

/*
****************************************************************************************
* <승인 결과 파라미터 정의>
* 샘플페이지에서는 승인 결과 파라미터 중 일부만 예시되어 있으며, 
* 추가적으로 사용하실 파라미터는 연동메뉴얼을 참고하세요.
****************************************************************************************
*/
String ResultCode 	= ""; String ResultMsg 	= ""; String PayMethod 	= "";
String GoodsName 	= ""; String Amt 		= ""; String TID 		= "";

/*
****************************************************************************************
* <인증 결과 성공시 승인 진행>
****************************************************************************************
*/
String resultJsonStr = "";
if(authResultCode.equals("0000")){
	/*
	****************************************************************************************
	* <해쉬암호화> (수정하지 마세요)
	* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
	****************************************************************************************
	*/
	DataEncrypt sha256Enc 	= new DataEncrypt();
	String merchantKey    = "beoYbMzOmawD+NsKobAJD7MbqrcBxVT406HBpSXrENX+XKXepFs1dA5fy1B3T5Fc+HpaDQ2VV9rYD60Ju/Lsug=="; // 상점키
	
	String ediDate			= getyyyyMMddHHmmss();
	String signData 		= sha256Enc.encrypt(authToken + mid + amt + ediDate + merchantKey);

	/*
	****************************************************************************************
	* <승인 요청>
	* 승인에 필요한 데이터 생성 후 server to server 통신을 통해 승인 처리 합니다.
	****************************************************************************************
	*/
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
		if(PayMethod != null){
			if(PayMethod.equals("CARD")){
				if(ResultCode.equals("3001")) paySuccess = true; // 신용카드(정상 결과코드:3001)       	
			}else if(PayMethod.equals("BANK")){
				if(ResultCode.equals("4000")) paySuccess = true; // 계좌이체(정상 결과코드:4000)	
			}else if(PayMethod.equals("CELLPHONE")){
				if(ResultCode.equals("A000")) paySuccess = true; // 휴대폰(정상 결과코드:A000)	
			}else if(PayMethod.equals("VBANK")){
				if(ResultCode.equals("4100")) paySuccess = true; // 가상계좌(정상 결과코드:4100)
			}else if(PayMethod.equals("SSG_BANK")){
				if(ResultCode.equals("0000")) paySuccess = true; // SSG은행계좌(정상 결과코드:0000)
			}else if(PayMethod.equals("CMS_BANK")){
				if(ResultCode.equals("0000")) paySuccess = true; // 계좌간편결제(정상 결과코드:0000)
			}
		}
	}
}else{
	ResultCode 	= authResultCode; 	
	ResultMsg 	= authResultMsg;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>NICEPAY PAY RESULT(UTF-8)</title>
<meta charset="utf-8">
</head>
<body>
	<table>
		<%if("9999".equals(resultJsonStr)){%>
		<tr>
			<th>승인 통신 실패로 인한 망취소 처리 진행 결과</th>
			<td>[<%=ResultCode%>]<%=ResultMsg%></td>
		</tr>
		<%}else{%>
		<tr>
			<th>결과 내용</th>
			<td>[<%=ResultCode%>]<%=ResultMsg%></td>
		</tr>
		<tr>
			<th>결제수단</th>
			<td><%=PayMethod%></td>
		</tr>
		<tr>
			<th>상품명</th>
			<td><%=GoodsName%></td>
		</tr>
		<tr>
			<th>결제 금액</th>
			<td><%=Amt%></td>
		</tr>
		<tr>
			<th>거래 번호</th>
			<td><%=TID%></td>
		</tr>
		<%}%>
	</table>
	<p>*테스트 아이디인경우 당일 오후 11시 30분에 취소됩니다.</p>
</body>
</html>
<%!
public final synchronized String getyyyyMMddHHmmss(){
	SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
	return yyyyMMddHHmmss.format(new Date());
}

// SHA-256 형식으로 암호화
public class DataEncrypt{
	MessageDigest md;
	String strSRCData = "";
	String strENCData = "";
	String strOUTData = "";
	
	public DataEncrypt(){ }
	public String encrypt(String strData){
		String passACL = null;
		MessageDigest md = null;
		try{
			md = MessageDigest.getInstance("SHA-256");
			md.reset();
			md.update(strData.getBytes());
			byte[] raw = md.digest();
			passACL = encodeHex(raw);
		}catch(Exception e){
			System.out.print("암호화 에러" + e.toString());
		}
		return passACL;
	}
	
	public String encodeHex(byte [] b){
		char [] c = Hex.encodeHex(b);
		return new String(c);
	}
}

//server to server 통신
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

//JSON String -> HashMap 변환
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
%>