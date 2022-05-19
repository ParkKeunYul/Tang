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
	
	Map<String, Object> bean = (Map<String, Object>)request.getAttribute("bean");
	
	
	String goodsCnt         = bean.get("goods_cnt")+"";                         // 결제상품개수
	String goodsName        = bean.get("goods_name")+"";                      // 결제상품명
	String Amt            	= (bean.get("goods_tot")+"").replace(".0", "");         // 결제상품금액
	
	int use_point           = StringUtil.ObjectToInt(bean.get("use_point")); 
	if(use_point > 0){
		Amt = (StringUtil.ObjectToInt(Amt) - use_point)+""; 
	}
	
	
	System.out.println("결제금액 frame   = "+ (Amt));
	
	
	/* String moid             = Const.NP_moid+"y"+(String.format("%08d", StringUtil.ObjectToInt(bean.get("goods_seq"))));              // 상품주문번호 */      
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	String moid             = Const.NP_moid+"y"+(String.format("%08d", StringUtil.ObjectToInt(bean.get("goods_seq"))))+"_"+sdf.format(today);              // 상품주문번호
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
	
	String returnURL        = "http://"+Const.M_DOMAIN_NM+"/m/m03/02_order_com_cart_card.do?itype=cart";
	
	
	String p_tot_price = bean.get("tot_price")+"";
	int  flagPrice = 0;
	
	String cPrice = (StringUtil.ObjectToInt( Amt) +  use_point)+"";
	
	if(!p_tot_price.equals( cPrice   )){
		flagPrice = -1;
	}
	
	System.out.println("결제금액 frame   = "+ (Amt));
	System.out.println("결제금액 02_order_app_cart frame  use_point = "+ (use_point));
	System.out.println("결제금액 p_tot_price   = "+ (p_tot_price));
	System.out.println("결제금액 flagPrice   = "+ (flagPrice));
%>
<script>
$(document).ready(function() {
	
	
	var flagPrice = $('#flagPrice').val();
	
	
	if(flagPrice == 0){
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
	}else{
		cartClose();
	}
	
	
});
	//결제창 최초 요청시 실행됩니다.
	function nicepayStart(){
	    document.charset = "euc-kr";
	    document.payForm.submit();
	}
/* 
	//결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
	function nicepaySubmit(){
		$.ajax({
  			url  : '/m03/02_order_com_cart_ajax.do.do',
  			type : 'POST',
  			data : $("#payForm").serialize(),
  			error : function() {
  				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
  				parent.closeFancyBox();
  			},
  			success : function(data) {
  				alert(data.msg);
  				if(data.suc){
  					parent.location.href='/m03/02_order_result_cart.do';
  				}
  				parent.closeFancyBox();
  			}
  		});
	}
 */
	//결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
	function nicepayClose(){
	    alert("결제가 취소 되었습니다");
	    parent.closeFancyBox();
	}
	
	function aaa(){
		parent.closeFancyBox();
	}
	
	function cartClose(){
		alert("상품정보가 일치하지 않습니다.\n새로고침후에 다시 시도해주세요");
		try{
	        parent.jQuery.fancybox.close();
	    }catch(err){
	        parent.$('#fancybox-overlay').hide();
	        parent.$('#fancybox-wrap').hide();
	    }
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
			<form name="payForm" id="payForm" method="post" target="_self" action="https://web.nicepay.co.kr/v3/smart/smartPayment.jsp" accept-charset="euc-kr">
				<input type="text" name="flagPrice" id="flagPrice"   value="<%=flagPrice %>" /> <br/>
			
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
				<input type="hidden" id="han_name"     value="${userInfo.han_name}" name="han_name" />
				
				
				<input type="hidden" id="han_tel01" name="han_tel01"  value="${tel[0]}" />
				<input type="hidden" id="han_tel02" name="han_tel02"   value="${tel[1]}" /> 
				<input type="hidden" id="han_tel03" name="han_tel03"   value="${tel[2]}" /> 
						
				페이지정보<br/>
				<input type="text" name="p_seq" id="p_seq"   value="${bean.p_seq}" /><br/>
				<input type="text" name="page"  id="page"  value="${bean.page}" /><br/>
				
				상품정보 <br/>
				상품 시퀀스 : <input type="text" name="all_seqno" id="all_seqno" value="${bean.all_seqno}" /> <br/>
				결제 정보 <input type="text" name="payment_kind" id="payment_kind" value="${bean.payment_kind}" /> <br/>
				
				
				<!-- 옵션정보 상품이 여러개일경우 의미 없어짐   <br/> -->
				<!-- 옵션 시퀀스 : --> <input type="hidden" name="box_option_seqno" id="box_option_seqno" value="${bean.box_option_seqno }"/>
				<!-- 옵션명 :  --><input type="hidden" name="box_option_nm" id="box_option_nm" value="${bean.box_option_nm }"/>
				<!-- 옵션가격 : --> <input type="hidden" name="box_option_price" id="box_option_price" value="${bean.box_option_price }"/>
				
				배송비정보<br/>
				수신인정보 : <input type="text" name="ship_type_to"  id="ship_type_to"  value="3" /><br/>
				발신인정보(배송):<input type="text" name="ship_type_from" id="ship_type_from" value="${bean.ship_type_from }"/><br/>
				배송비 무료금액<input type="text" id="freeDeileveryLimit" name="freeDeileveryLimit" value="${bean.freeDeileveryLimit }" /><br/>
				상품금액 : <input type="text" id="sum_goods_tot" name="sum_goods_tot" value="${bean.sum_goods_tot}" /><br/>
				배송비 : <input type="text" name="delivery_price" id="delivery_price" value="${bean.delivery_price}" /><br/>
				할인금액 : <input type="text" name="sale_price" id="sale_price" value="${bean.sale_price}" /><br/>
				총 결제금액 : <input type="text" name="tot_price" id="tot_price" value="${bean.tot_price}" /><br/>
				사용포인트 : <input type="text" name="use_point" id="use_point" value="${bean.use_point}" /><br/>
				포인트 사용내역 : <input type="text" name="reason" id="reason" value="약속처방 즉시구매 포인트 사용" /><br/>
				
				 보내는 사람<br/>
				<input type="text" name="o_name" id="o_name"  style="width:220px;" value="${bean.o_name }" /><br/>
				<input type="text" id="o_tel01" name="o_tel01" style="width:65px;" maxlength="4"  value="${bean.o_tel01 }"/> -
				<input type="text" id="o_tel02" name="o_tel02" style="width:65px;" maxlength="4"  value="${bean.o_tel02 }"/> -
				<input type="text" id="o_tel03" name="o_tel03" style="width:65px;" maxlength="4"  value="${bean.o_tel03 }"/><br/>
				
				<input type="text" id="o_handphone01" name="o_handphone01" style="width:65px;" maxlength="4"  value="${bean.o_handphone01 }"/> -
				<input type="text" id="o_handphone02" name="o_handphone02" style="width:65px;" maxlength="4"  value="${bean.o_handphone02 }"/> -
				<input type="text" id="o_handphone03" name="o_handphone03" style="width:65px;" maxlength="4"  value="${bean.o_handphone03 }"/><br/>
				
				<input type="text" name="o_zipcode" id="o_zipcode"  style="width:150px;"  value="${bean.o_zipcode }"/>
				<input type="text" name="o_address01"  style="width:350px;" readonly id="o_address01"  value="${bean.o_address01 }"/>
				<input type="text" name="o_address02"  style="width:270px; margin:0px 0 0 10px;" id="o_address02"  value="${bean.o_address02 }"/><br/>
				
				받는 사람<br/>
				<input type="text" name="r_name" id="r_name" style="width:220px;"  value="${bean.r_name }"/><br/>
				<input type="text" id="r_tel01" name="r_tel01" style="width:65px;" maxlength="4"  value="${bean.r_tel01 }"/> -
				<input type="text" id="r_tel02" name="r_tel02" style="width:65px;" maxlength="4"  value="${bean.r_tel02 }"/> -
				<input type="text" id="r_tel03" name="r_tel03" style="width:65px;" maxlength="4"  value="${bean.r_tel03 }"/><br/>
				
				<input type="text" id="r_handphone01" name="r_handphone01" style="width:65px;" maxlength="4"  value="${bean.r_handphone01 }"/> -
				<input type="text" id="r_handphone02" name="r_handphone02" style="width:65px;" maxlength="4"  value="${bean.r_handphone02 }"/> -
				<input type="text" id="r_handphone03" name="r_handphone03" style="width:65px;" maxlength="4"  value="${bean.r_handphone03 }"/><br/>
				
				<input type="text" name="r_zipcode" id="r_zipcode" style="width:150px;" value="${bean.r_zipcode }" />
				<input type="text" name="r_address01" style="width:350px; margin-top:10px;" readonly id="r_address01"  value="${bean.r_address01 }"/>
				<input type="text" name="r_address02"  style="width:270px; margin:10px 0 0 10px;" id="r_address02"  value="${bean.r_address02 }"/><br/>
				
				<textarea name="o_memo" id="o_memo" style="width:630px; height:40px;resize:none;">${bean.o_memo }</textarea><br/>
				
				<textarea name="o_memo2" id="o_memo2" style="width:630px; height:40px;resize:none;">${bean.o_memo2 }</textarea><br/>
			</form>
		</div>
	</div>
</body>
</html>
