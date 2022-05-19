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
	
	System.out.println("결제금액   = "+ (Amt));
	
	
%>
<script>
	//결제창 최초 요청시 실행됩니다. <<'nicepayStart()' 이름 수정 불가능>>
	function nicepayStart(){
	    goPay(document.frm);
	}

	//결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
	function nicepaySubmit(){
	    document.frm.submit();
	}

	//결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
	function nicepayClose(){
	    alert("결제가 취소 되었습니다");
	}
</script>
<style>
	.point_area{
		margin: 2px 0 25px 10px;
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
		float: left;
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
	}
	
	.point_area .my_point .box__inner .form__box{
		    position: relative;
		    display: inline-block;
		    width: 200px;
		    height: 46px;
		    padding: 0 24px 0 5px;
		    font-size: 18px;
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
		    margin-left: 10px;
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
<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="contents">

		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>약속처방</span><span>약속처방 보관함</span></p>
		</div>

		<ul class="sub_Menu w33">
			<li ><a href="01.do">약속처방</a></li>
			<li class="sel"><a href="02.do">약속처방 보관함</a></li>
			<li><a href="03.do">사전조제지시서 관리</a></li>
		</ul>

		<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
		<form action="02_order_com_cart.do" name="frm" id="frm">
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
			
				<c:forEach var="list" items="${list}">
					<c:set var="sum_goods_tot" value = "${sum_goods_tot + list.goods_tot}" />
					<tr>
						<td class="L">
							<p class="img"><img src="/upload/goods/${list.image}" style="width: 60px;height: 60px;"  class="am" alt="${list.p_name }" /></p>
							<div class="name">${list.goods_name }
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
							<strong>
								<fmt:formatNumber value="${list.goods_tot}" pattern="#,###" /></strong>원
						</td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
		<%-- <c:if test="${sum_goods_tot > 100000 }"><c:set var="sum_delivery_tot" value = "0" /></c:if> --%>
		<c:if test="${sum_goods_tot >= bean.freeDeileveryLimit }"><c:set var="sum_delivery_tot" value = "0" /></c:if>
		
	
		<!-- // orderview -->
		
		
		<!-- 배송정보 -->
		<div class="order_detail">
			<p class="tit"><img src="/assets/user/pc/images/sub/tit02.png" alt="배송정보" /></p>
			<div class="bline">
				<em>배송지 선택</em>
				<label id="ship_type_from1"><input type="radio" name="ship_type_from" id="ship_type_from1" value="1" checked="checked"/> 한의원 - 고객</label>
				<label id="ship_type_from2"><input type="radio" name="ship_type_from" id="ship_type_from2" value="2"/> 청담원외탕전 - 한의원</label>
				<label id="ship_type_from3"><input type="radio" name="ship_type_from" id="ship_type_from3" value="3"/> 청담원외탕전 - 고객</label>
				<label id="ship_type_from4"><input type="radio" name="ship_type_from" id="ship_type_from4" value="4"/> 직접입력</label>
				<div style="display: none;">
					<label id="ship_type_from5"><input type="radio" name="ship_type_from" id="ship_type_from5" value="5"/> 방문수령</label>
				</div>
			</div>
			<div class="bline">
				<em class="bgy mt50">보내는 사람</em>
				<table class="detailT" style="width:730px;">
					<colgroup>
						<col width="80px" />
						<col width="*" />
						<col width="80px" />
						<col width="230px" />
					</colgroup>
					<tbody>
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
			</div>
			<div class="clfix pt20 pl10">
				<em class="bgb mt110">받는 사람</em>
				<table class="detailT" style="width:730px;">
					<colgroup>
						<col width="80px" />
						<col width="*" />
						<col width="80px" />
						<col width="230px" />
					</colgroup>
					<tbody>
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
								<a href="#" id="latelyBtn"><span id="addrBtn1" class="h30 cg">최근배송정보</span></a>
								<br/>
								<input type="text" name="r_address01" style="width:350px; margin-top:10px;" readonly id="r_address01">
								<input type="text" name="r_address02" placeholder="상세주소" style="width:270px; margin:10px 0 0 10px;" id="r_address02">
								
								<div class="lately_wrap" style="position: absolute;width: 850px;min-height: 520px;z-index: 9999;background: #fff;top: 803px;left: 90px;border: 1px solid #26995d;display: none;"></div>
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
			</div>
		</div>
		<!-- //배송정보 -->
		
		<div class="order_detail">
			
			<div class="point_area">
				<!-- <div class="text_title">포인트 사용</div> -->
				<div class="my_point">
					<div class="left">
						<em class="bgy" style="width: 100px;">나의 포인트</em>
						<span class="text_cash"><fmt:formatNumber value="${member_point.tot_point}" pattern="#,###" /></span>
					</div>
					<div class="right">
						<div class="box__inner">
							<div class="form__box">
								<input type="text" class="input_txt" name="use_point_temp" id="use_point_temp" data-montelena-acode="100003099" placeholder="0" />
								<span class="text_unit">원</span>																
							</div>
							<button type="button" class="point_used" id="point_all">전액사용</button>
							
							<button type="button" class="point_used" id="point_cancel" style="display: none;" >사용취소</button>
						</div>
					</div>
					
					<div style="clear: both;"></div>					 				
				</div>
			</div>
		</div>


		<!-- 결제정보 -->
		<div class="order_detail">
			<p class="tit"><img src="/assets/user/pc/images/sub/tit03.png" alt="결제정보" /></p>
			<div class="bline">
				<p class="bluetxt">* <fmt:formatNumber value="${bean.freeDeileveryLimit }" pattern="#,###" />원 이상 주문할 경우 배송료 면제됩니다.</p>
				<table class="detailT" style="width:100%;">
					<colgroup>
						<col width="150px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>처방비용 합계</th>
							<td>
								<span class="price" id="show_total"><fmt:formatNumber value="${sum_goods_tot}" pattern="#,###" /></span>원
							</td>
						</tr>
						<tr>
							<th>배송료(+)</th>
							<td>
								<span class="price" id="show_del"><fmt:formatNumber value="${sum_delivery_tot}" pattern="#,###" /></span>원
							</td>
						</tr>
						<tr>
							<th>할인금액(-)</th>
							<td>
								<span class="price" id="show_sale"><fmt:formatNumber value="${bean.sale_price}" pattern="#,###" /></span>원								
							</td>
						</tr>
						<tr style="display: none;" id="use_point_tr">
							<th>포인트사용(-)</th>
							<td>
								<span class="price" id="show_point"></span>원								
							</td>
						</tr>
						<tr>
							<th>총 결제금액</th>
							<td>
								<span class="price fc04" id="show_all"><fmt:formatNumber value="${sum_goods_tot + sum_delivery_tot - bean.sale_price}" pattern="#,###" /></span>원
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="clfix pt20 pl10">
				<table class="detailT" style="width:100%;">
					<colgroup>
						<col width="120px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th><img src="/assets/user/pc/images/sub/tit04.png" alt="결제수단" /></th>
							<td>
								<div class="pay_type_select">
									<div id="pre_paybtn_area">
										<a href="#"><span class="cw h30">신용카드</span></a>
										<a href="#"><span class="cw h30 ml10">무통장 입금</span></a>
									</div>
								</div>
								<div id="pointbtn_area" style="display: none;">
										<a href="#"><span class="cw h30" id="btn_point">포인트 결제</span></a>
									</div>	
								<div class="boxA" style="display: none;">
									<c:set var="han_handphone" value="${fn:split(userInfo.handphone,'-')}" />
									<p class="fl">
										<label for="bill_part1"><input type="radio" name="bill_part" id="bill_part1" value="1" /> 세금계산서</label>
										<label for="bill_part2"><input type="radio" name="bill_part" id="bill_part2" value="2"/> 현금영수증</label>
										<label for="bill_part3"><input type="radio" name="bill_part" id="bill_part3" value="3" checked="checked"/> 미신청</label>
									</p>
									<p class="fl addInfo1 addInfo"  style="display: none;">
										<strong> 이메일 </strong> 
										<input type="text" name="bill_email" id="bill_email" style="width:250px;" value="${userInfo.email}">
									</p>
									<p class="fl addInfo2 addInfo" style="display: none;">
										<select name="cash_receipts" id="cash_receipts" class="opt2" style="width:100px;">
											<option value="소득공제용" selected>소득공제용</option>
											<option value="지출증빙용">지출증빙용</option>
										</select>
										<strong> 휴대폰 번호 </strong> 
										<input type="text" id="bill_handphone01" name="bill_handphone01" style="width:65px;" value="${han_handphone[0]}"  /> - 
										<input type="text" id="bill_handphone02" name="bill_handphone02" style="width:65px;" value="${han_handphone[1]}"/> - 
										<input type="text" id="bill_handphone03" name="bill_handphone03" style="width:65px;" value="${han_handphone[2]}" />
									</p>									
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- //결제정보 -->
		
		<!-- btnarea -->
		<div class="btn_area01">
			<a href="02.do"><span class="cw h60">취소</span></a>
			<c:if test="${userInfo.member_level ne 0 && userInfo.member_level ne 1 }">
				<a href="#" id="orderYakBtn"><span class="cg h60">주문하기</span></a>
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
		<input type="hidden" id="user_name"   value="${userInfo.name}">
		
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
		
		<!-- 사용 -->
		<input type="hidden"  name="use_point" id="use_point" value="0"/>
		<!-- 아웃 -->
		<input type="hidden"  name="use_point_focusout" id="use_point_focusout" value="0"/>
		<!-- 총 -->
		<input type="hidden"  name="tot_point" id="tot_point" value="${member_point.tot_point}"/>
		<input type="hidden"  name="reason" id="reason" value="약속처방 구매(장바구니) 포인트 사용"/>
		
		<!-- //본문내용 -->
		<script>
			var a_pre_ship_type_from = $('input[name="ship_type_from"]:checked').val();
			var a_all_price = 0;
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
						alert('보유한 포인트 내에서 입력하세요.' );
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
						
						$('#btn_point').removeClass('cw');
						$('#btn_point').addClass('cg');
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
					 var tot_price           = parseInt($('#tot_price').val());
					 var tot_point 		    = parseInt($('#tot_point').val());
					 
					 if(tot_point<=0){
						 return;
					 }
					 
					 var use_point = 0;
					 
					 if(tot_point >= tot_price){
						 use_point = tot_price;
						 
						 $('.pay_type_select a span').removeClass('cw');							
						 $('.pay_type_select a span').addClass('cw');
						 
						 
						 $('#btn_point').removeClass('cw');
						 $('#btn_point').addClass('cg');
						 
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
					/* 
					if(!valCheck( 'r_handphone01' ,'휴대전화를 입력하세요.') ) return false;
					if(!valCheck( 'r_handphone02' ,'휴대전화를 입력하세요.') ) return false;
					if(!valCheck( 'r_handphone03' ,'휴대전화를 입력하세요.') ) return false;
					 */
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
						}
					}					
					else if(payment_kind == 'Point'){
						var use_point          = $('#use_point').val();
						var use_point_focusout = $('#use_point_focusout').val();
						var tot_price          = $('#tot_price').val();
						
						
						if(use_point != tot_price){
							alert('사용된 금액과 포인트 금액이 일치하지 않습니다.\n확인후 다시 시도하세요.');
							return false;						
						}else{
							if(confirm('해당정보로 주문하겠습니까?')){
								$('#frm').submit();
								return false;
							}	
						}
					}					
					else if(payment_kind == 'Card'){
						//nicepayStart();
						var url = $(this).attr('href');
						try{
							$.fancybox({
								'width'         : '789px',
								'height'        : '505px',
								/* 'width'         : '1400px',
								'height'        : '1200px', */
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
					}else{
						alert('결제수단이 선택되지 않았습니다.');
						return false;
					}
					return false;
				});
				
				$(".pay_type_select a span").click(function() {
					
					//cw cg
					
					$('.pay_type_select a span').removeClass('cw');							
					$('.pay_type_select a span').addClass('cw');
					
					$(this).removeClass('cw');
					$(this).addClass('cg');
					
					var type = $(this).html();
					if(type == '신용카드'){
						$('.boxA').hide();
						$('#payment_kind').val('Card');
					}else if(type == '무통장 입금'){
						$('.boxA').show();
						$('#payment_kind').val('Bank');
					}else{
						$('.boxA').hide();
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
				$("input:radio[name=ship_type_from]").change(function(){
					settingOrderAddr('o', $(this).val());
					// var base_delivery_price     = 4000;
					var base_delivery_price     = parseInt( $('#a_delivery_price').val());
					var delivery_price = parseInt( $('#delivery_price').val());
					
					
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
					
					//console.log($(this).val());
				    var use_point_focusout = $('#use_point_focusout').val();
					if(use_point_focusout > 0){
						resetPoint();	
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
						var Amt             = sum_goods_tot - sale_good_price; // 결제금액
						
						$('#show_del').html('0');
						$('#show_sale').html(comma(sale_good_price));
						$('#show_all').html(comma(Amt));
						
						
						$('#delivery_price').val(0);
						$('#Amt').val(Amt);
						$('#tot_price').val(Amt);
						$('#sale_price').val(sale_good_price);
					}else{
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
					a_all_price = $('#tot_price').val();
					
				});
				
				$("input:radio[name=ship_type_to]").click(function(){
					
				});
				
				//settingOrderAddr('r', 2);
				settingOrderAddr('o', 2);
			});
			
			function settingOrderAddr(type , val){
				
				var han_han_name = $('#han_han_name').val();
				var user_name = $('#user_name').val();
				if(han_han_name == '' || han_han_name == null  || han_han_name == undefined){
					han_han_name = user_name;
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
					$('#'+type+'_name').val(han_han_name);
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
			
			function closeFancyBox(){
				console.log('closeFancyBox');
				$.fancybox.close();
			}
			
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
		</script>
		</form>
		
	</div>
	<!-- // contents -->

</div>
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
