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
		
		if(!confirm('?????????????????? ??????????????????????')){
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
				alert('????????? ??????????????????.\n???????????? ???????????????.');
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

	            var fullAddr = data.address; // ?????? ?????? ??????
	            var extraAddr = ''; // ????????? ?????? ??????

	            if(data.userSelectedType === 'R'){
	            	
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                fullAddr = data.roadAddress;
	                
	            } else { // ???????????? ?????? ????????? ???????????? ??????(J)
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

	    // iframe??? ?????? element??? ????????? ??????.
	    element_layer.style.display = 'block';

	    // iframe??? ?????? element??? ????????? ????????? ???????????? ???????????????.
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
			alert('????????? ??????????????????.\n???????????? ???????????????.');
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

    // ????????? ????????? ????????? ?????? element??? ?????????.
    element_layer.style.width = width + 'px';
    element_layer.style.height = height + 'px';
    element_layer.style.border = borderWidth + 'px solid';
    // ???????????? ????????? ?????? ????????? ?????? ?????? ???????????? ????????? ??? ??? ????????? ????????? ????????????.
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
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="?????? ??????"></div>
	<!-- ???????????? -->
	<p><span class="viewtit">????????????</span><span class="txt03">(???????????? : ${info.order_date})</span></p>
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
				<th>?????????</th>
				<th>????????????</th>
				<th>?????????</th>
				<th>?????????</th>
				<th>????????????</th>
				<th>?????????</th>
				<th>?????????</th>
				<th>?????????</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="tdL">${info.s_name} <a href="#" id="order_detail"><span class="btn04"  style="margin-left: 0px;">?????????????????????</span></a></td>
				<td class="tdL">${info.order_no} <a href="#" id="order_detai2"><span class="btn04"  style="margin-left: 0px;">???????????????</span></a></td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_yakjae_price}" pattern="#,###" /></strong>???</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_tang_price}" pattern="#,###" /></strong>???</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_suju_price}" pattern="#,###" /></strong>???</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_pojang_price}" pattern="#,###" /></strong>???</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_delivery_price}" pattern="#,###" /></strong>???</td>
				<td class="tdR"><strong><fmt:formatNumber value="${info.order_total_price+info.member_sale}" pattern="#,###" /></strong>???</td>
			</tr>
		</tbody>
	</table>

	<div class="totalBox" style="margin-top:-1px;">
		<ul>
			<li class="tit">?????????</li>
			<li class="Bt01">?????????<span class="won"><fmt:formatNumber value="${info.order_total_price + info.member_sale}" pattern="#,###" />???</span></li>
			<li class="Bt02">????????????<span class="won"><fmt:formatNumber value="${info.member_sale}" pattern="#,###" />???</span></li>
			<li class="total">???????????????<span class="won"><fmt:formatNumber value="${info.order_total_price}" pattern="#,###" /></span>???</li>
			<li class="Bt04">???????????? 
				<%-- ${info.payment} --%>
				<select name="payment" id="payment" class="upt_col" attr="payment" style="width:140px; margin-left:20px;">
					<option value="1" <c:if test="${info.payment eq 1}">selected</c:if>>??????</option>
					<option value="2" <c:if test="${info.payment eq 2}">selected</c:if>>?????????</option>
					<option value="3" <c:if test="${info.payment eq 3}">selected</c:if>>????????????</option>
					<option value="4" <c:if test="${info.payment eq 4}">selected</c:if>>??????</option>
				</select>
			</li>
		</ul>
	</div>
	<!-- // ???????????? -->

	<!-- ???????????? -->
	<p><span class="viewtit">????????????</span><span class="txt02">(${info.payment_kind_nm})</span><span class="txt03">??????????????? ????????? ???????????????</span></p>
	<table class="basic01">
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="35%" />
		</colgroup>
		<tbody>
			<tr>
				<th>?????????</th>
				<td class="tdL">${info.name}</td>
				<th>????????????</th>
				<td  class="tdL">${info.han_name }</td>
			</tr>
			<tr>
				<th>?????????</th>
				<td class="tdL">${info.d_to_tel} / ${info.d_to_handphone}</td>
				<th>?????????</th>
				<td  class="tdL">${info.email}</td>
			</tr>			
			<tr>
				<th>?????????</th>
				<td class="tdL">${info.w_name}</td>
				<th>??????/?????? </th>
				<td  class="tdL">${info.w_sex_nm}/${info.w_age}</td>
			</tr>
			
			<tr <c:if test="${info.payment_kind eq 'Bank'}">style="display:none;"</c:if>>
				<th>????????????</th>
				<td class="tdL">${info.card_gu_no}</td>
				<th>????????????</th>
				<td class="tdL">${info.card_ju_no }</td>
			</tr>
			<tr <c:if test="${info.payment_kind eq 'Bank'}">style="display:none;"</c:if>>				
				<th>????????????</th>
				<td class="tdL">
					<c:if test="${info.cancel_ing eq 'y'}"><font style="color: red;">???????????? ?????? ?????? ????????? ?????????</font></c:if>
					<c:if test="${info.cancel_ing eq 'i'}">
						<select name="cancel_ing" id="cancel_ing"  class="upt_col" attr="cancel_ing">
							<option value=""  >?????????????????? ??????</option>
							<option value="i" <c:if test="${info.cancel_ing eq 'i'}">selected</c:if>>???????????? ?????? ?????? ????????? ?????????</option>
						</select>
						<script>
							$(document).ready(function() {
								$('#cardCancelBtn').click(function(){
									console.log('?????? ?????? ??????');
									
									if(!confirm('?????? ??????????????? ??????????????????????')){
										return false;
									}
									
									$.ajax({
										url : 'card_cancel.do',
										data : $("#keyin_cancel_frm").serialize(),        
								        error: function(){
									    	alert('????????? ??????????????????.\n???????????? ???????????????.');
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
								<c:if test="${info.card_cnt <= 1 }">?????? ?????? ?????? ??????</c:if>
								<c:if test="${info.card_cnt >  1 }">?????? ?????? ?????? ??????</c:if>
							</a>
						</c:if>
						<div style="display: none;" id="cardCancelArea">
							?????? ?????? ?????? : <span id="card_cancel_info">${info.card_cancel_id}/${info.card_cancel_date}<br/>/${info.card_cancel_tid}</span>
						</div>
						<div style="display:none;" >
							<input type="text" id="card_cancel_id" value="${info.card_cancel_id}" />
							<form name="keyin_cancel_frm" method="post" id="keyin_cancel_frm">
								<input type="text" name="c_seqno"  		id="c_seqno" 	value="${info.seqno}" />
								<input type="text" name="CancelMsg" 	value="????????????">
								<input type="text" name="CancelAmt" 	id="c_CancelAmt" value="${info.order_total_price}">
								<input type="text" name="TID" 			id="c_TID" value="${info.card_gu_no}">
								<input type="text" name="MID" 			id="c_MID"  value="<%=Const.NP_MID%>">
								<input type="text" name="CancelPwd" 	value="<%=Const.NP_c_pass%>">
								<select name="PartialCancelCode" 		id="c_PartialCancelCode">
				                   <option value="0" <c:if test="${info.card_cnt <= 1 }">selected="selected"</c:if> >?????? ??????</option> 
				                   <option value="1" <c:if test="${info.card_cnt >  1 }">selected="selected"</c:if> >?????? ??????</option>
				                 </select>
			                 </form>
		                 </div>
					</c:if>
				</td>
				<th>????????????</th>
				<td class="tdL">${info.card_su_no}</td>
			</tr>
			<tr <c:if test="${info.payment_kind eq 'Card'}">style="display:none;"</c:if>>
				<th>???????????????</th>
				<td class="tdL">
					<c:if test="${info.bill_part eq '1' }">
						<c:set var="bill_part" value="??????????????? ??????"  />
					</c:if>
					<c:if test="${info.bill_part eq 2 }">
						<c:set var="bill_part" value="??????????????? ??????"  />
					</c:if>
					<c:if test="${info.bill_part eq 3 }">
						<c:set var="bill_part" value="?????????"  />
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
				<th>?????????/?????????</th>
				<td class="tdL">
					<c:if test="${info.payment_kind == 'Bank' }">
						<select name="cash_bill"  class="upt_col" attr="cash_bill">
							<option value="0" <c:if test="${info.cash_bill eq 0}">selected</c:if>>?????????</option>
							<option value="1" <c:if test="${info.cash_bill eq 1}">selected</c:if>>??????</option>
						</select>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>???????????????</th>
				<td class="tdL" colspan="3">
					<textarea style="width:900px;height:70px;" name="realprice_memo" id="realprice_memo">${info.realprice_memo}</textarea>
					<a href="#" id="memoBtn"  class="upt_colBtn btn03"  attr='realprice_memo' style="vertical-align: top;">[??????]</a>
				</td>
			</tr>
		</tbody>
	</table>
	<!-- //???????????? -->

	<!-- ???????????? -->
	<p><span class="viewtit">????????????</span>
		<span class="txt02">
			(<c:choose>
			   <c:when test="${info.d_type == '1'}">?????????</c:when>
			   <c:when test="${info.d_type == '2'}">??????????????? ???????????? ??? ?????????</c:when>
			   <c:when test="${info.d_type == '3'}">????????? ??? ??????</c:when>
			   <c:when test="${info.d_type == '4'}">??????????????? ???????????? ??? ??????</c:when>
			   <c:when test="${info.d_type == '6'}">????????????</c:when>
			   <c:otherwise>??????</c:otherwise>
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
				<th class="bg01">????????????</th>
				<td colspan="4" class="tdL bg01">
					<select name="order_ing"  class="upt_col" attr="order_ing">
						 <option value="1" <c:if test="${info.order_ing eq 1}">selected</c:if> >????????????</option>
						 <option value="2" <c:if test="${info.order_ing eq 2}">selected</c:if> >????????????</option>
						 <option value="3" <c:if test="${info.order_ing eq 3}">selected</c:if> >?????????</option>
						 <option value="4" <c:if test="${info.order_ing eq 4}">selected</c:if> >?????????</option>
						 <option value="5" <c:if test="${info.order_ing eq 5}">selected</c:if> >??????</option>
						 <option value="8" <c:if test="${info.order_ing eq 8}">selected</c:if> >????????????</option>
						 <option value="6" <c:if test="${info.order_ing eq 6}">selected</c:if> >??????</option>
						 <option value="7" <c:if test="${info.order_ing eq 7}">selected</c:if> >????????????</option>
					</select>

					<p class="txt01">????????????</p>
					<select name="tak_sel" id="tak_sel"  class="upt_col" attr="tak_sel" style="width: 200px;">
						<option value="">??????</option>
						<c:forEach var="list" items="${deli_list}">
							<option value="${list.seqno}"  <c:if test="${info.tak_sel eq list.seqno }">selected="selected"</c:if> >${list.delivery_nm}</option>
						</c:forEach>
					</select>
					<input type=text name="delivery_no" id="delivery_no" placeholder="-?????? ????????? ??????" style="width:200px;" size=14 value="${info.delivery_no}" > 
					<a href="#" attr='delivery_no' class="btn03 upt_colBtn">[??????]</a>
					
					<%-- <p class="txt01">?????????</p>
					<input type="checkbox" name="c_more_tang" value="y" <c:if test="${info.c_more_tang eq 'y'}">checked disabled</c:if>   onchange="c_more_change();">
					*???????????? ???????????? ????????? ????????? --%>
				</td>
			</tr>
			<tr>
				<th rowspan="2">????????? ??????</th>
				<th>????????? ??????</th>
				<td class="tdL">${info.d_from_name}</td>
				<th>?????????</th>
				<td class="tdL">${info.d_from_tel } / ${info.d_from_handphone }</td>
			</tr>
			<tr>
				<th>??????</th>
				<td colspan="3" class="tdL">${info.d_from_zipcode}<br>${info.d_from_address01}&nbsp; ${info.d_from_address02}</td>
			</tr>
			<tr>
				<th rowspan="4">????????? ??????</th>
				<th>????????? ??????</th>
				<td class="tdL">
					<input type="text" name="d_to_name" id="d_to_name" value="${info.d_to_name}"  placeholder="??????" style="width:160px;">
					<a href="#" id="dInfoBtn"><span class="btn04">????????? ?????? ??????</span></a>
				</td>
				<th>?????????</th>
				<td class="tdL">
					<input type="text" name="d_to_tel" id="d_to_tel" value="${info.d_to_tel}"  placeholder="????????????" style="width:160px;">
					/
					<input type="text" name="d_to_handphone" id="d_to_handphone" value="${info.d_to_handphone}"  placeholder="????????????" style="width:160px;">
				</td>
			</tr>
			<tr>
				<th>??????</th>
				<td colspan="3" class="tdL">
					<input type="text" name="d_to_zipcode" id="d_to_zipcode" value="${info.d_to_zipcode}"  style="width:80px;" readonly>
					<a href="#" id="addrBtn2" class="btn03" style="vertical-align:middle;" ><span >????????????</span></a><br/>
					<input type="text" name="d_to_address01" id="d_to_address01" value="${info.d_to_address01}"  style="width:570px;" readonly ><br/>
					<input type="text" name="d_to_address02" id="d_to_address02" value="${info.d_to_address02}"  style="width:570px;" > 
				</td>
			</tr>
			<tr>
				<th>????????? ??????</th>
				<td colspan="3" class="tdL">${fn:replace(info.d_to_contents, newLineChar, "<br/>")}</td>
			</tr>
			<tr>
				<th>????????? ????????????</th>
				<td colspan="3" class="tdL">${fn:replace(info.d_to_contents2, newLineChar, "<br/>")}</td>
			</tr>
		</tbody>
	</table>
	<!-- //???????????? -->
