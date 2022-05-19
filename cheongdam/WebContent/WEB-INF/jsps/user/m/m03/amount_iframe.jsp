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
	String encodeKey		= Const.NP_encodeKey; // 상점키
	String MID       		= Const.NP_MID;                   // 상점아이디
	//String moid             = Const.NP_moid;              // 상품주문번호
	
	Map<String, Object> bean = (Map<String, Object>)request.getAttribute("bean");
	
	
	String goodsCnt         = bean.get("goods_cnt")+"";                         // 결제상품개수
	String goodsName        = bean.get("goods_name")+"";                      // 결제상품명
	String Amt            	= (bean.get("goods_tot")+"").replace(".0", "");         // 결제상품금액
	
	
	
	System.out.println("결제금액 01_add_order frame   = "+ (Amt));
	
	
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
	
	String returnURL        = "http://"+Const.M_DOMAIN_NM+"/m/m03/amount_order_card.do?";
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
/* 
	//결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
	function nicepaySubmit(){
		$.ajax({
  			url  : '/m03/02_order_com_cart_ajax.do.do',
  			type : 'POST',
  			data : $("#frm").serialize(),
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
				<!-- 산용카드 정보 -->
				<input type="text" name="PayMethod" id="PayMethod"    value="CARD" /> <br/>
				<input type="text" name="seqno" id="seqno"   value="${param.seqno}" /> <br/>
				<input type="text" name="ea" id="ea"   value="${param.ea}" /> <br/>
				<input type="text" name="GoodsName"    value="<%=goodsName%>" /> <!-- 상품명 --><br/>
				<input type="text" name="GoodsCnt"     value="<%=goodsCnt%>" /> <!-- 상품겟수 --><br/>
				<input type="text" name="Amt"          value="<%=Amt%>" /> <!-- 결제금액 -->
				<input type="text" name="BuyerName"    value="${userInfo.name}" /><br/>
				<input type="text" name="BuyerTel"     value="${userInfo.handphone}" /><br/>
				<input type="text" name="mem_seqno" id="mem_seqno"    value="${userInfo.seqno}" /><br/>
				<input type="text" name="Moid"         value="<%=moid%>" /><br/>
				<input type="text" name="MID"          value="<%=MID%>" /><br/>
				
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
			</form>
		</div>
	</div>
</body>
</html>
