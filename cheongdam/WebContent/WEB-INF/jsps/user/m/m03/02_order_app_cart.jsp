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
<style>
	.point_area{
		margin: 2px 0 15px 10px;
	    font-size: 22px;
	    line-height: 33px;
	    font-weight: bold;
	    color: #000;					    
	}
	.point_area .text_title{
		font-weight: 700;
	} 
	
	.point_area .my_point{
		margin-top : 10px;
		font-size: 15px;										
	}
	
	.point_area .my_point .left{		
		line-height: 46px;
		margin-right: 15px;
	}
	.point_area .my_point .left{
		line-height: 46px;
	}
	
	.point_area .my_point .box__inner{
		position: relative;
	    display: inline-block;
	    vertical-align: top;
	    min-width: 320px;
	}
	
	.point_area .my_point .box__inner .form__box{
	    position: relative;
	    display: inline-block;
	    width: 170px;
	    height: 46px;
	    padding: 0 24px 0 5px;
	    font-size: 15px;
	    color: #000;
	    border: 1px solid #e0e0e0;
	    box-sizing: border-box;
	    vertical-align: top;
	    background-color: white;
	}
	
	.point_area .my_point .box__inner .form__box .input_txt{
		width: 100%;
	    height: 44px;
	    line-height: 44px;
	    background: transparent;
	    border: none;
	    text-align: right;
	    color: #000;
	    font-size: 15px;
	    
	    /* 
	    background: white;
	    border: 1px solid #dddddd;
	     */ 
	}
	
	.point_area .my_point .box__inner .form__box .text_unit{
		    position: absolute;
		    top: 5px;
		    right: 5px;
		    color: #000;
	}
	
	.point_area .my_point .box__inner .point_used{
		    display: inline-block;
		    margin-left: 3px;
		    width: 90px;
		    line-height: 44px;
		    font-size: 14px;
		    border: 1px solid #999;
		    vertical-align: top;
	}
	
	.point_area .my_point .text_cash{
		position: relative;
		font-weight: bold;
	}
</style>
<%
	/*
	*******************************************************
	* <???????????? ????????????>
	* ????????? Form ??? ????????? ???????????? ?????????????????????.
	* ???????????????????????? ??????(??????) ??????????????? ???????????? ?????????, 
	* ?????? ????????? ?????? ??????????????? ?????????????????? ???????????????.
	* POST??? ?????? / ????????? EUC-KR / ?????? ?????? ?????? ?????? ????????? ??????
	*******************************************************
	*/
	String encodeKey		= Const.NP_encodeKey; // ?????????
	String MID       		= Const.NP_MID;                   // ???????????????
	//String moid             = Const.NP_moid;              // ??????????????????
	
	Map<String, Object> bean = (Map<String, Object>)request.getAttribute("bean");
	
	
	String goodsCnt         = bean.get("goods_cnt")+"";                         // ??????????????????
	String goodsName        = bean.get("goods_name")+"";                      // ???????????????
	String Amt            	= (bean.get("goods_tot")+"").replace(".0", "");         // ??????????????????
	
	
	/* int sale_per            = StringUtil.ObjectToInt(bean.get("sale_per"));
	
	
	int sale_price =  (StringUtil.ObjectToInt(Amt) * sale_per) / 100;
	
	System.out.println("?????????      = "+ Amt);
	System.out.println("??????????????? = "+ sale_per);
	System.out.println("????????????   = "+ sale_price);		
	String tot_price = (Amt-sale_price)+""; */
	
	System.out.println("????????????   = "+ (Amt));
	
	
	/* String moid             = Const.NP_moid+"y"+(String.format("%08d", StringUtil.ObjectToInt(bean.get("goods_seq"))));              // ?????????????????? */      
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	String moid             = Const.NP_moid+"y"+(String.format("%08d", StringUtil.ObjectToInt(bean.get("goods_seq"))))+"_"+sdf.format(today);              // ??????????????????
	System.out.println("moid   = "+ (moid));
	String charset          = "utf-8";
	
	/*
	*******************************************************
	* <???????????????> (???????????? ?????????)
	* SHA-256 ?????????????????? ?????? ???????????? ???????????? ???????????????. 
	*******************************************************
	*/
	DataEncrypt sha256Enc 	  = new DataEncrypt();
	String ediDate      	  = getyyyyMMddHHmmss();	
	String encryptData    	  = sha256Enc.encrypt(ediDate + MID + Amt + encodeKey);
	System.out.println("???????????? = "+ encryptData);
	/*
	******************************************************* 
	* <?????? IP???>
	*******************************************************
	*/
	InetAddress inet        = InetAddress.getLocalHost();	
	
	
	//String returnURL        = "http://m.cdherb.com/m/m03/personal_com.do?seqno="+view.get("seqno");
	
	String returnURL        = "http://"+Const.M_DOMAIN_NM+"/m/m03/02_order_com_cart_card.do?itype=cart";
%>
<!-- container -->
<style>
.fancybox-close{
	display: none;
}
</style>
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">???????????? ?????????</p>
		<div class="lnbDepth">
			<ul>
				<li><a href="01.do">????????????</a></li>
				<li class="sel"><a href="02.do">???????????? ?????????</a></li>
				<li><a href="03.do">?????????????????????</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- ?????? -->
	<form action="#" name="frm" id="frm">
	<!-- <form name="payForm" id="payForm" method="post" target="_self" action="https://web.nicepay.co.kr/v3/smart/smartPayment.jsp" accept-charset="euc-kr"> -->
		<div class="contents" id="contents">
			<!-- view -->
			<div class="orderview">				
				<!-- ?????? ???????????? -->
				<div class="orderDetail">
					<c:set var="sum_goods_tot"    value = "0" />
					<c:set var="sum_delivery_tot" value = "${bean.sum_delivery_tot}" />
					
					<c:forEach var="list" items="${list}">
						<c:set var="sum_goods_tot" value = "${sum_goods_tot + list.goods_tot}" />
						<div class="detailList">
							<div class="Dtit">
								<img src="/upload/goods/${list.image}" width="50px" height="50px"  alt="${list.p_name }" /> <p>${list.goods_name }</p>
							</div>
							<c:if test="${list.box_option_seqno ne 0 && list.box_option_seqno ne null}">
								<ul class="op">
									<li>- ?????? : ${list.box_option_nm }(+<fmt:formatNumber value="${list.box_option_price}" pattern="#,###" />)</li>
								</ul>
							</c:if>
							<ul class="info">
								<li>
									<label class="title">????????????</label>
									<p><strong><fmt:formatNumber value="${list.p_price}" pattern="#,###" /></strong>???</p>
								</li>
								<li>
									<label class="title">??????</label>
									<p><strong><fmt:formatNumber value="${list.ea}" pattern="#,###" /></strong></p>
								</li>
								<li>
									<label class="title">????????????</label>
									<p><strong><fmt:formatNumber value="${list.goods_tot}" pattern="#,###" /></strong>???</p>
								</li>
							</ul>
						</div>
					</c:forEach>
				</div>
				<%-- <c:if test="${sum_goods_tot > 100000 }"><c:set var="sum_delivery_tot" value = "0" /></c:if> --%>
				<c:if test="${sum_goods_tot > bean.freeDeileveryLimit }"><c:set var="sum_delivery_tot" value = "0" /></c:if>
				
				<!-- //?????? ???????????? -->
				<div class="delivery">
					<label>???????????? ??????</label>
					<select name="ship_type_from" id="ship_type_from"  style="width:65%;">
						<option value="1">????????? - ??????</option>
						<option value="2">?????????????????? -> ?????????</option>
						<option value="3">?????????????????? - ??????</option>
						<option value="4">????????????</option>
						<!-- <option value="5">????????????</option> -->
					</select>
				</div>
				<!-- ????????? ?????? -->
				<div class="Listbox mt10">
					<p class="tit02">????????? ??????</p>
					<ul>
						<li class="type02">
							<label class="title" for="o_name">?????????</label>
							<div><input type="text" name="o_name" id="o_name"></div>
						</li>
						<li class="type02">
							<label class="title" for="o_tel01">?????????1</label>
							<div>
								<input type="text" id="o_tel01" name="o_tel01" style="width:65px;" maxlength="4"> -
								<input type="text" id="o_tel02" name="o_tel02" style="width:65px;" maxlength="4"> -
								<input type="text" id="o_tel03" name="o_tel03" style="width:65px;" maxlength="4">
							</div>
						</li>
						<li class="type02">
							<label class="title" for="o_handphone01">?????????2</label>
							<div>
								<input type="text" id="o_handphone01" name="o_handphone01" style="width:65px;" maxlength="4"> -
								<input type="text" id="o_handphone02" name="o_handphone02" style="width:65px;" maxlength="4"> -
								<input type="text" id="o_handphone03" name="o_handphone03" style="width:65px;" maxlength="4">
							</div>
						</li>
						<li class="type02 address">
							<label class="title" for="findAddrBtn1">??????</label>
							<div>
								<span><input type="text" name="o_zipcode" id="o_zipcode" style="width:80px;" readonly></span><button type="button" id="findAddrBtn1" class="btnTypeBasic"><span>????????????</span></button>
								<input type="text" name="o_address01" style="width:100%;" readonly id="o_address01">
								<input type="text" name="o_address02" style="width:100%;" id="o_address02"> 
							</div>
						</li>
					</ul>
				</div>
				<!-- //????????? ?????? -->
				<!-- ?????? ?????? -->
				<div class="Listbox">
					<p class="tit03">?????? ??????</p>
					<ul>
						<li class="type02">
							<label class="title" for="r_name">?????????</label>
							<div><input type="text" name="r_name" id="r_name"></div>
						</li>
						<li class="type02">
							<label class="title" for="r_tel01">?????????1</label>
							<div>
								<input type="text" id="r_tel01" name="r_tel01" style="width:65px;" maxlength="4"> -
								<input type="text" id="r_tel02" name="r_tel02" style="width:65px;" maxlength="4"> -
								<input type="text" id="r_tel03" name="r_tel03" style="width:65px;" maxlength="4">
							</div>
						</li>
						<li class="type02">
							<label class="title" for="r_handphone01">?????????2</label>
							<div>
								<input type="text" id="r_handphone01" name="r_handphone01" style="width:65px;" maxlength="4"> -
								<input type="text" id="r_handphone02" name="r_handphone02" style="width:65px;" maxlength="4"> -
								<input type="text" id="r_handphone03" name="r_handphone03" style="width:65px;" maxlength="4">
							</div>
						</li>
						<li class="type02 address">
							<label class="title" for="findAddrBtn2">??????</label>
							<div>
								<span><input type="text" name="r_zipcode" id="r_zipcode" style="width:80px;" readonly></span><button type="button" id="findAddrBtn2" class="btnTypeBasic"><span>????????????</span></button>
								<button type="button"  onclick="window.open('/m/m03/lately.do','??????????????????','width=700, height=570, menubar=no, status=no, toolbar=no');" class="btnTypeBasic colorDGreen"><span>??????????????????</span></button>
								<input type="text" name="r_address01" style="width:100%;" readonly id="r_address01">
								<input type="text" name="r_address02" style="width:100%;" id="r_address02"> 
							</div>
						</li>
						<li class="type02">
							<label class="title" for="o_memo">????????????</label>
							<div><input type="text" id="o_memo" name="o_memo"></div>
						</li>
						<li class="type02">
							<label class="title mt20" for="o_memo2">?????????<br/>????????????</label>
							<div><textarea name="o_memo2" id="o_memo2" style="width:100%; height:100px;resize:none;"></textarea></div>
						</li>
					</ul>
				</div>
				<script>
					var a_pre_ship_type_from = $('input[name="ship_type_from"]:checked').val();
					var a_all_price = 0;
					
					function resetPoint(){
						 var use_point_focusout  = parseInt($('#use_point_focusout').val());
						 var tot_price           = parseInt($('#tot_price').val());
						 
						 $('#use_point').val(0);	
						 $('#use_point_temp').val(0);
						 $('#show_point').text( 0 );
						 $('#use_point_focusout').val(0);
						 
						 
						 $('#use_point_tr').hide();
						 $('#point_all').show();
						 $('#point_cancel').hide();
						 
						 
						 $('.pay_type_select a span').removeClass('cw');							
						 $('.pay_type_select a span').addClass('cw');
						 
						 $('#pre_paybtn_area').show();
						 $('#pointbtn_area').hide();
						 $('#show_all').html( comma(a_all_price) );
					}
				
					$(document).ready(function() {
						a_all_price = $('#tot_price').val();
						
						$("#use_point_temp").keydown(function(e) {
							 var  price = $(this).val();
							 price = price.replaceAll(/\D/g, "");
							 $(this).val(comma(price));	
							 $('#use_point').val(price);
						  });
						 $("#use_point_temp").keypress(function(){
							 var  price = $(this).val();
							 price = price.replaceAll(/\D/g, "");
							 $(this).val(comma(price));
							 $('#use_point').val(price);
						  });
						 $("#use_point_temp").keyup(function(){
							 var  price = $(this).val();
							 price = price.replaceAll(/\D/g, "");
							 $(this).val(comma(price));
							 $('#use_point').val(price);
						  });
						 
						 
						 $("#use_point_temp").focusout(function(){
							var use_point_temp      = $(this).val();
							var use_point           = parseInt($('#use_point').val());
							var tot_point 		    = parseInt($('#tot_point').val());
							var tot_price           = parseInt($('#tot_price').val());
							var use_point_focusout  = parseInt($('#use_point_focusout').val());
							
							
							if(use_point > tot_point  ){
								if(use_point_focusout  == 0){
									$('#use_point').val(0);	
									$('#use_point_temp').val(0);
								}else{
									$('#use_point').val(use_point_focusout);	
									$('#use_point_temp').val(use_point_focusout);
								}
								alert('????????? ????????? ????????? ???????????????.' );
								return;
							}
							/* 
							point_all
							point_cancel
							 */
						   console.log('use_point = ', use_point);
						   console.log('tot_price = ', tot_price);
							 
							if(use_point >= tot_price){
								use_point_temp = tot_price;
								use_point      = tot_price;
								
								
								$('#use_point').val(use_point);
								$('#use_point_temp').val(comma(use_point));
								
								$('#btn_point').removeClass('colorWhite');
								$('#btn_point').addClass('colorGreen');
								 
								$('#pre_paybtn_area').hide();
								$('#pointbtn_area').show();
								 
								$('.boxA').hide();
								$('#payment_kind').val('Point');
							}
							else if(use_point > 0 && use_point < tot_price){
								$('.pay_type_select a span').removeClass('cw');							
								$('.pay_type_select a span').addClass('cw');
								 
								$('#pre_paybtn_area').show();
								$('#pointbtn_area').hide();
								$('#payment_kind').val('');
							}
									
							 
							 
							$('#show_point').text( comma(use_point_temp) );
							$('#use_point_tr').show();
							$('#use_point_focusout').val(use_point);
							
							
							if( use_point > 0 ){
								$('#point_all').hide();
								$('#point_cancel').show();	
								$('#show_all').html( comma(a_all_price -use_point) );
							}else{
								$('#show_all').html( comma(a_all_price) );
							}
							
						 });
						 
	
						 
						 $("#point_cancel").click(function(){
							 console.log('point_cancel');
							 
							 resetPoint();
						 });
						 
						 
						 $("#point_all").click(function(){
							 var tot_price          = parseInt($('#tot_price').val());
							 var tot_point 		    = parseInt($('#tot_point').val());
							 
							 var use_point = 0;
							 
							 if(tot_point <= 0){
								 return;
							 }
							 
							 if(tot_point >= tot_price){
								 use_point = tot_price;
								 
								 
								 $('.pay_type_select button').removeClass('colorGreen');							
								 $('.pay_type_select button').removeClass('colorWhite');
								 $('.pay_type_select button').addClass('colorWhite');
								 
								 
								 
								 $('#btn_point').removeClass('colorWhite');
								 $('#btn_point').addClass('colorGreen');
								 
								 $('#pre_paybtn_area').hide();
								 $('#pointbtn_area').show();
								 
								 $('.boxA').hide();
								 
								 $('#payment_kind').val('Point');
							 }else{
								 use_point = tot_point;
							 }
							 
							 $('#use_point_temp').val(comma(use_point));
							 $('#use_point').val(use_point);
							 
							 //$('#tot_price').val(tot_price -use_point );
							 $('#show_point').text(comma( use_point ));
							 $('#use_point_tr').show();
							 
							 $('#use_point_focusout').val(use_point);		
							 $('#point_all').hide();
							 $('#point_cancel').show();
							 		 
							 $('#show_all').html( comma(a_all_price - use_point) );
						 });
					});
				</script>
				<div class="orderTotal">
					<p class="tit04">????????? ??????</p>
					<div class="point_area">
						<!-- <div class="text_title">????????? ??????</div> -->
						<div class="my_point">
							<div class="left">
								<em class="bgy" style="width: 100px;">?????? ?????????</em>
								<span class="text_cash" style="color: blue;font-weight: 700;"><fmt:formatNumber value="${member_point.tot_point}" pattern="#,###" /></span>
							</div>
							<div class="right">
								<div class="box__inner">
									<div class="form__box">
										<input type="text" class="input_txt" name="use_point_temp" id="use_point_temp" data-montelena-acode="100003099" placeholder="0" />
										<span class="text_unit">???</span>																
									</div>
									<button type="button" class="point_used" id="point_all">????????????</button>
									
									<button type="button" class="point_used" id="point_cancel" style="display: none;" >????????????</button>
								</div>
							</div>
							
							<div style="clear: both;"></div>					 				
						</div>
					</div>
				</div>
				
				<!-- //?????? ?????? -->
				<!-- ?????? ?????? -->
				<div class="orderTotal">
					<p class="tit04">????????????</p>
					<ul class="tlist">
						<li>
							<label class="title">???????????? ??????</label>
							<p><strong id="show_total"><fmt:formatNumber value="${sum_goods_tot}" pattern="#,###" /></strong>???</p>
						</li>
						<li>
							<label class="title">?????????(+)</label>
							<p><strong>+ <span  id="show_del"><fmt:formatNumber value="${sum_delivery_tot}" pattern="#,###" /></span></strong>???</p>
						</li>
						<li>
							<em class="bluetxt02">* <fmt:formatNumber value="${bean.freeDeileveryLimit }" pattern="#,###" />??? ?????? ????????? ?????? ????????? ???????????????.</em>
						</li>
						<li style="display: none;" id="use_point_tr">
							<label class="title">???????????????(-)</label>
							<p><strong>- <span  id="show_point"></span></strong>???</p>
						</li>
						<li>
							<label class="title">????????????(-)</label>
							<p><strong>- <span  id="show_sale"><fmt:formatNumber value="${bean.sale_price}" pattern="#,###" /></span></strong>???</p>
						</li>
					</ul>				
				</div>
				<ul class="totalarea">
					<li>
						<label class="title">??? ????????????</label>
						<p><strong  id="show_all"><fmt:formatNumber value="${sum_goods_tot + sum_delivery_tot - bean.sale_price}" pattern="#,###" /></strong>???</p>
					</li>
				</ul>
				<!-- //?????? ?????? -->
				<!-- ???????????? -->
				<div class="paybox">
					<p class="tit01">????????????</p>
					<div class="btnArea write pay_type_select"  id="pre_paybtn_area">
						<button type="button"  class="btnTypeBasic colorWhite"><span>????????????</span></button>
						<button type="button"  class="btnTypeBasic colorWhite"><span>???????????????</span></button>
					</div>
					<div class="btnArea write pay_type_select" id="pointbtn_area" style="display: none;">
						<button type="button"  class="btnTypeBasic colorWhite" id="btn_point"><span>????????? ??????</span></button>
					</div>
					<!-- colorWhite colorGreen-->
					<!-- ??????????????? ????????? -->
					<div class="inner boxA" style="display: none;">
						<div class="selA" >
							<input type="radio" id="bill_part1" name="bill_part" value="1" /><label for="bill_part1">???????????????</label>
							<input type="radio" id="bill_part2" name="bill_part" value="2" /><label for="bill_part2">???????????????</label>
							<input type="radio" id="bill_part3" name="bill_part" value="3" checked="checked" /><label for="bill_part3">?????????</label>
						</div>
						
						<div class="addInfo addInfo1" style="display: none;">
							<label class="tit">?????????</label>
							<div><input type="text" name="bill_email" id="bill_email"  value="${userInfo.email}" style="width:50%;" /></div>
						</div>
						<c:set var="han_handphone" value="${fn:split(userInfo.handphone,'-')}" />
						
						<div class="addInfo addInfo2" style="display: none;">
							<select name="cash_receipts" id="cash_receipts"  style="width:100%;margin-bottom:1rem;">
								<option value="???????????????" selected="selected">???????????????</option>
								<option value="???????????????">???????????????</option>
							</select>
							<label class="tit">????????? ??????</label>
							<div>
								<input type="text" id="bill_handphone01" name="bill_handphone01" style="width:65px;" maxlength="4" value="${han_handphone[0]}" > -
								<input type="text" id="bill_handphone02" name="bill_handphone02" style="width:65px;" maxlength="4" value="${han_handphone[1]}" > -
								<input type="text" id="bill_handphone03" name="bill_handphone03" style="width:65px;" maxlength="4" value="${han_handphone[2]}" >
							</div>
						</div>
					</div>
					
				</div>
				<!-- //???????????? -->
			</div>			
			<!-- //view -->
			
			<div class="btnArea">
				<c:if test="${userInfo.member_level ne 0 && userInfo.member_level ne 1 }">
					<button type="button" id="orderYakBtn" class="btnTypeSearch sizeL colorBlue"><span>????????????</span></button>
				</c:if>
			</div>
		</div>
		<script>
		
			$(document).ready(function() {
				
				a_sale_per = parseInt( $('#sale_per').val() );
				
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
					if(!valCheck( 'o_name' ,'???????????? ???????????????.') ) return false;
					/* if(!valCheck( 'o_handphone01' ,'??????????????? ???????????????.') ) return false;
					if(!valCheck( 'o_handphone02' ,'??????????????? ???????????????.') ) return false;
					if(!valCheck( 'o_handphone03' ,'??????????????? ???????????????.') ) return false; */
					if(!valCheck( 'o_tel01' ,'???????????? ???????????????.') ) return false;
					if(!valCheck( 'o_tel02' ,'???????????? ???????????????.') ) return false;
					if(!valCheck( 'o_tel03' ,'???????????? ???????????????.') ) return false;
					
					if(!valCheck( 'o_zipcode' ,'????????? ???????????????.') ) return false;
					if(!valCheck( 'o_address01' ,'????????? ???????????????.') ) return false;
					
					
					if(!valCheck( 'r_name' ,'???????????? ???????????????.') ) return false;
					if(!valCheck( 'r_tel01' ,'???????????? ???????????????.') ) return false;
					if(!valCheck( 'r_tel02' ,'???????????? ???????????????.') ) return false;
					if(!valCheck( 'r_tel03' ,'???????????? ???????????????.') ) return false;
					/* if(!valCheck( 'r_handphone01' ,'??????????????? ???????????????.') ) return false;
					if(!valCheck( 'r_handphone02' ,'??????????????? ???????????????.') ) return false;
					if(!valCheck( 'r_handphone03' ,'??????????????? ???????????????.') ) return false; */
					if(!valCheck( 'r_zipcode' ,'????????? ???????????????.') ) return false;
					if(!valCheck( 'r_address01' ,'????????? ???????????????.') ) return false;
					
					var payment_kind = objToStr($('#payment_kind').val() , '');
					
					if(payment_kind == ''){
						alert('?????? ????????? ???????????????.');
						return false;
					}
					
					if(payment_kind == 'Bank'){
						var bill_part = $(":input:radio[name=bill_part]:checked").val();
						if(bill_part == 1){
							if(!valCheck( 'bill_email' ,'???????????? ???????????????.') ) return false;
						}
						
						if(bill_part == 2){
						//	if(!valCheck( 'bill_name' ,'????????? ???????????????.') ) return false;
							if(!valCheck( 'bill_handphone01' ,'???????????? ????????? ???????????????.') ) return false;
							if(!valCheck( 'bill_handphone02' ,'???????????? ????????? ???????????????.') ) return false;
							if(!valCheck( 'bill_handphone03' ,'???????????? ????????? ???????????????.') ) return false;
						}
						
						if(confirm('??????????????? ??????????????????????')){
							$('#frm').attr('accept-charset', 'utf-8');
							$('#frm').attr('action', '/m/m03/02_order_com_cart.do');
							$('#frm').submit();
						}
					}
										
					else if(payment_kind == 'Point'){
						
						var use_point          = $('#use_point').val();
						var use_point_focusout = $('#use_point_focusout').val();
						var tot_price          = $('#tot_price').val();
						
						if(use_point != tot_price){
							alert('????????? ????????? ????????? ????????? ???????????? ????????????.\n????????? ?????? ???????????????.');
							return false;						
						}else{
							if(confirm('??????????????? ??????????????????????')){
								$('#frm').attr('accept-charset', 'utf-8');
								$('#frm').attr('action', '/m/m03/02_order_com_cart.do');
								$('#frm').submit();
								return false;
							}
						}
					}
					else if(payment_kind == 'Card'){
						var url = $(this).attr('href');
						try{
							$.fancybox({
								'width'         : $( window ).width()+'px',
								'height'        : $( window ).height()+'px',
								'href'			: "02_order_app_cart_iframe.do?"+$('#frm').serialize(),
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
						}catch (e) {
							console.log(e);
							return false;
						}
						return false;
						
						<%-- 
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
						
						 --%>
					}else{
						alert('??????????????? ???????????? ???????????????.');
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
					
					if(type == '<span>????????????</span>'){
						$('.boxA').hide();
						$('#payment_kind').val('Card');
					}else if(type == '<span>????????? ??????</span>'){
						$('.boxA').hide();
						$('#payment_kind').val('Point');
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
				/* 
				$("input:radio[name=ship_type_to]").click(function(){
					settingOrderAddr('r', $(this).val())
				});
				 */
				//$("input:radio[name=ship_type_from]").click(function(){
				$("#ship_type_from").change(function(){
					//var base_delivery_price     = 4000;
					var base_delivery_price     = parseInt( $('#a_delivery_price').val());
					var delivery_price = parseInt( $('#delivery_price').val());
					
					
					
					settingOrderAddr('o', $(this).val())
					if($(this).val() == 1){
						settingOrderAddr('o', 2);
						settingOrderAddr('r', 3);
					}else if($(this).val() == 2){
						settingOrderAddr('o', 1);
						settingOrderAddr('r', 2);
					}else if($(this).val() == 3){
						settingOrderAddr('o', 1);
						settingOrderAddr('r', 3);
					}else if($(this).val() == 4){
						settingOrderAddr('o', 3);
						settingOrderAddr('r', 3);
					}else if($(this).val() == 5){
						settingOrderAddr('o', 1);
						//settingOrderAddr('r', 1);
						settingOrderAddr('r', 2);
					}
					
					var use_point_focusout = $('#use_point_focusout').val();
					if(use_point_focusout > 0){
						resetPoint();	
					}
					
					var sale_per      = parseInt( $('#sale_per').val() );
					var sum_goods_tot = parseInt( $('#sum_goods_tot').val() );							
					var show_del	  = parseInt( $('#show_del').val() );
					var show_sale     = parseInt( $('#show_sale').val() );
					var show_all      = parseInt( $('#show_all').val() );
					var freeDeileveryLimit      = parseInt( $('#freeDeileveryLimit').val() );
					
					if(sum_goods_tot >= freeDeileveryLimit){
						return;
					}
					
					if(delivery_price > 0 && $(this).val() == 5){
						var sale_good_price = sale_per / 100 * sum_goods_tot;
						var Amt             = sum_goods_tot - sale_good_price; // ????????????
						
						$('#show_del').html('0');
						$('#show_sale').html(comma(sale_good_price));
						$('#show_all').html(comma(Amt));
						
						$('#delivery_price').val(0);
						$('#Amt').val(Amt);
						$('#tot_price').val(Amt);
						$('#sale_price').val(sale_good_price);
					}else{
						var sale_good_price = sale_per / 100 * (sum_goods_tot + base_delivery_price);
						var Amt             = sum_goods_tot - sale_good_price + base_delivery_price; // ????????????
						
						$('#show_del').html(comma(base_delivery_price));
						$('#show_sale').html(comma(sale_good_price));
						$('#show_all').html(comma(Amt));
						
						$('#delivery_price').val(base_delivery_price);
						$('#Amt').val(Amt);
						$('#tot_price').val(Amt);
						$('#sale_price').val(sale_good_price);
					}
					a_all_price = $('#tot_price').val();
				});
				
				$("input:radio[name=ship_type_to]").click(function(){
					
				});
				
				//settingOrderAddr('r', 2);
				settingOrderAddr('o', 2);
			});
			
			//????????? ?????? ????????? ???????????????.
			function nicepayStart(){
			    document.charset = "euc-kr";
			    document.payForm.submit();
			}
				 
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
					$('#'+type+'_handphone01').val('');
					$('#'+type+'_handphone02').val('');
					$('#'+type+'_handphone03').val('');
					$('#'+type+'_zipcode').val(a_zip);
					$('#'+type+'_address01').val(a_addr1);
					$('#'+type+'_address02').val(a_addr2);
				}else if(val == 2){
					$('#'+type+'_name').val( han_name );
					$('#'+type+'_tel01').val($('#han_tel01').val());
					$('#'+type+'_tel02').val($('#han_tel02').val());
					$('#'+type+'_tel03').val($('#han_tel03').val());
					/* $('#'+type+'_handphone01').val($('#han_handphone01').val());
					$('#'+type+'_handphone02').val($('#han_handphone02').val());
					$('#'+type+'_handphone03').val($('#han_handphone03').val()); */
					$('#'+type+'_zipcode').val($('#han_zip').val());
					$('#'+type+'_address01').val($('#han_addr1').val());
					$('#'+type+'_address02').val($('#han_addr2').val());
				}else{
					$('#'+type+'_name').val('');
					$('#'+type+'_tel01').val('');
					$('#'+type+'_tel02').val('');
					$('#'+type+'_tel03').val('');
					$('#'+type+'_handphone01').val('');
					$('#'+type+'_handphone02').val('');
					$('#'+type+'_handphone03').val('');
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
		<input type="hidden" name="all_seqno" id="all_seqno" value="${bean.all_seqno}" />
		<input type="hidden" name="delivery_price" id="delivery_price" value="${sum_delivery_tot}" />
		<input type="hidden" name="ea" value="${ea}" />
		<fmt:parseNumber var="i_sum_goods_tot" type="number" value="${sum_goods_tot}" />

		<input type="hidden" name="tot_price" id="tot_price"  value="${i_sum_goods_tot + sum_delivery_tot - bean.sale_price}" /> <!-- ????????? -->
		
		
		<c:set var="tel" value="${fn:split(userInfo.han_tel,'-')}" />
		<input type="hidden" id="han_addr1" 	 name="han_addr1"	value="${userInfo.address01}" />
		<input type="hidden" id="han_addr2" 	 name="han_addr2"	value="${userInfo.address02}" />
		<input type="hidden" id="han_zip"   	 name="han_zip"	value="${userInfo.zipcode}" />
		<input type="hidden" id="han_handphone01"  name="han_handphone01"  value="${han_handphone[0]}">
		<input type="hidden" id="han_handphone02"  name="han_handphone02" value="${han_handphone[1]}"> 
		<input type="hidden" id="han_handphone03"  name="han_handphone03"  value="${han_handphone[2]}"> 
		<input type="hidden" id="han_han_name"     value="${userInfo.han_name}" name="han_han_name" />
		<input type="hidden" id="han_name"     value="${userInfo.han_name}" name="han_name" />
		<input type="hidden" id="user_name"     value="${userInfo.name}" name="user_name" />
		
		
		<input type="hidden" id="han_tel01" name="han_tel01"  value="${tel[0]}">
		<input type="hidden" id="han_tel02" name="han_tel02"   value="${tel[1]}"> 
		<input type="hidden" id="han_tel03" name="han_tel03"   value="${tel[2]}"> 
		
		
		<input type="hidden" name="p_seq"   value="${bean.p_seq}">
		<input type="hidden" name="page"   value="${bean.page}">
		
		<input type="hidden" name="box_option_seqno" value="${bean.box_option_seqno }"/>
		<input type="hidden" name="box_option_nm" value="${bean.box_option_nm }"/>
		<input type="hidden" name="box_option_price" value="${bean.box_option_price }"/>
		
		<input type="hidden" name="ship_type_to"   value="3">

		<input type="hidden" id="sale_per"  name="sale_per"  value="${bean.sale_per}">
		<input type="hidden" id="freeDeileveryLimit" name="freeDeileveryLimit" value="${bean.freeDeileveryLimit }" />
		<input type="hidden" id="sum_goods_tot" name="sum_goods_tot" value="${sum_goods_tot}" />
		<input type="hidden" id="Amt" name="Amt" value="<%=Amt %>" />
		<input type="hidden" id="sale_price" name="sale_price" value="${bean.sale_price}" />
		
		
		<input type="hidden"  name="a_delivery_price" id="a_delivery_price" value="${taekbaeInfo.box}"/>
		
		
		<!-- ?????? -->
		<input type="hidden"  name="use_point" id="use_point" value="0"/>
		<!-- ?????? -->
		<input type="hidden"  name="use_point_focusout" id="use_point_focusout" value="0"/>
		<!-- ??? -->
		<input type="hidden"  name="tot_point" id="tot_point" value="${member_point.tot_point}"/>
		<input type="hidden"  name="reason" id="reason" value="???????????? ???????????? ?????? ????????? ??????"/>
		
		
		<div id="nice_pay_setting_area"  style="display: none;">
			<input type="text" name="PayMethod"   value="CARD">
			<input type="text" name="GoodsName"   value="<%=goodsName%>"> <!-- ????????? -->
			<input type="text" name="GoodsCnt"    value="<%=goodsCnt%>"> <!-- ???????????? -->
			<input type="text" name="Amt"         value="${sum_goods_tot + sum_delivery_tot- bean.sale_price}"> <!-- ???????????? -->
			<input type="text" name="BuyerName"   value="${userInfo.name}">
			<input type="text" name="BuyerTel"    value="${userInfo.handphone}">
			<input type="text" name="Moid"        value="<%=moid%>">
			<input type="text" name="MID"         value="<%=MID%>">
			
			<!-- IP -->
	        <input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>"/>      <!-- ????????????IP -->
	                          
	          <!-- ?????? -->
		  	<input type="hidden" name="CharSet"    value="<%=charset%>"/>                   <!-- ????????? ?????? -->               
	        <input type="hidden" name="BuyerEmail" value="${userInfo.email}"/>             <!-- ????????? ????????? -->				  
	        <input type="hidden" name="GoodsCl"    value="1"/>                              <!-- ????????????(??????(1),?????????(0)) -->
	        <input type="hidden" name="TransType"  value="0"/>                            <!-- ??????(0)/????????????(1) -->
	        <input type="hidden" name="ReturnURL" id="ReturnURL" value="<%=returnURL%>">  
	            
	        <!-- ?????? ????????? -->
	        <input type="hidden" name="EdiDate" value="<%=ediDate%>"/>                   <!-- ?????? ???????????? -->
	        <input type="hidden" name="EncryptData" value="<%=encryptData%>"/>            <!-- ?????????	-->
	        <input type="hidden" name="TrKey" value=""/>
	        <input type="hidden" name="AcsNoIframe" value="Y"/>
		</div>
		
	</form>
	<!-- //?????? -->
</div>
<!-- //container -->
<%!
	public final synchronized String getyyyyMMddHHmmss(){
	    SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
	    return yyyyMMddHHmmss.format(new Date());
	}
	// SHA-256 ???????????? ?????????
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
				System.out.print("????????? ??????" + e.toString());
		    }
			return passACL;
		}
		
		public String encodeHex(byte [] b){
			char [] c = Hex.encodeHex(b);
			return new String(c);
		}
	}
%>