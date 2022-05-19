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
.fancybox-close{
	  display: none;  
}
</style>
<%
//PAYTKN1d2430b58c10eb726c8f7a4cda177801211cdf54a10c6933b63221299ed15a5e
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
	
	
	/* int sale_per            = StringUtil.ObjectToInt(bean.get("sale_per"));
	
	
	int sale_price =  (StringUtil.ObjectToInt(Amt) * sale_per) / 100;
	
	System.out.println("총가격      = "+ Amt);
	System.out.println("할인퍼센트 = "+ sale_per);
	System.out.println("할인가격   = "+ sale_price);		
	String tot_price = (Amt-sale_price)+""; */
	
	System.out.println("결제금액   01_add_order= "+ (Amt));
	System.out.println("결제금액   01_add_order= "+ (Amt));
	System.out.println("결제금액   01_add_order= "+ (Amt));
%>
	<!-- contents -->
	<div class="contents">

		<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>약속처방</span></p>
		<c:choose>
			<c:when test="${userSession.member_level eq  4}">
				<ul class="submenu w25">
					<li><a href="/m03/01.do" class="${bean.jungm_menu}">약속처방</a></li>
					<li><a href="/m99/01.do" class="${bean.ga_menu}">약속처방(가맹점)</a></li>
					<li><a href="/m03/02.do" class="">약속처방 보관함</a></li>
					<li><a href="/m03/03.do" class="">사전조제지시서 관리</a></li>
				</ul>
			</c:when>
			<c:otherwise>
				<ul class="submenu w33">
					<li><a href="01.do" class="sel">약속처방</a></li>
					<li><a href="02.do" class="">약속처방 보관함</a></li>
					<li><a href="03.do" class="">사전조제지시서 관리</a></li>
				</ul>
			</c:otherwise>
		</c:choose>

		<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
		<form action="01_com_order.do" name="frm" id="frm" method="post">
			
		<!-- 본문내용 -->
		<!-- orderview -->
		<table class="order_view mb30">
			<colgroup>
				<col width="*" />
				<col width="130px" />
				<col width="90px" />
				<col width="150px" />
			</colgroup>
			<thead>
				<tr>
					<th>상품정보</th>
					<th>상품단가</th>
					<th>수량</th>
					<th>합계</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="sum_goods_tot"    value = "0" />
				<c:set var="sum_delivery_tot" value = "${bean.sum_delivery_tot}" />
				<c:set var="ea"    value = "0" />
				
				<c:forEach var="list" items="${list}">
					<c:set var="sum_goods_tot" value = "${sum_goods_tot + list.goods_tot}" />
					<c:set var="ea"    value ="${list.ea}" />
					<tr>
						<td class="L">
							<p class="img"><img src="/upload/goods/${list.image}" style="width: 60px;height: 60px;"  class="am" alt="${list.p_name }" /></p>
							<div class="name">${list.p_name }
								<c:if test="${list.box_option_seqno ne 0 && list.box_option_seqno ne null}">
									<p class="opttxt">
										- 옵션 : ${list.box_option_nm }(+<fmt:formatNumber value="${list.box_option_price}" pattern="#,###" />)
									</p>
								</c:if>	
							</div>
						</td>	
						<td class="R"><strong><fmt:formatNumber value="${list.p_price}" pattern="#,###" /></strong>원</td>
						<td>${list.ea}</td>
						<td class="R">
							<strong><fmt:formatNumber value="${list.goods_tot}" pattern="#,###" />원</strong>
						</td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
		<%-- <c:if test="${sum_goods_tot > 100000 }"><c:set var="sum_delivery_tot" value = "0" /></c:if> --%>
		<c:if test="${sum_goods_tot >= bean.freeDeileveryLimit }"><c:set var="sum_delivery_tot" value = "0" /></c:if>
		
		<!-- 배송정보 -->
		<p class="titG">배송정보</p>
		<div class="bline">
			<em>배송지 선택</em>
			<label id="ship_type_from2"><input type="radio" name="ship_type_from" id="ship_type_from2" value="2" checked="checked"/> 비움환원외탕전 - 한의원</label>
			<label id="ship_type_from1"><input type="radio" name="ship_type_from" id="ship_type_from1" value="1"/> 한의원 - 고객</label>
			<label id="ship_type_from3"><input type="radio" name="ship_type_from" id="ship_type_from3" value="3"/> 비움환원외탕전 - 고객</label>
			<label id="ship_type_from4"><input type="radio" name="ship_type_from" id="ship_type_from4" value="4"/> 직접입력</label>
			<label id="ship_type_from5"><input type="radio" name="ship_type_from" id="ship_type_from5" value="5"/> 방문수령</label>
		</div>
		<table class="detailT01">
			<colgroup>
				<col width="12%" />
				<col width="10%" />
				<col width="36%" />
				<col width="10%" />
				<col width="32%" />
			</colgroup>
			<tbody>
				<tr>
					<th rowspan="4" class="bg01">보내는 사람</th>
				</tr>
				<tr>
					<th>발신인</th>
					<td colspan="3"><input type="text" name="o_name" id="o_name"  style="width:220px;"></td>
				</tr>
				<tr>
					<th><!-- 연락처 -->연락처1</th>
					<td>
						<input type="text" id="o_tel01" name="o_tel01" style="width:65px;" maxlength="4"> -
						<input type="text" id="o_tel02" name="o_tel02" style="width:65px;" maxlength="4"> -
						<input type="text" id="o_tel03" name="o_tel03" style="width:65px;" maxlength="4">
					</td>
					<th><!-- 휴대전화 -->연락처2</th>
					<td>
						<input type="text" id="o_handphone01" name="o_handphone01" style="width:65px;" maxlength="4"> -
						<input type="text" id="o_handphone02" name="o_handphone02" style="width:65px;" maxlength="4"> -
						<input type="text" id="o_handphone03" name="o_handphone03" style="width:65px;" maxlength="4">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">
						<input type="text" name="o_zipcode" id="o_zipcode"  style="width:150px;" readonly>
						<a href="#"><span id="findAddrBtn1" class="h30 cB">주소찾기</span></a><br/>
						<input type="text" name="o_address01"  style="width:350px;" readonly id="o_address01">
						<input type="text" name="o_address02" placeholder="상세주소" style="width:270px; margin:0px 0 0 10px;" id="o_address02"> 
					</td>
				</tr>
			</tbody>
		</table>
		
		<table class="detailT01">
			<colgroup>
				<col width="12%" />
				<col width="10%" />
				<col width="36%" />
				<col width="10%" />
				<col width="32%" />
			</colgroup>
			<tbody>
				<tr>
					<th rowspan="6" class="bg02">받는 사람</th>
				</tr>
			
				<tr>
					<th>수신인</th>
					<td colspan="3"><input type="text" name="r_name" id="r_name" style="width:220px;"></td>
				</tr>
				<tr>
					<th>연락처1</th>
					<td>
						<input type="text" id="r_tel01" name="r_tel01" style="width:65px;" maxlength="4"> -
						<input type="text" id="r_tel02" name="r_tel02" style="width:65px;" maxlength="4"> -
						<input type="text" id="r_tel03" name="r_tel03" style="width:65px;" maxlength="4">
					</td>
					<th><!-- 휴대전화 -->연락처2</th>
					<td>
						<input type="text" id="r_handphone01" name="r_handphone01" style="width:65px;" maxlength="4"> -
						<input type="text" id="r_handphone02" name="r_handphone02" style="width:65px;" maxlength="4"> -
						<input type="text" id="r_handphone03" name="r_handphone03" style="width:65px;" maxlength="4">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">
						<input type="text" name="r_zipcode" id="r_zipcode" style="width:150px;" readonly>
						<a href="#"><span id="findAddrBtn2" class="h30 cB">주소찾기</span></a>
						<a href="#" id="latelyBtn"><span id="addrBtn1" class="h30 cp">최근배송정보</span></a>
						<br/>
						<input type="text" name="r_address01" style="width:350px; margin-top:10px;" readonly id="r_address01">
						<input type="text" name="r_address02" placeholder="상세주소" style="width:270px; margin:10px 0 0 10px;" id="r_address02">
					</td>
				</tr>
				<tr>
					<th>배송메모</th>
					<td colspan="3" class="pt10">
						<textarea name="o_memo" id="o_memo" style="width:630px; height:40px;resize:none;"></textarea>
					</td>
				</tr>
				<tr>
					<th>주문시<br/>요청사항</th>
					<td colspan="3" class="pt10">
						<textarea name="o_memo2" id="o_memo2" style="width:630px; height:40px;resize:none;"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="lately_wrap" style="position: absolute;width: 850px;min-height: 520px;z-index: 9999;background: #fff;top: 803px;left: 90px;border: 1px solid #26995d;display: none;"></div>
		
		<!-- 결제정보 -->
		<p class="titG">결제정보</p>
		<p class="bluetxt">* <fmt:formatNumber value="${bean.freeDeileveryLimit }" pattern="#,###" />원 이상 주문할 경우 배송료 면제됩니다.</p>
		<table class="detailT02" style="width:100%;">
			<colgroup>
				<col width="110px" />
				<col width="*" />
				<col width="110px" />
				<col width="110px" />
				<col width="110px" />
				<col width="110px" />
				<col width="110px" />
				<col width="160px" />
			</colgroup>
			<tbody>
				<tr>
					<th>처방비용 합계</th>
					<td>
						<span class="price" id="show_total"><fmt:formatNumber value="${sum_goods_tot}" pattern="#,###" /></span>원
					</td>
					<th>배송료(+)</th>
					<td>
						<span class="price02" id="show_del"><fmt:formatNumber value="${sum_delivery_tot}" pattern="#,###" /></span>원
					</td>
					<th>할인금액(-)</th>
					<td>
						<span class="price02" id="show_sale"><fmt:formatNumber value="${bean.sale_price}" pattern="#,###" /></span>원
					</td>
					<th>총 결제금액</th>
					<td>
						<span class="price fc04" id="show_all"><fmt:formatNumber value="${sum_goods_tot + sum_delivery_tot - bean.sale_price}" pattern="#,###" /></span>원
					</td>
				</tr>
			</tbody>
		</table>
		
		<p class="titG">결제수단</p>
		<table class="detailT03">
			<colgroup>
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<td valign="top" style="padding-left:0px;">
						<div class="pay_type_select">
							<a href="#"><span class="cw h35">신용카드</span></a>
							<a href="#"><span class="cw h35">계좌 간편결제</span></a>
							<a href="#"><span class="cw h35">무통장 입금</span></a>
						</div>
					</td>
				</tr>
				<tr height="41px;">
					<td  style="padding-left:0px;">
						<div class="boxA" style="display: none;">
							<p class="selbox">
								<label for="bill_part1"><input type="radio" name="bill_part" id="bill_part1" value="1" /> 세금계산서</label>
								<label for="bill_part2"><input type="radio" name="bill_part" id="bill_part2" value="2"/> 현금영수증</label>
								<label for="bill_part3"><input type="radio" name="bill_part" id="bill_part3" value="3" checked="checked"/> 미신청</label>
							</p>
							<p>
								<span class="fl addInfo2 addInfo" style="display: none;">
									<c:set var="han_handphone" value="${fn:split(userInfo.handphone,'-')}" />
									<select name="cash_receipts" id="cash_receipts" class="opt2" style="width:90px;">
										<option value="소득공제용" selected>소득공제용</option>
										<option value="지출증빙용">지출증빙용</option>
									</select>
									<strong> 휴대폰 번호 </strong> 
									<input type="text" id="bill_handphone01" name="bill_handphone01" style="width:45px;" value="${han_handphone[0]}"  maxlength="4" /> - 
									<input type="text" id="bill_handphone02" name="bill_handphone02" style="width:45px;" value="${han_handphone[1]}"  maxlength="4"/> - 
									<input type="text" id="bill_handphone03" name="bill_handphone03" style="width:45px;" value="${han_handphone[2]}"   maxlength="4"/>
								</span>
								
								<span class="fl addInfo1 addInfo"  style="display: none;">
									<strong> 이메일 </strong> 
									<input type="text" name="bill_email" id="bill_email" style="width:250px;" value="${userInfo.email}">
								</span>
							</p>
							<!--
							<p>
								<strong> 이메일 </strong> 
								<input type="text" name="" id="" style="width:250px;">
							</p>
							-->
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //결제정보 -->
		
		<%-- ${taekbaeInfo } --%>
		
		<!-- btnarea -->
		<div class="btn_area01">
			<a href="02.do"><span class="cw h60">취소</span></a>
			
			<c:if test="${userInfo.member_level ne 0 && userInfo.member_level ne 1 }">
				<a href="/m05/02_end.do" id="orderYakBtn"><span class="cp h60">주문하기</span></a>
				
			</c:if>
			
		</div>		
		<!-- //btnarea -->
		<input type="hidden" name="payment_kind" id="payment_kind" value=""/>
		<input type="hidden" name="all_seqno" id="all_seqno" value="${bean.all_seqno}" />
		<input type="hidden" name="delivery_price" id="delivery_price" value="${sum_delivery_tot}" />
		<input type="hidden" name="ea" value="${ea}" />
		
		<fmt:parseNumber var="i_sum_goods_tot" type="number" value="${sum_goods_tot}" />

		<input type="hidden" name="tot_price" id="tot_price" value="${i_sum_goods_tot + sum_delivery_tot - bean.sale_price}" /> <!-- 체크용 -->
		
		
		<c:set var="tel" value="${fn:split(userInfo.han_tel,'-')}" />
		<input type="hidden" id="han_addr1" 		value="${userInfo.address01}" />
		<input type="hidden" id="han_addr2" 		value="${userInfo.address02}" />
		<input type="hidden" id="han_zip"   		value="${userInfo.zipcode}" />
		<input type="hidden" id="han_handphone01"   value="${han_handphone[0]}">
		<input type="hidden" id="han_handphone02"   value="${han_handphone[1]}"> 
		<input type="hidden" id="han_handphone03"   value="${han_handphone[2]}"> 
		<input type="hidden" id="han_han_name"   	value="${userInfo.han_name}" name="han_han_name">
		<input type="hidden" id="han_name"   	value="${userInfo.han_name}" name="han_name">
		
		
		<input type="hidden" id="han_tel01"   value="${tel[0]}">
		<input type="hidden" id="han_tel02"   value="${tel[1]}"> 
		<input type="hidden" id="han_tel03"   value="${tel[2]}"> 
		
		
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
		
		<!-- //본문내용 -->
		<script>
			function cmsResult(){
				closeFancyBox();
				$("#frm").attr("action", "/m03/01_com_order_cms.do");
				$('#frm').submit();
			}
		
		
			$(document).ready(function() {
				
				$("#latelyBtn").click(function() {
					$.ajax({
					    url: "/m03/lately.do",		    
					    type : 'POST',
				        error: function(){
					    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					    },
					    success: function(data){
					    	$('.lately_wrap').fadeIn();
					        $(".lately_wrap").html(data);						        
					    }   
					});	
					
					return false;
				});
				
				$("#latelyCloseBtn").click(function() {
					$('.lately_wrap').fadeOut();
					return false;
				});
				
				a_sale_per = parseInt( $('#sale_per').val() );
				if(isNaN(a_sale_per)){
					a_sale_per = 0;
				}
				
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
					/* if(!valCheck( 'o_handphone01' ,'휴대전화를 입력하세요.') ) return false;
					if(!valCheck( 'o_handphone02' ,'휴대전화를 입력하세요.') ) return false;
					if(!valCheck( 'o_handphone03' ,'휴대전화를 입력하세요.') ) return false; */
					if(!valCheck( 'o_zipcode' ,'주소를 입력하세요.') ) return false;
					if(!valCheck( 'o_address01' ,'주소를 입력하세요.') ) return false;
					
					
					if(!valCheck( 'r_name' ,'수신인을 입력하세요.') ) return false;
					/* if(!valCheck( 'r_handphone01' ,'연락처를 입력하세요.') ) return false;
					if(!valCheck( 'r_handphone02' ,'연락처를 입력하세요.') ) return false;
					if(!valCheck( 'r_handphone03' ,'연락처를 입력하세요.') ) return false; */
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
							//if(!valCheck( 'bill_name' ,'이름을 입력하세요.') ) return false;
							if(!valCheck( 'bill_handphone01' ,'휴대전화 번호를 입력하세요.') ) return false;
							if(!valCheck( 'bill_handphone02' ,'휴대전화 번호를 입력하세요.') ) return false;
							if(!valCheck( 'bill_handphone03' ,'휴대전화 번호를 입력하세요.') ) return false;
						}
						
						if(confirm('해당정보로 주문하겠습니까?')){
							$('#frm').submit();
							return false;
						}
					}
					else if(payment_kind == 'Cms'){
						/* $('.fancybox-close').css('display','block'); */
						 
						$.fancybox({
							'width'         : '789px',
							'height'        : '805px',
							'href'			: "01_add_order_iframe.do?"+$('#frm').serialize(),
							'padding'		: '0',
							'margin'	    : 0,
							'transitionIn'	:	'elastic',
							'transitionOut'	:	'elastic',
							'type' 			: 	'iframe',
							'scrolling'     : 'no',
							closeClick      : true
							/* ,afterClose  : function() { 
					            window.location.reload();
					        } */
						});
					}
					else if(payment_kind == 'Card'){
						var url = $(this).attr('href');
						
						/* $('.fancybox-close').css('display','none'); */
						
						try{
							$.fancybox({
								'width'         : '959px',
								'height'        : '505px',
								/* 'width'         : '1400px',
								'height'        : '1200px', */
								'href'			: "01_add_order_iframe.do?"+$('#frm').serialize(),
								'padding'		: '0',
								'margin'	    : 0,
								'transitionIn'	:	'elastic',
								'transitionOut'	:	'elastic',
								'type' 			: 	'iframe',
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
					}
					return false;
				});
				
				$(".pay_type_select a span").click(function() {
					
					//cw cg
					
					$('.pay_type_select a span').removeClass('cBlue');							
					$('.pay_type_select a span').addClass('cw');
					
					$(this).removeClass('cw');
					$(this).addClass('cBlue');
					
					var type = $(this).html();
					if(type == '신용카드'){
						$('.boxA').hide();
						$('#payment_kind').val('Card');
					}else if(type == '계좌 간편결제'){
						//$('.boxA').hide();
						$('.boxA').show();
						$('#payment_kind').val('Cms');
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
				$("input:radio[name=ship_type_from]").click(function(){
					settingOrderAddr('o', $(this).val());
					var base_delivery_price     = parseInt( $('#a_delivery_price').val());
					var delivery_price          = parseInt( $('#delivery_price').val());
					
					//settingOrderAddr('o', $(this).val())
					
					console.log('base_delivery_price = ', base_delivery_price);
					console.log('delivery_price = ', delivery_price);
					
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
						settingOrderAddr('r', 2);
					}
					// txt 
					//show_total // 처방비용 함계 
					//show_del  // 배송금액
					//show_sale // 할인금액
					// show_all 총결제금액
					
					// value
					// sum_goods_tot
					// delivery_price
					// sale_per
					
					console.log($('#sale_per').val());
					console.log($('#sale_per').val());
					
					var sale_per      = parseInt( $('#sale_per').val() );
					if(isNaN(sale_per)){
						sale_per = 0;
					}
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
						var Amt             = sum_goods_tot - sale_good_price; // 결제금액
						$('#show_del').html('0');
						$('#show_sale').html(comma(sale_good_price));
						$('#show_all').html(comma(Amt));
						
						
						$('#delivery_price').val(0);
						$('#Amt').val(Amt);
						$('#tot_price').val(Amt);
						$('#sale_price').val(sale_good_price);
						
					}else{
						console.log(2);
						var sale_good_price = sale_per / 100 * (sum_goods_tot + base_delivery_price);
						var Amt             = sum_goods_tot - sale_good_price + base_delivery_price; // 결제금액
						
						$('#show_del').html(comma(base_delivery_price));
						$('#show_sale').html(comma(sale_good_price));
						$('#show_all').html(comma(Amt));
						
						$('#delivery_price').val(base_delivery_price);
						$('#Amt').val(Amt);
						$('#tot_price').val(Amt);
						$('#sale_price').val(sale_good_price);
						
					}
				});
				
				$("input:radio[name=ship_type_to]").click(function(){
					
				});
				
				settingOrderAddr('r', 2);
				settingOrderAddr('o', 1);
			});
			
			function settingOrderAddr(type , val){
				
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
					$('#'+type+'_name').val($('#han_han_name').val());
					$('#'+type+'_tel01').val($('#han_tel01').val());
					$('#'+type+'_tel02').val($('#han_tel02').val());
					$('#'+type+'_tel03').val($('#han_tel03').val());
					
					/* 
					$('#'+type+'_handphone01').val($('#han_handphone01').val());
					$('#'+type+'_handphone02').val($('#han_handphone02').val());
					$('#'+type+'_handphone03').val($('#han_handphone03').val());
					 */
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
			
			function closeFancyBox(){
				console.log('closeFancyBox');
				$.fancybox.close();
			}
		</script>
		</form>
		
	</div>
	<!-- // contents -->

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