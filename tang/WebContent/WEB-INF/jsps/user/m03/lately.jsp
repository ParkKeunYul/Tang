<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>Document</title>
	<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>
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
		
		.lately_area [type="text"]{
			height: 34px;	
			margin-left: -3px;
			padding-left: 0px;
			background-color: #fff;								
		}
		.lately_area select{
			height: 38px;
			vertical-align: top;
			margin-right: 0px;
			padding-right: 0px;
			background-color: #fff;
		}
		
		.beforetit{
			color: #222222;
			margin-bottom: 0px;
		}
		
		.lately_area .h35{
			vertical-align: top;
		}
		
		#latelyCloseBtn{
			position: absolute;
			right: 20px;
			top: 25px;
		}
		
		.ui-jqgrid-labels{
			background:#e8e8e8; 
			border-bottom:1px solid #dddddd; 
			padding:10px 0 10px 0; 
			font-weight:700; 
			text-align:center;
		}
		
		.ui-jqgrid .ui-jqgrid-htable th{
			padding: 0 0 5px 0;
		}
		
		.ui-jqgrid .ui-jqgrid-htable th div{
			height: auto;
			font-size: 13px;
			font-weight: 700;
			font-family: 'Nanum Gothic';
		}
		
		.ui-jqgrid .ui-jqgrid-sortable{
			cursor: default;
		}
		
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
		
		.ui-jqgrid tr.ui-row-ltr td{
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
	<script type="text/javascript" src="/assets/user/js/m03_lately.js"></script>
</head>
<body>

	<script>
	
	</script>
	<div class="lately_area" style="width: 100%;border-top: none;">
		<p class="beforetit" style="width: 100%;">
			?????? ???????????? ??????
			<a href="#" id="latelyCloseBtn" ><span class="cB h35">??????</span></a>
		</p>	
		<div class="beforeB">
			<div class="topA" style="margin-bottom: 10px;">
				<select name="search_title" id="search_title"  style="width:120px;">
					<option value="r_name">?????????</option>
				</select>
				<input type="text" name="search_value" id="search_value" placeholder="???????????? ??????????????????." style="width:230px;" />
				<a href="#" id="searchBtn"><span class="cB h35">??????</span></a>
			</div>
			
			<div style="width: 100%;min-width: 808px;">
				<table id="jqGrid" class="order_view" style="width: 809px;"></table>
				<div id="jqGridControl"></div>
			</div>
		</div>
	</div>
</body>
</html>


