<%@page import="kr.co.hany.common.Const"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%-- ${info } --%>
<table class="basic01">
	<colgroup>
		<col width="15%" />
		<col width="*%" />
	</colgroup>
	<tbody>
	<tr>
		<th>성명</th>
		<td class="tdL">${info.mem_name }</td>
	</tr>
	<tr>
		<th>상품명</th>
		<td class="tdL">${info.a_title }</td>
	</tr>
	<tr>
		<th>상품가격</th>
		<td class="tdL"><fmt:formatNumber value="${info.amount_price}" pattern="#,###" /></td>
	</tr>
	<tr>
		<th>상품포인트</th>
		<td class="tdL"><fmt:formatNumber value="${info.point}" pattern="#,###" /></td>
	</tr>
	<tr>
		<th>구매수량</th>
		<td class="tdL">${info.ea}</td>
	</tr>
	<tr>
		<th>총 결제금액</th>
		<td class="tdL"><fmt:formatNumber value="${info.tot_price}" pattern="#,###" /></td>
	</tr>
	<tr>
		<th>총 충전 포인트</th>
		<td class="tdL"><fmt:formatNumber value="${info.tot_point}" pattern="#,###" /></td>
	</tr>
	<tr>
		<th>결제정보</th>
		<td class="tdL">
			${info.card_gu_no } <br/>
			${info.card_ju_no } <br/> 
			${info.card_su_no } <br/>
			${info.card_nm } <br/>
			${info.card_quota } <br/> 
			${info.card_amt } <br/>  
			<c:if test="${info.cancel_yn ne 'y'}">
				<a href="#" id="cardCancelBtn" class="btn02" style="color: white;">결제취소</a>
			</c:if>
			
			<div style="display:none;" >
				<form name="keyin_cancel_frm" method="post" id="keyin_cancel_frm">
					1
					<input type="text" name="seqno"  		id="seqno" 	value="${info.seqno}" />
					<input type="text" name="mem_seqno"  	id="mem_seqno" 	value="${info.mem_seqno}" />
					<input type="text" name="pp_seqno"  	id="pp_seqno" 	value="0" />
					<input type="text" name=point  	id="point" 	value="${info.tot_point}" />
					<input type="text" name="reason" 	    value="카드결제취소">
					<input type="text" name="CancelMsg" 	    value="고객변심">
					<input type="text" name="CancelAmt" 	id="c_CancelAmt" value="${info.tot_price}">
					<input type="text" name="TID" 			id="c_TID" value="${info.card_gu_no}">
					<input type="text" name="MID" 			id="c_MID"  value="<%=Const.NP_MID%>">
					<input type="text" name="CancelPwd" 	value="<%=Const.NP_c_pass%>">
					<select name="PartialCancelCode" 		id="c_PartialCancelCode">
	                   <option value="0" >전체 취소</option> 
	                 </select>
                 </form>
             </div>
             <script>
				$(document).ready(function() {
					$('#cardCancelBtn').click(function(){
						console.log('카드 결제 취소');
						
						if(!confirm('카드 결제금액을 취소하겠습니까?')){
							return false;
						}
						
						$.ajax({
							url : '/admin/item/amountHis/card_cancel.do',
							data : $("#keyin_cancel_frm").serialize(),        
					        error: function(){
						    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
						    },
						    success: function(data){
						    	console.log(data);
								alert(data.msg);
						    	if(data.suc){
						    		$("#jqGrid").trigger("reloadGrid");
						    		
						    		$('#card_cancel_info').html(data.card_cancel_id);
						    	}
						    }   
						});
						return false;
					});
					
					var card_cancel_id = $('#card_cancel_id').val();
					if(card_cancel_id != '' && card_cancel_id != null){
						$('#cardCancelArea').show();
					}
				});
			</script>
		</td>
	</tr>
	<tr>
		<th>결제취소정보</th>
		<td class="tdL">
			<span id="card_cancel_info">${info.card_cancel_id} / ${info.card_cancel_date}<br/></span>
		</td>	
	</tr>
	
	
		<%-- <tr >				
			<th>취소요청</th>
			<td class="tdL">
				<c:if test="${info.cancel_ing eq 'y'}"><font style="color: red;">주문자에 의해 취소 요청된 주문건</font></c:if>
				<c:if test="${info.cancel_ing eq 'i'}">
					<script>
						$(document).ready(function() {
							$('#cardCancelBtn').click(function(){
								console.log('카드 결제 취소');
								
								if(!confirm('카드 결제금액을 취소하겠습니까?')){
									return false;
								}
								
								$.ajax({
									url : 'card_cancel.do',
									data : $("#keyin_cancel_frm").serialize(),        
							        error: function(){
								    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
								    },
								    success: function(data){
								    	console.log(data);
										alert(data.msg);
								    	if(data.suc){
								    		$("#jqGrid").trigger("reloadGrid");
								    		
								    		$('#card_cancel_info').html(data.card_cancel_id);
								    		$('#cardCancelArea').show();
								    		$('#cardCancelBtn').hide();
								    	}
								    }   
								});
								return false;
							});
							
							var card_cancel_id = $('#card_cancel_id').val();
							if(card_cancel_id != '' && card_cancel_id != null){
								$('#cardCancelArea').show();
							}
						});
					</script>
					<c:if test="${info.payment_kind eq 'Card' && empty info.card_cancel_id }">
						<a href="#" id="cardCancelBtn"    class="btn03" style="vertical-align: top;">카드 결제 전액 취소</a>
					</c:if>
					<div style="display: none;" id="cardCancelArea">
						카드 취소 정보 : <span id="card_cancel_info">${info.card_cancel_id}/${info.card_cancel_date}<br/>/${info.card_cancel_tid}</span>
					</div>
					<div style="display:none;" >
						<input type="text" id="card_cancel_id" value="${info.card_cancel_id}" />
						<form name="keyin_cancel_frm" method="post" id="keyin_cancel_frm">
							<input type="text" name="c_seqno"  		id="c_seqno" 	value="${info.seqno}" />
							<input type="text" name="CancelMsg" 	value="고객취소">
							<input type="text" name="CancelAmt" 	id="c_CancelAmt" value="${info.order_total_price}">
							<input type="text" name="TID" 			id="c_TID" value="${info.card_gu_no}">
							<input type="text" name="MID" 			id="c_MID"  value="<%=Const.NP_MID%>">
							<input type="text" name="CancelPwd" 	value="<%=Const.NP_c_pass%>">
							<select name="PartialCancelCode" 		id="c_PartialCancelCode">
			                   <option value="0" >전체 취소</option> 
			                 </select>
		                 </form>
	                 </div>
				</c:if>
			</td>
			<th>승인번호</th>
			<td class="tdL">${info.card_su_no}</td>
		</tr> --%>
	</tbody>
</table>
