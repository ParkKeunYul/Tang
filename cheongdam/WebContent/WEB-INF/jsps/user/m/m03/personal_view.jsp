<%@page import="kr.co.hany.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.hany.common.Const"%>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="org.apache.commons.codec.binary.Hex" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- <script src="https://web.nicepay.co.kr/v3/webstd/js/nicepay-2.0.js" type="text/javascript"></script> -->
<%
	/*
	*******************************************************
	* <결제요청 파라미터>
	* 결제시 Form 에 보내는 결제요청 파라미터입니다.
	* 샘플페이지에서는 기본(필수) 파라미터만 예시되어 있으며, 
	* 추가 가능한 옵션 파라미터는 연동메뉴얼을 참고하세요.
	* POST로 처리 / 인코딩 EUC-KR / 로그 외부 노출 되지 않도록 주의
	*******************************************************
	*/
	String encodeKey		= Const.NP_encodeKey; // 상점키
	String MID       		= Const.NP_MID;                   // 상점아이디
	//String moid             = Const.NP_moid;              // 상품주문번호
	
	Map<String, Object> view = (Map<String, Object>)request.getAttribute("view");
	
	String Amt            	= (view.get("price")+"").replace(".0", "");         // 결제상품금액
	
	
	/* int sale_per            = StringUtil.ObjectToInt(bean.get("sale_per"));
	
	
	int sale_price =  (StringUtil.ObjectToInt(Amt) * sale_per) / 100;
	
	System.out.println("총가격      = "+ Amt);
	System.out.println("할인퍼센트 = "+ sale_per);
	System.out.println("할인가격   = "+ sale_price);		
	String tot_price = (Amt-sale_price)+""; */
	
	System.out.println("결제금액   = "+ (Amt));
	
	
	String moid             = Const.NP_moid+"p"+(String.format("%08d", StringUtil.ObjectToInt(view.get("seqno"))));              // 상품주문번호      
		
	String charset          = "utf-8";
	
	/*
	*******************************************************
	* <해쉬암호화> (수정하지 마세요)
	* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
	*******************************************************
	*/
	DataEncrypt sha256Enc 	  = new DataEncrypt();
	String ediDate      	  = getyyyyMMddHHmmss();	
	String encryptData    	  = sha256Enc.encrypt(ediDate + MID + Amt + encodeKey);
	/*
	******************************************************* 
	* <서버 IP값>
	*******************************************************
	*/
	InetAddress inet        = InetAddress.getLocalHost();	
	
	
	
	
	String returnURL        = "http://"+Const.M_DOMAIN_NM+"/m/ext/personal_com.do?seqno="+view.get("seqno");
%>
<script>
//결제창 최초 요청시 실행됩니다.
function nicepayStart(){
    document.charset = "euc-kr";
    document.payForm.submit();
}

$(document).ready(function() {
	
	$("#orderPerBtn").click(function() {
		document.charset = "euc-kr";
		nicepayStart();
		return false;
	});
	
});
</script>

<!-- container -->
<!-- 
<form action="personal_com.do" name="frm" id="frm">
 -->
 <form name="payForm" method="post" target="_self" action="https://web.nicepay.co.kr/v3/smart/smartPayment.jsp" accept-charset="euc-kr">
 
 
	<div class="container sub" id="contents">
		<!-- LNB -->
		<div class="localMenu">
			<p class="tit">약속처방</p>
			<div class="lnbDepth">
				<ul>
					<li class="sel"><a href="/m/m03/01.do">약속처방</a></li>
					<li><a href="/m/m03/02.do">약속처방 보관함</a></li>
					<li><a href="/m/m03/03.do">사전조제지시서</a></li>
				</ul>
			</div>
		</div>	
	
		<!-- 본문 -->
		<div class="contents" id="contents">
			<div class="commView">
				<h4 <c:if test="${view.pay_yn eq 'y' }">style="text-decoration: line-through;"</c:if> >${view.title}</h4>
				<div class="dateInfo">
					<span ><b>결제금액 : </b><em <c:if test="${view.pay_yn eq 'y' }">style="text-decoration: line-through;"</c:if>><fmt:formatNumber value="${view.price}" pattern="#,###원" /></em></span>
				</div>
				
				<div class="textInfo"  style="<c:if test="${view.pay_yn eq 'y' }">text-decoration: line-through;</c:if>">${view.CONTENT}</div>
				
									
			</div>
			
			<div class="btnArea">
				<c:if test="${view.pay_yn eq  'n' }"><a href="#" id="orderPerBtn" style="width: 100%;margin-bottom: 10px;"><span class="btnTypeBasic colorGreen">결제하기</span></a></c:if>
				<c:if test="${view.pay_yn eq  'y' }"><span class="btnTypeBasic colorWhite" style="width: 100%;margin-bottom: 10px;">결제완료</span></c:if>
				<a href="personal.do?page=${bean.page}" class="btnTypeBasic colorGray" style="width: 100%;"><span>목록보기</span></a>
				
			</div>
		</div>
		<!-- //본문 -->
		<div id="nice_pay_setting_area"  style="display: none;">
			<input type="text" name="seqno" value="${view.seqno}" />
		
			<input type="text" name="PayMethod"   value="CARD">
			<input type="text" name="GoodsName"   value="${view.title}"> <!-- 상품명 -->
			<input type="text" name="GoodsCnt"    value="1"> <!-- 상품겟수 -->
			<input type="text" name="Amt"         value="${view.price}"> <!-- 결제금액 -->
			<input type="text" name="BuyerName"   value="${userInfo.name}">
			<input type="text" name="BuyerTel"    value="${userInfo.handphone}">
			<input type="text" name="Moid"        value="<%=moid%>">
			<input type="text" name="MID"         value="<%=MID%>">
			
			<!-- IP -->
	        <input type="text" name="MallIP" value="<%=inet.getHostAddress()%>"/>      <!-- 상점서버IP -->
	                          
	          <!-- 옵션 -->
		  	<input type="text" name="CharSet"    value="<%=charset%>"/>                   <!-- 인코딩 설정 -->               
	        <input type="text" name="BuyerEmail" value="${userInfo.email}"/>             <!-- 구매자 이메일 -->				  
	        <input type="text" name="GoodsCl"    value="1"/>                              <!-- 상품구분(실물(1),컨텐츠(0)) -->
	        <input type="text" name="TransType"  value="0"/>                            <!-- 일반(0)/에스크로(1) -->
	        <input type="text" style="width: 500px;" name="ReturnURL" value="<%=returnURL%>&m_cf=${view.price}&m_code=card_won&m_value=${userInfo.seqno}abpdf${userInfo.id}">                <!-- Return URL --> 
	            
	        <!-- 변경 불가능 -->
	        <input type="text" name="EdiDate" value="<%=ediDate%>"/>                   <!-- 전문 생성일시 -->
	        <input type="text" name="EncryptData" value="<%=encryptData%>"/>            <!-- 해쉬값	-->
	        <input type="text" name="TrKey" value=""/>
	        <input type="hidden" name="AcsNoIframe" value="Y"/>
		</div>
	
	</div>
</form>
<!-- //container -->
<!-- // container -->
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