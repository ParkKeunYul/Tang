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
			var pre_req    = $('#pre_req').val();
			
			
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

		<!-- 본문내용 -->
		<!-- orderview -->
		<table class="order_view">
			<colgroup>						
				<col width="50px" />
				<col width="*" />
				<col width="90px" />
				<col width="130px" />
				<col width="140px" />
				<col width="150px" />
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
							<input type="hidden" id="box_option_${list.seqno}" value="${list.box_option_price}" />
							<input type="hidden" id="p_seq_${list.seqno}" value="${list.goods_seq}" />
							<input type="hidden" id="pre_req_${list.seqno}" value="${list.pre_req}" />
						</td>
						<td class="L">
							<p class="img"><img src="/upload/goods/${list.image}" class="am" alt="${list.p_name }"  style="width: 60px;height: 60px;"/></p>
							<div class="name">
								<a href="/m03/01_view.do?p_seq=${list.p_seq}" style="text-decoration: none;color: #222222;">${list.goods_name }</a>
								<c:if test="${list.box_option_seqno ne 0 && list.box_option_seqno ne null }">
									<p class="opttxt">
										- 옵션 : ${list.box_option_nm }(+<fmt:formatNumber value="${list.box_option_price}" pattern="#,###" />)
									</p>
								</c:if>								
							</div>												
						</td>							
						<td  <c:if test="${list.p_ea eq '처방불가'}">style="color:red;"</c:if>>${list.p_ea}</td> 
						<td class="R"><strong id="txt_price_${list.seqno}"><fmt:formatNumber value="${list.p_price}" pattern="#,###" /></strong>원</td>
						<td>
							<input type="text"  value="${list.ea}" id="ea_${list.seqno}" class="goods_ea" style="text-align: right;padding-right: 15px;" maxlength="4" />
							<a href="#" style="margin-left: -4px;" attr="${list.seqno}" class="cartUpdateBtn"><span class="cB h25">수정</span></a>
						</td>
						<td class="R"><strong id="txt_price_tot_${list.seqno}"><fmt:formatNumber value="${list.goods_tot}" pattern="#,###" /></strong>원</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="mt10">
			<a href="#" id="delCartBtn"><span class="cw h30">선택항목 삭제</span></a>
			<p class="bluetxt02">* <fmt:formatNumber value="${bean.freeDeileveryLimit}" pattern="#,###" />원 이상 주문할 경우 배송료 면제됩니다.</p>
		</div>
		<!-- // orderview -->
		
		<!-- btnarea -->
		<form action="02_order_app_cart.do" name="frm" id="frm" method="post">
			<input type="hidden" name="all_seqno" id="all_seqno" />
			<c:if test="${userInfo.member_level ne 0 && userInfo.member_level ne 1 }">
				<div class="btn_area01">
					<a href="#" id="appOrderBtn"><span class="cg h60">발송요청하기</span></a>
				</div>
			</c:if>
		</form>
		<!-- //btnarea -->
		<!-- //본문내용 -->
	
	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		