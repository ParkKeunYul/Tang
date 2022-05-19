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
<!-- container -->

<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "마이페이지";
		String sec_nm = "마이페이지";
		String thr_nm = "장바구니";
		int fir_n = 5;
		int sub_n = 2;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	
	<style>
		.cart_list tfoot .totalBoxfoot .Bt01,
		.cart_list tfoot .totalBoxfoot .Bt02{
			background: none;
		}
		
		.cblue1 {background:#436782; color:#ffffff;border:1px solid #444444;}
		.cblue1:hover {background:#345b79;}
	</style>
	
	<script src="<%=Const.NP_url%>" type="text/javascript"></script>
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
		
		
		String goodsCnt         = bean.get("goods_cnt")+"";         // 결제상품개수
		String goodsName        = bean.get("goods_name")+"";        // 결제상품명
		String Amt            	= bean.get("goods_tot")+"";         // 결제상품금액
		
		System.out.println("goods_tot = "+ bean.get("goods_tot"));
		
		String moid             = Const.NP_moid+"t"+(String.format("%08d", StringUtil.ObjectToInt(bean.get("goods_seq"))));              // 상품주문번호      
			
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
	<div id="contents">
		<c:if test="${fn:length(list) eq 0}">
			<script>alert('결재할 처방이 없습니다.');location.href='/m05/02.do';</script>
		</c:if>
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit">장바구니</p>
			<p>주문하고자 하는 처방명을 클릭 후 <strong>배송정보 및 미기입 사항을 입력하셔야만 선택버튼이 활성화 되어 주문</strong> 할 수 있습니다.<br/><strong>복수 선택을 하여 한번에 주문</strong> 할 수도 있습니다.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">
			<form action="/m05/02_cart_plus_order_com.do" name="frm" id="frm" method="post">
				<!-- cartview -->
				<table class="cart_list">
					<colgroup>
						<col width="120px" />
						<col width="120px" />
						<col width="140px" />
						<col width="*" />
						<col width="130px" />
						<col width="180px" />
					</colgroup>
					<thead>
						<tr>
							<th>처방일자</th>
							<th>담당한의사</th>
							<th>환자명</th>
							<th>처방명</th>
							<th>합계금액</th>
							<th>배송지</th>
						</tr>
					</thead>
					<tbody>
						<c:set var = "sum1" value = "0" />
						<c:forEach var="list" items="${list}">
							<c:set var="q" value="${q+1}"></c:set>
							<tr>
								<td>${list.wdate2}</td>
								<td>${list.name }</td>
								<td>${list.han_name }</td>
								<td class="L">${list.s_name}</td>
								<td class="R fc01"><fmt:formatNumber value="${list.order_total_price}" pattern="#,###원" /></td>
								<td>
									<c:choose>
										<c:when test="${list.d_type eq 1 }">원외탕전 → 한의원</c:when>
										<c:when test="${list.d_type eq 4 }">원외탕전 → 환자</c:when>
										<c:when test="${list.d_type eq 3 }">한의원 → 환자</c:when>
										<c:when test="${list.d_type eq 6 }">방문수령</c:when>
									</c:choose>
									
								</td>
							</tr>
							<c:set var="sum1" value = "${sum1 + list.order_total_price}" />
							<input type="hidden" name="cart_seqno" id="cart_seqno${q}" value="${list.seqno}" />
							<input type="hidden" name="s_name" id="s_name${q}" value="${list.s_name}" />
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="6" class="totalBoxfoot">
								<ul class="fr">
									<li class="Bt01">총금액<span class="won"><fmt:formatNumber value="${sum1}" pattern="#,###원" /></span></li>
									<li class="Bt02">배송비<span class="won" style="color: red;">- <fmt:formatNumber value="${delivery_price}" pattern="#,###원" /></span></li>
									<li class="total">합계<span class="won"><fmt:formatNumber value="${sum1 - delivery_price}" pattern="#,###원" /></span></li>
								</ul>
							</td>
						</tr>
					</tfoot>
				</table>
				
				<div id="nice_pay_setting_area" style="display: none;">
					<input type="text"   name="PayMethod"   value="CARD">
					<input type="text"   name="GoodsName"   value="<%=goodsName%>"> <!-- 상품명 -->
					<input type="text"   name="GoodsCnt"    value="<%=goodsCnt%>"> <!-- 상품겟수 -->
					<input type="text"   name="Amt"         value="${sum1 - delivery_price}"> <!-- 결제금액 -->
					<input type="text"   name="BuyerName"   value="${userInfo.name}">
					<input type="hidden" name="BuyerTel"    value="${userInfo.handphone}">
					<input type="text"   name="Moid"        value="<%=moid%>">
					<input type="text"   name="MID"         value="<%=MID%>">
					
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
				
				
				<script>
					var a_delivery_price  = 4000;
					var a_sale_per        = 0;
				
					$(document).ready(function() {
						a_sale_per = parseInt( $('#sale_per').val() );
						
						$(".pay_type_select a span").click(function() {
							$('.pay_type_select a span').removeClass('cblue1');							
							$('.pay_type_select a span').addClass('cBB');
							
							$(this).removeClass('cBB');
							$(this).addClass('cblue1');
							
							var type = $(this).html();
							if(type == '신용카드'){
								$('#tax_bill_area').hide();
								$('#payment_kind').val('Card');
							}else{
								$('#tax_bill_area').show();
								$('#payment_kind').val('Bank');
							}
							
							return false;
						});
						
						$("#orderBtn").click(function() {
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
								return false;
							}
							
							return false;
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
						
						
						$('input[name="bill_part"]').change(function() {
							var bill = $(this).val();
							$('.addInfo').hide();
							$('.addInfo'+bill).show();
						});
					});
				
				</script>
				
				<c:set var="han_handphone" value="${fn:split(userInfo.handphone,'-')}" />
				<!-- //cartlist -->
				<div class="totalend">
					<ul>
						<li class="tit">결제수단</li>
						<li class="pay_type_select">
							<a href="#"><span class="cBB h30">신용카드</span></a>
							<a href="#"><span class="cBB h30">무통장 입금</span></a>
						</li>
						<li >
							<div id="tax_bill_area" style="display: none;" class="tax_bill">
								<label for="bill_part1"><input type="radio" name="bill_part" id="bill_part1" value="1" />세금계산서</label>
								<label for="bill_part2"><input type="radio" name="bill_part" id="bill_part2" value="2" />현금영수증</label>
								<label for="bill_part3"><input type="radio" name="bill_part" id="bill_part3" value="3" checked="checked" />미신청</label>								
							</div>
							<!-- 세금계산서 -->
							<div class="addInfo addInfo1" style="display: none;">
								<strong>이메일</strong> <input type="text"  name="bill_email" id="bill_email" style="width:250px;"  value="${userInfo.email }"/>
							</div>
							<!-- 현금영수증 -->
							<div class="addInfo addInfo2"  style="display: none;">
								<strong>이름</strong> <input type="text" id="bill_name" name="bill_name" style="width:70px;" value="${userInfo.name}" />
								<strong>휴대전화</strong> <input type="text" id="bill_handphone01" name="bill_handphone01" style="width:55px;" value="${han_handphone[0]}" /> - 
								<input type="text" id="bill_handphone02" name="bill_handphone02" style="width:55px;" value="${han_handphone[1]}" /> - 
								<input type="text" id="bill_handphone03" name="bill_handphone03" style="width:55px;" value="${han_handphone[2]}" />
							</div>
							
						</li>
					</ul>
				</div>
				<!-- btnarea -->
				<div class="btn_area01">
					<a href="/m05/02.do"><span class="cw h60">취소</span></a>
					<a href="02_cart_plus_order_end.do" id="orderBtn" ><span class="cg h60">주문하기</span></a>
				</div>
				<!-- //btnarea -->
				
				<input type="hidden" name="member_sale" id="member_sale" value="${member_sale}"/>
				<input type="hidden" name="delivery_price" id="delivery_price" value="${delivery_price}"/>
				<input type="hidden" name="payment_kind" id="payment_kind" value=""/>
				<input type="hidden" id="pay_total_order_price" name="pay_total_order_price" value="${sum1 - delivery_price}" />
			</form>
		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
	
</div>
<!-- //container -->	
