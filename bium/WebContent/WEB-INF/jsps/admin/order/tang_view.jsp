<%@page import="kr.co.hany.common.Const"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<style>
	.totalBox .Bt01{
		background: url("/assets/admin/images/bg_m.png") no-repeat right 17px;;
	}
</style>
<script>
$(document).ready(function() {
	
	$('#order_detail').click(function(){
  		var seqno = $('#a_seqno').val();
  		
  		var width  = 820;
 	    var height = 700;
		var left2  = window.pageXOffset + parseInt( ( $(window).width()/2 )  - (width/2)  );
 	    var top2   = window.pageYOffset + parseInt( ( $(window).height()/2 ) - (height/2) );
  		
  		window.open ("/admin/order/tang/detail_view.do?seqno=" + seqno,"over_view_","toolbar=no, location=no, directories=no,resizable=no,left="+left2+",top="+top2+", width="+width+", height="+height+",scrollbars=yes")
  		return;
  	});
	
	
	$('#order_detai2').click(function(){
  		var seqno = $('#a_seqno').val();
  		
  		var width  = 820;
 	    var height = 700;
		var left2  = window.pageXOffset + parseInt( ( $(window).width()/2 )  - (width/2)  );
 	    var top2   = window.pageYOffset + parseInt( ( $(window).height()/2 ) - (height/2) );
  		
  		window.open ("/admin/order/tang/detail_view2.do?seqno=" + seqno,"over_view2_","toolbar=no, location=no, directories=no,resizable=no,left="+left2+",top="+top2+", width="+width+", height="+height+",scrollbars=yes")
  		return;
  	});
	
	
	$('.upt_col').change(function(){
		var param = {
			 cellName  : $(this).attr('attr')
			,cellValue : $(this).val()
			,seqno     : $('#a_seqno').val()
			,oper      : 'edit'
		}
		update_one(param);
		return;
	});
	
	$('.upt_colBtn').click(function(){
		
		var param = {
			 cellName  : $(this).attr('attr')
			,cellValue : $('#'+$(this).attr('attr')).val()
			,seqno     : $('#a_seqno').val()
			,oper      : 'edit'
		}
		update_one(param, true);
		return;
	});
	
	$('#dInfoBtn').click(function(){
		
		if(!confirm('수취인정보를 변경하겠습니까?')){
			return false;
		}
		
		var param ={
			 seqno          : $('#a_seqno').val()
			,d_to_name      : $('#d_to_name').val()
			,d_to_tel       : $('#d_to_tel').val()
			,d_to_handphone : $('#d_to_handphone').val()
			,d_to_zipcode   : $('#d_to_zipcode').val()
			,d_to_address01 : $('#d_to_address01').val()
			,d_to_address02 : $('#d_to_address02').val()
		};
		
		$.ajax({
			url : '/admin/order/tang/update_d_info.do',
			type : 'POST',
			data : param,
			error : function() {
				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			},
			success : function(data) {
				alert(data.msg);
			}
		});
		
		return false;
	});
	
	var delivery_no = $('#delivery_no').val();
	var sel_delivery_fuc = false;
	if(delivery_no.length == 0){
		sel_delivery_fuc = true;			
	}
	
	
	$("#delivery_no").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	    
	    if($(this).val().length == 0){
	    	sel_delivery_fuc = true;
	    }
	    if(sel_delivery_fuc){
	    	sel_delivery_fuc = false;
	    	$('#tak_sel').val("${deli_seqno}");
	    	
	    	var param = {
	   			 cellName  : 'tak_sel'
	   			,cellValue : "${deli_seqno}"
	   			,seqno     : $('#a_seqno').val()
	   			,oper      : 'edit'
	   		}
	   		update_one(param, false);
	    	
	    }
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
	
	$('#addrBtn2').click(function() {
		var element_layer = document.getElementById('layerFindAddr');
		
		 new daum.Postcode({
	        oncomplete: function(data) {

	            var fullAddr = data.address; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수

	            if(data.userSelectedType === 'R'){
	            	
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                fullAddr = data.roadAddress;
	                
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }
	            
	            fullAddr = fullAddr;
	            
	            //document.getElementById(txt_addr1).value = fullAddr;
	            //me.lookupReference(txt_addr1).setExValue(fullAddr);
	            
	            var addrNm =  "(" + data.bname;
	            if(data.buildingName != '' && data.buildingName != null && data.buildingName != undefined){
	            	addrNm = addrNm + ","+data.buildingName
	            }
	            addrNm = addrNm + ")";
	            
	        	 $('#d_to_zipcode').val(data.zonecode);
	        	 $('#d_to_address01').val(fullAddr);
	        	 $('#d_to_address02').focus();
	            element_layer.style.display = 'none';
	        },
	        width : '100%',
	        height : '100%',
	        maxSuggestItems : 5
	    }).embed(element_layer);

	    // iframe을 넣은 element를 보이게 한다.
	    element_layer.style.display = 'block';

	    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	    initLayerPosition(element_layer);
	    
	    return false;
    });
	
});

function update_one(param , msg){
	$.ajax({
		url : '/admin/order/tang/update_col.do',
		type : 'POST',
		data : param,
		error : function() {
			alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		},
		success : function(data) {
			console.log(data);
			if(msg){
				alert(data.msg);
			}
			if(data.suc){
	    		$("#jqGrid").trigger("reloadGrid");
	    	}
		}
	});
}

function initLayerPosition(element_layer){
	var width = 1000; 
    var height = 600; 
    var borderWidth = 5; 

    // 위에서 선언한 값들을 실제 element에 넣는다.
    element_layer.style.width = width + 'px';
    element_layer.style.height = height + 'px';
    element_layer.style.border = borderWidth + 'px solid';
    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
    element_layer.style.left  = '210px';
    element_layer.style.top  = '220px';
   // element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
   // element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
}

function closeDaumPostcode(){
	$('.find_addr_layer_pop').hide();
}

</script>
<%-- ${info} --%>
<input type="hidden" id="a_seqno" value="${info.seqno}" />
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
	<!-- 주문내역 -->
	<p><span class="viewtit">주문내역</span><span class="txt03">(주문날짜 : ${info.order_date})</span></p>
	<table class="basic01">
		<colgroup>
			<col width="*" />
			<col width="240px" />
			<col width="80px" />
			<col width="80px" />
			<col width="80px" />
			<col width="80px" />
			<col width="80px" />
			<col width="100px" />
		</colgroup>
		<thead>
			<tr>
				<th>처방명</th>
				<th>처방번호</th>
				<th>약재비</th>
				<th>탕전비</th>
				<th>주수상반</th>
				<th>포장비</th>
				<th>배송비</th>
				<th>총비용</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="tdL">${info.s_name} <a href="#" id="order_detail"><span class="btn04"  style="margin-left: 0px;">탕전주문내역서</span></a></td>
				<td class="tdL">${info.order_no} <a href="#" id="order_detai2"><span class="btn04"  style="margin-left: 0px;">조제지시서</span></a></td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_yakjae_price}" pattern="#,###" /></strong>원</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_tang_price}" pattern="#,###" /></strong>원</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_suju_price}" pattern="#,###" /></strong>원</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_pojang_price}" pattern="#,###" /></strong>원</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_delivery_price}" pattern="#,###" /></strong>원</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_total_price+info.member_sale}" pattern="#,###" /></strong>원</td>
			</tr>
		</tbody>
	</table>

	<div class="totalBox" style="margin-top:-1px;">
		<ul>
			<li class="tit">총금액</li>
			<li class="Bt01">총비용<span class="won"><fmt:formatNumber value="${info.order_total_price + info.member_sale}" pattern="#,###" />원</span></li>
			<li class="Bt02">할인금액<span class="won"><fmt:formatNumber value="${info.member_sale}" pattern="#,###" />원</span></li>
			<li class="total">총결제비용<span class="won"><fmt:formatNumber value="${info.order_total_price}" pattern="#,###" /></span>원</li>
			<li class="Bt04">입금상태 
				<%-- ${info.payment} --%>
				<select name="payment" id="payment" class="upt_col" attr="payment" style="width:140px; margin-left:20px;">
					<option value="1" <c:if test="${info.payment eq 1}">selected</c:if>>입금</option>
					<option value="2" <c:if test="${info.payment eq 2}">selected</c:if>>미입금</option>
					<option value="3" <c:if test="${info.payment eq 3}">selected</c:if>>방문결제</option>
					<option value="4" <c:if test="${info.payment eq 4}">selected</c:if>>증정</option>
				</select>
			</li>
		</ul>
	</div>
	<!-- // 주문내역 -->

	<!-- 결제정보 -->
	<p><span class="viewtit">결제정보</span><span class="txt02">(${info.payment_kind_nm})</span><span class="txt03">상점관리자 조회시 참고하세요</span></p>
	<table class="basic01">
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="35%" />
		</colgroup>
		<tbody>
			<tr>
				<th>회원명</th>
				<td class="tdL">${info.name}</td>
				<th>한의원명</th>
				<td  class="tdL">${info.han_name }</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td class="tdL">${info.d_to_tel} / ${info.d_to_handphone}</td>
				<th>이메일</th>
				<td  class="tdL">${info.email}</td>
			</tr>			
			<tr>
				<th>환자명</th>
				<td class="tdL">${info.w_name}</td>
				<th>성별/나이 </th>
				<td  class="tdL">${info.w_sex_nm}/${info.w_age}</td>
			</tr>
			
			<tr <c:if test="${info.payment_kind eq 'Bank'}">style="display:none;"</c:if>>
				<th>거래번호</th>
				<td class="tdL">${info.card_gu_no}</td>
				<th>주문번호</th>
				<td class="tdL">${info.card_ju_no }</td>
			</tr>
			<tr <c:if test="${info.payment_kind eq 'Bank'}">style="display:none;"</c:if>>				
				<th>취소요청</th>
				<td class="tdL">
					<c:if test="${info.cancel_ing eq 'y'}"><font style="color: red;">주문자에 의해 취소 요청된 주문건</font></c:if>
					<c:if test="${info.cancel_ing eq 'i'}">
						<select name="cancel_ing" id="cancel_ing"  class="upt_col" attr="cancel_ing">
							<option value=""  >정상주문으로 변경</option>
							<option value="i" <c:if test="${info.cancel_ing eq 'i'}">selected</c:if>>주문자에 의해 취소 요청된 주문건</option>
						</select>
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
							<a href="#" id="cardCancelBtn"    class="btn03" style="vertical-align: top;">
								<c:if test="${info.card_cnt <= 1 }">카드 결제 전액 취소</c:if>
								<c:if test="${info.card_cnt >  1 }">카드 결제 부분 취소</c:if>
							</a>
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
				                   <option value="0" <c:if test="${info.card_cnt <= 1 }">selected="selected"</c:if> >전체 취소</option> 
				                   <option value="1" <c:if test="${info.card_cnt >  1 }">selected="selected"</c:if> >부분 취소</option>
				                 </select>
			                 </form>
		                 </div>
					</c:if>
				</td>
				<th>승인번호</th>
				<td class="tdL">${info.card_su_no}</td>
			</tr>
			<tr <c:if test="${info.payment_kind eq 'Card'}">style="display:none;"</c:if>>
				<th>영수증신청</th>
				<td class="tdL">
					<c:if test="${info.bill_part eq '1' }">
						<c:set var="bill_part" value="세금계산서 신청"  />
					</c:if>
					<c:if test="${info.bill_part eq 2 }">
						<c:set var="bill_part" value="현금영수증 신청"  />
					</c:if>
					<c:if test="${info.bill_part eq 3 }">
						<c:set var="bill_part" value="미신청"  />
					</c:if>
				
					<c:if test="${info.payment_kind == 'Bank' }">
						<c:if test="${info.bill_part eq '1' }">
							<font color="blue" >${bill_part}</font>
							${info.bill_email}
						</c:if>
						<c:if test="${info.bill_part eq '2' }">
							<font color="red" >${bill_part}</font>
							${info.bill_name } / ${info.bill_handphone}
						</c:if>
						<c:if test="${info.bill_part eq '3' }">
							${bill_part}
						</c:if>
					</c:if>	
				</td>
				<th>계산서/영수증</th>
				<td class="tdL">
					<c:if test="${info.payment_kind == 'Bank' }">
						<select name="cash_bill"  class="upt_col" attr="cash_bill">
							<option value="0" <c:if test="${info.cash_bill eq 0}">selected</c:if>>미발행</option>
							<option value="1" <c:if test="${info.cash_bill eq 1}">selected</c:if>>발행</option>
						</select>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>관리자메모</th>
				<td class="tdL" colspan="3">
					<textarea style="width:900px;height:70px;" name="realprice_memo" id="realprice_memo">${info.realprice_memo}</textarea>
					<a href="#" id="memoBtn"  class="upt_colBtn btn03"  attr='realprice_memo' style="vertical-align: top;">[입력]</a>
				</td>
			</tr>
		</tbody>
	</table>
	<!-- //결제정보 -->

	<!-- 배송정보 -->
	<p><span class="viewtit">배송정보</span>
		<span class="txt02">
			(<c:choose>
			   <c:when test="${info.d_type == '1'}">직배송</c:when>
			   <c:when test="${info.d_type == '2'}">북경한의원 원외탕전 → 한의원</c:when>
			   <c:when test="${info.d_type == '3'}">한의원 → 고객</c:when>
			   <c:when test="${info.d_type == '4'}">북경한의원 원외탕전 → 고객</c:when>
			   <c:when test="${info.d_type == '6'}">방문수령</c:when>
			   <c:otherwise>기타</c:otherwise>
		   </c:choose>)
		</span>
	</p>
	<table class="basic02">
		<colgroup>
			<col width="120px" />
			<col width="130px" />
			<col width="340px" />
			<col width="130px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th class="bg01">진행상태</th>
				<td colspan="4" class="tdL bg01">
					<select name="order_ing"  class="upt_col" attr="order_ing">
						 <option value="1" <c:if test="${info.order_ing eq 1}">selected</c:if> >접수대기</option>
						 <option value="2" <c:if test="${info.order_ing eq 2}">selected</c:if> >입금대기</option>
						 <option value="3" <c:if test="${info.order_ing eq 3}">selected</c:if> >조제중</option>
						 <option value="4" <c:if test="${info.order_ing eq 4}">selected</c:if> >탕전중</option>
						 <option value="5" <c:if test="${info.order_ing eq 5}">selected</c:if> >발송</option>
						 <option value="8" <c:if test="${info.order_ing eq 8}">selected</c:if> >예약발송</option>
						 <option value="6" <c:if test="${info.order_ing eq 6}">selected</c:if> >완료</option>
						 <option value="7" <c:if test="${info.order_ing eq 7}">selected</c:if> >환불취소</option>
					</select>

					<p class="txt01">송장번호</p>
					<select name="tak_sel" id="tak_sel"  class="upt_col" attr="tak_sel" style="width: 200px;">
						<option value="">선택</option>
						<c:forEach var="list" items="${deli_list}">
							<option value="${list.seqno}"  <c:if test="${info.tak_sel eq list.seqno }">selected="selected"</c:if> >${list.delivery_nm}</option>
						</c:forEach>
					</select>
					<input type=text name="delivery_no" id="delivery_no" placeholder="-없이 숫자만 등록" style="width:200px;" size=14 value="${info.delivery_no}" > 
					<a href="#" attr='delivery_no' class="btn03 upt_colBtn">[입력]</a>
					
					<%-- <p class="txt01">알림톡</p>
					<input type="checkbox" name="c_more_tang" value="y" <c:if test="${info.c_more_tang eq 'y'}">checked disabled</c:if>   onchange="c_more_change();">
					*송장번호 입력후에 체크해 주세요 --%>
				</td>
			</tr>
			<tr>
				<th rowspan="2">발송인 정보</th>
				<th>발송인 이름</th>
				<td class="tdL">${info.d_from_name}</td>
				<th>연락처</th>
				<td class="tdL">${info.d_from_tel } / ${info.d_from_handphone }</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3" class="tdL">${info.d_from_zipcode}<br>${info.d_from_address01}&nbsp; ${info.d_from_address02}</td>
			</tr>
			<tr>
				<th rowspan="4">수취인 정보</th>
				<th>수취인 이름</th>
				<td class="tdL">
					<input type="text" name="d_to_name" id="d_to_name" value="${info.d_to_name}"  placeholder="이름" style="width:160px;">
					<a href="#" id="dInfoBtn"><span class="btn04">수취인 정보 수정</span></a>
				</td>
				<th>연락처</th>
				<td class="tdL">
					<input type="text" name="d_to_tel" id="d_to_tel" value="${info.d_to_tel}"  placeholder="전화번호" style="width:160px;">
					/
					<input type="text" name="d_to_handphone" id="d_to_handphone" value="${info.d_to_handphone}"  placeholder="휴대전화" style="width:160px;">
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td colspan="3" class="tdL">
					<input type="text" name="d_to_zipcode" id="d_to_zipcode" value="${info.d_to_zipcode}"  style="width:80px;" readonly>
					<a href="#" id="addrBtn2" class="btn03" style="vertical-align:middle;" ><span >주소찾기</span></a><br/>
					<input type="text" name="d_to_address01" id="d_to_address01" value="${info.d_to_address01}"  style="width:570px;" readonly ><br/>
					<input type="text" name="d_to_address02" id="d_to_address02" value="${info.d_to_address02}"  style="width:570px;" > 
				</td>
			</tr>
			<tr>
				<th>배송시 메모</th>
				<td colspan="3" class="tdL">${fn:replace(info.d_to_contents, newLineChar, "<br/>")}</td>
			</tr>
			<tr>
				<th>주문시 요청사항</th>
				<td colspan="3" class="tdL">${fn:replace(info.d_to_contents2, newLineChar, "<br/>")}</td>
			</tr>
		</tbody>
	</table>
	<!-- //배송정보 -->
