<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="org.apache.commons.codec.binary.Hex" %>
<%
/*
*******************************************************
* <결제요청 파라미터>
* 결제시 Form 에 보내는 결제요청 파라미터입니다.
* 샘플페이지에서는 기본(필수) 파라미터만 예시되어 있으며, 
* 추가 가능한 옵션 파라미터는 연동메뉴얼을 참고하세요.
*******************************************************
*/

 /*  
String merchantKey = "xqVH8KYzcJgWiYSjIaIM4LBE5+MYpncLeveB7RqHApwdI1BUbPXaLzOqnZqLtw4M1Sb3B7mwkfQ31vdgGOSf+Q=="; // 상점키
String merchantID = "payutest0m"; // 상점아이디 
  */
  
 String merchantKey = "beoYbMzOmawD+NsKobAJD7MbqrcBxVT406HBpSXrENX+XKXepFs1dA5fy1B3T5Fc+HpaDQ2VV9rYD60Ju/Lsug=="; // 상점키
 String merchantID  = "biumherb1m"; // 상점아이디 
 
String goodsName  = "박근열_상품"; // 결제상품명
String price      = "10000"; // 결제상품금액
String buyerName  = "박근열"; // 구매자명 
String buyerTel   = "01048512238"; // 구매자연락처
String buyerEmail = "matrix1597@naver.com"; // 구매자메일주소        
String moid       = "mnoid1234567890"; // 상품주문번호                     
String returnURL  = "http://localhost//payResult_utf.jsp"; // 결과페이지

/*
*******************************************************
* <해쉬암호화> (수정하지 마세요)
* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
*******************************************************
*/
DataEncrypt sha256Enc 	= new DataEncrypt();
String ediDate 			= getyyyyMMddHHmmss();	
String hashString 		= sha256Enc.encrypt(ediDate + merchantID + price + merchantKey);
%>
<!DOCTYPE html>
<html>
<head>
<title>NICEPAY PAY-U REQUEST(EUC-KR)</title>
<meta charset="utf-8">
<style>
	html,body {height: 100%;}
	form {overflow: hidden;}
</style>
</head>
<body>

<form name="payForm" method="post" action="https://payu.nicepay.co.kr/main.do"  accept-charset="euc-kr">
	<input type="text" name="MID" value="<%=merchantID%>" style="width: 400px;"> 상점ID<br>
	<input type="text" name="MallUserID" value="matrix" style="width: 400px;"> 상점 고객ID<br>
	<input type="text" name="UserKey" value="" style="width: 400px;"> 간편결제 사용자Key<br>
	<input type="text" name="BuyerName" value="<%=buyerName%>" style="width: 400px;"> 고객명<br>
	<input type="text" name="BuyerEmail" value="<%=buyerEmail%>" style="width: 400px;"> 고객 Email<br>
	<input type="text" name="Moid" value="<%=moid%>" style="width: 400px;"> 주문번호<br>
	<input type="text" name="EdiDate" value="<%=ediDate%>" style="width: 400px;" /> 전문 생성일시<br>
	<input type="text" name="Amt" value="<%=price%>" style="width: 400px;"> 결제금액<br>
	<input type="text" name="GoodsName" value="<%=goodsName%>" style="width: 400px;"> 상품명<br>
	<input type="text" name="ReturnUrl" value="<%=returnURL%>" style="width: 800px;"> 간편결제 인증결과 수신URL<br>
	<input type="text" name="SignData" value="<%=hashString%>" style="width: 800px;" /> 해쉬값<br>
	<input type="text" name="ApproveMode" value="API" style="width: 400px;" > ApproveMode<br>
	<input type="text" name="BuyerTel" value="01048512238" /> 고객 핸드폰<br />
	<input type="text" name="AuthType" value="2"/> CharSet<br />
	
	<input type="text" name="CharSet" value="euc-kr" style="width: 400px;" /> CharSet<br>

	<a href="#" onClick="nicepayStart();">요 청</a>

<script type="text/javascript">
function nicepayStart(){
	document.payForm.submit();
}
</script>

</form>
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
%>