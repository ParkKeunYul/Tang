<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>

<jsp:useBean id="now" class="java.util.Date" />
<%--  
<script type="text/javascript" src="/assets/user/js/tangOrderGrid.js?1${now}"></script>
<script type="text/javascript" src="/assets/user/js/m02_01.js?2${now}"></script>
 --%>
<script type="text/javascript" src="/assets/user/js/z_js/z_tangOrderGrid.js?111${now}"></script>
<script type="text/javascript" src="/assets/user/js/z_js/z_m02_01.js?${now}"></script>
<style>
	.orderlistGrid {width:100%; font-size:14px;}				
	.orderlistGrid tbody tr td {				 	
		line-height:32px; 
		text-align:center;					
	}
	.orderlistGrid .L {
		text-align:left; padding-left:10px;
	}
	.orderlistGrid tbody tr:nth-child(even) {
		background:#f9f9f9;
	}
	
					
	.ui-jqgrid tr.ui-row-ltr td{
		border-right-width : 0px !important;
		border-bottom:1px solid #dddddd;
	}
	
	
	/* #gview_jqGrid .ui-jqgrid-labels, */
	.ui-jqgrid-labels{
		background:#e8e8e8; 
		border-bottom:1px solid #dddddd; 
		padding:10px 0 10px 0; 
		font-weight:700; 
		text-align:center;
	}
	
	.ui-jqgrid .ui-jqgrid-htable th{
		padding: 12px 0;
	}
	
	.ui-jqgrid .ui-jqgrid-htable th div{
		height: auto;
		font-size: 14px;
		font-weight: 700;
		font-family: 'Nanum Gothic';
	}
	
	#jqGrid input[name=my_joje]{
		height: 27px;
		text-align: right;
		font-size: 15px;
		background:#f5f5f5 !important;
		width: 45px !important;
	}
	
	.ui-jqgrid .ui-jqgrid-sortable{
		cursor: default;
	}
	/*ui-widget-content jqgrow ui-row-ltr ui-state-highlight*/
	.ui-jqgrid .ui-jqgrid-pager{
		height: 38px;
	}
	.ui-state-default, .ui-widget-content .ui-state-default{
		border:  none;
	}
	
	.ui-widget-content{
		border: none; 
	}
	.ui-state-highlight, .ui-widget-content .ui-state-highlight{
		border : none;
	}
	
	div.ui-pager-control .ui-pg-input[type="text"]{
		height: 15px !important;
		width : 22px;
		padding : 0 0;
		vertical-align: middle;
		font-size: 13px;
		text-align: right;
	}
	
	.ui-jqgrid .ui-pg-table td{
		font-size: 13px;
	}
	
	.ui-th-ltr, .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr{
		background: #e8e8e8;
	}
	
	.ui-corner-all, .ui-corner-bottom, .ui-corner-right, .ui-corner-br{
		border-bottom-right-radius : 0px;
	}
	
	.ui-corner-all, .ui-corner-bottom, .ui-corner-left, .ui-corner-bl{
		border-bottom-left-radius : 0px;
	}
	.ui-corner-all, .ui-corner-top, .ui-corner-right, .ui-corner-tr{
		border-top-right-radius : 0px;
	}
	.ui-corner-all, .ui-corner-top, .ui-corner-left, .ui-corner-tl{
		border-top-left-radius : 0px;
	}
	
	.ui-widget.ui-widget-content{
		/* border-left : none; */
	}
	
	
	.LArea .oderlist_top{
		border-bottom:  none;
	}
	
	#yakjaeGrid,
	#patientGrid,
	#dicGrid,
	#myDicGrid{
		font-size: 13px;
	}
	
	#patientDetailGrid{
		font-size: 11px;
	}
	
	#list_popup03{
		padding: 5px;
	}
	
	#jqgh_patientDetailGrid_s_name,
	#jqgh_patientDetailGrid_d_to_address01,
	#jqgh_patientDetailGrid_sel1,
	#jqgh_patientDetailGrid_sel2{
		font-size: 13px;
	}
	
	.extend_img1{									
		position: absolute;
		width: 300px;
		height: 300px;
		background: #fff;
		border: 1px solid #dddddd;
		bottom: 266px;
		left: 150px;
	}
	
	.extend_img2{									
		position: absolute;
		width: 300px;
		height: 300px;
		background: #fff;
		border: 1px solid #dddddd;
		bottom: 266px;
		right: 70px;
	}
</style>
<script>
function getMok(c_chup_ea){
	
	//console.log('getMok =>' , parseInt(c_chup_ea / 20)+1);
	
	var mok = parseInt(c_chup_ea / 20);
	if( (c_chup_ea % 20) > 0){
		return mok +1;
	}
	
	return mok;
}

function setJusuPrice(){
	
	//c_tang_check14
	if($("#c_tang_check13").is(":checked")){
		
		var c_chup_ea = $('#c_chup_ea').val();
		var mok       = getMok(c_chup_ea);
		
		console.log('a_jusu_price = ', a_jusu_price);
		console.log('mok = ', mok);
		
		var total_jusu_price = a_jusu_price * mok;
		
		
		$('#order_suju_price').val(total_jusu_price);
		$('#order_suju_price_txt').html( comma(total_jusu_price+'') );
		
		$('#c_tang_check14').prop("checked", false);
		$('#c_tang_check15').prop("checked", false);
		$('#c_tang_check16').prop("checked", false);
		
    }else{
    	$('#order_suju_price').val(0);
		$('#order_suju_price_txt').html('0');
    }
	
	//$('#c_tang_check13').change(function()
	//$('#c_chup_ea').change(function()
			
}


function setCheck14(){
	$('#order_suju_price').val(a_jeunglyu_price);
	$('#order_suju_price_txt').html( comma(a_jeunglyu_price+'') );
	
	$('#c_tang_check13').prop("checked", false);
	$('#c_tang_check15').prop("checked", false);
	$('#c_tang_check16').prop("checked", false);
}

function setCheck15(){
	$('#order_suju_price').val(a_balhyo_price);
	$('#order_suju_price_txt').html( comma(a_balhyo_price+'') );
	
	$('#c_tang_check13').prop("checked", false);
	$('#c_tang_check14').prop("checked", false);
	$('#c_tang_check16').prop("checked", false);
}

function setCheck16(){
	$('#order_suju_price').val(a_jaetang_price);
	$('#order_suju_price_txt').html( comma(a_jaetang_price+'') );
	
	$('#c_tang_check13').prop("checked", false);
	$('#c_tang_check14').prop("checked", false);
	$('#c_tang_check15').prop("checked", false);
}

</script>
<!-- container -->
<div id="container">	
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="?????? ??????"></div>

	<!-- submenuArea -->
	<%
		String fir_nm = "????????????";
		String sec_nm = "????????????";
		String thr_nm = "????????????";
		int fir_n = 2;
		int sub_n = 1;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	
	<input type="hidden" name="dic_seqno" 	   id="dic_seqno" 	       value="${bean.dic_seqno}"  alt="bean_seqno" />
	<input type="hidden" name="mem_sub_seqno"   id="mem_sub_seqno" 	   value="${userInfo.mem_sub_seqno}"   />
	<input type="hidden" name="mem_sub_grade"   id="mem_sub_grade" 	   value="${userInfo.mem_sub_grade}"   />
	
		
	<form action="/m02/01_save_cart.do" name="frm" id="frm" method="post" enctype="multipart/form-data" >
	<!-- contents -->
	<div id="contents_order">
	
		<!-- ?????? -->			
		<!-- LArea -->
		<div class="LArea">
			<%-- ${userInfo} --%>
			<!-- ???????????? ?????? -->
			<c:set var="han_handphone" value="${fn:split(userInfo.handphone,'-')}" />
			<input type="hidden" id="han_addr1" 		value="${userInfo.address01}" />
			<input type="hidden" id="han_addr2" 		value="${userInfo.address02}" />
			<input type="hidden" id="han_zip"   		value="${userInfo.zipcode}" />
			<input type="hidden" id="han_handphone01"   value="${han_handphone[0]}">
			<input type="hidden" id="han_handphone02"   value="${han_handphone[1]}"> 
			<input type="hidden" id="han_handphone03"   value="${han_handphone[2]}"> 
			<input type="hidden" id="han_han_name"   	value="${userInfo.han_name}">
			<input type="hidden" id="sale_per"  name="sale_per" value="${userInfo.sale_per}">
			<%-- ${setting}111111 --%>
			<%-- ${userInfo} --%>
			<div class="div_tit">???????????? ??????</div>
			<table class="orderlist01">
				<colgroup>
					<col width="150px" />
					<col width="*" />
				</colgroup>
				<thead>
					<tr>
						<td colspan="2">
							<ul>
								<li><span class="tit">?????????</span>${userInfo.name}</li>
								<li><span class="tit">?????? ?????????</span>${userInfo.han_name }</li>
								<li><span class="tit">?????????</span>${bean.today}</li>
							</ul>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>?????????</th>
						<td>
							<div>
								<input type="text" name="w_name" id="w_name"  value="${setting.w_name }" style="width:200px;" />
								<!-- ???????????? ?????????. -->
								<a href="#" class="fr" id="patientDelBtn"><span class="h34 cB">????????????</span></a>
								<!--// ???????????? ?????????. -->
							</div>
							<p class="fc05">* ??????????????? ?????? ???????????? ?????? ??????????????????.</p>
						</td>
					</tr>
					<tr>
						<th class="pb20">??????</th>
						<td class="pb20">
							<textarea name="w_contents" id="w_contents"  style="width:525px; height:50px;resize:none;">${setting.w_contents }</textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="wp_seqno" 	id="wp_seqno"     value="${setting.wp_seqno }"  />
			<input type="hidden" name="temp_save" 	id="temp_save"     value="${setting.temp_save }"  />
			<input type="hidden" name="w_sex" 		id="w_sex"        value="${setting.w_sex }"/>
			<input type="hidden" name="w_jindan" 	id="w_jindan"     value="${setting.w_jindan }"/>
			<input type="hidden" name="w_age" 		id="w_age"        value="${setting.w_age }"/>
			<input type="hidden" name="w_birthyear" id="w_birthyear"  value="${setting.w_birthyear }"/>
			<input type="hidden" name="w_etc01" 	id="w_etc01"      value="${setting.w_etc01 }" />
			<input type="hidden" name="w_etc02" 	id="w_etc02"      value="${setting.w_etc02 }"/>
			<input type="hidden" name="w_address01" id="w_address01"  value="${setting.w_address01 }"/>
			<input type="hidden" name="w_address02" id="w_address02"  value="${setting.w_address02 }" />
			<input type="hidden" name="w_zipcode"   id="w_zipcode"    value="${setting.w_zipcode }" />
			<input type="hidden" name="w_name_sel"	id="w_name_sel"   value="${setting.w_name }" />
			
			<c:set var="wp_handphone" value="${fn:split(setting.w_cel_sel,'-')}" />
			
			<input type="hidden" name="w_cel1_sel"	id="w_cel1_sel"   value="${wp_handphone[0] }" />
			<input type="hidden" name="w_cel2_sel"	id="w_cel2_sel"   value="${wp_handphone[1] }" />
			<input type="hidden" name="w_cel3_sel"	id="w_cel3_sel"   value="${wp_handphone[2] }" />
			<!-- // ???????????? ?????? -->

			<input type="hidden" name="json_yakjae" id="json_yakjae"/>
			<input type="hidden" name="json_temp_yakjae" id="json_temp_yakjae"/>

			<!-- ???????????? ?????? -->
			<div class="div_tit mt30">????????????<span class="fc06">(????????? 1????????? ???????????????.)</span></div>
			<div class="oderlist_top">
				<p><span>?????????</span><input type="text" name="s_name" id="s_name" value="${setting.s_name }" style="width:550px;margin-left:10px;" /></p>
				<input type="hidden" name="b_name" id="b_name" value="${setting.b_name }" />
			</div>
			
			<!-- ??????????????? ???????????? -->
			<div class="oderlistArea" style="display:;">
			
				<table id="jqGrid" class="orderlistGrid"></table>
				<table class="orderlist02">
					<colgroup>
						<col width="24px" />
						<col width="*" />
						<col width="70px" />
						<col width="120px" />
						<col width="90px" />
						<col width="90px" />
						<col width="110px" />
					</colgroup>								
					<tfoot>
						<tr>
							<td colspan="3">
								<div><a href="#" id="delItemBtn"><span class="cBB h30">?????? ??????</span></a></div>
							</td>
							<td class="b">??????</td>
							<td>
								<span class="b" id="tot_yakjae_joje_txt">0</span>g
							</td>
							<td colspan="2">
								<c:choose>
									<c:when test="${userInfo.mem_sub_grade eq 2}">
										<span class="b">***,***</span>
										<span class="b" id="tot_yakjae_danga_txt" style="display: none;">0</span>
									</c:when>
									<c:otherwise>
										<span class="b" id="tot_yakjae_danga_txt">0</span>???										
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</tfoot>
				</table>
				<!-- ???????????? popup -->
				<div class="yakjae_popup" style="display:none; top:75px; left:130px;"></div>
				<!-- // ???????????? popup -->
			</div>				
			<!-- // ??????????????? ???????????? -->
			
			<!-- // ???????????? ?????? -->
						
			<!-- ?????? ?????? -->
			<div class="div_tit mt30">??????</div>
			<!-- ?????? -->
			<table class="orderlist03">
				<colgroup>
					<col width="110px" />
					<col width="*" />
					<col width="90px" />
					<col width="230px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="padding-top:25px;">????????????</th>
						<td colspan="3" class="pt15">
							<select name="c_tang_type" id="c_tang_type"  style="width:230px;">
								<option value="1"  <c:if test="${setting.c_tang_type eq '1' }">selected="selected"</c:if>>??????</option>								
								<option value="2"  <c:if test="${setting.c_tang_type eq '2' }">selected="selected"</c:if>>???????????????</option>
								<option value="3"  <c:if test="${setting.c_tang_type eq '3' }">selected="selected"</c:if>>????????????</option>
							</select>
							<p class="comment01" id="jusu_txt"  style="display:none;">
								<input type="checkbox" name="c_tang_check13" <c:if test="${setting.c_tang_check13 eq 'y' }">checked="checked"</c:if>  id="c_tang_check13"   readonly="readonly" value="y" attr="12000" /> <span class="b"><label for="c_tang_check13">????????????</label> </span>
								* ?????? ?????? 1:1????????? ?????? ?????? ????????????.
								<c:choose>
									<c:when test="${userInfo.mem_sub_grade eq 2}">
										(+***,***)
									</c:when>
									<c:otherwise>
										(+12,000)										
									</c:otherwise>
								</c:choose>
								<br/>
								<input type="checkbox" name="c_tang_check14" <c:if test="${setting.c_tang_check14 eq 'y' }">checked="checked"</c:if>  id="c_tang_check14"   readonly="readonly" value="y" attr="8000" /> <span class="b"><label for="c_tang_check14">??????</label> </span>
								<c:choose>
									<c:when test="${userInfo.mem_sub_grade eq 2}">
										(+***,***)
									</c:when>
									<c:otherwise>
										(+8,000)										
									</c:otherwise>
								</c:choose>
								<br/>
								<input type="checkbox" name="c_tang_check15" <c:if test="${setting.c_tang_check15 eq 'y' }">checked="checked"</c:if>  id="c_tang_check15"   readonly="readonly" value="y" attr="20000" /> <span class="b"><label for="c_tang_check15">??????</label> </span>
								<c:choose>
									<c:when test="${userInfo.mem_sub_grade eq 2}">
										(+***,***)
									</c:when>
									<c:otherwise>
										(+20,000)										
									</c:otherwise>
								</c:choose>
								<br/>
								<input type="checkbox" name="c_tang_check16" <c:if test="${setting.c_tang_check16 eq 'y' }">checked="checked"</c:if>  id="c_tang_check16"   readonly="readonly" value="y" attr="20000" /> <span class="b"><label for="c_tang_check15">??????</label> </span>
								<c:choose>
									<c:when test="${userInfo.mem_sub_grade eq 2}">
										(+***,***)
									</c:when>
									<c:otherwise>
										(+7,000)										
									</c:otherwise>
								</c:choose>
							</p>
						</td>
					</tr>
					<tr>
						<th>??????</th>
						<td>
							<select name="c_chup_ea" id="c_chup_ea"  style="width:80px;">
								<option value="0">??????</option>
								<c:forEach var="i" begin="1" end="120">
									<option value="${i}" <c:if test="${setting.c_chup_ea eq i }">selected="selected"</c:if>>${i}</option>
								</c:forEach>
							</select> ???
							x
							<c:choose>
								<c:when test="${userInfo.mem_sub_grade eq 2}">
									<input type="text" name=""hidden_1""  id="hidden_1" readonly="readonly" value="***,***" style="width:60px;" />
									<input type="text" name="c_chup_ea_price"  id="c_chup_ea_price" readonly="readonly" style="width:60px;display: none;" /> ???
								</c:when>
								<c:otherwise>
									<input type="text" name="c_chup_ea_price"  id="c_chup_ea_price" readonly="readonly" style="width:60px;" /> ???										
								</c:otherwise>
							</c:choose>
							
						</td>
						<th>??? ?????????</th>
						<td>
							<input type="text" name="c_chup_g" id="c_chup_g" style="width:75px;" /> g
						</td>
					</tr>
					<tr class="tang_type_area">
						<th>?????????</th>
						<td>
							<select name="c_pack_ml" id="c_pack_ml"  style="width:160px;">
								<option value="0">??????</option>
								<option value="50"   <c:if test="${setting.c_pack_ml eq 50 }">selected="selected"</c:if>>50ml</option>
                                <option value="60"   <c:if test="${setting.c_pack_ml eq 60 }">selected="selected"</c:if>>60ml</option>
								<option value="70"   <c:if test="${setting.c_pack_ml eq 70 }">selected="selected"</c:if>>70ml</option>
								<option value="80"   <c:if test="${setting.c_pack_ml eq 80 }">selected="selected"</c:if>>80ml</option>
								<option value="90"   <c:if test="${setting.c_pack_ml eq 90 }">selected="selected"</c:if>>90ml</option>
								<option value="100"  <c:if test="${setting.c_pack_ml eq 100 }">selected="selected"</c:if>>100ml</option>
								<option value="110"  <c:if test="${setting.c_pack_ml eq 110 }">selected="selected"</c:if>>110ml</option>
								<option value="120"  <c:if test="${setting.c_pack_ml eq 120 }">selected="selected"</c:if>>120ml</option>
								<option value="130"  <c:if test="${setting.c_pack_ml eq 130 }">selected="selected"</c:if>>130ml</option>
								<option value="140"  <c:if test="${setting.c_pack_ml eq 140 }">selected="selected"</c:if> >140ml</option>
							</select>
						</td>
						<th>??????</th>
						<td>
							<select name="c_pack_ea" id="c_pack_ea"  style="width:85px;">
								<option value="0">??????</option>
								<c:forEach var="i" step="1" begin="1" end="120">
									<option value="${i}"  <c:if test="${setting.c_pack_ea eq i }">selected="selected"</c:if>  >${i}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr  class="tang_type_area tang_type_area_po">
						<th>?????????</th>
						<td>
							<select name="c_pouch_type" id="c_pouch_type"  style="width:160px;">
								<option value="0" attr2="0">????????????</option>
								<c:forEach var="list" items="${pouch_list}">
									<option value="${list.seqno}"  attr="/upload/pouch/${list.pouch_image}"  attr2=${list.pouch_price }  <c:if test="${setting.c_pouch_type eq list.seqno }">selected="selected"</c:if>  >${list.pouch_name}(+${list.pouch_price})</option>
								</c:forEach>
							</select>
							<div class="img" id="pouchImgExp1"   ><img id="pouchImgExp"  style="cursor: pointer;" src="" alt="" height="123" width="123" /></div>
							<div class="extend_img1" style="display: none;"><img src="" alt="" id="extend_img1" style="width: 100%;height: 100%;" /></div>
						</td>
						<th>??????</th>
						<td>
							<select name="c_box_type" id="c_box_type"  style="width:160px;">
								<option value="0" attr2="0">????????????</option>
								<c:forEach var="list" items="${box_list}">
									<option value="${list.seqno}" attr="/upload/box/${list.box_image}"  attr2=${list.box_price }  <c:if test="${setting.c_box_type eq list.seqno }">selected="selected"</c:if> >${list.box_name}(+${list.box_price})</option>
								</c:forEach>
							</select>
							<div class="img" id="boxImgExp1"><img id="boxImgExp" style="cursor: pointer;" src="" alt="" height="123" width="123" /></div>
							<div class="extend_img2" style="display: none;"><img src="" alt="" id="extend_img2" style="width: 100%;height: 100%;" /></div>
							
						</td>
					</tr>
					<tr  class="tang_type_area">
						<th>???????????? ??????</th>
						<td>
							<select name="c_stpom_type" id="c_stpom_type"  style="width:160px;">
								<option value="0" attr2="0">????????????</option>
								<c:forEach var="list" items="${sty_list}">
									<option value="${list.seqno}" attr2="${list.price}"  <c:if test="${setting.c_stpom_type eq list.seqno }">selected="selected"</c:if>  >${list.sty_name}(+${list.price})</option>
								</c:forEach>
							</select>
						</td>
						<th>?????? ??????</th>
						<td>
							<input type="text" name="c_box_ea" id="c_box_ea" value="1"   style="width:75px;"  readonly="readonly" />						
						</td>
					</tr>
				</tbody>
			</table>
			<!-- // ?????? -->
			<table class="orderlist04">
				<colgroup>
					<col width="110px" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>????????????<br/>??????</th>
						<td>
							<!-- <a href="#"><span id="" class="h34 cB fl">?????? ?????? ????????????</span></a> -->
							<select name="" id="joje_name"  style="width:250px;">
								<option value="" attr="">???????????????.</option>
								<c:forEach var="list" items="${joje_list}">
									<option value="${list.seqno}" attr="${list.contents}" attr2="${list.base_yn}" <c:if test="${list.base_yn eq 'y'}">selected="selected"</c:if> >${list.name}</option>
								</c:forEach>
							</select>
							<p class="fr"><input type="file" name="c_joje_file" id="c_joje_file" /></p>
							<c:if test="${!empty setting.c_joje_file}"><p class="fr"><a href="/download.do?path=tang/${setting.c_joje_folder}&filename=${setting.c_joje_file}&refilename=${setting.c_joje_file}">${setting.c_joje_file}</a></p></c:if>
							<textarea name="c_joje_contents" id="c_joje_contents" class="textop">${setting.c_joje_contents}</textarea>
						</td>
					</tr>
					
					<tr>
						<th>????????????<br/>??????</th>
						<td style="padding-bottom:30px;">
							<!-- <a href="#"><span id="" class="h34 cB fl">?????? ?????? ????????????</span></a> -->
							<select name="" id="bok_name"  style="width:250px;">
								<option value="" attr="">???????????????.</option>
								<c:forEach var="list" items="${bok_list}">
									<option value="${list.seqno}" attr="${list.contents}" attr2="${list.base_yn}" <c:if test="${list.base_yn eq 'y'}">selected="selected"</c:if> >${list.name}</option>
								</c:forEach>
							</select>
							<p class="fr"><input type="file" id="c_bokyong_file" name="c_bokyong_file" /></p>
							<c:if test="${!empty setting.c_bokyong_file}"><p class="fr"><a href="/download.do?path=tang/${setting.c_bokyong_folder}&filename=${setting.c_bokyong_file}&refilename=${setting.c_bokyong_file}">${setting.c_bokyong_file}</a></p></c:if>
							<textarea name="c_bokyong_contents" id="c_bokyong_contents" class="textop">${setting.c_bokyong_contents}</textarea>
						</td>
					</tr>
					
				</tbody>
			</table>
			<!-- layer_popup ????????? ??? ???????????? ???????????? -->
			<div id="popup7" class="Pstyle2"></div>
			<!-- //layer_popup ????????? ??? ???????????? ???????????? -->
			
			<!-- // ?????? ?????? -->

		</div>
		<!-- // LArea -->

		<!-- RArea -->
		<div class="RArea">

			<!-- ???????????? ?????? -->
			<div class="patientArea">
				<ul class="tab2">
					<li class="fir"><a href="#" class="sel">????????????</a></li>
					<li class="sec"><a href="#">????????????</a></li>
				</ul>
				<!-- ???????????? -->
				<div class="patient_search" style="display:;">
					<p class="searchA">
						<select name="pat_search_titile" id="pat_search_titile"  style="width:110px;">
							<option value="name">?????????</option>
						</select>
						<input type="text" id="pat_search_value" name="pat_search_value" placeholder="???????????? ???????????????" style="width:255px;" />
						<a href="#" id="patientSearchBtn"><span id="" class="h34 cB">??????</span></a>
					</p>
					<table id="patientGrid" class="orderlistGrid"></table>
					<div id="patientGridControl"></div>
				</div>
				<!-- // ???????????? -->

				<!-- ???????????? -->
				<div class="detail_info" style="display:none;">
					<table class="detail">
						<colgroup>
							<col width="85px" />
							<col width="*" />
							<col width="85px" />
							<col width="120px" />
						</colgroup>
						<tbody>
							<tr>
								<th>?????????</th>
								<td><span class="p_name_txt">?????????</span></td>
								<th>????????????</th>
								<td><span class="p_chart_txt">12365</span></td>
							</tr>
							<tr>
								<th>????????????</th>
								<td><span class="p_info_txt">30-19880808</span></td>
								<th>??????</th>
								<td><span class="p_sex_txt">???</span></td>
							</tr>
							<tr>
								<th>?????????</th>
								<td><span class="p_tel_txt"></span></td>
								<th>????????????</th>
								<td><span class="p_handphnoe_txt">010-1234-5678</span></td>
							</tr>
							<tr>
								<th>??????</th>
								<td colspan="3">
									<p class="p_zipcode_txt">10564</p>
									<p class="p_address01_txt">????????? ????????? ????????? ?????????</p>
									<p class="p_address02_txt"></p>									
								</td>
							</tr>
							<tr>
								<th>??????/??????</th>
								<td colspan="3"><p class="p_size_txt">10564</p></td>
							</tr>
							<tr>
								<th>??????</th>
								<td colspan="3"><p class="p_jindan_txt">10564</p></td>
							</tr>
							<tr>
								<th>??????</th>
								<td colspan="3"><p class="p_contents_txt">10564</p></td>
							</tr>
							<tr>
								<th>??????</th>
								<td colspan="3"><p class="p_etc1_txt">10564</p></td>
							</tr>
						</tbody>
					</table>						
					<div class="ac">
						<a href="#" id="patientSelectBtn"><span class="cB h34">????????????</span></a>
						<a href="#" id="p_listBtn"><span class="cw h34">??????</span></a>
					</div>
				</div>
				<!-- // ???????????? -->

			</div>
			<!-- // ???????????? ?????? -->

			<!-- ????????? -->
			<div class="order_option">
				<ul class="tab4">
					<li><a href="#" class="sel">????????????</a></li>
					<li><a href="#">???????????????</a></li>
					<li><a href="#" >????????????</a></li>
					<li><a href="#">????????????</a></li>
				</ul>
				
				
				<!-- ???????????? -->
				<div class="yakjae order_detail" id="orderOp0" style="" id="">
					<div class="searchA">
						<p>
							<input type="text" id="yakjae_search_value" style="width:115px;" />
							<a href="#" id="yakjaeSearchBtn"><span id="" class="h34 cB mr5">??????</span></a>
							<input type="text" id="yakjae_multi_value"  placeholder="??????????????? ???????????? ??????" style="width:180px;" />
							<a href="#" id="yakjaeMultiSearchBtn"><span id="" class="h34 cbg">????????????</span></a>
						</p>
						<ul class="search_han2 yakjae_search_han2">
							<li><a href="#" attr="" class="fir sel">??????</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
						</ul>
					</div>
					<table id="yakjaeGrid" class="orderlistGrid"></table>
					<div id="yakjaeGridControl"></div>
				</div>
				<!-- // ???????????? -->
				
				<!-- ??????????????? -->
				<div class="dictionary order_detail" id="orderOp1" style="display:none;">
					<div class="searchA">
						<p>
							<input type="text" id="dic_search_value" style="width:355px;" />
							<a href="#" id="dicSearchBtn"><span id="" class="h34 cB mr5">????????????</span></a>
						</p>
						<ul class="search_han2 dic_search_han2">
							<li><a href="#" attr="" class="fir sel">??????</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
						</ul>
					</div>
					

					<table id="dicGrid" class="orderlistGrid"></table>
					<div id="dicGridControl"></div>
					

					<!-- ???????????????, ???????????? ???????????? popup -->
					<div class="list_popup01" id="list_popup01" style="display:none ;">
						<p><a href="#" class="btn_close dic_btn_close"><img src="/assets/user/images/sub/btn_close03.png" alt="" /></a></p>
						<p class="tit">???????????? <a href="#" id="dic_pop_detail"><img src="/assets/user/images/sub/btn_view.png" alt="????????????" /></a></p>
						<table class="poplist">
							<colgroup>
								<col width="80px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th>?????????</th>
									<td class="b"><div id="dic_txt_sname"></div></td>
								</tr>
								<tr>
									<th>????????????</th>
									<td height=210>
										<span class="jo" id="dic_txt_bname"></span>
										<div id="dic_txt_jomun" style="height: auto;"></div>										
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- // ???????????????, ???????????? ???????????? popup -->
				</div>
				<!-- // ??????????????? -->
				
				<!-- ???????????? -->
				<div class="my_dictionary order_detail"  id="orderOp2" style="display:none;">
					<div class="searchA">
						<p>
							<input type="text" id="mydic_search_value" style="width:355px;" />
							<a href="#" id="mydicSearchBtn"><span id="" class="h34 cB mr5">????????????</span></a>
						</p>
						<ul class="search_han2 myDic_search_han2">
							<li><a href="#" attr="" class="fir sel">??????</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
						</ul>
					</div>
					<table id="myDicGrid" class="orderlistGrid"></table>
					<div id="myDicGridControl"></div>
					
					<div class="list_popup01" id="list_popup02" style="display:none ;">					
						<p><a href="#" class="btn_close mydic_btn_close"><img src="/assets/user/images/sub/btn_close03.png" alt="" /></a></p>
						<p class="tit">???????????? <a href="#" id="mydic_pop_detail"><img src="/assets/user/images/sub/btn_view.png" alt="????????????" /></a></p>
						<table class="poplist">
							<colgroup>
								<col width="80px" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th>?????????</th>
									<td class="b"><div id="mydic_txt_sname"></div></td>
								</tr>
								<tr>
									<th>????????????</th>
									<td height=210>
										<span class="jo" id="mydic_txt_bname"></span>
										<div id="mydic_txt_jomun" style="height: auto;"></div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<!-- // ???????????? -->
				
				<!-- ???????????? -->
				<div class="before_dictionary order_detail"  id="orderOp3" style="display:none;">
					<div class="searchA">
						<p>
							<input type="text" name="preorder_search_value" id="preorder_search_value" style="width:355px;" />
							<a href="#" id="preorderSearchBtn"><span id="" class="h34 cB mr5">????????????</span></a>
						</p>
						<ul class="search_han2 preorder_search_han2">
							<li><a href="#" attr="" class="fir sel">??????</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
							<li><a href="#" attr="???">???</a></li>
						</ul>
					</div>
					
					<table id="preOrderGrid" class="orderlistGrid"></table>
					<div id="preOrderGridControl"></div>
					
					<!-- ???????????? popup -->
					<div class="list_popup01" id="list_popup03" style="display:none;height: 350px;width: 450px;left:5px;"   >
						<p class="tit" style="padding-top: 10px;">?????? ?????? ??????</p>
						<div style="margin-top: 10px;"></div>
						<table id="patientDetailGrid"  class="orderlistGrid"></table>
						<div id="patientDetailGridControl"></div>
						<p><a href="#" class="btn_close preorder_btn_close"><img src="/assets/user/images/sub/btn_close03.png" alt="" /></a></p>
					</div>
					<!-- // ???????????? popup -->
				</div>
				<!-- // ???????????? -->

			</div>
			<!-- // ????????? -->

			<!-- ???????????? -->
			<div class="deliver">
				<p class="tit">
					????????????
					<select name="d_type" id="d_type"  style="width:330px;margin-left:10px;">
						<option value="">??????</option>
						<option value="1" <c:if test="${setting.d_type eq 1 }">selected="selected"</c:if>>???????????? ??? ?????????</option>
						<option value="4" <c:if test="${setting.d_type eq 4 }">selected="selected"</c:if>>???????????? ??? ??????</option>
						<option value="3" <c:if test="${setting.d_type eq 3 }">selected="selected"</c:if>>????????? ??? ??????</option>
						<option value="6" <c:if test="${setting.d_type eq 6 }">selected="selected"</c:if>>????????????</option>
					</select>
					
					
				</p>
				<div class="send">
					<p class="stit01 fc08">* ????????? ??????(????????????)</p>
					<ul>
						<li><input type="text" name="d_from_name" id="d_from_name" value="${setting.d_from_name}"  placeholder="??????" style="width:160px;"></li>
						<li>
							<c:set var="d_from_handphone" value="${fn:split(setting.d_from_handphone,'-')}" />
							<c:set var="d_to_handphone" value="${fn:split(setting.d_to_handphone,'-')}" />
						
							<input type="text" id="d_from_handphone01" name="d_from_handphone01" value="${d_from_handphone[0]}"  style="width:65px;" maxlength="4"> -
							<input type="text" id="d_from_handphone02" name="d_from_handphone02" value="${d_from_handphone[1]}"  style="width:65px;" maxlength="4"> -
							<input type="text" id="d_from_handphone03" name="d_from_handphone03" value="${d_from_handphone[2]}"  style="width:65px;" maxlength="4">
						</li>
						<li>
							<span class="dI H40">
								<input type="text" name="d_from_zipcode" id="d_from_zipcode01" value="${setting.d_from_zipcode}"  style="width:180px;" readonly><a href="#" id="addrBtn1"><span id="" class="h34 cB">????????????</span></a>
							</span>
							<span class="dI">
								<input type="text" name="d_from_address01" value="${setting.d_from_address01}"  style="width:370px;" readonly id="d_from_address01">
								<input type="text" name="d_from_address02" value="${setting.d_from_address02}"  style="width:370px;" id="d_from_address02"> 
							</span>
						</li>
					</ul>
				</div>
				<div class="receive" style="position: relative;">
					<p class="stit02 fc07">* ????????? ??????(??????)</p>
					<ul>
						<li><input type="text" name="d_to_name" id="d_to_name" value="${setting.d_to_name}"  placeholder="??????" style="width:160px;"></li>
						<li>
							<input type="text" id="d_to_handphone01" name="d_to_handphone01" value="${d_to_handphone[0]}"  style="width:65px;" maxlength="4"> -
							<input type="text" id="d_to_handphone02" name="d_to_handphone02" value="${d_to_handphone[1]}"  style="width:65px;" maxlength="4"> -
							<input type="text" id="d_to_handphone03" name="d_to_handphone03" value="${d_to_handphone[2]}"  style="width:65px;" maxlength="4">
						</li>
						<li>
							<span class="dI H40">
								<input type="text" name="d_to_zipcode" id="d_to_zipcode01" value="${setting.d_to_zipcode}"  style="width:180px;" readonly><a href="#" id="addrBtn2" ><span id="" class="h34 cB">????????????</span></a>
								<a href="#" id="latelyBtn" ><span id="" class="h34 cB">???????????????</span></a>
							</span>
							<span class="dI">
								<input type="text" name="d_to_address01" id="d_to_address01" value="${setting.d_to_address01}"  style="width:370px;" readonly >
								<input type="text" name="d_to_address02" id="d_to_address02" value="${setting.d_to_address02}"  style="width:370px;" > 
							</span>
						</li>
						<li>
							<textarea name="d_to_contents" id="d_to_contents" placeholder="????????????" style="width:370px; height:30px;resize:none;">${setting.d_to_contents}</textarea>
						</li>
					</ul>
					<div class="lately_wrap" style="position: absolute;width: 850px;min-height: 520px;z-index: 9999;background: #fff;top: -100px;right: -20px;border: 1px solid #26995d;display: none;">
					</div>
				</div>
			</div>
			<!-- // ???????????? -->
			
			<!-- ???????????? -->
			<div class="priceBox">
				<input type="hidden" name="cart_seqno" 	   id="cart_seqno" 	   value="${setting.cart_seqno}"  alt="cart_seqno" />
				<input type="hidden" name="tang_seqno" 	   id="tang_seqno" 	   value="${bean.tang_seqno}"    alt="tang_seqno" />
				<input type="hidden" name="temp_cnt" 	   id="temp_cnt" 	   value="${temp_cnt}"    alt="temp_cnt" />
				<input type="hidden" name="referer" 	   id="referer" 	   value="${referer}"    alt="referer" />
				
				
			
				<input type="hidden" name="order_yakjae_price" 	   id="order_yakjae_price" 	   value="${setting.order_yakjae_price}"  alt="?????????" />
				<input type="hidden" name="order_tang_price" 	   id="order_tang_price" 	   value="${setting.order_tang_price}"    alt="?????????" />
				<input type="hidden" name="order_suju_price" 	   id="order_suju_price" 	   value="${setting.order_suju_price}"    alt="????????????" />
				<input type="hidden" name="order_pojang_price" 	   id="order_pojang_price" 	   value="${setting.order_pojang_price}"    alt="????????????" />
				<input type="hidden" name="order_delivery_price"   id="order_delivery_price"   value="${setting.order_delivery_price}"    alt="?????????" />
				
				<input type="hidden" name="order_total_price_temp" id="order_total_price_temp"  value="${setting.order_total_price_temp}"   alt="?????????" />
				<input type="hidden" name="member_sale" 		   id="member_sale" 		    value="${setting.member_sale}"   alt="????????????" />
				<input type="hidden" name="order_total_price" 	   id="order_total_price" 	    value="${setting.order_total_price}"  alt="???????????????" />
				
				<input type="hidden" name="order_delivery_price_check" id="order_delivery_price_check"  value="${setting.order_delivery_price_check}"   />
				<input type="hidden" name="cart_complete"   		     id="cart_complete"  			  value="${setting.cart_complete}"   />
				<input type="hidden" name="view_yn"   				 id="view_yn"  					  value="${setting.view_yn}"   />
				<input type="hidden" name="bunch"   				     id="bunch"                       value="${setting.bunch}"   />
				
				<!-- ?????? -->
				<input type="hidden" name="order_yakjae_price_cart" 	   id="order_yakjae_price_cart"    value="${setting.order_yakjae_price}"  alt="???????????????" />
				
				<p class="tit">????????????</p>
				
				<c:if test="${userInfo.mem_sub_grade eq 2}">
					<table class="pricelist" <c:if test="${userInfo.mem_sub_grade ne 2}">style="display: none;"</c:if>>
						<colgroup>
							<col width="140px" />
							<col width="170px" />
							<col width="150px" />
						</colgroup>
						<tbody>
							<tr>
								<th>?????????</th>
								<td><!-- <span>1,298</span>??? x <span>20</span>??? --></td>
								<td><span >***,***</span>???</td>
							</tr>
							<tr>
								<th>?????????</th>
								<td><!-- <span>????????????</span> x <span>1</span>ea --></td>
								<td><span  >***,***</span>???</td>
							</tr>
							<tr>
								<th>????????????</th>
								<td><!-- <span>0</span>ea --></td>
								<td><span >***,***</span>???</td>
							</tr>
							<tr>
								<th>?????????</th>
								<td><!-- <span>2,000</span>??? x <span>1</span>ea --></td>
								<td><span >***,***</span>???</td>
							</tr>
							<tr>
								<th>?????????</th>
								<td><!-- <span>4,000</span>??? x <span>1</span>ea --></td>
								<td><span >***,***</span>???</td>
							</tr>
						</tbody>
					</table>
					<table class="pricetotal">
						<colgroup>
							<col width="140px" />
							<col width="320px" />
						</colgroup>
						<tbody>
							<tr>
								<th>?????????</th>
								<td><span >***,***</span>???</td>
							</tr>
							<tr>
								<th>????????????</th>
								<td><span >(-)***,***</span>???</td>
							</tr>
							<tr>
								<th class="total pt15">????????????</th>
								<td class="total pt15" ><font class="total2" >***,***</font>???</td>
							</tr>
						</tbody>
					</table>
				</c:if>
				
				
				<table class="pricelist" <c:if test="${userInfo.mem_sub_grade eq 2}">style="display: none;"</c:if>>
					<colgroup>
						<col width="140px" />
						<col width="170px" />
						<col width="150px" />
					</colgroup>
					<tbody>
						<tr>
							<th>?????????</th>
							<td><!-- <span>1,298</span>??? x <span>20</span>??? --></td>
							<td><span id="order_yakjae_price_txt">0</span>???</td>
						</tr>
						<tr>
							<th>?????????</th>
							<td><!-- <span>????????????</span> x <span>1</span>ea --></td>
							<td><span id="order_tang_price_txt" >0</span>???</td>
						</tr>
						<tr>
							<th>????????????</th>
							<td><!-- <span>0</span>ea --></td>
							<td><span id="order_suju_price_txt">0</span>???</td>
						</tr>
						<tr>
							<th>?????????</th>
							<td><!-- <span>2,000</span>??? x <span>1</span>ea --></td>
							<td><span id="order_pojang_price_txt">0</span>???</td>
						</tr>
						<tr>
							<th>?????????</th>
							<td><!-- <span>4,000</span>??? x <span>1</span>ea --></td>
							<td><span id="order_delivery_price_txt">0</span>???</td>
						</tr>
					</tbody>
				</table>
				<table class="pricetotal"  <c:if test="${userInfo.mem_sub_grade eq 2}">style="display: none;"</c:if>>
					<colgroup>
						<col width="140px" />
						<col width="320px" />
					</colgroup>
					<tbody>
						<tr>
							<th>?????????</th>
							<td><span id="order_total_price_temp_txt">0</span>???</td>
						</tr>
						<tr>
							<th>????????????</th>
							<td><span id="member_sale_txt">(-)0</span>???</td>
						</tr>
						<tr>
							<th class="total pt15">????????????</th>
							<td class="total pt15" ><font class="total2" id="order_total_price_txt">0</font>???</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btn_area05">
				<!-- <a href="#"><span class="cw h50">??????</span></a> -->
				
				<c:choose>
					<c:when test="${!empty  bean.cart_seqno}">
						<a href="#" id="updateCartBtn"><span class="cg h50">????????????</span></a>
					</c:when>
					<c:otherwise>
						<a href="#" id="saveCartBtn"><span class="cg h50">???????????? ??????</span></a>	
					</c:otherwise>
				</c:choose>
				
			</div>
			<!-- // ???????????? -->
			
			<script>
				$(document).ready(function() {
					$("#latelyBtn").click(function() {
						$.ajax({
						    url: "/m02/lately.do",		    
						    type : 'POST',
					        error: function(){
						    	alert('????????? ??????????????????.\n???????????? ???????????????.');
						    },
						    success: function(data){
						    	$('.lately_wrap').fadeIn();
						        $(".lately_wrap").html(data);						        
						    }   
						});	
						return false;
					});
					
					
					$("#saveCartBtn").click(function() {
		    			
						if(!cartValidate()){
							return false;
						}
						
		    			var wp_seqno = objToStr($('#wp_seqno').val() , '');
		    			
		    			if(wp_seqno == ''){
		    				//???????????? ?????? ???????????? ??????
			    			$.ajax({
								url : '/m02/01_duple_patinet.do',
								type: 'POST',
								data : {
									name : $('#w_name').val(),
								},
								error : function() {
									alert('????????? ??????????????????.\n???????????? ???????????????.');
								},
								success : function(info) {
									if(info.duple > 0){
										if(confirm($('#w_name').val() + '????????? ????????? ????????? ??????????????? ????????????????????????.\n????????? ????????? ??????????????????????') ){
											saveCartForm();
										}else{
											return false;
										}
									}else{
										saveCartForm();	
									}
								}
							});
		    			}else{
		    				saveCartForm();	
		    			}
						return false;
					});
					
					$("#updateCartBtn").click(function() {
						
						if(!cartValidate()){
							return false;
						}
						
		    			var wp_seqno = objToStr($('#wp_seqno').val() , '');
		    			
		    			if(wp_seqno == ''){
		    				//???????????? ?????? ???????????? ??????
			    			$.ajax({
								url : '/m02/01_duple_patinet.do',
								type: 'POST',
								data : {
									name : $('#w_name').val(),
								},
								error : function() {
									alert('????????? ??????????????????.\n???????????? ???????????????.');
								},
								success : function(info) {
									if(info.duple > 0){
										if(confirm($('#w_name').val() + '????????? ????????? ????????? ??????????????? ????????????????????????.\n????????? ????????? ??????????????????????') ){
											updateCartForm();
										}else{
											return false;
										}
									}else{
										updateCartForm();	
									}
								}
							});
		    			}else{
		    				updateCartForm();	
		    			}
						return false;
					});
					
					$("#pouchImgExp1").mouseover(function(){
			            var src = $('#pouchImgExp').attr('src');
			            console.log('src = ', src);
			            
			            if(src == undefined || src ==  '' || src == null){
			            	$('.extend_img1').hide();
			            	return;
			            }
			            $('#extend_img1').attr('src', src)
			            $('.extend_img1').show();
			        });
					
					$("#extend_img1").mouseout(function(){
						$('.extend_img1').hide();				
					}).mouseleave(function(){
						$('.extend_img1').hide();
					});
					
					$("#boxImgExp1").mouseover(function(){
			            var src = $('#boxImgExp').attr('src');
			            
			            if(src == undefined || src ==  '' || src == null){
			            	$('.extend_img2').hide();
			            	return;
			            }
			            
			            $('#extend_img2').attr('src', src)
			            $('.extend_img2').show();
			        });
					
					$("#extend_img2").mouseout(function(){
						$('.extend_img2').hide();				
					}).mouseleave(function(){
						$('.extend_img2').hide();
					});
					
					$("#c_box_type, #c_pouch_type").mouseover(function(){
						$('.extend_img1').hide();
						$('.extend_img2').hide();				
					});
					
					var temp_save     = $('#temp_save').val();
					var temp_cnt      = $('#temp_cnt').val();
					var mem_sub_seqno = $('#mem_sub_seqno').val();
					
					
					if(temp_save == 'y' && temp_cnt > 0 && mem_sub_seqno == 0){
						
						if(!confirm('??????????????? ?????? ????????? ????????????.\n??????????????????????')){
							return;
						}
						
						$("#jqGrid").setGridParam({
							 postData : {},
							 datatype  : "json",
							 mtype     : 'POST',
							 url       : '/m02/01_select_temp.do',
							 loadComplete: function(data){
								 load_jqgird_after();								 
							 }
						}).trigger("reloadGrid",[{page : 1}]);	
					}
					
					//$('#mem_sub_grade').val();					
					
					//
					
				});
				
				function cartValidate(){
					
					if (!valCheck('w_name', '???????????? ????????????, ???????????????.')) return false;
					if (!valCheck('s_name', '???????????? ???????????????.')) return false;
					
					if( $('#c_chup_ea').val() == 0 ){
						alert('????????? ???????????????.');
						$('#c_chup_ea').focus();
						return false;
					}
					
					var c_tang_type = $('#c_tang_type').val();
					
					if( c_tang_type != '1' ){
						
						if( $('#c_pack_ml').val() == 0 ){
							alert('???????????? ???????????????.');
							$('#c_pack_ml').focus();
							return false;
						}
						
						if( $('#c_pack_ea').val() == 0 ){
							alert('????????? ???????????????.');
							$('#c_pack_ea').focus();
							return false;
						}
						
						if( $('#c_pouch_type').val() == 0 || $('#c_pouch_type').val() == null){
							alert('???????????? ???????????????');
							$('#c_pouch_type').focus();
							return false;
						}
						
						if( $('#c_box_type').val() == 0 || $('#c_box_type').val() == null ){
							alert('????????? ???????????????.');
							$('#c_box_type').focus();
							return false;
						}
						
					}
															
					if (!valCheck('d_from_name', '????????? ????????? ???????????????.')) return false;
					if (!valCheck('d_from_handphone01', '????????? ????????? ????????? ???????????????.')) return false;
					if (!valCheck('d_from_handphone02', '????????? ????????? ????????? ???????????????.')) return false;
					if (!valCheck('d_from_handphone03', '????????? ????????? ????????? ???????????????.')) return false;
					
					if (!valCheck('d_from_zipcode01', '????????? ????????? ???????????????.')) return false;
					if (!valCheck('d_from_address02', '????????? ????????? ???????????????.')) return false;
					
					if (!valCheck('d_to_name', '????????? ????????? ???????????????.')) return false;
					if (!valCheck('d_to_handphone01', '????????? ????????? ????????? ???????????????.')) return false;
					if (!valCheck('d_to_handphone02', '????????? ????????? ????????? ???????????????.')) return false;
					if (!valCheck('d_to_handphone03', '????????? ????????? ????????? ???????????????.')) return false;
					if (!valCheck('d_to_zipcode01', '????????? ?????????  ???????????????.')) return false;
					if (!valCheck('d_to_address02', '????????? ????????? ???????????????.')) return false;
					
					var rows = $("#jqGrid").getDataIDs();
					if(rows.length <=0){
						alert('????????? ????????? ????????????.');
						return false;
					}
					
					for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
		    			$('#jqGrid').editCell(i,  5 , false);	
		    		}
					
					/* ??????????????? ?????? ????????? ????????? ?????? ?????????*/
					for (var i = 0; i < rows.length; i++){
						var record = $('#jqGrid').jqGrid('getRowData', rows[i]);
						//console.log('record = ', record);
						if( record.yak_status != 'y' ){
							alert('????????? ???????????? ????????? ???????????? ????????????.');
							$('#jqGrid').editCell((i+1),  5 , true);
							return false;
						}
						
						if( objToStr(record.my_joje, 0)  == 0 ){
							alert('???????????? 0g ??????????????? ?????????.');
							$('#jqGrid').editCell((i+1),  5 , true);
							return false;
						}
					}//
					
					var jsonNewData = [];
					for (var i = 0; i < rows.length; i++){
						var record = $('#jqGrid').jqGrid('getRowData', rows[i]);
						record.yak_name = '';
						record.sel_img = '';
						
						jsonNewData.push(JSON.stringify(record));
	    			}//
	    			$('#json_yakjae').val(jsonNewData);
	    			
	    			return true;
				}
				
				function updateCartForm(){
					$("#frm").attr('action', '/m02/01_update_cart.do');
					$('#frm').ajaxForm({		        
						url     : '/m02/01_update_cart.do',
				        enctype : "multipart/form-data",
				        beforeSerialize: function(){
				             // form??? ?????????????????? ??????????????? ????????? ????????? ?????? ??????.            
				        },
				        beforeSubmit : function() {
				        	//action??? ??????????????? ????????? ???????????? ?????? ex)????????? ????????? ???????????? ??????.
				        },
				        success : function(data) {		             
				            alert(data.msg);
				            if(data.suc){
				            	location.href='/m05/02.do';
				            }
				        }		        
				    });
				    
					$("#frm").submit();
				}// 
				
				
				function saveCartForm(){
					$("#frm").attr('action', '/m02/01_save_cart.do');
					$('#frm').ajaxForm({		        
						url     : '/m02/01_save_cart.do',
				        enctype : "multipart/form-data",
				        beforeSerialize: function(){
				             // form??? ?????????????????? ??????????????? ????????? ????????? ?????? ??????.            
				        },
				        beforeSubmit : function() {
				        	//action??? ??????????????? ????????? ???????????? ?????? ex)????????? ????????? ???????????? ??????.
				        },
				        success : function(data) {		             
				            alert(data.msg);
				            if(data.suc){
				            	location.href='/m05/02.do';
				            }
				        }		        
				    });	
					$("#frm").submit();
				}
				
				function yak_temp_save(){
					var rows = $("#jqGrid").getDataIDs();
					
					
					
					var mem_sub_seqno = objToStr( $('#mem_sub_seqno').val(), '');
					
					if(mem_sub_seqno != 0 ){
						return;
					}
					
					var cart_seqno    = objToStr( $('#cart_seqno').val(), '');
					var temp_save 	  = objToStr( $('#temp_save').val(), '');
					
					/* 
					console.log('mem_sub_seqno = ', mem_sub_seqno);
					console.log('cart_seqno = ', cart_seqno);
					console.log('temp_save = ', temp_save);
					 */
					if(cart_seqno != '' || temp_save == 'n'){
						return;
					}
					
										
					var row_id = $('#jqGrid').getGridParam('selrow');					
					
					//console.log(  $('#jqGrid').jqGrid('getRowData', row_id) );
					
					var sel_record = $('#jqGrid').jqGrid('getRowData', row_id);
					
					for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
		    			$('#jqGrid').editCell(i,  5 , false);			    						    		
		    		}
					
					
					var jsonNewData = [];
					
					for (var i = 0; i < rows.length; i++){
						var record = $('#jqGrid').jqGrid('getRowData', rows[i]);
						jsonNewData.push(JSON.stringify(record));
						
						try{
							if(sel_record.seqno == record.seqno){
								console.log('sel_record = ', sel_record.my_joje);
								//console.log('record = ', record);
								//alert(1);
								$("#jqGrid").setCell(rows[i],"my_joje", sel_record.my_joje)
								//alert(2);
								$('#jqGrid').editCell(i+1,  5 , true);
							}	
						}catch(Exception){
							console.log('edit errr');
						}
						
					}// for
					$('#json_temp_yakjae').val(jsonNewData);
					
					
					
					// ?????? ??????
					$.ajax({
						url  : '/m02/01_temp_yakjae.do',
						data : {
							json_temp_yakjae  : $('#json_temp_yakjae').val()
						},
					    type : "POST",
					    error: function(){
					    	console.log('????????? ??????????????????. ???????????? ???????????????.');
					    },
					    success: function(data){
							console.log('temp_save =', data)
					    }
					});
				}// for
			</script>

		</div>
		<!-- // RArea -->

		<!-- // ?????? -->
	</div>
	<!-- //contents -->
	</form>
</div>
<!-- //container -->	