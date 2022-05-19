<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>최근 배송정보 검색</title>	
	<style>	
		.lately_area{
			width: 100%;
			border-top : none;
		}
		
		.lately_area div{
			width: 100%;
			border-top : none;
			border-bottom : none;
			clear: both;
			margin-bottom: 0px;
		}
		
		.lately_area div p{
			margin-bottom: 0px;
		}
		
		.lately_area .beforeB [type="text"]{
			height: 34px !important;
			margin-left: -3px !important;
			padding-left: 0px !important;
			background-color: #fff !important;
		}
		
		.lately_area select{
			height: 34px !important;
			vertical-align: top !important;
			margin-right: 0px !important;
			padding-right: 0px !important;
			background-color: #fff !important;
		}
		
		.beforetit{
			color: #222222;
			margin-bottom: 0px;
			background: #f9f9f9;
		}
		
		.lately_area .h35{
			vertical-align: top;
		}
		
		#latelyCloseBtn{
			position: absolute;
			right: 20px;
			top: 10px;
		}	
		.lately_area .beforetit{
			width:100%; background:#f9f9f9; border-bottom:1px solid #dddddd; padding:15px 0 15px 20px; font-weight:700; margin-bottom:10px;
		}
		
		.grid_pop_la .ui-jqgrid .ui-jqgrid-htable th{
			padding: 0 0 5px 0;
		}
		
		
		.grid_pop_la .ui-jqgrid-labels{
			background:#e8e8e8; 
			border-bottom:1px solid #dddddd; 
			padding:10px 0 10px 0; 
			font-weight:700; 
			text-align:center;
		}
		
		.grid_pop_la .ui-jqgrid .ui-jqgrid-htable th{
			padding: 0 0 5px 0;
		}
		
		.grid_pop_la .ui-jqgrid .ui-jqgrid-htable th div{
			height: auto;
			font-size: 13px;
			font-weight: 700;
			font-family: 'Nanum Gothic';
		}
		
		.grid_pop_la .ui-jqgrid .ui-jqgrid-sortable{
			cursor: default;
		}
		
		.grid_pop_la .ui-jqgrid .ui-jqgrid-pager{
			height: 38px;
		}
		.grid_pop_la .ui-state-default, .ui-widget-content .ui-state-default{
			border:  none;
		}
		
		.grid_pop_la .ui-widget-content{
			border: none; 
		}
		.grid_pop_la .ui-state-highlight, .ui-widget-content .ui-state-highlight{
			border : none;
		}
		
		
		.grid_pop_la .ui-jqgrid .ui-pg-table td{
			font-size: 13px;
		}
		
		.grid_pop_la .ui-th-ltr, .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr{
			background: #e8e8e8;
		}
		
		.grid_pop_la .ui-corner-all, .ui-corner-bottom, .ui-corner-right, .ui-corner-br{
			border-bottom-right-radius : 0px;
		}
		
		.grid_pop_la .ui-corner-all, .ui-corner-bottom, .ui-corner-left, .ui-corner-bl{
			border-bottom-left-radius : 0px;
		}
		.grid_pop_la .ui-corner-all, .ui-corner-top, .ui-corner-right, .ui-corner-tr{
			border-top-right-radius : 0px;
		}
		.grid_pop_la .ui-corner-all, .ui-corner-top, .ui-corner-left, .ui-corner-tl{
			border-top-left-radius : 0px;
		}
		
		.grid_pop_la .ui-jqgrid tr.ui-row-ltr td{
			border-right-width : 0px !important;
			border-bottom:1px solid #dddddd;
		}
		
		.order_view{
			border-top: none;
		}
		
		.ui-widget.ui-widget-content{
			border: none;
		}
		
		.ui-jqgrid tr.jqgfirstrow td{
			border-right-width : 0px;
		}
		
		div.ui-pager-control .ui-pg-input[type="text"]{
			height: 15px !important;
			width : 22px;
			padding : 0 0;
			vertical-align: middle;
			font-size: 13px;
			text-align: right;
		}
		
	</style>
	<script type="text/javascript" src="/assets/user/js/m02_lately.js"></script>
</head>
<body>

	<script>
	
	</script>
	<div class="lately_area" style="width: 100%;border-top: none;">
		<p class="beforetit" style="width: 100%;padding-left: 0px;">
			<span style="display: inline-block;padding-left: 20px;font-weight: 700;">최근 배송정보 검색</span>			
			<a href="#" id="latelyCloseBtn" ><span class="cB h35">닫기</span></a>
		</p>	
		<div class="beforeB">
			<div class="topA" style="margin-bottom: 10px;">
				<select name="search_title" id="search_title"  style="width:120px;">
					<option value="d_to_name">수취인</option>
				</select>
				<input type="text" name="search_value" id="search_value" placeholder="검색어를 입력해주세요." style="width:230px;" />
				<a href="#" id="searchBtn"><span class="cB h35">검색</span></a>
			</div>
			
			<div style="width: 100%;min-width: 808px;" class="grid_pop_la">
				<table id="layelyPop" class="orderlistGrid" style="width: 809px;"></table>
				<div id="layelyPopControl"></div>
			</div>
		</div>
	</div>
</body>
</html>


