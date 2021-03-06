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
<!-- container -->
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "약속처방";
		String sec_nm = "약속처방";
		String thr_nm = "전체처방";
		int fir_n = 3;
		int sub_n = 1;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	<script src="<%=Const.NP_url%>" type="text/javascript"></script>
	<style>
		.cblue1 {background:#436782; color:#ffffff;border:1px solid #444444;}
		.cblue1:hover {background:#345b79;}
		.h40{
			padding: 0 0;
		}
	</style>
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
		String Amt            	= bean.get("goods_tot")+"";         // 결제상품금액	
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
	<!-- contents -->
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
	<form action="/m03/01_com_order.do" name="frm" id="frm" >
		
	<div id="contents">
		<!-- 내용 -->
		<div class="conArea">
		
			<!-- orderview -->
			<table class="order_view">
				<colgroup>
					<col width="*" />
					<col width="160px" />
					<col width="120px" />
					<col width="140px" />
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
							<td class="L"><img src="/upload/goods/${list.image}" style="width: 60px;height: 60px;"  class="am" alt="${list.p_name }" /> ${list.p_name }</td>	
							<td class="R"><strong><fmt:formatNumber value="${list.p_price}" pattern="#,###" /></strong>원</td>
							<td>${list.ea}</td>
							<td class="R"><strong><fmt:formatNumber value="${list.goods_tot}" pattern="#,###" /></strong>원</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${sum_goods_tot >= 100000 }"><c:set var="sum_delivery_tot" value = "0" /></c:if>
			
			<div class="totalBox" style="margin-top:-1px;">
				<ul>
					<li class="Bt03">처방비용합계<span class="won"><fmt:formatNumber value="${sum_goods_tot}" pattern="#,###" />원</span></li>
					<li class="Bt02">배송비<span class="won"><fmt:formatNumber value="${sum_delivery_tot}" pattern="#,###" />원</span></li>
					<li class="total">총 결제금액<span class="won"><fmt:formatNumber value="${sum_goods_tot + sum_delivery_tot}" pattern="#,###" />원</span></li>
				</ul>
			</div>
			
			<div id="nice_pay_setting_area" style="display: none;">
				<input type="text" name="PayMethod"   value="CARD">
				<input type="text" name="GoodsName"   value="<%=goodsName%>"> <!-- 상품명 -->
				<input type="text" name="GoodsCnt"    value="<%=goodsCnt%>"> <!-- 상품겟수 -->
				<input type="text" name="Amt"         value="${sum_goods_tot + sum_delivery_tot}"> <!-- 결제금액 -->
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
		            
		        <!-- 변경 불가능 -->
		        <input type="hidden" name="EdiDate" value="<%=ediDate%>"/>                   <!-- 전문 생성일시 -->
		        <input type="hidden" name="EncryptData" value="<%=encryptData%>"/>            <!-- 해쉬값	-->
		        <input type="hidden" name="TrKey" value=""/>		       
			</div>

			<div class="topinfo mt60">
				<div>
					<p>보내는 사람</p>
					<p class="inputA">
						<label id="ship_type_from1"><input type="radio" name="ship_type_from" id="ship_type_from1" value="1" checked="checked"/> 북경한의원 원외탕전실</label>
						<label id="ship_type_from2"><input type="radio" name="ship_type_from" id="ship_type_from2" value="2"  /> 한의원</label>
						<label id="ship_type_from3"><input type="radio" name="ship_type_from" id="ship_type_from3" value="3" /> 새로입력</label>
					</p>
					<ul>
						<li>
							<span class="tit">발신인</span>
							<input type="text" name="o_name" id="o_name" style="width:220px;">
						</li>
						<li>
							<span class="tit">연락처</span>
							<input type="text" id="o_tel01" name="o_tel01" style="width:65px;" maxlength="4"> -
							<input type="text" id="o_tel02" name="o_tel02" style="width:65px;" maxlength="4"> -
							<input type="text" id="o_tel03" name="o_tel03" style="width:65px;" maxlength="4">
						</li>
						<li>
							<span class="tit">휴대전화</span>
							<input type="text" id="o_handphone01" name="o_handphone01" style="width:65px;" maxlength="4"> -
							<input type="text" id="o_handphone02" name="o_handphone02" style="width:65px;" maxlength="4"> -
							<input type="text" id="o_handphone03" name="o_handphone03" style="width:65px;" maxlength="4">
						</li>
						<li>
							<span class="tit">주소</span>
							<span class="dI H40">
								<input type="text" name="o_zipcode" id="o_zipcode" style="width:180px;" readonly><a href="#" id="findAddrBtn1" ><span id="addrBtn1" class="h34 cB">주소찾기</span></a>
							</span>
							<span class="dI">
								<input type="text" name="o_address01"  style="width:350px;" readonly id="o_address01">
								<input type="text" name="o_address02" placeholder="상세주소" style="width:350px;" id="o_address02"> 
							</span>
						</li>
					</ul>
				</div>
				<div class="ml60" style="position: relative;">
					<p>받는 사람</p>
					<p class="inputA">
						<label id="ship_type_to1"><input type="radio" name="ship_type_to" id="ship_type_to1" value="1"/> 북경한의원 원외탕전실</label>
						<label id="ship_type_to2"><input type="radio" name="ship_type_to" id="ship_type_to2" value="2" checked="checked"/> 한의원</label>
						<label id="ship_type_to3"><input type="radio" name="ship_type_to" id="ship_type_to3" value="3" /> 새로입력</label>
					</p>
					<ul>
						<li>
							<span class="tit">수신인</span>
							<input type="text" name="r_name" id="r_name" style="width:220px;">
						</li>
						<li>
							<span class="tit">연락처</span>
							<input type="text" id="r_tel01" name="r_tel01" style="width:65px;" maxlength="4"> -
							<input type="text" id="r_tel02" name="r_tel02" style="width:65px;" maxlength="4"> -
							<input type="text" id="r_tel03" name="r_tel03" style="width:65px;" maxlength="4">
						</li>
						<li>
							<span class="tit">휴대전화</span>
							<input type="text" id="r_handphone01" name="r_handphone01" style="width:65px;" maxlength="4"> -
							<input type="text" id="r_handphone02" name="r_handphone02" style="width:65px;" maxlength="4"> -
							<input type="text" id="r_handphone03" name="r_handphone03" style="width:65px;" maxlength="4">
						</li>
						<li>
							<span class="tit">주소</span>
							<span class="dI H40">
								<input type="text" name="r_zipcode" id="r_zipcode" style="width:180px;" readonly><a href="#" id="findAddrBtn2"><span id="addrBtn1" class="h34 cB">주소찾기</span></a>
								<a href="#" id="latelyBtn"><span id="" class="h34 cB">최근배송지</span></a>
							</span>
							<span class="dI">
								<input type="text" name="r_address01" style="width:350px;" readonly id="r_address01">
								<input type="text" name="r_address02" placeholder="상세주소" style="width:350px;" id="r_address02"> 
							</span>
							<div class="lately_wrap" style="position: absolute;width: 850px;min-height: 520px;z-index: 9999;background: #fff;top: 103px;left: -280px;border: 1px solid #26995d;display: none;"></div>
						</li>
						<li>
							<span class="tit">배송메모</span>
							<span>
								<textarea name="o_memo" id="o_memo" style="width:350px; height:40px;resize:none;"></textarea>
							</span>
						</li>
					</ul>
				</div>
			</div>
			<!-- // orderview -->

	
			<c:set var="han_handphone" value="${fn:split(userInfo.handphone,'-')}" />
			<div class="totalend">
				<ul>
					<li class="tit">결제수단</li>
					<li class="pay_type_select">
						<a href="#"><span class="cBB h30">신용카드</span></a>
						<a href="#"><span class="cBB h30">무통장 입금</span></a>
					</li>
					<li>
						<div id="tax_bill_area" style="display: none;" class="tax_bill">
							<label for="bill_part1"><input type="radio" name="bill_part" id="bill_part1" value="1" />세금계산서</label>
							<label for="bill_part2"><input type="radio" name="bill_part" id="bill_part2" value="2" />현금영수증</label>
							<label for="bill_part3"><input type="radio" name="bill_part" id="bill_part3" value="3" checked="checked" />미신청</label>
						</div>
						<!-- 세금계산서 -->
						<div class="addInfo addInfo1" style="display: none;">
							<strong>이메일</strong> <input type="text"  name="bill_email" id="bill_email" style="width:250px;" value="${userInfo.email }" />
						</div>
						<!-- 현금영수증 -->
						<div class="addInfo addInfo2"  style="display: none;">
							<strong>이름</strong> <input type="text" id="bill_name" name="bill_name" style="width:70px;" value="${userInfo.name}" />
							<strong>휴대전화</strong> <input type="text" id="bill_handphone01" name="bill_handphone01" style="width:55px;" value="${han_handphone[0]}"  /> - 
							<input type="text" id="bill_handphone02" name="bill_handphone02" style="width:55px;" value="${han_handphone[1]}"/> - 
							<input type="text" id="bill_handphone03" name="bill_handphone03" style="width:55px;" value="${han_handphone[2]}" />
						</div>
					</li>
				</ul>
			</div>
			<!-- btnarea -->
			
				<div class="btn_area01">
					<a href="#"><span class="cw h60">취소</span></a>
					<a href="/m05/02_end.do" id="orderYakBtn"><span class="cg h60">주문하기</span></a>
				</div>
				<input type="hidden" name="payment_kind" id="payment_kind" value=""/>
				<input type="hidden" name="all_seqno" value="${bean.all_seqno}" />
				<input type="hidden" name="delivery_price" value="${sum_delivery_tot}" />
				<input type="hidden" name="ea" value="${ea}" />
				
				<fmt:parseNumber var="i_sum_goods_tot" type="number" value="${sum_goods_tot}" />

				<input type="hidden" name="tot_price" value="${i_sum_goods_tot}" /> <!-- 체크용 -->
				
				
				<c:set var="tel" value="${fn:split(userInfo.tel,'-')}" />
				<input type="hidden" id="han_addr1" 		value="${userInfo.address01}" />
				<input type="hidden" id="han_addr2" 		value="${userInfo.address02}" />
				<input type="hidden" id="han_zip"   		value="${userInfo.zipcode}" />
				<input type="hidden" id="han_handphone01"   value="${han_handphone[0]}">
				<input type="hidden" id="han_handphone02"   value="${han_handphone[1]}"> 
				<input type="hidden" id="han_handphone03"   value="${han_handphone[2]}"> 
				<input type="hidden" id="han_han_name"   	value="${userInfo.han_name}" name="han_name">
				
				
				<input type="hidden" id="han_tel01"   value="${tel[0]}">
				<input type="hidden" id="han_tel02"   value="${tel[1]}"> 
				<input type="hidden" id="han_tel03"   value="${tel[2]}"> 
				
				
				<input type="hidden" name="p_seq"   value="${bean.p_seq}">
				<input type="hidden" name="page"   value="${bean.page}">
				
				
			<!-- //btnarea -->
			
			<script>
				$(document).ready(function() {
					 
					/* var referrer =  document.referrer;
					if(referrer.indexOf('/m03/01_view.do') == -1){
						alert('잘못된 경로입니다.');
						location.href='/m03/01.do';
						return;
					}
					 */
					 
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
						
						
						if(!valCheck( 'r_name' ,'발신인을 입력하세요.') ) return false;
						if(!valCheck( 'r_handphone01' ,'휴대전화를 입력하세요.') ) return false;
						if(!valCheck( 'r_handphone02' ,'휴대전화를 입력하세요.') ) return false;
						if(!valCheck( 'r_handphone03' ,'휴대전화를 입력하세요.') ) return false;
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
								if(!valCheck( 'bill_name' ,'이름을 입력하세요.') ) return false;
								if(!valCheck( 'bill_handphone01' ,'휴대전화 번호를 입력하세요.') ) return false;
								if(!valCheck( 'bill_handphone02' ,'휴대전화 번호를 입력하세요.') ) return false;
								if(!valCheck( 'bill_handphone03' ,'휴대전화 번호를 입력하세요.') ) return false;
							}
							
							if(confirm('해당정보로 주문하겠습니까?')){
								$('#frm').submit();
								return false;
							}
						}
						
						if(payment_kind == 'Card'){
							nicepayStart();
						}
						return false;
					});
					
					$(".pay_type_select a span").click(function() {
						$('.pay_type_select a span').removeClass('cblue1');							
						$('.pay_type_select a span').addClass('cBB');
						
						$(this).removeClass('cBB');
						$(this).addClass('cblue1');
						
						var type = $(this).html();
						if(type == '신용카드'){
							$('#tax_bill_area').hide();
							$('.addInfo').hide();
							$('#payment_kind').val('Card');
						}else{
							$('#tax_bill_area').show();
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
					
					$("input:radio[name=ship_type_to]").click(function(){
						settingOrderAddr('r', $(this).val())
					});
					
					$("input:radio[name=ship_type_from]").click(function(){
						settingOrderAddr('o', $(this).val())
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
						$('#'+type+'_handphone01').val($('#han_handphone01').val());
						$('#'+type+'_handphone02').val($('#han_handphone02').val());
						$('#'+type+'_handphone03').val($('#han_handphone03').val());
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
		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
	</form>
	
</div>
<!-- //container -->	