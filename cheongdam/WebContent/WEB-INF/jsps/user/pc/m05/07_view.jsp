<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<jsp:useBean id="now" class="java.util.Date" />
<!-- container -->
<script>
var jqGridDataUrl = '/m05/07_select_main.do';
</script>
<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>

<script type="text/javascript" src="/assets/user/js/z_js/z_tangOrderGrid.js?111${now}"></script>

<!-- <script type="text/javascript" src="/assets/user/js/z_js/z_tangOrderGrid.js"></script> -->
<script type="text/javascript" src="/assets/user/js/m04_04_view.js"></script>

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
	#dicGrid,
	#myDicGrid{
		font-size: 13px;
	}
	
	#wrap #container #contents_order {position:relative; width:1260px; height:100%; min-height:800px; margin-left:200px; padding:55px 30px 100px 30px; background:#ffffff; box-sizing:border-box; z-index:99;}
</style>
<div id="container">

	
	<!-- contents -->
	<div id="contents_order" style="margin-bottom: 150px;">
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>???????????????</span><span>????????????</span></p>
		</div>

		<ul class="sub_Menu w16">
			<li><a href="01.do">??? ????????????</a></li>
			<li><a href="02.do">????????????</a></li>
			<li><a href="03.do">????????????</a></li>
			<li class="sel"><a href="07.do">?????? ????????????</a></li>
			<li><a href="05.do">????????????</a></li>
			<li><a href="04.do">???????????????????????????</a></li>
		</ul>
		
	
		<!-- LArea -->
		<div class="LArea">
			<form action="#" name="frm" id="frm" method="post">
				<input type="hidden" name="my_seqno" id="my_seqno" value="${bean.seqno}" />
				<input type="hidden" name="json_yakjae" id="json_yakjae"  value=""/>
				<!-- ???????????? ?????? -->
				<div class="div_tit">????????????<span class="fc06">(????????? 1????????? ???????????????.)</span></div>
				<div class="oderlist_top">
					<p><span>?????????</span><input type="text" name="s_name" id="s_name" value="${view.s_name}"  style="width:550px;margin-left:10px;" /></p>
					<p><span>??????</span><input type="text" name="b_name" id="b_name" value="${view.b_name}" style="width:250px;margin-left:10px;" /></p>
				</div>
			</form>
		
			<div class="oderlistArea pb60" style="display:;">
				
			
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
								<div>
									<a href="#" id="delItemBtn"><span class="cBB h30" style="font-weight: 700;">?????? ??????</span></a>
								</div>
							</td>
							<td class="b">??????</td>
							<td><span class="b" id="tot_yakjae_joje_txt">0</span>g</td>
							<td colspan="2"><span class="b" id="tot_yakjae_danga_txt">0</span>???</td>
						</tr>
					</tfoot>
				</table>
				
				<!-- ???????????? popup -->
				<div class="yakjae_popup" style="display:none; top:0px; left:0px;"></div>
				<!-- // ???????????? popup -->
			</div>
			<!-- // ??????????????? ???????????? -->				
			<!-- // ???????????? ?????? -->

		</div>
		<!-- // LArea -->

		<!-- RArea -->
		<div class="RArea">

			<!-- ????????? -->
			<div class="order_option">
				<ul class="tab4">
					<li><a href="#" class="sel">????????????</a></li>
					<li><a href="#">???????????????</a></li>
					<li><a href="#" >????????????</a></li>
					<li><a href="#" style="cursor: default;">????????????</a></li>
				</ul>
				
				<!-- ???????????? -->				
				<div class="yakjae order_detail" id="orderOp0" style=";" id="">					
				
					<div class="searchA">
						<p>
							<input type="text" id="yakjae_search_value" style="width:115px;" />
							<a href="#" id="yakjaeSearchBtn"><span id="addrBtn1" class="h34 cB mr5">??????</span></a>
							<input type="text" id="yakjae_multi_value"  placeholder="??????????????? ???????????? ??????" style="width:180px;" />
							<a href="#" id="yakjaeMultiSearchBtn"><span id="addrBtn1" class="h34 cbg">????????????</span></a>
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
				<div class="dictionary order_detail" style="display:none;" id="orderOp1" >
					<div class="searchA">
						<p>
							<input type="text" id="dic_search_value" style="width:355px;" />
							<a href="#" id="dicSearchBtn"><span id="addrBtn1" class="h34 cB mr5">????????????</span></a>
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
						<p><a href="#" class="btn_close dic_btn_close"><img src="/assets/user/pc/images/sub/btn_close03.png" alt="" /></a></p>
						<p class="tit">???????????? <a href="#" id="dic_pop_detail"><img src="/assets/user/pc/images/sub/btn_view.png" alt="????????????" /></a></p>
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
				<div class="my_dictionary order_detail" style="display:none;" id="orderOp2">
					<div class="searchA">
						<p>
							<input type="text" id="mydic_search_value" style="width:355px;" />
							<a href="#" id="mydicSearchBtn"><span id="addrBtn1" class="h34 cB mr5">????????????</span></a>
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
						<p><a href="#" class="btn_close mydic_btn_close"><img src="/assets/user/pc/images/sub/btn_close03.png" alt="" /></a></p>
						<p class="tit">???????????? <a href="#" id="mydic_pop_detail"><img src="/assets/user/pc/images/sub/btn_view.png" alt="????????????" /></a></p>
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
			</div>
			<!-- // ????????? -->
			
			<script>
				//addBtnAll
				$(document).ready(function() {
					
					$('#addBtnAll').click(function() {
						
						for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
			    			$('#jqGrid').editCell(i,  5 , false);	
			    		}
						
						if (!valCheck('s_name', '???????????? ???????????????.')) return false;
						if (!valCheck('b_name', '???????????? ???????????????.')) return false;
						
						var rows = $("#jqGrid").getDataIDs();
						/* if(rows.length <=0){
							alert('????????? ????????? ????????????.');
							return false;
						} */
						
						var jsonNewData = [];
						for (var i = 0; i < rows.length; i++){
							var record = $('#jqGrid').jqGrid('getRowData', rows[i]);
							record.yak_name = '';
							record.sel_img = '';
							
							jsonNewData.push(JSON.stringify(record));
		    			}//
		    			console.log(1);
						$('#json_yakjae').val(jsonNewData);
		    			//console.log('json_yakjae = ', $('#json_yakjae').val());
						
		    			
		    			$.ajax({
		    				url : '/m05/07_save.do',
		    				type: 'POST',
		    				data : $("form[name=frm]").serialize(),
		    				//dataType : 'json',
		    				error : function() {
		    					alert('????????? ??????????????????.\n???????????? ???????????????.');
		    				},
		    				success : function(data) {
		    					alert(data.msg);
		    					if(data.suc && objToStr($('#my_seqno').val()) == ''){
		    						location.href='/m05/07.do';
		    					}
		    				}
		    			});
		    			
						return false;
					});
					
				});
				
				function yak_temp_save(){
					
				}
			</script>
			
			<div class="btn_area05">
				<a href="07.do?page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}"><span class="cw h50">??????</span></a>
				<a href="#" id="addBtnAll"><span class="cg h50">??????</span></a>
			</div>

		</div>
		<!-- // RArea -->
		<div style="clear: both;"></div>
		<!-- // ?????? -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	