<%@page import="kr.co.hany.common.Const"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
	$(document).ready(function() {
		$('.upt_col').change(function(){
			var param = {
				 cellName  : $(this).attr('attr')
				,cellValue : $(this).val()
				,order_no  : $('#order_no').val()
				,oper      : 'edit'
			}
			ajax_proc(param);
			return;
		});
		
		$('.upt_colBtn').click(function(){
			
			var param = {
				 cellName  : $(this).attr('attr')
				,cellValue : $('#'+$(this).attr('attr')).val()
				,order_no  : $('#order_no').val()
				,oper      : 'edit'
			}
			ajax_proc(param, true);
			return;
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
		            
		        	 $('#r_zipcode').val(data.zonecode);
		        	 $('#r_address').val(fullAddr);
		        	 $('#r_address').focus();
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
		
		$('#dInfoBtn').click(function(){
			
			if(!confirm('수취인정보를 변경하겠습니까?')){
				return false;
			}
			
			var param ={
				 order_no       : $('#order_no').val()
				,r_name 		: $('#r_name').val()
				,r_zipcode      : $('#r_zipcode').val()
				,d_to_tel       : $('#d_to_tel').val()
				,r_address 		: $('#r_address').val()
				,r_tel   		: $('#r_tel').val()
				,r_handphone 	: $('#r_handphone').val()
			};
			
			$.ajax({
				url : 'update_d_info.do',
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
		
		
		$('#printBtn').click(function(){
			alert('준비중');
			return false;
		});
		
		
		$('#cardCancelBtn').click(function(){
			console.log('카드 결제 취소');
			
			if(!confirm('카드 결제금액을 취소하겠습니까?')){
				return false;
			}
			
			$.ajax({
				url : '/admin/order/shop/card_cancel.do',
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
		
		
		var deliveryno = $('#deliveryno').val();
		var sel_delivery_fuc = false;
		if(deliveryno.length == 0){
			sel_delivery_fuc = true;			
		}
		
		
		$("#deliveryno").on("keyup", function() {
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
		   			,order_no  : $('#order_no').val()
		   			,oper      : 'edit'
		   		}
		    	ajax_proc(param);
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
		
	});
	
	
	function ajax_proc(data , msg){
		$.ajax({
			url : '/admin/order/shop/update_col.do',
		    data : data,        
	        error: function(){
		    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		    },
		    success: function(data){
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

<style>
</style>

<%-- ${info} --%>
<input type="hidden" name="order_no" id="order_no" value="${info.order_no}" />
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
	<!-- 주문내역 -->
	<p class="view_title"><span class="viewtit">주문내역</span><a href="#" id="printBtn"><span class="btn05">인쇄</span></a></p>
	<table class="basic01">
		<colgroup>
			<col width="*" />
			<col width="80px" />
			<col width="130px" />
			<col width="130px" />
			<col width="130px" />
			<col width="150px" />
		</colgroup>
		<thead>
			<tr>
				<th>상품명</th>
				<th>수량</th>
				<th>판매가</th>
				<th>상품구매금액</th>
				<th>할인금액</th>
				<th>최종 구매금액</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${p_list}">		   			
			<tr>
				<td class="tdL"><img src="/upload/goods/${list.good_image}" style="width: 60px;height: 60px;"  class="am" alt="${list.goods_name }" />${list.goods_name}</td>
				<td>${list.ea}</td>
				<td class="tdR"><strong><fmt:formatNumber value="${list.goods_price}" pattern="#,###" /></strong>원</td>
				<td class="tdR"><strong><fmt:formatNumber value="${list.price}" pattern="#,###" /></strong>원</td>
				<td class="tdR"><strong><fmt:formatNumber value="${list.member_sale}" pattern="#,###" /></strong>원</td>
				<td class="tdR"><strong><fmt:formatNumber value="${list.price - list.member_sale}" pattern="#,###" /></strong>원</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="totalBox" style="margin-top:-1px;">
		<ul>
			<li class="tit">총금액</li>
			<li class="Bt01">최종 구매금액<span class="won"><fmt:formatNumber value="${info.tot_price}" pattern="#,###" />원</span></li>
			<li class="Bt02">배송비<span class="won"><fmt:formatNumber value="${info.delivery_price}" pattern="#,###" />원</span></li>
			<li class="total">합계<span class="won"><fmt:formatNumber value="${info.all_price}" pattern="#,###" /></span>원</li>
			<li class="Bt04">입금상태 
				<select name="pay_ing" id="pay_ing" class="upt_col" attr="pay_ing"  style="width:140px; margin-left:20px;">
					<option value="1"  <c:if test="${info.pay_ing eq 1 }">selected="selected"</c:if>>입금</option>
					<option value="2"  <c:if test="${info.pay_ing eq 2 }">selected="selected"</c:if>>미입금</option>
					<option value="3"  <c:if test="${info.pay_ing eq 3 }">selected="selected"</c:if>>방문결제</option>
					<option value="4"  <c:if test="${info.pay_ing eq 4 }">selected="selected"</c:if>>증정</option>
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
				<td class="tdL">
					<input type=text name="order_name" id="order_name"  value="${info.order_name}" style="border:1 solid BABBBA;width: 100px;" size=20> 
					<a href="#" id="orderNameBtn" attr='order_name' class="upt_colBtn btn03">[변경]</a>
				</td>
				<th>한의원명</th>
				<td class="tdL">${info.han_name }</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td class="tdL">${info.han_tel } / ${info.handphone }</td>
				<th>이메일</th>
				<td class="tdL">${info.email}</td>
			</tr>
			<tr <c:if test="${info.payment eq 'Bank'}">style="display:none;"</c:if>>
				<th>거래번호</th>
				<td class="tdL">${info.card_gu_no}</td>
				<th>주문번호</th>
				<td class="tdL">${info.card_ju_no }</td>				
			</tr>
			<tr <c:if test="${info.payment eq 'Bank'}">style="display:none;"</c:if>>
				<th>취소요청</th>
				<td class="tdL">
					<c:if test="${info.cancel_ing eq 'y'}"><font style="color: red;">주문자에 의해 취소 요청된 주문건</font></c:if>
					<c:if test="${info.cancel_ing eq 'i'}">
						<select name="cancel_ing" id="cancel_ing"  class="upt_col" attr="cancel_ing">
							<option value=""  >정상주문으로 변경</option>
							<option value="i" <c:if test="${info.cancel_ing eq 'i'}">selected</c:if>>주문자에 의해 취소 요청된 주문건</option>
						</select>
						<c:if test="${info.payment eq 'Card' && empty info.card_cancel_id }">
							<a href="#" id="cardCancelBtn"    class="btn03" style="vertical-align: top;">카드 결제 취소</a>
						</c:if>
						<div style="display: none;" id="cardCancelArea">
							카드 취소 정보 : <span id="card_cancel_info">${info.card_cancel_id}/${info.card_cancel_date}</span>
						</div>
						
						<div style="display:none;" >
							<input type="text" id="card_cancel_id" value="${info.card_cancel_id}" />
							<form name="keyin_cancel_frm" method="post" id="keyin_cancel_frm">
								<input type="text" name="c_seqno"  		id="c_seqno" 	value="${info.seqno}" />
								<input type="text" name="c_order_no" 	id="c_order_no" value="${info.order_no}" />
								<input type="text" name="CancelMsg" 	value="고객취소">
								<input type="text" name="CancelAmt" 	id="c_CancelAmt" value="${info.all_price}">
								<input type="text" name="TID" 			id="c_TID" value="${info.card_gu_no}">
								<input type="text" name="MID" 			id="c_MID"  value="<%=Const.NP_MID%>">
								<input type="text" name="CancelPwd" 	value="<%=Const.NP_c_pass%>">
								<select name="PartialCancelCode" 		id="c_PartialCancelCode">
				                   <option value="0" selected="selected">전체 취소</option>
				                   <!-- <option value="1" >부분 취소</option> -->
				                 </select>
			                 </form>
		                 </div>
					</c:if>
				</td>
				<th>승인번호</th>
				<td class="tdL">${info.card_su_no}</td>
			</tr>
			<tr <c:if test="${info.payment eq 'Card'}">style="display:none;"</c:if>>
				<th>영수증신청</th>
				<td class="tdL">
					<c:choose>
						<c:when test="${info.bill_part eq 1}">
							<font color="blue">세금계산서 선청</font> / ${info.bill_email }
						</c:when>
						<c:when test="${info.bill_part eq 2}">
							<font color="red">현금영수증 신청</font> / ${info.bill_name } / ${info.bill_handphone}
						</c:when>
						<c:otherwise>미신청</c:otherwise>
					</c:choose>
				</td>
				<th>계산서/영수증</th>
				<td class="tdL">
					<c:if test="${info.payment eq 'Bank' }">
						<select name="o_paypart" id="o_paypart" class="upt_col" attr='o_paypart' >
							<option value="1" <c:if test="${info.o_paypart eq 1 }">selected="selected"</c:if>>미발행</option>
							<option value="0" <c:if test="${info.o_paypart eq 0 }">selected="selected"</c:if>>발행</option>
						</select>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>관리자메모</th>
				<td class="tdL" colspan="3">
					<textarea rows=3 cols=120 name="realprice_memo" id="realprice_memo">${info.realprice_memo}</textarea>
					<a href="#" id="memoBtn"  attr="realprice_memo"  class="upt_colBtn btn03" style="vertical-align: top;">[입력]</a>					
				</td>
			</tr>
		</tbody>
	</table>
	<!-- //결제정보 -->

	<!-- 배송정보 -->
	<p><span class="viewtit">배송정보</span>
		<span class="txt02">
			(
				<c:if test="${info.ship_type_from eq 1 }">원외탕전실</c:if>
				<c:if test="${info.ship_type_from eq 2 }">한의원</c:if>
				<c:if test="${info.ship_type_from eq 3 }">새로입력</c:if>
				->
				<c:if test="${info.ship_type_to eq 1 }">원외탕전실</c:if>
				<c:if test="${info.ship_type_to eq 2 }">한의원</c:if>
				<c:if test="${info.ship_type_to eq 3 }">새로입력</c:if>
			)
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
					<select name="order_ing" id="order_ing"  class="upt_col" attr="order_ing" style="width:100px;">
						 <option value="1" <c:if test="${info.order_ing eq 1 }">selected="selected"</c:if>>주문처리중</option>
						 <option value="7" <c:if test="${info.order_ing eq 7 }">selected="selected"</c:if>>입금대기</option>
						 <option value="2" <c:if test="${info.order_ing eq 2 }">selected="selected"</c:if>>배송준비</option>
						 <option value="3" <c:if test="${info.order_ing eq 3 }">selected="selected"</c:if>>배송중</option>
						 <option value="4" <c:if test="${info.order_ing eq 4 }">selected="selected"</c:if>>배송완료</option>
						 <option value="6" <c:if test="${info.order_ing eq 6 }">selected="selected"</c:if>>예약발송</option>
						 <option value="5" <c:if test="${info.order_ing eq 5 }">selected="selected"</c:if>>환불/취소</option>
					</select>

					<p class="txt01">송장번호</p>
					<select name="tak_sel" id="tak_sel"  class="upt_col" attr="tak_sel" style="width: 200px;">
						<option value="">선택</option>
						<c:forEach var="list" items="${deli_list}">
							<option value="${list.seqno}"  <c:if test="${info.tak_sel eq list.seqno }">selected="selected"</c:if> >${list.delivery_nm}</option>
						</c:forEach>
					</select>
					
					<input type=text name="deliveryno" id="deliveryno" placeholder="-없이 숫자만 등록" style="width:200px;" size=14 value="${info.deliveryno}" > 
					<a href="#" id="deliBtn" attr="deliveryno" class="upt_colBtn btn03">[입력]</a>
					
					<%-- <p class="txt01">알림톡</p>
					<input type="checkbox" name="r_class" value="y" <c:if test="${info.r_class eq 'y' }">checked disabled</c:if>  onchange="r_class_change();">
					*송장번호 입력후에 체크해 주세요 --%>
				</td>
			</tr>
			<tr>
				<th class="bg02" rowspan="2">발송인 정보</th>
				<th class="bg02">발송인 이름</th>
				<td class="tdL">${info.o_name}</td>
				<th class="bg02">연락처</th>
				<td class="tdL">${info.o_tel} / ${info.o_handphone}</td>
			</tr>
			<tr>
				<th class="bg02">주소</th>
				<td colspan="3" class="tdL">${info.o_zipcode}<br>${info.o_address}</td>
			</tr>
			<tr>
				<th class="bg03" rowspan="4">수취인 정보</th>
				<th class="bg03">수취인 이름</th>
				<td class="tdL">
					<input type="text" name="r_name" id="r_name" value="${info.r_name}"  placeholder="이름" style="width:160px;">
					<a href="#" id="dInfoBtn"><span class="btn04">수취인 정보 수정</span></a>
				</td>
				<th class="bg03">연락처</th>
				<td class="tdL">
					<input type="text" name="r_tel" id="r_tel" value="${info.r_tel}"  placeholder="전화번호" style="width:160px;">
					/
					<input type="text" name="r_handphone" id="r_handphone" value="${info.r_handphone}"  placeholder="휴대전화" style="width:160px;">
				</td>
			</tr>
			<tr>
				<th class="bg03">주소</th>
				<td colspan="3" class="tdL">
					<%-- ${info.r_zipcode}  <br>${info.r_address} --%>
					<input type="text" name="r_zipcode" id="r_zipcode" value="${info.r_zipcode}"  style="width:80px;" readonly>
					<a href="#" id="addrBtn2" class="btn03" style="vertical-align:middle;" ><span >주소찾기</span></a><br/>
					<input type="text" name="r_address" id="r_address" value="${info.r_address}"  style="width:570px;"  ><br/>
				</td>
			</tr>
			<tr>
				<th class="bg03">배송시 메모</th>
				<td colspan="3" class="tdL">${info.o_memo}</td>
			</tr>
			<tr>
				<th class="bg03">주문시 요청사항</th>
				<td colspan="3" class="tdL">${info.o_memo2}</td>
			</tr>
		</tbody>
	</table>
	<!-- //배송정보 -->
