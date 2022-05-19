<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	
	<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
	
	<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>
	<style>	
		.lately_area{
			width: 100%;
			border-top : none;
		}
		
		/* #00b49c */
		.ui-th-ltr, .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr{
			background: #f9f9f9;
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
		
		.popup [type="text"]{
			height: 34px;	
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
		
		.detailT01{
		
		}
		
		.detailT01 tr td{
			border-left : none;
		}
	</style>
	<script>
		$(document).ready(function() {
			$("#jqGrid").jqGrid({
		  		datatype: "local", 
		  		url : '/m03/select.do',
		  		datatype: 'json',
		  		hidegrid: false,
		  		width: '99%',
		  		height: "99%",
		  		rowNum: 6,
		  		colNames:[
		  			'주문순번'  , '수취인','우편번호'  , '주소'  , '휴대폰',
		  			'처방일' ,'적용' , 'r_tel'
		  		],
		  		colModel:[
		  			{name:'seqno',		index:'seqno',			width:68,	align:"center"  ,sortable : false ,key: true  },
		  			{name:'r_name',		index:'r_name',			width:100,	align:"center"  ,sortable : false },
		  			{name:'r_zipcode',	index:'r_zipcode',		width:50,	align:"center"  ,sortable : false },
		  			{name:'r_address',	index:'r_address',		width:270,	align:"left"  	,sortable : false },
		  			{name:'r_handphone',index:'r_handphone',	width:120,	align:"center"  ,sortable : false },
		  			
		  			
		  			{name:'order_date3', index:'order_date2',	width:80,	align:"center"  ,sortable : false},
		  			{name:'btn',		 index:'btn',			width:60,	align:"center"  ,sortable : false},
		  			{name:'r_tel',		 index:'r_tel',			width:60,	align:"center"  ,sortable : false, hidden:true}
		  		],
				pager: "#jqGridControl",
				viewrecords: true,
				autowidth: true,				
				//sortname: 'seqno',
				//sortorder: "desc",
				viewrecords: true,
				loadtext  : '',
				emptyrecords  : '',
				multiselect: false,
				cellEdit : false,
				loadComplete: function(data) {
					var rows = $("#jqGrid").getDataIDs(); 				
				    for (var i = 0; i < rows.length; i++){
				    	$('#').val();
				    	var a_btn = '<span class="cO h25">적용</span>';
				    	$("#jqGrid").setCell(rows[i] , 'btn', a_btn ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경									    										    	
				    }
				},
				onCellSelect : function(row,iCol,cellcontent,e){
					console.log('iCol = ', iCol);
					if(iCol == 6){
						var data = $("#jqGrid").jqGrid('getRowData', row);	
						console.log('data = ', data);
						
						$('#r_address01').val( objToStr(data.r_address , '') );
						$('#r_zipcode').val( objToStr(data.r_zipcode , '') );
						
						var r_handphone = objToStr(data.r_handphone , '');
						if(r_handphone != ''){
							 var jbSplit = r_handphone.split('-');
							 $('#r_handphone01').val( jbSplit[0] );
							 $('#r_handphone02').val( jbSplit[1] );
							 $('#r_handphone03').val( jbSplit[2] );
								
						}else{
							$('#r_handphone01').val( '' );
							$('#r_handphone02').val( '' );
							$('#r_handphone03').val( '' );	
						}											
						$('#r_name').val( objToStr(data.r_name , '') );
						
						var r_tel = objToStr(data.r_tel , '');
						if(r_tel != ''){
							 var jbSplit = r_tel.split('-');
							 $('#r_tel01').val( jbSplit[0] );
							 $('#r_tel02').val( jbSplit[1] );
							 $('#r_tel03').val( jbSplit[2] );
								
						}else{
							$('#r_tel01').val( '' );
							$('#r_tel02').val( '' );
							$('#r_tel03').val( '' );	
						}
						
						
						$('#r_address02').val('');
						setTimeout(function(){
							$('#r_address02').focus();						
				    	},50);
						$('.lately_wrap').fadeOut();
						
					}
				}
			});
			
			$("#jqGrid").jqGrid('navGrid','#jqGridControl',
		  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
		  	);
			
			$("#latelyCloseBtn").click(function() {
				$('.lately_wrap').hide();
				return false;
			});
			
			$("#search_value").keydown(function(key) {
				if (key.keyCode == 13) {
					search();
				}
			});
			
			$("#searchBtn").click(function() {
				search();
				return false;
			});
			
			$("#searchBtnAll").click(function() {
				$('#search_value').val('');
				search();
				return false;
			});
		});
			
		function search(){
			var param = {
				 pageSearch   : 1
				,search_value : $('#search_value').val()
				,search_title : $('#search_title').val()
			};
			$("#jqGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
		}
	</script>
	<style>
		
		.popup .tit .pop_closeBtn{
			float: right;
			right : 30px;
			top:30px;
			position: absolute;
		}
	</style>

	<!-- popup 사이즈 850x520 -->
	<div class="popup">
		<p class="tit">
			<span style="display: inline-block;">최근 배송정보 검색</span>
			
			<a href="#" id="latelyCloseBtn" class="pop_closeBtn"><img src="/assets/user/pc/images/btn_close01.png" alt="닫기" /></a>
		</p>
		<div class="topA">
			<select name="search_title" id="search_title" class="h35"  style="width:120px;">
				<option value="r_name">수취인</option>
			</select>
			<input type="text" placeholder="검색어를 입력해주세요."  name="search_value" id="search_value" style="width:230px;" />
			<a href="#" id="searchBtn"><span class="cB h35">검색</span></a>
			<a href="#" id="searchBtnAll"><span class="cg h35">전체보기</span></a>
			<!-- <a href="#" id="latelyCloseBtn"><span class="cB h35">닫기</span></a> -->
			
		</div>
		<table id="jqGrid" class="poplist" style="width: 809px;"></table>
		<div id="jqGridControl"></div>		
	</div>
