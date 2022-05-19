<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- container -->
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "약속처방";
		String sec_nm = "약속처방";
		String thr_nm = "처방하기";
		int fir_n = 3;
		int sub_n = 1;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	<script>
	
	var a_ajax_cart_flag = true;
	
	$(document).ready(function() {
		$("#minusBtn").click(function() {
			var ea = parseInt($('#ea').val());
			if(ea <= 0){
				ea = 0;
			}else{
				ea = ea - 1;
			}
			$('#ea').val(ea);
			return false;
		});
		
		$("#plusBtn").click(function() {
			var ea = parseInt($('#ea').val());
			if(ea >= 99){
				ea = 99;
			}else{
				ea = ea + 1;
			}
			$('#ea').val(ea);
			return false;
		});
		
		
		
		$("#saveOrderBtn").click(function() {
			var ea = parseInt($('#ea').val());
			
			if(ea <= 0){
				alert('최소 수량은 1개 이상이여야 합니다.');
				return false;
			}
			
			if(!$("input:checkbox[name='agree']").is(":checked")){
				alert('사전조제 처방구성 및 제법 사용을\n동의후 즉시발송 가능합니다.');
				return false;
			}
			
			$('#frm').submit();
			
			return false;
		});
		
		$("#saveCartBtn").click(function() {
			var ea = parseInt($('#ea').val());
			
			if(ea <= 0){
				alert('최소 수량은 1개 이상이여야 합니다.');
				return false;
			}
			
			if(!$("input:checkbox[name='agree']").is(":checked")){
				alert('사전조제 처방구성 및 제법 사용을\n동의후 보관 가능합니다.');
				return false;
			}
			
			if(!a_ajax_cart_flag){
				return false;
			}
			
			$.ajax({
				url : '/m03/01_add_cart.do',
				type : 'POST',
				data : {
					 p_seq : $('#p_seq').val()   
					,ea    : $('#ea').val()
				},
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(data) {
					if(data.suc){
						a_ajax_cart_flag = true;
 						$('#agree').prop('checked', false);
 						if(confirm('약속처방 보관함에 저장되었습니다.\n약속처방 보관함으로 이동하겠습니까?')){
 							location.href='/m03/02.do';
 						}
					}else{
						alert(data.msg);	
					}
					
				}
			});
			
			return false;
		});
		
	});
	</script>
	<!-- contents -->
	<div id="contents">
		<!-- 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">
		<form action="/m03/01_add_order.do" name="frm" id="frm" method="post" >
			<input type="hidden" name="p_seq" id="p_seq" value="${view.p_seq}" />
			<input type="hidden" name="page" id="page" value="${bean.page}" />
			<input type="hidden" name="mem_sub_grade" 	id="mem_sub_grade" 	value="${userInfo.mem_sub_grade}" />
			<input type="hidden" name="mem_sub_seqno"   id="mem_sub_seqno" 	value="${userInfo.mem_sub_seqno}"   />
			
			<!-- product_view -->
			<div class="product_view">
				<!-- 상품정보 -->
				<ul class="product_info">
					<li class="imgA">
						<img src="/upload/goods/${view.image}" alt="${view.p_name }"  style="width: 402px;height: 402px;"  />
					</li>
					<li>
						<div class="infoA">
							<p class="tit">
								${view.p_name }
								<span class="btok">처방가능</span>
							</p>
							<div class="info">
								<table>
									<colgroup>
										<col width="175px" />
										<col width="110px" />
									</colgroup>
									<tr>
										<td>용량</td>
										<td>${view.p_size}</td>
									</tr>
									<tr>
										<td>포장단위</td>
										<td>${view.set_design}</td>
									</tr>
									<tr>
										<td colspan="2" height="10"></td>
									</tr>
									<tr>
										<td class="pricetit">판매금액</td>
										<td class="priceR">
											<c:choose>
												<c:when test="${userInfo.mem_sub_grade eq 2}">
													***,***원
												</c:when>
												<c:otherwise>										
													<fmt:formatNumber value="${view.p_price}" pattern="#,###원" />
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<tr>
										<td class="pricetit">수량</td>
										<td class="priceR">
											<div>
												<a href="#" class="bt" id="minusBtn">-</a>
												<input type="text" class="amount" id="ea" name="ea" value="1" style="text-align: center;"  maxlength="2" />
												<a href="#" class="bt" id="plusBtn">+</a>
											</div>
										</td>
									</tr>
								</table>
							</div>
							<p class="check">
								<input type="checkbox" id="agree" name="agree" /> <label for="agree" style="margin-left:0px;">사전조제 처방구성 및 제법 사용을 동의합니다.</label>
							</p>
							<p class="btnArea">
								<a href="#" id="saveCartBtn"><span class="bt_cart">처방보관함(장바구니)</span></a>
								<c:if test="${userInfo.mem_sub_grade ne 2}">
									<a href="#" id="saveOrderBtn"><span class="bt_now">즉시발송</span></a>
								</c:if>
							</p>
						</div>
					</li>
				</ul>
				<!-- // 상품정보 -->
				<!-- 상품 상세 -->
				<div class="div_tit mt70">상품정보</div>
				<div class="product_detail">
					<c:set var="yak_design1" value="${fn:split(view.yak_design1,'|')}" />
					<c:set var="yak_design2" value="${fn:split(view.yak_design2,'|')}" />
					<c:set var="yak_design3" value="${fn:split(view.yak_design3,'|')}" />
					<c:set var="yak_design4" value="${fn:split(view.yak_design4,'|')}" />
					<c:set var="yak_design5" value="${fn:split(view.yak_design5,'|')}" />
					<c:set var="yak_design6" value="${fn:split(view.yak_design6,'|')}" />
					<c:set var="yak_design7" value="${fn:split(view.yak_design7,'|')}" />
					<c:set var="yak_design8" value="${fn:split(view.yak_design8,'|')}" />
					<c:set var="yak_design9" value="${fn:split(view.yak_design9,'|')}" />
					<c:set var="yak_design10" value="${fn:split(view.yak_design10,'|')}" />
					<c:set var="yak_design11" value="${fn:split(view.yak_design11,'|')}" />
					<c:set var="yak_design12" value="${fn:split(view.yak_design12,'|')}" />
					<c:set var="yak_design13" value="${fn:split(view.yak_design13,'|')}" />
					<c:set var="yak_design14" value="${fn:split(view.yak_design14,'|')}" />
					<c:set var="yak_design15" value="${fn:split(view.yak_design15,'|')}" />
					
					<strong>처방구성 및 제법</strong><br/>
					<c:if test="${!empty view.jo_from}">* 출전 : ${view.jo_from}<br/></c:if>
					* 처방구성 : 
					${yak_design1[0]}  ${yak_design1[2]}<c:if test="${!empty yak_design1[2]}">g</c:if> 
					${yak_design2[0]}  ${yak_design2[2]}<c:if test="${!empty yak_design2[2]}">g</c:if> 
					${yak_design3[0]}  ${yak_design3[2]}<c:if test="${!empty yak_design3[2]}">g</c:if> 
					${yak_design4[0]}  ${yak_design4[2]}<c:if test="${!empty yak_design4[2]}">g</c:if> 
					${yak_design5[0]}  ${yak_design5[2]}<c:if test="${!empty yak_design5[2]}">g</c:if> 
					${yak_design6[0]}  ${yak_design6[2]}<c:if test="${!empty yak_design6[2]}">g</c:if> 
					${yak_design7[0]}  ${yak_design7[2]}<c:if test="${!empty yak_design7[2]}">g</c:if> 
					${yak_design8[0]}  ${yak_design8[2]}<c:if test="${!empty yak_design8[2]}">g</c:if> 
					${yak_design9[0]}  ${yak_design9[2]}<c:if test="${!empty yak_design9[2]}">g</c:if> 
					${yak_design10[0]} ${yak_design10[2]}<c:if test="${!empty yak_design10[2]}">g</c:if> 
					${yak_design11[0]} ${yak_design11[2]}<c:if test="${!empty yak_design11[2]}">g</c:if> 
					${yak_design12[0]} ${yak_design12[2]}<c:if test="${!empty yak_design12[2]}">g</c:if> 
					${yak_design13[0]} ${yak_design13[2]}<c:if test="${!empty yak_design13[2]}">g</c:if> 
					${yak_design14[0]} ${yak_design14[2]}<c:if test="${!empty yak_design14[2]}">g</c:if> 
					${yak_design15[0]} ${yak_design15[2]}<c:if test="${!empty yak_design15[2]}">g</c:if> 
					<br/><br/>
					<strong>상품설명</strong><br/>
					${view.p_contents}
				</div>
				<!-- // 상품 상세 -->
			</div>
			<!-- //product_view -->
			<!-- btnarea -->
			<div class="btn_area02">
				<a href="01.do?page=${bean.page}"><span class="cglay h40">목록보기</span></a>
			</div>
			<!-- //btnarea -->
		</form>
		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	