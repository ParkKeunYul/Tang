<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			
			var seqno      = $(this).attr('attr');
			var ea         = parseInt( $('#ea_'+seqno).val() );
			var p_price    = parseInt( $('#price_'+seqno).val() );
			var box_option = parseInt( $('#box_option_'+seqno).val() );
			var p_seq      = $('#p_seq_'+seqno).val()
			var pre_req    = $('#pre_req'+seqno).val()
			
			
			var tot_price = (ea * p_price) + box_option;
			 
			if(ea <= 0){
				alert('수량은 최소 0 이상을 입력해야 합니다.');
				return false;
			}
			$.ajax({
				url : '/m03/02_mod_cart_ea.do',
				type : 'POST',
				data : {
					 seqno   : seqno
					,ea      : ea
					,p_seq   : p_seq
					,pre_req : pre_req
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
	});
</script>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">약속처방 보관함</p>
		<div class="lnbDepth">
			<ul>
				<li><a href="01.do">약속처방</a></li>
				<li class="sel"><a href="02.do">약속처방 보관함</a></li>
				<li><a href="03.do">사전조제지시서</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<div class="contents" id="contents">
		<!-- productCart -->
		<div class="productCart">
			<div class="check"><input type="checkbox"  id="all_check"/><label for="all_check">전체 선택</label></div>
			
			<c:forEach var="list" items="${list}">
				<c:set var="q" value="${q+1}"></c:set>
				<div class="cList" id="list_${list.seqno}">
					<input type="hidden" id="p_ea_${list.seqno}" value="${list.p_ea}" />
					<input type="hidden" id="goods_tot_${list.seqno}" value="${list.goods_tot}" />
					<input type="hidden" id="price_${list.seqno}" value="${list.p_price}" />
					<input type="hidden" id="box_option_${list.seqno}" value="${list.box_option_price}" />
					<input type="hidden" id="p_seq_${list.seqno}" value="${list.goods_seq}" />
					<input type="hidden" id="pre_req_${list.seqno}" value="${list.pre_req}" />
					
					<input type="checkbox" class="part_check" value="${list.seqno}"    />
					<div class="inner ml25">
						<div class="Dtit">
							<img src="/upload/goods/${list.image}" alt="${list.p_name }"  style="width: 60px;height: 60px;" /> 
							<p>
								<c:if test="${list.p_ea ne '처방불가'}">
									<span class="orderok">처방가능</span>
								</c:if>
								<c:if test="${list.p_ea eq '처방불가'}">
									<span class="orderno">처방불가</span>
								</c:if>
								<br/>${list.goods_name }
							</p>
						</div>
						<c:if test="${list.box_option_seqno ne 0 && list.box_option_seqno ne null }">
							<ul class="op">
								<li>- 옵션 : ${list.box_option_nm }(+<fmt:formatNumber value="${list.box_option_price}" pattern="#,###" />)</li>
							</ul>
						</c:if>
						
						<ul class="info">
							<li>
								<label class="title">상품단가</label>
								<p><strong id="txt_price_${list.seqno}"><fmt:formatNumber value="${list.p_price}" pattern="#,###" /></strong>원</p>
							</li>
							<li>
								<label class="title">수량</label>
								<p>
								<input type="text"  value="${list.ea}" id="ea_${list.seqno}" class="goods_ea" style="text-align: right;padding-right: 15px;width:53px;height: 25px;" maxlength="4" />
								<a href="#" style="margin-left: -4px;" attr="${list.seqno}" class="cartUpdateBtn"><span class="btnTypeBasic colorWhite" style="height: 25px;line-height: 25px;">수정</span></a>
								</p>
							</li>
							<li>
								<label class="title">주문금액</label>
								<p><strong id="txt_price_tot_${list.seqno}"><fmt:formatNumber value="${list.goods_tot}" pattern="#,###" /></strong>원</p>
							</li>
						</ul>
					</div>
				</div>
			</c:forEach>
			<!-- //제품정보 -->
		</div>
		<div class="bluetxt02">* <fmt:formatNumber value="${bean.freeDeileveryLimit}" pattern="#,###" />원 이상 주문할 경우 배송료 면제됩니다.</div>
		<!-- productCart -->
		<form action="02_order_app_cart.do" name="frm" id="frm" method="post">
			<input type="hidden" name="all_seqno" id="all_seqno" />
			<div class="btnArea view">
				<button type="button" id="delCartBtn" class="btnTypeBasic colorWhite"><span>선택항목 삭제</span></button>
				<c:if test="${userInfo.member_level ne 0 && userInfo.member_level ne 1 }">
					<button type="button" id="appOrderBtn" class="btnTypeBasic colorGreen"><span>발송요청하기</span></button>
				</c:if>
			</div>
		</form>
	</div>
	<!-- //본문 -->

</div>
<!-- //container -->