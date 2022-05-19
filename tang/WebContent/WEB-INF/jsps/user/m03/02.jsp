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
		String thr_nm = "약속처방 보관함";
		int fir_n = 3;
		int sub_n = 2;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	
	<!-- contents -->
	<div id="contents">
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit" style="width:270px;">약속처방 보관함</p>
			<p class="b">발송요청 상태가 <font class="fc01">"가능"</font>한 처방만 주문이 가능합니다.<font class="point">(약속처방 보관함 보관기간은 1일입니다.)</font></p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">
		<script>
			var checkboxCnt = 0;
		
			$(document).ready(function() {
				
				
				$('#all_check').click(function () {
					var cksubarr = $('.part_check'); 
					if($(this).is(":checked")){
						 $(cksubarr).each(function(i){cksubarr[i].checked = true;});
					} else {
						$(cksubarr).each(function(i){cksubarr[i].checked = false;});
					}
				});
				
				$('.part_check').click(function () {
					if($(".part_check:checkbox:checked").length == checkboxCnt){
						$('#all_check').prop("checked", true);
					}else{
						$('#all_check').prop("checked", false);
					}
				});
				
				
				$('#delCartBtn').click(function () {
					if($(".part_check:checkbox:checked").length == 0){
						alert('1개 이상 선택하세요.');
						return false;
					}
					
					var all_seqno = '';
					var i = 0;
					$(".part_check:checked").each(function() {
						var seqno = $(this).val();
						if(i == 0){
		  					all_seqno  = seqno
		  				}else{
		  					all_seqno += ','+seqno
		  				}
						i++;
					});
					
					console.log('all_seqno = ', all_seqno);
					
					$.ajax({
						url : '/m03/02_del_cart.do',
						type : 'POST',
						data : {
							seqno : all_seqno
						},
						error : function() {
							alert('에러가 발생했습니다.\n관리자에 문의하세요.');
						},
						success : function(data) {
							alert(data.msg);
							if (data.suc) {
								$(".part_check:checked").each(function() {
									var seqno = $(this).val();
									$('#list_'+seqno).remove();
									checkboxCnt = $(".part_check:checkbox").length;
								});
							}
						}
					});
					
					return false;
				});
				
				
				$('#appOrderBtn').click(function () {
					var search_sub_seqno = $('#search_sub_seqno').val();
					
					if($(".part_check:checkbox:checked").length == 0){
						alert('1개 이상 선택하세요.');
						return false;
					}
					
					var all_seqno = '';
					var i = 0;
					$(".part_check:checked").each(function() {
						var seqno = $(this).val();
						var p_ea = $('#p_ea_'+seqno).val();
						if(p_ea == '처방불가'){
							alert('처방불가능한 처방이 포함되어 있습니다.');
							return false;
						}
						if(i == 0){
		  					all_seqno  = seqno
		  				}else{
		  					all_seqno += ','+seqno
		  				}
						i++;
					});
					$('#all_seqno').val(all_seqno);
					$('#search_sub_seqno_frm').val(search_sub_seqno);
					
					
					
					$('#frm').submit();
					return false;
				});
				
				checkboxCnt = $(".part_check:checkbox").length;
				
				$(".goods_ea").on("keyup", function() {
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
				
				
				$('.cartUpdateBtn').click(function () {
					
					var seqno            = $(this).attr('attr');
					var ea               = parseInt( $('#ea_'+seqno).val() );
					var p_price          = parseInt( $('#price_'+seqno).val() );
					var tot_price        = ea * p_price;
					var search_sub_seqno = $('#search_sub_seqno').val();
					 
					if(ea <= 0){
						alert('수량은 최소 0 이상을 입력해야 합니다.');
						return false;
					}
					
					$.ajax({
						url : '/m03/02_mod_cart_ea.do',
						type : 'POST',
						data : {
							 seqno : seqno
							,ea    : ea
							,search_sub_seqno : search_sub_seqno
						},
						error : function() {
							alert('에러가 발생했습니다.\n관리자에 문의하세요.');
						},
						success : function(data) {
							alert(data.msg);
							if(data.suc){
								$('#txt_price_tot_'+seqno).html( comma(tot_price+'' ) );
							}
						}
					});
					
					return false;
				});
				
				$('#search_sub_seqno').change(function() {
					$('#sfrm').submit();
				});
			});
		</script>
			
			<%-- <c:if test="${userInfo.mem_sub_seqno ne 0 }">display: none;</c:if> --%>
			<form action="#" name="sfrm" id="sfrm" method="post">
				<div class="searchArea"  style="padding-bottom: 10px;<c:if test="${userInfo.mem_sub_seqno ne 0}">display: none;</c:if>">
					<table>
						<colgroup>
							<col width="230px" />
							<col width="220px" />
							<col width="*" />
						</colgroup>
						<tr>
							<td colspan="3">
								계정 선택 :
								<select name="search_sub_seqno" id="search_sub_seqno">
									<option value="0"  <c:if test="${bean.search_sub_seqno eq 0}">selected="selected"</c:if> >마스터  : ${userInfo.id} [ ${userInfo.name} ]</option>
									<c:forEach var="list" items="${sub_id}">
										<c:set var="sub_grade" value="부원장" />
										<c:if test="${list.grade eq 2 }"><c:set var="sub_grade" value="직원" /></c:if>
										<option value="${list.seqno}"  <c:if test="${bean.search_sub_seqno eq list.seqno }">selected="selected"</c:if>>${sub_grade} :  ${list.id} [ ${list.name} ]</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
					
				</div>
			</form>
			
			<!-- orderview -->
			<table class="order_view">
				<colgroup>						
					<col width="50px" />
					<col width="*" />
					<col width="100px" />
					<col width="140px" />
					<col width="160px" />
					<col width="140px" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>상품정보</th>
						<th>발송요청</th>
						<th>상품단가</th>
						<th>수량</th>
						<th>합계</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
						<c:set var="q" value="${q+1}"></c:set>
						<tr id="list_${list.seqno}">
							<td>
								<input type="checkbox" class="part_check" value="${list.seqno}"   />
								<input type="hidden" id="p_ea_${list.seqno}" value="${list.p_ea}" />
								<input type="hidden" id="goods_tot_${list.seqno}" value="${list.goods_tot}" />
								<input type="hidden" id="price_${list.seqno}" value="${list.p_price}" />
							</td>
							<td class="L">
								<a href="/m03/01_view.do?p_seq=${list.p_seq}" style="text-decoration: none;">
									<img src="/upload/goods/${list.image}" style="width: 60px;height: 60px;"  class="am" alt="${list.p_name }" /> ${list.goods_name }
								</a>
							</td>							
							<td<c:if test="${list.p_ea eq '처방불가'}">style="color:red;"</c:if>>${list.p_ea}</td> 
							<td class="R">
								<c:if test="${userInfo.mem_sub_grade eq 2}"><strong>***,***</strong></c:if>
								
								<strong id="txt_price_${list.seqno}"  <c:if test="${userInfo.mem_sub_grade eq 2}">style="display: none;"</c:if> ><fmt:formatNumber value="${list.p_price}" pattern="#,###" /></strong>원
							</td>
							<td>
								<input type="text"  value="${list.ea}" id="ea_${list.seqno}"  class="goods_ea"   maxlength="3" style="width: 30px;text-align: center;margin-right: 0px;height: 24px;" />
								<a href="#" style="margin-left: -4px;" attr="${list.seqno}" class="cartUpdateBtn"><span class="cB h25">수정</span></a>
							</td>
							<td class="R">
								<c:if test="${userInfo.mem_sub_grade eq 2}"><strong>***,***</strong></c:if>
								<strong id="txt_price_tot_${list.seqno}" <c:if test="${userInfo.mem_sub_grade eq 2}">style="display: none;"</c:if> ><fmt:formatNumber value="${list.goods_tot}" pattern="#,###" /></strong>원
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="mt10">
				<a href="#" id="delCartBtn"><span class="cBB h30">선택항목 삭제</span></a>
			</div>
			<!-- // orderview -->
			
			<c:if test="${userInfo.mem_sub_grade ne 2}">
			<!-- btnarea -->
			<form action="02_order_app_cart.do" name="frm" id="frm" method="post">
				<input type="hidden" name="all_seqno" id="all_seqno" />
				<input type="hidden" name="search_sub_seqno" id="search_sub_seqno_frm" />
				
				<div class="btn_area01">
					<a href="02_order_app.do" id="appOrderBtn"><span class="cg h60">발송요청하기</span></a>
				</div>
			</form>
			<!-- //btnarea -->
			</c:if>

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	