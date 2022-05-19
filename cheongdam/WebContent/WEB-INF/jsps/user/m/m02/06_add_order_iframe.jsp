<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>	
	<title>청담원외탕전</title>
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
<script  src="https://code.jquery.com/jquery-1.12.4.js" ></script>
<link type="text/css" rel='stylesheet' href="/assets/user/js/_fancybox2.0/jquery.fancybox.css?v=2.1.4"  media="screen"/>
<link rel="stylesheet" type="text/css" href="/assets/user/js/_fancybox2.0/helpers/jquery.fancybox-buttons.css?v=1.0.5" />
<link rel="stylesheet" type="text/css" href="/assets/user/js/_fancybox2.0/helpers/jquery.fancybox-thumbs.css?v=1.0.7" />
<script type="text/javascript" src="/assets/user/js/_fancybox2.0/jquery.mousewheel-3.0.6.pack.js"></script>
<script type="text/javascript" src="/assets/user/js/_fancybox2.0/jquery.fancybox.js?v=2.1.4"></script>

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
	
	
	String goodsCnt         = "1";                       // 결제상품개수;
	String goodsName        = view.get("tang_name")+"";                      // 결제상품명
	String Amt            	= view.get("Amt")+"";
	
	
	
	System.out.println("결제금액 frame   = "+ (Amt));
	
	
	/* String moid             = Const.NP_moid+"y"+(String.format("%08d", StringUtil.ObjectToInt(bean.get("goods_seq"))));              // 상품주문번호 */      
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	String moid             = Const.NP_moid+"t"+(String.format("%08d", StringUtil.ObjectToInt(view.get("seqno"))))+"_"+sdf.format(today);              // 상품주문번호
	System.out.println("moid   = "+ (moid));	
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
	
	String returnURL        = "http://"+Const.M_DOMAIN_NM+"/m/m02/06_com_order_card.do?itype=cart";
%>
<script>
$(document).ready(function() {
	
	$('#wrapSize').css('width',$( window ).width()+'px').css('height',$( window ).height()+'px');

	
	var targetForm = $("#payForm");
	
	var url        = "<%=returnURL%>";
	
	$('input, select, textarea').each(
	    function(index){  
	        var input = $(this);
	        if(input.attr('id') != undefined ){
	        	url += "&"+input.attr('id')+"="+encodeURI(input.val())
	        	console.log(' ID: ' + input.attr('id') + ' Value: ' + input.val());	
	        }
	    }
	);
	
	$('#ReturnURL').val(url);
	$('#payForm').attr('accept-charset', 'euc-kr');
	$('#payForm').attr('action', 'https://web.nicepay.co.kr/v3/smart/smartPayment.jsp');
	nicepayStart();
	
});
//결제창 최초 요청시 실행됩니다.
function nicepayStart(){
    document.charset = "euc-kr";
    document.payForm.submit();
}

function aaa(){
	parent.closeFancyBox();
}
</script>


		
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
<style>
.fancybox-close{
	display: none;
}

body {
    -ms-overflow-style: none; /* IE and Edge */
    scrollbar-width: none; /* Firefox */
}

body::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera*/
}
</style>
</head>

<body style="margin: 0 0; padding: 0 0;">
	<div style="margin: 0 0; padding: 0 0;width: 320px;min-height: 568px;" id="wrapSize">
		&nbsp;
		<div  style="display: block;">
			<!-- <form action="01_com_order_ajax" name="payForm" id="payForm" > -->
			<form name="payForm" method="post" target="_self" action="https://web.nicepay.co.kr/v3/smart/smartPayment.jsp" accept-charset="euc-kr">
				<!-- 산용카드 정보 -->
				<input type="text" name="PayMethod"    value="CARD" /> <br/>
				<input type="text" name="GoodsName"    value="<%=goodsName%>" /> <!-- 상품명 --><br/>
				<input type="text" name="GoodsCnt"    value="<%=goodsCnt%>" /> <!-- 상품겟수 --><br/>
				<input type="text" name="Amt"         value="<%=Amt%>" /> <!-- 결제금액 -->
				<input type="text" name="BuyerName"   value="${userInfo.name}" /><br/>
				<input type="text" name="BuyerTel"    value="${userInfo.handphone}" /><br/>
				<input type="text" name="Moid"         value="<%=moid%>" /><br/>
				<input type="text" name="MID"         value="<%=MID%>" /><br/>
				
				
				
				<!-- IP -->
				<input type="text" name="MallIP"  value="<%=inet.getHostAddress()%>" /> <br/>     <!-- 상점서버IP --><br/>
				                        
				<!-- 옵션 -->
				<input type="text" name="CharSet"   value="<%=charset%>"/> <br/>                  <!-- 인코딩 설정 -->               
				<input type="text" name="BuyerEmail" value="${userInfo.email}"/>  <br/>           <!-- 구매자 이메일 -->				  
				<input type="text" name="GoodsCl"     value="1"/>  <br/>                            <!-- 상품구분(실물(1),컨텐츠(0)) -->
				<input type="text" name="TransType"   value="0"/> <br/>                           <!-- 일반(0)/에스크로(1) --> 
				<input type="hidden" name="ReturnURL" id="ReturnURL" value="<%=returnURL%>"/>
				          
				<!-- 변경 불가능 -->
				<input type="text" name="EdiDate"  value="<%=ediDate%>"/>  <br/>                 <!-- 전문 생성일시 -->
				<input type="text" name="EncryptData"  value="<%=encryptData%>"/><br/>            <!-- 해쉬값	-->
				<input type="hidden" name="TrKey"   value=""/>
	        	<input type="hidden" name="AcsNoIframe"  value="Y"/>
				
				<!-- 주문정보 -->
				
				<input type="hidden" id="order_sale_per"   name="order_sale_per"   value="${view.sale_per}" />
				계정정보<br/>
				<%-- 
				<c:set var="tel" value="${fn:split(userInfo.han_tel,'-')}" />
				<input type="hidden" id="han_addr1" 	 name="han_addr1"	value="${userInfo.address01}" />
				<input type="hidden" id="han_addr2" 	 name="han_addr2"	value="${userInfo.address02}" />
				<input type="hidden" id="han_zip"   	 name="han_zip"	value="${userInfo.zipcode}" />
				<input type="hidden" id="han_handphone01"  name="han_handphone01"  value="${han_handphone[0]}" />
				<input type="hidden" id="han_handphone02"  name="han_handphone02" value="${han_handphone[1]}" /> 
				<input type="hidden" id="han_handphone03"  name="han_handphone03"  value="${han_handphone[2]}" />
				 --%> 
						
				페이지정보<br/>
				<input type="text" name="seqno" id="seqno"   value="${bean.seqno}" /><br/>
				<input type="text" name="page"  id="page"  value="${bean.page}" /><br/>
				<input type="text" name="payment_kind"  id="payment_kind"       value="Card" />
				
				주문자 정보
				<c:set var="tel" value="${fn:split(userInfo.han_tel,'-')}" />
				<input type="hidden" id="han_addr1" 	 name="han_addr1"	value="${userInfo.address01}" />
				<input type="hidden" id="han_addr2" 	 name="han_addr2"	value="${userInfo.address02}" />
				<input type="hidden" id="han_zip"   	 name="han_zip"	value="${userInfo.zipcode}" />
				<input type="hidden" id="han_handphone01"  name="han_handphone01"  value="${han_handphone[0]}" />
				<input type="hidden" id="han_handphone02"  name="han_handphone02" value="${han_handphone[1]}" /> 
				<input type="hidden" id="han_handphone03"  name="han_handphone03"  value="${han_handphone[2]}" /> 
				<input type="hidden" id="han_han_name"     value="${userInfo.han_name}" name="han_han_name" />
				<input type="hidden" id="han_name"     value="${userInfo.han_name}" name="han_name" />
				
				
				<input type="hidden" id="han_tel01" name="han_tel01"  value="${tel[0]}" />
				<input type="hidden" id="han_tel02" name="han_tel02"   value="${tel[1]}" /> 
				<input type="hidden" id="han_tel03" name="han_tel03"   value="${tel[2]}" /> 
				
				
					정보<br/>
				수신인정보 : <input type="text" name="d_type"  id="d_type"  value="${bean.d_type}" /><br/>
				
				
				<input type="hidden" id="sale_per"   name="sale_per"   value="${view.sale_per}" />
				<input type="hidden" id="sale_price" name="sale_price" value="${view.sale_price}" />
				<input type="hidden" id="order_type" name="order_type" value="${bean.order_type}" />
				
				 보내는 사람<br/>
				<input type="text" name="d_from_name" id="d_from_name"  style="width:220px;" value="${bean.d_from_name }" /><br/>
				<input type="text" id="d_from_handphone01" name="d_from_handphone01" style="width:65px;" maxlength="4"  value="${bean.d_from_handphone01 }"/> -
				<input type="text" id="d_from_handphone02" name="d_from_handphone02" style="width:65px;" maxlength="4"  value="${bean.d_from_handphone02 }"/> -
				<input type="text" id="d_from_handphone03" name="d_from_handphone03" style="width:65px;" maxlength="4"  value="${bean.d_from_handphone03 }"/><br/>
				
				
				<input type="text" name="d_from_zipcode" id="d_from_zipcode"  style="width:150px;"  value="${bean.d_from_zipcode }"/>
				<input type="text" name="d_from_address01"  style="width:350px;" readonly id="d_from_address01"  value="${bean.d_from_address01 }"/>
				<input type="text" name="d_from_address02"  style="width:270px; margin:0px 0 0 10px;" id="d_from_address02"  value="${bean.d_from_address02 }"/><br/>
				
				받는 사람<br/>
				<input type="text" name="d_to_name" id="d_to_name" style="width:220px;"  value="${bean.d_to_name }"/><br/>
				<input type="text" id="d_to_handphone01" name="d_to_handphone01" style="width:65px;" maxlength="4"  value="${bean.d_to_handphone01 }"/> -
				<input type="text" id="d_to_handphone02" name="d_to_handphone02" style="width:65px;" maxlength="4"  value="${bean.d_to_handphone02 }"/> -
				<input type="text" id="d_to_handphone03" name="d_to_handphone03" style="width:65px;" maxlength="4"  value="${bean.d_to_handphone03 }"/><br/>
				
				<input type="text" name="d_to_zipcode" id="d_to_zipcode" style="width:150px;" value="${bean.d_to_zipcode }" />
				<input type="text" name="d_to_address01" style="width:350px; margin-top:10px;" readonly id="d_to_address01"  value="${bean.d_to_address01 }"/>
				<input type="text" name="d_to_address02"  style="width:270px; margin:10px 0 0 10px;" id="d_to_address02"  value="${bean.d_to_address02 }"/><br/>
				
			</form>
		</div>
	</div>
</body>
</html>
