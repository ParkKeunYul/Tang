package kr.co.hany.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import jdk.nashorn.internal.runtime.ConsString;
import kr.co.hany.common.Const;
import kr.co.nicevan.nicepay.adapter.web.NicePayHttpServletRequestWrapper;
import kr.co.nicevan.nicepay.adapter.web.NicePayWEB;
import kr.co.nicevan.nicepay.adapter.web.dto.WebMessageDTO;

import org.apache.commons.codec.binary.Hex;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class NicePayUtil {

	
	public static Map<String, Object> reqPayResult( HttpServletRequest request
  			 									   ,HttpServletResponse response){
		
		Map<String, Object> resultInfo = null;
		/*resultInfo.put("suc", "fail");
		resultInfo.put("msg", "결제 실패했습니다.");*/
		try {
			String EncodeKey            = Const.NP_encodeKey; //가맹점키
			String logPath              = Const.UPLOAD_ROOT+"nplog/";
			String APP_LOG              = "1";                // 어플리케이션로그 모드 설정(0: DISABLE, 1: ENABLE)
			String EVENT_LOG            = "1";                // 이벤트로그 모드 설정(0: DISABLE, 1: ENABLE)
			String EncFlag              = "S";                // 암호화플래그 설정(N: 평문, S:암호화)
			String SERVICE_MODE         = "PY0";              // 서비스모드 설정(결제 서비스 : PY0 , 취소 서비스 : CL0)
			String Currency             = "KRW";
			
			String payMethod            = "";  String resultCode           = "";  String resultMsg            = "";
			String authDate             = "";  String authCode             = "";  String buyerName            = "";
			String mallUserID           = "";  String goodsName            = "";  String mid                  = "";
			String tid                  = "";  String moid                 = "";  String amt                  = "";
			String cardCode             = "";  String cardName             = "";  String cardQuota            = "";
			String bankCode             = "";  String bankName             = "";  String rcptType             = "";
			String rcptAuthCode         = "";  String rcptTID              = "";  String carrier              = "";
			String dstAddr              = "";  String vbankBankCode        = "";  String vbankBankName        = "";
			String vbankNum             = "";  String vbankExpDate         = "";  String authResultCode       = "";
			String authResultMsg        = "";  String easyBankUserNo       = "";  
			
			authResultCode   = (String)request.getParameter("AuthResultCode");              // 인증결과 : 0000(성공)
			authResultMsg    = (String)request.getParameter("AuthResultMsg");               // 인증결과 메시지
			
			
			
			System.out.println("authResultCode = "+ authResultCode);
			System.out.println("authResultMsg = "+ authResultMsg);
			
			if("0000".equals(authResultCode)){
				resultInfo = new HashMap<String, Object>();
				
				
			    NicePayWEB nicepayWEB = new NicePayWEB();
			    payMethod = request.getParameter("PayMethod");                           
			    nicepayWEB.setParam("NICEPAY_LOG_HOME",logPath);                           
			    nicepayWEB.setParam("APP_LOG",APP_LOG);                                         
			    nicepayWEB.setParam("EVENT_LOG",EVENT_LOG);                                      
			    nicepayWEB.setParam("EncFlag",EncFlag);                                         
			    nicepayWEB.setParam("SERVICE_MODE",SERVICE_MODE);                                  
			    nicepayWEB.setParam("Currency",Currency);                                                                                            
			    nicepayWEB.setParam("PayMethod",payMethod);                                                                                   
			    nicepayWEB.setParam("EncodeKey",EncodeKey);
			    
			    System.out.println("payMethod = "+ payMethod);
			    System.out.println("logPath111 = "+ logPath);
	
			    /*
			    *******************************************************
			    * <결제 결과 필드>
			    *******************************************************
			    */
			    NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);
				httpRequestWrapper.addParameter("EncMode","S12");							// 전문 암호화 (S12: SHA-256)	
			    WebMessageDTO responseDTO   = nicepayWEB.doService(httpRequestWrapper,response);
	
			    resultCode           = responseDTO.getParameter("ResultCode");              // 결과코드 (정상 결과코드:3001)
			    resultMsg            = responseDTO.getParameter("ResultMsg");               // 결과메시지
			    authDate             = responseDTO.getParameter("AuthDate");                // 승인일시 (YYMMDDHH24mmss)
			    authCode             = responseDTO.getParameter("AuthCode");                // 승인번호
			    buyerName            = responseDTO.getParameter("BuyerName");               // 구매자명
			    mallUserID           = responseDTO.getParameter("MallUserID");              // 회원사고객ID
			    goodsName            = responseDTO.getParameter("GoodsName");               // 상품명
			    mid                  = responseDTO.getParameter("MID");                     // 상점ID
			    tid                  = responseDTO.getParameter("TID");                     // 거래ID
			    moid                 = responseDTO.getParameter("Moid");                    // 주문번호
			    amt                  = responseDTO.getParameter("Amt");                     // 금액
			    cardCode             = responseDTO.getParameter("CardCode");                // 결제카드사코드
			    cardName             = responseDTO.getParameter("CardName");                // 결제카드사명
			    cardQuota            = responseDTO.getParameter("CardQuota");               // 카드 할부개월 (00:일시불,02:2개월)
			    
			    bankCode             = responseDTO.getParameter("BankCode");         // 은행코드
			    bankName             = responseDTO.getParameter("BankName");         // 은행명
			    rcptType             = responseDTO.getParameter("RcptType");         // 현금 영수증 타입 (0:발행되지않음,1:소득공제,2:지출증빙)
			    rcptAuthCode         = responseDTO.getParameter("RcptAuthCode");     // 현금영수증 승인 번호
			    rcptTID              = responseDTO.getParameter("RcptTID");          // 현금 영수증 TID   
			    carrier              = responseDTO.getParameter("Carrier");          // 이통사구분
			    dstAddr              = responseDTO.getParameter("DstAddr");          // 휴대폰번호
			    vbankBankCode        = responseDTO.getParameter("VbankBankCode");    // 가상계좌은행코드
			    vbankBankName        = responseDTO.getParameter("VbankBankName");    // 가상계좌은행명
			    vbankNum             = responseDTO.getParameter("VbankNum");         // 가상계좌번호
			    vbankExpDate         = responseDTO.getParameter("VbankExpDate");     // 가상계좌입금예정일
			    easyBankUserNo 		 = responseDTO.getParameter("EasyBankUserNo");   // 계좌간편결제 회원ID
	
			    resultInfo.put("resultCode", resultCode);
			    resultInfo.put("resultMsg", resultMsg);
			    resultInfo.put("authDate", authDate);
			    resultInfo.put("authCode", authCode);
			    resultInfo.put("buyerName", buyerName);
			    resultInfo.put("mallUserID", mallUserID);
			    resultInfo.put("goodsName", goodsName);
			    resultInfo.put("mid", mid);
			    resultInfo.put("tid", tid);
			    resultInfo.put("moid", moid);
			    resultInfo.put("amt", amt);
			    resultInfo.put("cardCode", cardCode);
			    resultInfo.put("cardName", cardName);
			    resultInfo.put("cardQuota", cardQuota);
			    
			    
			    resultInfo.put("bankCode", bankCode);
			    resultInfo.put("bankName", bankName);
			    resultInfo.put("rcptType", rcptType);
			    resultInfo.put("rcptAuthCode", rcptAuthCode);
			    resultInfo.put("rcptTID", rcptTID);
			    resultInfo.put("carrier", carrier);
			    resultInfo.put("dstAddr", dstAddr);
			    resultInfo.put("vbankBankCode", vbankBankCode);
			    resultInfo.put("vbankBankName", vbankBankName);
			    resultInfo.put("vbankNum", vbankNum);
			    resultInfo.put("vbankExpDate", vbankExpDate);
			    resultInfo.put("easyBankUserNo", easyBankUserNo);
			    
			    /*
			    *******************************************************
			    * <결제 성공 여부 확인>
			    *******************************************************
			    */
			    boolean paySuccess = false;
			    if(payMethod.equals("CARD")){
			        if(resultCode.equals("3001")) paySuccess = true;	                    // 신용카드(정상 결과코드:3001)       	
			    }
			}
			return resultInfo;
		}catch (Exception e) {
			e.printStackTrace();
			return resultInfo;
		}
	}
	
	public static Map<String, Object>  cancelCard( CommonMap param
												  ,HttpServletRequest request
												  ,HttpServletResponse response){
		
		Map<String, Object> resultInfo = new HashMap<String, Object>();
		
		try {
			
			NicePayHttpServletRequestWrapper httpRequestWrapper = new NicePayHttpServletRequestWrapper(request);
			NicePayWEB nicepayWEB = new NicePayWEB();
			String logPath              = Const.UPLOAD_ROOT+"nplog/cancel/";
			nicepayWEB.setParam("NICEPAY_LOG_HOME",logPath); 
			nicepayWEB.setParam("APP_LOG","1");                                         // 이벤트로그 모드 설정(0: DISABLE, 1: ENABLE)
			nicepayWEB.setParam("EVENT_LOG","1");                                       // 어플리케이션로그 모드 설정(0: DISABLE, 1: ENABLE)
			nicepayWEB.setParam("EncFlag","S");                                         // 암호화플래그 설정(N: 평문, S:암호화)
			nicepayWEB.setParam("SERVICE_MODE","CL0");  
			
			WebMessageDTO responseDTO   = nicepayWEB.doService(httpRequestWrapper,response);
			
			String resultCode           = responseDTO.getParameter("ResultCode");       // 결과코드 (취소성공: 2001, 취소성공(LGU 계좌이체):2211)
			String resultMsg            = responseDTO.getParameter("ResultMsg");        // 결과메시지
			String cancelAmt            = responseDTO.getParameter("CancelAmt");        // 취소금액
			String cancelDate           = responseDTO.getParameter("CancelDate");       // 취소일
			String cancelTime           = responseDTO.getParameter("CancelTime");       // 취소시간
			String cancelNum            = responseDTO.getParameter("CancelNum");        // 취소번호
			String payMethod            = responseDTO.getParameter("PayMethod");        // 취소 결제수단
			String mid                  = responseDTO.getParameter("MID");              // 상점 ID
			String tid                  = responseDTO.getParameter("TID");              // 거래아이디 TID
			
			
			resultInfo.put("resultCode", resultCode);
			resultInfo.put("resultMsg", resultMsg);
			resultInfo.put("cancelAmt", cancelAmt);
			resultInfo.put("cancelDate", cancelDate);
			resultInfo.put("cancelTime", cancelTime);
			resultInfo.put("cancelNum", cancelNum);
			resultInfo.put("payMethod", payMethod);
			resultInfo.put("mid"	  , mid);
			resultInfo.put("tid"	  , tid);
			
			System.out.println("resultInfo can = "+ resultInfo);
			
			return resultInfo;
		}catch (Exception e) {
			e.printStackTrace();
			return resultInfo;
		}
	}
	
	
	public static Map<String, Object>  cancelCms ( CommonMap param
												  ,HttpServletRequest request
												  ,HttpServletResponse response){

		Map<String, Object> resultInfo = new HashMap<String, Object>();
		
		try {
			
			
			String tid 					= param.getString("TID");	// 거래 ID
			String cancelAmt 			= param.getString("CancelAmt");	// 취소금액
			String partialCancelCode 	= param.getString("PartialCancelCode");	 	// 부분취소여부
			String mid 					= param.getString("MID");	// 상점 ID
			String moid					= param.getString("MOID");
			String cancelMsg 			= param.getString("CancelMsg");
			
			DataEncrypt sha256Enc 	= new DataEncrypt();
			String merchantKey 		= Const.NP_CMS_encodeKey;
			String ediDate			= getyyyyMMddHHmmss();
			String signData 		= sha256Enc.encrypt(mid + cancelAmt + ediDate + merchantKey);
			
			StringBuffer requestData = new StringBuffer();
			requestData.append("TID=").append(tid).append("&");
			requestData.append("MID=").append(mid).append("&");
			requestData.append("Moid=").append(moid).append("&");
			requestData.append("CancelAmt=").append(cancelAmt).append("&");
			requestData.append("CancelMsg=").append(URLEncoder.encode(cancelMsg, "euc-kr")).append("&");
			requestData.append("PartialCancelCode=").append(partialCancelCode).append("&");
			requestData.append("EdiDate=").append(ediDate).append("&");
			requestData.append("CharSet=").append("utf-8").append("&");
			requestData.append("SignData=").append(signData);
			String resultJsonStr = connectToServer(requestData.toString(), "https://webapi.nicepay.co.kr/webapi/cancel_process.jsp");
			
			String ResultCode 	= ""; String ResultMsg 	= ""; String CancelAmt 	= "";
			String CancelDate 	= ""; String CancelTime = ""; String TID 		= "";
			
			
			if("9999".equals(resultJsonStr)){

				resultInfo.put("resultCode", "9999");
				resultInfo.put("resultMsg", "통신실패");
			}else{
				HashMap resultData = jsonStringToHashMap(resultJsonStr);
				ResultCode 	= (String)resultData.get("ResultCode");	// 결과코드 (취소성공: 2001, 취소성공(LGU 계좌이체):2211)
				ResultMsg 	= (String)resultData.get("ResultMsg");	// 결과메시지
				CancelAmt 	= (String)resultData.get("CancelAmt");	// 취소금액
				CancelDate 	= (String)resultData.get("CancelDate");	// 취소일
				CancelTime 	= (String)resultData.get("CancelTime");	// 취소시간
				TID 		= (String)resultData.get("TID");		// 거래아이디 TID
				
				
				resultInfo.put("resultCode", ResultCode);
				resultInfo.put("resultMsg", ResultMsg);
				resultInfo.put("cancelAmt", CancelAmt);
				resultInfo.put("cancelDate", CancelDate);
				resultInfo.put("cancelTime", CancelTime);
				resultInfo.put("mid"	  , mid);
				resultInfo.put("tid"	  , tid);
			}
			
			
			
			return resultInfo;
			
		}catch (Exception e) {
			e.printStackTrace();
			return resultInfo;
		}
	}
	
	
	public static final synchronized String getyyyyMMddHHmmss(){
		SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
		return yyyyMMddHHmmss.format(new Date());
	}


	//server to server 통신
	public static String connectToServer(String data, String reqUrl) throws Exception{
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
	
}

