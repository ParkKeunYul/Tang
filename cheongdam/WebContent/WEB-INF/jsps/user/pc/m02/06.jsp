<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>

<jsp:useBean id="now" class="java.util.Date" />
<%-- 
<script type="text/javascript" src="/assets/user/js/tangOrderGrid.js?1{now}"></script>
<script type="text/javascript" src="/assets/user/js/m02_01.js?2${now}"></script>
 --%> 
<%--  
<script type="text/javascript" src="/assets/user/js/z_js/z_m06_01.js?${now}"></script>
 --%> 
<script type="text/javascript" src="/assets/user/js/m06_01.js?2${now}"></script>
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
		bottom: 222px;
		left: 150px;
	}
	
	.extend_img2{									
		position: absolute;
		width: 300px;
		height: 300px;
		background: #fff;
		border: 1px solid #dddddd;
		bottom: 222px;
		right: 70px;
	}
	
	
	#wrap #container #contents {position:relative; width:1260px; height:100%; min-height:800px; margin-left:200px; padding:55px 30px 100px 30px; background:#ffffff; box-sizing:border-box; z-index:99;}
	.swiper-container{ width:240px; height:410px; margin:0 auto; position:fixed; top:200px; left:1490px; overflow:hidden;list-style:none;padding:0;z-index:1;}
	
	.RArea .tab2 .sel, .RArea .tab4 .sel{
		background : #ffffff;
	}
	
	.LArea .orderlist01 thead tr td ul li{
		height: 21px;	
	}
	
</style>
<!-- container -->
<div id="container">
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:9999;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="?????? ??????"></div>
	
	<!-- contents -->
	<div id="contents" >
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>????????????</span><span>????????????</span></p>
		</div>

		<ul class="sub_Menu w50">
			<li class="sel" ><a href="/m02/06.do">????????????</a></li>
			<li ><a href="/m05/02.do">????????????</a></li>
		</ul>
		
		<div style="height: 2px;margin-bottom: 50px;"> </div>
		
		<input type="hidden" name="dic_seqno" 	   id="dic_seqno" 	       value="${bean.dic_seqno}"  alt="bean_seqno" />
		<input type="hidden" name="mem_sub_seqno"   id="mem_sub_seqno" 	   value="${userInfo.mem_sub_seqno}"   />
		<input type="hidden" name="mem_sub_grade"   id="mem_sub_grade" 	   value="${userInfo.mem_sub_grade}"   />
		
		<form action="/m02/01_save_cart.do" name="frm" id="frm" method="post" enctype="multipart/form-data" >
		<div id="contents_order">
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
				<input type="hidden" name="order_type"   value="2" />
				<input type="hidden" id="user_name"   value="${userInfo.name}">
				
				
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
				<div class="div_tit mt30">????????????<span class="fc06_tang">(????????? 1????????? ???????????????.)</span></div>
				<div class="oderlist_top">
					<p><span>?????????</span><input type="text" name="s_name" id="s_name" value="${setting.s_name }" disabled="disabled" style="width:550px;margin-left:10px;" /></p>
					<input type="hidden" name="b_name" id="b_name" value="${setting.b_name }"  />
				</div>
				
				<!-- ??????????????? ???????????? -->
				<div class="oderlistArea" style="display:;">
				
					<table id="jqGrid" class="orderlistGrid"></table>
					<table class="orderlist02">
						<colgroup>
							<col width="*" />
							<col width="120px" />
							<col width="2px" />
						</colgroup>								
						<tfoot>
							<tr>
								<td class="b" style="text-align:right;">??????</td>
								<td>
									<span class="b" id="tot_yakjae_joje_txt">0</span> g 
									<span class="b" id="tot_yakjae_danga_txt"  style="display: none;">0</span>									
								</td>
								<td></td>
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
						<tr style="display:none;">
							<th style="padding-top:25px;">????????????</th>
							<td colspan="3" class="pt15">
								<input type="hidden" id="c_tang_type_temp" value="${setting.c_tang_type}"/>
								<select name="c_tang_type" id="c_tang_type"  style="width:230px;" disabled="disabled">
									<option value="1" disabled="disabled"  <c:if test="${setting.c_tang_type eq '1' || empty setting.c_tang_type  }">selected="selected"</c:if>>??????</option>								
									<option value="2" disabled="disabled"  <c:if test="${setting.c_tang_type eq '2' }">selected="selected"</c:if>>???????????????</option>
									<option value="3" disabled="disabled"  <c:if test="${setting.c_tang_type eq '3' }">selected="selected"</c:if>>????????????</option>
								</select>
								<p class="comment01" id="jusu_txt"  style="display:none;">
									<input type="checkbox" name="c_tang_check13" <c:if test="${setting.c_tang_check13 eq 'y' }">checked="checked"</c:if>   disabled="disabled" id="c_tang_check13"   readonly="readonly" value="y" attr="8000" /> <span class="b"><label for="c_tang_check13">????????????</label> </span>
									* ?????? ???(????????????)??? 1:1????????? ?????? ?????? ????????????.
									<br/>
									<input type="checkbox" name="c_tang_check14" <c:if test="${setting.c_tang_check14 eq 'y' }">checked="checked"</c:if>  disabled="disabled" id="c_tang_check14"   readonly="readonly" value="y" attr="8000" /> <span class="b"><label for="c_tang_check14">??????</label> </span>
									<br/>
									<input type="checkbox" name="c_tang_check15" <c:if test="${setting.c_tang_check15 eq 'y' }">checked="checked"</c:if>  disabled="disabled" id="c_tang_check15"   readonly="readonly" value="y" attr="20000" /> <span class="b"><label for="c_tang_check15">??????</label> </span>
									<br/>
									<input type="checkbox" name="c_tang_check16" <c:if test="${setting.c_tang_check16 eq 'y' }">checked="checked"</c:if>  disabled="disabled" id="c_tang_check16"   readonly="readonly" value="y" attr="20000" /> <span class="b"><label for="c_tang_check15">??????</label> </span>
								</p>
							</td>
						</tr>
						<tr>
							<th>??????</th>
							<td>
								<select name="c_chup_ea" id="c_chup_ea"  style="width:80px;" disabled="disabled">
									<option value="0">??????</option>
									<c:forEach var="i" begin="1" end="120">
										<option value="${i}" <c:if test="${setting.c_chup_ea eq i }">selected="selected"</c:if>>${i}</option>
									</c:forEach>
								</select> ???
								x
								<c:choose>
									<c:when test="${userInfo.mem_sub_grade eq 2}">
										<input type="text" name="hidden_1"  id="hidden_1" readonly="readonly" value="***,***" style="width:60px;" />
										<input type="text" name="c_chup_ea_price"  id="c_chup_ea_price" disabled="disabled" style="width:60px;display: none;" /> ???
									</c:when>
									<c:otherwise>
										<input type="text" name="c_chup_ea_price"  id="c_chup_ea_price" value="${setting.c_chup_ea_price }" disabled="disabled" style="width:60px;" /> ???										
									</c:otherwise>
								</c:choose>
								
							</td>
							<th>??? ?????????</th>
							<td>
								<input type="text" name="c_chup_g" id="c_chup_g" value="${setting.c_chup_g}" style="width:75px;" disabled="disabled" /> g
							</td>
						</tr>
						<tr class="tang_type_area" style="display:none;">
							<th>?????????</th>
							<td>
								<select name="c_pack_ml" id="c_pack_ml"  style="width:160px;" disabled="disabled">
									<option value="0">??????</option>
									<option value="50"   <c:if test="${setting.c_pack_ml eq 50 }">selected="selected"</c:if>>50ml</option>
	                                <option value="60"   <c:if test="${setting.c_pack_ml eq 60 }">selected="selected"</c:if>>60ml</option>
									<option value="70"   <c:if test="${setting.c_pack_ml eq 70 }">selected="selected"</c:if>>70ml</option>
									<option value="80"   <c:if test="${setting.c_pack_ml eq 80 }">selected="selected"</c:if>>80ml(??????)</option>
									<option value="90"   <c:if test="${setting.c_pack_ml eq 90 }">selected="selected"</c:if>>90ml</option>
									<option value="100"  <c:if test="${setting.c_pack_ml eq 100 }">selected="selected"</c:if>>100ml(??????)</option>
									<option value="110"  <c:if test="${setting.c_pack_ml eq 110 }">selected="selected"</c:if>>110ml</option>
									<option value="120"  <c:if test="${setting.c_pack_ml eq 120 }">selected="selected"</c:if>>120ml(??????)</option>
									<option value="130"  <c:if test="${setting.c_pack_ml eq 130 }">selected="selected"</c:if>>130ml</option>
									<option value="140"  <c:if test="${setting.c_pack_ml eq 140 }">selected="selected"</c:if> >140ml</option>
								</select>
							</td>
							<th>??????</th>
							<td>
								<select name="c_pack_ea" id="c_pack_ea"  style="width:85px;" disabled="disabled">
									<option value="0">??????</option>
									<c:forEach var="i" step="1" begin="1" end="120">
										<option value="${i}"  <c:if test="${setting.c_pack_ea eq i }">selected="selected"</c:if>  >${i}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr  class="tang_type_area tang_type_area_po" style="display:none;">
							<th>?????????</th>
							<td>
								<select name="c_pouch_type" id="c_pouch_type"  style="width:160px;" disabled="disabled">
									<option value="0" attr2="0">????????????</option>
									<c:forEach var="list" items="${pouch_list}">
										<option value="${list.seqno}"  attr="/upload/pouch/${list.pouch_image}"  attr2=${list.pouch_price }  <c:if test="${setting.c_pouch_type eq list.seqno }">selected="selected"</c:if>  >${list.pouch_name}</option>
									</c:forEach>
								</select>
								<div class="img" id="pouchImgExp1"   ><img id="pouchImgExp"  style="cursor: pointer;" src="" alt="" height="123" width="123" /></div>
								<div class="extend_img1" style="display: none;"><img src="" alt="" id="extend_img1" style="width: 100%;height: 100%;" /></div>
							</td>
							<th>??????</th>
							<td>
								<select name="c_box_type" id="c_box_type"  style="width:160px;" disabled="disabled">
									<option value="0" attr2="0">????????????</option>
									<c:forEach var="list" items="${box_list}">
										<option value="${list.seqno}" attr="/upload/box/${list.box_image}"  attr2=${list.box_price }  <c:if test="${setting.c_box_type eq list.seqno }">selected="selected"</c:if> >${list.box_name}</option>
									</c:forEach>
								</select>
								<div class="img" id="boxImgExp1"><img id="boxImgExp" style="cursor: pointer;" src="" alt="" height="123" width="123" /></div>
								<div class="extend_img2" style="display: none;"><img src="" alt="" id="extend_img2" style="width: 100%;height: 100%;" /></div>
								
							</td>
						</tr>
						<tr  class="" style="display:none;">
							<th>???????????? ??????</th>
							<td>
								<select name="c_stpom_type" id="c_stpom_type"  style="width:160px;" disabled="disabled">
									<option value="0" attr2="0">????????????</option>
									<c:forEach var="list" items="${sty_list}">
										<option value="${list.seqno}" attr2="${list.price}"  <c:if test="${setting.c_stpom_type eq list.seqno }">selected="selected"</c:if>  >${list.sty_name}</option>
									</c:forEach>
								</select>
							</td>
							<th>?????? ??????</th>
							<td>
								<input type="text" name="c_box_ea" id="c_box_ea" value="1"   style="width:75px;"  disabled="disabled" />						
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
						<tr style="display:none;">
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
								<textarea name="c_joje_contents" id="c_joje_contents" class="textop"></textarea>
							</td>
						</tr>
						
						<tr>
							<th>????????????<br/>??????</th>
							<td style="padding-bottom:30px;">
								<!-- <a href="#"><span id="" class="h34 cB fl">?????? ?????? ????????????</span></a> -->
								<select name="" id="bok_name"  style="width:250px;" disabled="disabled">
									
									<!-- <option value="" attr="" selected="selected">???????????????.</option> -->
									<c:forEach var="list" items="${bok_list}">
										<%-- 
										<option value="${list.seqno}" attr="${list.contents}" attr2="${list.base_yn}" <c:if test="${list.base_yn eq 'y'}">selected="selected"</c:if> >${list.name}</option>
										 --%>
									</c:forEach>
								</select>
								<p class="fr"><input type="file" id="c_bokyong_file" name="c_bokyong_file" /></p>
								<c:if test="${!empty setting.c_bokyong_file}"><p class="fr"><a href="/download.do?path=tang/${setting.c_bokyong_folder}&filename=${setting.c_bokyong_file}&refilename=${setting.c_bokyong_file}">${setting.c_bokyong_file}</a></p></c:if>
								<textarea name="c_bokyong_contents" id="c_bokyong_contents" class="textop">${setting.c_bokyong_contents}</textarea>
							</td>
						</tr>
						
					</tbody>
				</table>
	
			</div>
			<!-- // LArea -->
			
			<!-- RArea -->
			<div class="RArea">
			
				<!-- ???????????? ?????? -->
				<div class="patientArea">
					<ul class="tab2">
						<li class="fir"><a href="#"  style="cursor: default;text-decoration: none;" class="sel">????????????</a></li>
						<li class="sec"><a href="#" style="cursor: default;text-decoration: none;">????????????</a></li>
					</ul>
					<!-- ???????????? -->
					<div class="patient_search" style="display:;">
						<p class="searchA">
							<select name="pat_search_titile" id="pat_search_titile"  style="width:110px;">
								<option value="name">?????????</option>
							</select>
							<input type="text" id="pat_search_value" name="pat_search_value" placeholder="???????????? ???????????????" style="width:255px;" />
							<a href="#" id="patientSearchBtn"><span id="" class="h32 cB">??????</span></a>
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
						<li ><a href="#" class="sel" style="width: 100%;cursor: default;text-decoration: none;" >???????????? ????????????</a></li>
					</ul>
					
					
					<!-- ???????????? -->
					<div class="yakjae order_detail" id="orderOp0" style="" id="">
						<div class="searchA">
							<p>
								<input type="text" id="fast_search_value" style="width:383px;" />
								<a href="#" id="fastTangBtn"><span id="" class="h34 cB mr5">??????</span></a>
							</p>
							<ul class="search_han2 fast_search_han2">
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
						<table id="fastGrid" class="orderlistGrid"></table>
						<div id="fastGridControl"></div>
						
						<style>
							.list_popup_fast{
								background: #ffff;
								border: 1px solid #717171;
								width: 448px;
								height: 600px;
								position: absolute;
								z-index: 99;
								top : 207px;
								left : 0px;			
								padding: 5px;					
							}
							
							.list_popup_fast .tit{
								font-weight: 700;
								width: 100%;
							}
							.list_popup_fast .btn_close{
								position: absolute;
								right: 15px;
								top: 15px;
							}
						</style>
						
						<div class="list_popup_fast" id="list_popup" style="display:none ;"></div>
					</div>
					<!-- // ???????????? -->
						
	
				</div>
				<!-- // ????????? -->
				
				
				<!-- ???????????? -->
				<div class="deliver">
					<p class="tit">
						<select name="d_type" id="d_type"  style="width:330px;margin-left:10px;">
							<option value="">??????</option>
							<option value="3" <c:if test="${setting.d_type eq 3 }">selected="selected"</c:if>>????????? ??? ??????</option>
							<option value="1" <c:if test="${setting.d_type eq 1 }">selected="selected"</c:if>>??????????????????  ??? ?????????</option>
							<option value="4" <c:if test="${setting.d_type eq 4 }">selected="selected"</c:if>>??????????????????  ??? ??????</option>							
							<option value="6" <c:if test="${setting.d_type eq 6 }">selected="selected"</c:if>>????????????</option>
							<option value="7" <c:if test="${setting.d_type eq 7 }">selected="selected"</c:if>>????????????</option>
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
									<input type="text" name="d_from_zipcode" id="d_from_zipcode01" value="${setting.d_from_zipcode}"  style="width:180px;" readonly><a href="#" id="addrBtn1"><span id="" class="h28 cB">????????????</span></a>
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
									<input type="text" name="d_to_zipcode" id="d_to_zipcode01" value="${setting.d_to_zipcode}"  style="width:180px;" readonly><a href="#" id="addrBtn2" ><span id="" class="h28 cB">????????????</span></a>
									<a href="#" id="latelyBtn" ><span id="" class="h28 cB">???????????????</span></a>
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
						<div class="lately_wrap" style="position: absolute;width: 850px;min-height: 520px;z-index: 99999;background: #fff;top: -100px;right: -20px;border: 1px solid #26995d;display: none;">
						</div>
					</div>
				</div>
				<!-- // ???????????? -->
				
				
					<div class="priceBox">
					<input type="hidden" name="cart_seqno" 	   id="cart_seqno" 	   value="${setting.cart_seqno}"  alt="cart_seqno" />
					<input type="hidden" name="tang_seqno" 	   id="tang_seqno" 	   value="${bean.tang_seqno}"    alt="tang_seqno" />
					<input type="hidden" name="temp_cnt" 	   id="temp_cnt" 	   value="${temp_cnt}"    alt="temp_cnt" />
					<input type="hidden" name="referer" 	   id="referer" 	   value="${referer}"    alt="referer" />
					
					
				
					<input type="hidden" name="order_yakjae_price" 	   id="order_yakjae_price" 	   value="0"  alt="?????????" />
					<input type="hidden" name="order_tang_price" 	   id="order_tang_price" 	   value="0"    alt="?????????" />
					<input type="hidden" name="order_suju_price" 	   id="order_suju_price" 	   value="0"    alt="????????????" />
					<input type="hidden" name="order_pojang_price" 	   id="order_pojang_price" 	   value="0"    alt="????????????" />
					<input type="hidden" name="order_delivery_price"   id="order_delivery_price"   value="0"    alt="?????????" />
					
					<input type="hidden" name="order_total_price_temp" id="order_total_price_temp"  value="${setting.order_total_price_temp}"   alt="?????????" />
					<input type="hidden" name="member_sale" 		   id="member_sale" 		    value="${setting.member_sale}"   alt="????????????" />
					<input type="hidden" name="order_total_price" 	   id="order_total_price" 	    value="${setting.order_total_price}"  alt="???????????????" />
					
					<input type="hidden" name="order_delivery_price_check"   id="order_delivery_price_check"  value="${setting.order_delivery_price_check}"   />
					<input type="hidden" name="cart_complete"   		     id="cart_complete"  			  value="${setting.cart_complete}"   />
					<input type="hidden" name="view_yn"   				     id="view_yn"  					  value="${setting.view_yn}"   />
					<input type="hidden" name="bunch"   				     id="bunch"                       value="${setting.bunch}"   />
					
					<!-- ?????? -->
					<input type="hidden" name="order_yakjae_price_cart" 	   id="order_yakjae_price_cart"    value="${setting.order_yakjae_price}"  alt="???????????????" />
					
					<p class="tit">????????????</p>
					
					
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
						
						$("#extend_img1").mouseout(function(){
							$('.extend_img1').hide();				
						}).mouseleave(function(){
							$('.extend_img1').hide();
						});
						
						
						$("#pouchImgExp1").mouseover(function(){
				            var src = $('#pouchImgExp').attr('src');
				            console.log('src = ', src);
				            $('.extend_img2').hide();
				            if(src == undefined || src ==  '' || src == null){
				            	$('.extend_img1').hide();
				            	return;
				            }
				            $('#extend_img1').attr('src', src)
				            $('.extend_img1').show();
				        });
						
						$("#boxImgExp1").mouseover(function(){
				            var src = $('#boxImgExp').attr('src');
				            $('.extend_img1').hide();
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
						
						
						var cal_cart_seqno = $('#cart_seqno').val();
						if(cal_cart_seqno != ''){
							 
							var cal_order_total_price = $('#order_total_price').val();
							var ca_member_sale        = $('#member_sale').val();
							var cal_order_total_price_temp_txt = new Number(cal_order_total_price) + new Number(ca_member_sale);
							$('#order_total_price_temp_txt').html( comma(  cal_order_total_price_temp_txt  )+'' );
							$('#member_sale_txt').html( comma( ca_member_sale +'' ) );
							$('#order_total_price_txt').html( comma(cal_order_total_price +'' ) );
						}
						
					}); // document
					
					function cartValidate(){
						
						if (!valCheck('w_name', '???????????? ????????????, ???????????????.')) return false;
						if (!valCheck('s_name', '???????????? ???????????????.')) return false;
																
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
							alert('????????? ??????????????? ????????????.');
							return false;
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
						}
						
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
						setAbleInput();
						
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
					        	setDisAbleInput();
					            alert(data.msg);
					            if(data.suc){
					            	location.href='/m05/02.do';
					            }
					        },
					        error : function(xhr, status) {
					        	setDisAbleInput();
				                console.log('xhr= ', xhr);
				                console.log('status= ', status);
				            }
					    });
					    
						$("#frm").submit();
					}// 
					
					
					function saveCartForm(){
						setAbleInput();
						
						setTimeout(function(){
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
						        	setDisAbleInput();
						            if(data.suc){
						            	if(confirm(data.msg)){
						            		location.href='/m05/02.do';
				 						}
						            }else{
						            	alert(data.msg);
						            }
						        },	
						        error : function(xhr, status) {
						        	setDisAbleInput();
					                console.log('xhr= ', xhr);
					                console.log('status= ', status);
					            }
						    });	
							$("#frm").submit();
						},100);
						
						
					}
					
					function setDisAbleInput(){
						$('#s_name').attr("disabled", true);
						$('#c_tang_type').attr("disabled", true);
						$('#c_tang_check13').attr("disabled", true);
						$('#c_tang_check14').attr("disabled", true);
						$('#c_tang_check15').attr("disabled", true);
						$('#c_tang_check16').attr("disabled", true);
						$('#c_chup_ea').attr("disabled", true);
						$('#c_chup_ea_price').attr("disabled", true);
						$('#c_chup_g').attr("disabled", true);
						$('#c_pack_ml').attr("disabled", true);
						$('#c_pack_ea').attr("disabled", true);
						$('#c_pouch_type').attr("disabled", true);
						
						$('#c_box_type').attr("disabled", true);
						$('#c_stpom_type').attr("disabled", true);
						$('#c_box_ea').attr("disabled", true);
					}
					
					function setAbleInput(){
						$('#s_name').attr("disabled", false);
						$('#c_tang_type').attr("disabled", false);
						$('#c_tang_check13').attr("disabled", false);
						$('#c_tang_check14').attr("disabled", false);
						$('#c_tang_check15').attr("disabled", false);
						$('#c_tang_check16').attr("disabled", false);
						$('#c_chup_ea').attr("disabled", false);
						$('#c_chup_ea_price').attr("disabled", false);
						$('#c_chup_g').attr("disabled", false);
						$('#c_pack_ml').attr("disabled", false);
						$('#c_pack_ea').attr("disabled", false);
						$('#c_pouch_type').attr("disabled", false);
						
						$('#c_box_type').attr("disabled", false);
						$('#c_stpom_type').attr("disabled", false);
						$('#c_box_ea').attr("disabled", false);
					}
				</script>
				
			</div>
			
			<div style="clear: both;"></div>
		</div>
		</form>
		
		
	</div>
	<!-- contents -->
</div>
<!-- //container -->	