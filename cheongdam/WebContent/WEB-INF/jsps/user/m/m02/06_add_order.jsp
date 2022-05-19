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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
	
	
	/* int sale_per            = StringUtil.ObjectToInt(bean.get("sale_per"));
	
	
	int sale_price =  (StringUtil.ObjectToInt(Amt) * sale_per) / 100;
	
	System.out.println("총가격      = "+ Amt);
	System.out.println("할인퍼센트 = "+ sale_per);
	System.out.println("할인가격   = "+ sale_price);		
	String tot_price = (Amt-sale_price)+""; */
	
	System.out.println("결제금액   = "+ (Amt));
	
	
	/* String moid             = Const.NP_moid+"y"+(String.format("%08d", StringUtil.ObjectToInt(bean.get("goods_seq"))));              // 상품주문번호 */      
	Date today = new Date();
	SimpleDateFormat sdf       = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	String moid                = Const.NP_moid+"y"+(String.format("%08d", StringUtil.ObjectToInt(view.get("seqno"))))+"_"+sdf.format(today);              // 상품주문번호
	System.out.println("moid   = "+ (moid));
	String charset             = "utf-8";
	
	/*
	*******************************************************
	* <해쉬암호화> (수정하지 마세요)
	* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
	*******************************************************
	*/
	DataEncrypt sha256Enc 	  = new DataEncrypt();
	String ediDate      	  = getyyyyMMddHHmmss();	
	String encryptData    	  = sha256Enc.encrypt(ediDate + MID + Amt + encodeKey);
	System.out.println("할인가격 = "+ encryptData);
	/*
	******************************************************* 
	* <서버 IP값>
	*******************************************************
	*/
	InetAddress inet        = InetAddress.getLocalHost();	
	
	
	//String returnURL        = "http://m.cdherb.com/m/m03/personal_com.do?seqno="+view.get("seqno");
	
	String returnURL        = "http://"+Const.M_DOMAIN_NM+"/m/m02/06_com_order_card.do?itype=cart";
%>
<style>
.fancybox-close{
	display: none;
}
</style>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">탕전처방</p>
		<div class="lnbDepth">
			<ul>
				<li class="sel" style="width: 100%;"><a href="/m/m02/06.do">실속처방</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<form action="#" name="frm" id="frm">
	<!-- <form name="payForm" id="payForm" method="post" target="_self" action="https://web.nicepay.co.kr/v3/smart/smartPayment.jsp" accept-charset="euc-kr"> -->
		<div class="contents" id="contents">
			<!-- view -->
			<div class="orderview">				
				<!-- 결제 제품정보 -->
				<div class="orderDetail">
					<div class="detailList">
						<div class="Dtit">
							<img src="/upload/fast/${view.image1}" width="50px" height="50px"  alt="${view.tang_name }" onerror="this.src='/assets/user/m/images/no_image.png';"  /> 
							<p style="line-height: 20px;">
								${view.tang_name }
								<br/>
								<c:choose>
									<c:when test="${view.c_tang_type eq 2}">무압력탕전</c:when>
									<c:when test="${view.c_tang_type eq 3}">압력탕전</c:when>
									<c:otherwise>첩약</c:otherwise>
								</c:choose>
								<c:if test="${view.c_tang_type ne 1}">
									<span style="color: red;">
										<c:if test="${view.c_tang_check eq 13}">(주수상반)</c:if>
										<c:if test="${view.c_tang_check eq 14}">(증류)</c:if>
										<c:if test="${view.c_tang_check eq 15}">(발효)</c:if>
										<c:if test="${view.c_tang_check eq 16}">(재탕)</c:if>
									</span>
								</c:if>
								 / 
								${view.c_chup_ea}첩 
								<c:if test="${view.c_tang_type ne 1}">
									/ ${view.c_pack_ml}ml / ${view.c_pack_ea} 팩
								</c:if>
							</p>
							
						</div>
						<ul class="info">
							<li>
								<label class="title">주문금액</label>
								<p><strong><fmt:formatNumber value="${view.price}" pattern="#,###" /></strong>원</p>
							</li>
						</ul>						
					</div>
				</div>
				
				<div class="orderDetail">
					
				</div>
				
				<!-- //결제 제품정보 -->
				<div class="delivery">
					<label>배송유형 선택</label>
					<select name="d_type" id="ship_type_from"  style="width:65%;">
						<option value="3">한의원 - 고객</option>
						<option value="1" selected="selected">청담원외탕전 -> 한의원</option>
						<option value="4">청담원외탕전 - 고객</option>
						<option value="6">직접입력</option>
						<option value="7">방문수령</option>
					</select>
				</div>
				
				<!-- 보내는 사람 -->
				<div class="Listbox mt10">
					<p class="tit02">보내는 사람</p>
					<ul>
						<li class="type02">
							<label class="title" for="o_name">발신인</label>
							<div><input type="text" name="d_from_name" id="o_name"></div>
						</li>
						<li class="type02">
							<label class="title" for="o_tel01">연락처1</label>
							<div>
								<input type="text" id="o_tel01" name="d_from_handphone01" style="width:65px;" maxlength="4"> -
								<input type="text" id="o_tel02" name="d_from_handphone02" style="width:65px;" maxlength="4"> -
								<input type="text" id="o_tel03" name="d_from_handphone03" style="width:65px;" maxlength="4">
							</div>
						</li>
						<li class="type02 address">
							<label class="title" for="findAddrBtn1">주소</label>
							<div>
								<span><input type="text" name="d_from_zipcode" id="o_zipcode" style="width:80px;" readonly></span><button type="button" id="findAddrBtn1" class="btnTypeBasic"><span>주소찾기</span></button>
								<input type="text" name="d_from_address01" style="width:100%;" readonly id="o_address01">
								<input type="text" name="d_from_address02" style="width:100%;" id="o_address02"> 
							</div>
						</li>
					</ul>
				</div>
				<!-- //보내는 사람 -->
				<!-- 받는 사람 -->
				<div class="Listbox">
					<p class="tit03">받는 사람</p>
					<ul>
						<li class="type02">
							<label class="title" for="r_name">수신인</label>
							<div><input type="text" name="d_to_name" id="r_name"></div>
						</li>
						<li class="type02">
							<label class="title" for="r_tel01">연락처1</label>
							<div>
								<input type="text" id="r_tel01" name="d_to_handphone01" style="width:65px;" maxlength="4"> -
								<input type="text" id="r_tel02" name="d_to_handphone02" style="width:65px;" maxlength="4"> -
								<input type="text" id="r_tel03" name="d_to_handphone03" style="width:65px;" maxlength="4">
							</div>
						</li>
						<li class="type02 address">
							<label class="title" for="findAddrBtn2">주소</label>
							<div>
								<span><input type="text" name="d_to_zipcode" id="r_zipcode" style="width:80px;" readonly></span><button type="button" id="findAddrBtn2" class="btnTypeBasic"><span>주소찾기</span></button>
								<button type="button"  onclick="window.open('/m/m02/lately.do','최근배송정보','width=700, height=570, menubar=no, status=no, toolbar=no');" class="btnTypeBasic colorDGreen"><span>최근배송정보</span></button>
								<!-- <button type="button"  onclick="window.open('/m/m03/lately.do','최근배송정보','width=700, height=570, menubar=no, status=no, toolbar=no');" class="btnTypeBasic colorDGreen"><span>최근배송정보</span></button> -->
								<input type="text" name="d_to_address01" style="width:100%;" readonly id="r_address01">
								<input type="text" name="d_to_address02" style="width:100%;" id="r_address02"> 
							</div>
						</li>
					</ul>
				</div>
				<!-- //받는 사람 -->
				<!-- 결제 정보 -->
				<div class="orderTotal">
					<p class="tit04">결제정보</p>
					<ul class="tlist">
						<li>
							<label class="title">처방비용</label>
							<p><strong id="show_total"><fmt:formatNumber value="${view.price}" pattern="#,###" /></strong>원</p>
						</li>
						<li>
							<label class="title">할인금액(-)</label>
							<p><strong>- <span  id="show_sale"><fmt:formatNumber value="${view.sale_price}" pattern="#,###" /></span></strong>원</p>
						</li>
					</ul>				
				</div>
				<ul class="totalarea">
					<li>
						<label class="title">총 결제금액</label>
						<p><strong id="show_all"><fmt:formatNumber value="${view.price - view.sale_price}" pattern="#,###" /></strong>원</p>
					</li>
				</ul>
				<!-- //결제 정보 -->
				<!-- 결제수단 -->
				<div class="paybox">
					<p class="tit01">결제수단</p>
					<div class="btnArea write pay_type_select" >
						<button type="button"  class="btnTypeBasic colorWhite"><span>신용카드</span></button>
						<button type="button"  class="btnTypeBasic colorWhite"><span>무통장입금</span></button>
					</div>
					<!-- colorWhite colorGreen-->
					<!-- 세금계산서 선택시 -->
					<div class="inner boxA" style="display: none;">
						<div class="selA" >
							<input type="radio" id="bill_part1" name="bill_part" value="1" /><label for="bill_part1">세금계산서</label>
							<input type="radio" id="bill_part2" name="bill_part" value="2" /><label for="bill_part2">현금영수증</label>
							<input type="radio" id="bill_part3" name="bill_part" value="3" checked="checked" /><label for="bill_part3">미신청</label>
						</div>
						
						<div class="addInfo addInfo1" style="display: none;">
							<label class="tit">이메일</label>
							<div><input type="text" name="bill_email" id="bill_email"  value="${userInfo.email}" style="width:50%;" /></div>
						</div>
						<c:set var="han_handphone" value="${fn:split(userInfo.handphone,'-')}" />
						
						<div class="addInfo addInfo2" style="display: none;">
							<select name="cash_receipts" id="cash_receipts"  style="width:100%;margin-bottom:1rem;">
								<option value="소득공제용" selected="selected">소득공제용</option>
								<option value="지출증빙용">지출증빙용</option>
							</select>
							<label class="tit">휴대폰 번호</label>
							<div>
								<input type="text" id="bill_handphone01" name="bill_handphone01" style="width:65px;" maxlength="4" value="${han_handphone[0]}" > -
								<input type="text" id="bill_handphone02" name="bill_handphone02" style="width:65px;" maxlength="4" value="${han_handphone[1]}" > -
								<input type="text" id="bill_handphone03" name="bill_handphone03" style="width:65px;" maxlength="4" value="${han_handphone[2]}" >
							</div>
						</div>
					</div>
					
				</div>
				<!-- //결제수단 -->
			</div>			
			<!-- //view -->
			
			<div class="btnArea">
				<c:if test="${userInfo.member_level ne 0 && userInfo.member_level ne 1 }">
					<button type="button" id="orderYakBtn" class="btnTypeSearch sizeL colorBlue"><span>주문하기</span></button>
				</c:if>
			</div>
		</div>
		<script>
			$(document).ready(function() {
				
				
				$('input[name="bill_part"]').change(function() {
					var bill = $(this).val();
					$('.addInfo').hide();
					$('.addInfo'+bill).show();
				});
				
				
				$("#bill_handphone01,#bill_handphone02,#bill_handphone03,#r_handphone01,#r_handphone02,#r_handphone03,#o_handphone01,#o_handphone02,#o_handphone03").on("keyup", function() {
				    $(this).val($(this).val().replace(/[^0-9]/g,""));
				}).on("focusout", function() {
				    var x = $(this).val();
				    if(x && x.length > 0) {
				        if(!$.isNumeric(x)) {
				            x = x.replace(/[^0-9]/g,"");
				        }
				        $(this).val(x);
				    }
				}).on("focus", function() {
					var x = $(this).val();
				    if(x && x.length > 0) {
				        if(!$.isNumeric(x)) {
				            x = x.replace(/[^0-9]/g,"");
				        }
				        $(this).val(x);
				    }
				});
				
				$("#orderYakBtn").click(function() {
					if(!valCheck( 'o_name' ,'발신인을 입력하세요.') ) return false;
					
					if(!valCheck( 'o_tel01' ,'연락처를 입력하세요.') ) return false;
					if(!valCheck( 'o_tel02' ,'연락처를 입력하세요.') ) return false;
					if(!valCheck( 'o_tel03' ,'연락처를 입력하세요.') ) return false;
					
					
					if(!valCheck( 'o_zipcode' ,'주소를 입력하세요.') ) return false;
					if(!valCheck( 'o_address01' ,'주소를 입력하세요.') ) return false;
					
					
					if(!valCheck( 'r_name' ,'수신인을 입력하세요.') ) return false;
					if(!valCheck( 'r_tel01' ,'연락처를 입력하세요.') ) return false;
					if(!valCheck( 'r_tel02' ,'연락처를 입력하세요.') ) return false;
					if(!valCheck( 'r_tel03' ,'연락처를 입력하세요.') ) return false;
					
					
					if(!valCheck( 'r_zipcode' ,'주소를 입력하세요.') ) return false;
					if(!valCheck( 'r_address01' ,'주소를 입력하세요.') ) return false;
					
					var payment_kind = objToStr($('#payment_kind').val() , '');
					
					if(payment_kind == ''){
						alert('결제 방법을 선택하세요.');
						return false;
					}
					
					if(payment_kind == 'Bank'){
						var bill_part = $(":input:radio[name=bill_part]:checked").val();
						if(bill_part == 1){
							if(!valCheck( 'bill_email' ,'이메일을 입력하세요.') ) return false;
						}
						
						if(bill_part == 2){
						//	if(!valCheck( 'bill_name' ,'이름을 입력하세요.') ) return false;
							if(!valCheck( 'bill_handphone01' ,'휴대전화 번호를 입력하세요.') ) return false;
							if(!valCheck( 'bill_handphone02' ,'휴대전화 번호를 입력하세요.') ) return false;
							if(!valCheck( 'bill_handphone03' ,'휴대전화 번호를 입력하세요.') ) return false;
						}
						
						if(confirm('해당정보로 주문하겠습니까?')){
							$('#frm').attr('accept-charset', 'utf-8');
							$('#frm').attr('action', '/m/m02/06_com_order.do');
							$('#frm').submit();
						}
					}
					
					if(payment_kind == 'Card'){						
						var url = $(this).attr('href');
						try{
							$.fancybox({
								'width'         : $( window ).width()+'px',
								'height'        : $( window ).height()+'px',
								'href'			: "06_add_order_iframe.do?"+$('#frm').serialize(),
								'padding'		: '0',
								'margin'	    : 0,
								'transitionIn'	:	'elastic',
								'transitionOut'	:	'elastic',
								'type' 			: 	'iframe',
						//		'type' 			: 	'ajax',
								'scrolling'     : 'no',
								closeClick      : true
								/* ,afterClose  : function() { 
						            window.location.reload();
						        } */
							});
							return false;
						}catch (e) {
							console.log(e);
							return false;
						}
						return false;
					}
					return false;
				});
				
				$(".pay_type_select button").click(function() {
					
					//cw cg
					$('.pay_type_select button').removeClass('colorGreen');							
					$('.pay_type_select button').removeClass('colorWhite');
					
					$('.pay_type_select button').addClass('colorWhite');
					
					$(this).removeClass('colorWhite');
					$(this).addClass('colorGreen');
					
					var type = $(this).html();
					
					if(type == '<span>신용카드</span>'){
						$('.boxA').hide();
						$('#payment_kind').val('Card');
					}else{
						$('.boxA').show();
						$('#payment_kind').val('Bank');
					}
					
					return false;
				});
				
				$("#findAddrBtn1").click(function() {
					find_addr('o_zipcode','o_address01', 'o_address02');
					return false;
				});
				
				$("#findAddrBtn2").click(function() {
					find_addr('r_zipcode','r_address01', 'r_address02');
					return false;
				});
				
				$("#ship_type_from").change(function(){
					
					settingOrderAddr('o', $(this).val())
					if($(this).val() == 3){
						settingOrderAddr('o', 2);
						settingOrderAddr('r', 3);
					}else if($(this).val() == 1){
						settingOrderAddr('o', 1);
						settingOrderAddr('r', 2);
					}else if($(this).val() == 4){
						settingOrderAddr('o', 1);
						settingOrderAddr('r', 3);
					}else if($(this).val() == 6){
						settingOrderAddr('o', 3);
						settingOrderAddr('r', 3);
					}else if($(this).val() == 7){
						settingOrderAddr('o', 1);
						//settingOrderAddr('r', 1);
						settingOrderAddr('r', 2);
					}
				});
				
				/* 
				settingOrderAddr('o', 2);
				 */
				settingOrderAddr('o', 1);
				settingOrderAddr('r', 2);
			});
			
				 
			function settingOrderAddr(type , val){
				
				var han_name  = $('#han_han_name').val();
				var user_name = $('#user_name').val();
				if(han_name == '' || han_name == null  || han_name == undefined){
					han_name = user_name;
				}
				
				if(val == 1){
					$('#'+type+'_name').val(a_tang_name);
					$('#'+type+'_tel01').val(a_tel1);
					$('#'+type+'_tel02').val(a_tel2);
					$('#'+type+'_tel03').val(a_tel3);
					$('#'+type+'_zipcode').val(a_zip);
					$('#'+type+'_address01').val(a_addr1);
					$('#'+type+'_address02').val(a_addr2);
				}else if(val == 2){
					$('#'+type+'_name').val(han_name);
					$('#'+type+'_tel01').val($('#han_handphone01').val());
					$('#'+type+'_tel02').val($('#han_handphone02').val());
					$('#'+type+'_tel03').val($('#han_handphone03').val());
					
					$('#'+type+'_zipcode').val($('#han_zip').val());
					$('#'+type+'_address01').val($('#han_addr1').val());
					$('#'+type+'_address02').val($('#han_addr2').val());
				}else{
					$('#'+type+'_name').val('');
					$('#'+type+'_tel01').val('');
					$('#'+type+'_tel02').val('');
					$('#'+type+'_tel03').val('');
					$('#'+type+'_zipcode').val('');
					$('#'+type+'_address01').val('');
					$('#'+type+'_address02').val('');
					$('#'+type+'_name').focus();
				}
				
			}
		</script>
		
		<!--  all_seqno ${bean.all_seqno}-->
		<!-- //btnarea -->
		<input type="hidden" name="payment_kind" id="payment_kind" value=""/>
		
		<c:set var="tel" value="${fn:split(userInfo.han_tel,'-')}" />
		<input type="hidden" id="han_addr1" 	 name="han_addr1"	value="${userInfo.address01}" />
		<input type="hidden" id="han_addr2" 	 name="han_addr2"	value="${userInfo.address02}" />
		<input type="hidden" id="han_zip"   	 name="han_zip"	value="${userInfo.zipcode}" />
		<input type="hidden" id="han_handphone01"  name="han_handphone01"  value="${han_handphone[0]}">
		<input type="hidden" id="han_handphone02"  name="han_handphone02" value="${han_handphone[1]}"> 
		<input type="hidden" id="han_handphone03"  name="han_handphone03"  value="${han_handphone[2]}"> 
		<input type="hidden" id="han_han_name"     value="${userInfo.han_name}" name="han_han_name" />
		<input type="hidden" id="han_name"     value="${userInfo.han_name}" name="han_name" />
		<input type="hidden" id="user_name"     value="${userInfo.name}" name="name" />
				
		
		<input type="hidden" id="han_tel01" name="han_tel01"  value="${tel[0]}">
		<input type="hidden" id="han_tel02" name="han_tel02"   value="${tel[1]}"> 
		<input type="hidden" id="han_tel03" name="han_tel03"   value="${tel[2]}"> 
		
		
		<input type="hidden" name="seqno"   value="${view.seqno}">
		<input type="hidden" name="page"   value="${bean.page}">
		
		<input type="hidden" name="ship_type_to"   value="3">

		<input type="hidden" id="sale_per"   name="sale_per"   value="${view.sale_per}">
		<%-- <input type="hidden" id="Amt"		 name="Amt"        value="<%=Amt %>" /> --%>
		<input type="hidden" id="sale_price" name="sale_price" value="${view.sale_price}" />
		<input type="hidden" id="order_type" name="order_type" value="2" />
		
		
		<div id="nice_pay_setting_area"  style="display: none;">
			<input type="text" name="PayMethod"   value="CARD">
			<input type="text" name="GoodsName"   value="<%=goodsName%>"> <!-- 상품명 -->
			<input type="text" name="GoodsCnt"    value="<%=goodsCnt%>"> <!-- 상품겟수 -->
			<input type="text" name="Amt"         value="${view.Amt }"> <!-- 결제금액 -->
			<input type="text" name="BuyerName"   value="${userInfo.name}">
			<input type="text" name="BuyerTel"    value="${userInfo.handphone}">
			<input type="text" name="Moid"        value="<%=moid%>">
			<input type="text" name="MID"         value="<%=MID%>">
			
			<!-- IP -->
	        <input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>"/>      <!-- 상점서버IP -->
	                          
	          <!-- 옵션 -->
		  	<input type="hidden" name="CharSet"    value="<%=charset%>"/>                   <!-- 인코딩 설정 -->               
	        <input type="hidden" name="BuyerEmail" value="${userInfo.email}"/>             <!-- 구매자 이메일 -->				  
	        <input type="hidden" name="GoodsCl"    value="1"/>                              <!-- 상품구분(실물(1),컨텐츠(0)) -->
	        <input type="hidden" name="TransType"  value="0"/>                            <!-- 일반(0)/에스크로(1) -->
	        <input type="hidden" name="ReturnURL" id="ReturnURL" value="<%=returnURL%>">  
	            
	        <!-- 변경 불가능 -->
	        <input type="hidden" name="EdiDate" value="<%=ediDate%>"/>                   <!-- 전문 생성일시 -->
	        <input type="hidden" name="EncryptData" value="<%=encryptData%>"/>            <!-- 해쉬값	-->
	        <input type="hidden" name="TrKey" value=""/>
	        <input type="hidden" name="AcsNoIframe" value="Y"/>
		</div>
		
	</form>
	<!-- //본문 -->
</div>
<!-- //container -->
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