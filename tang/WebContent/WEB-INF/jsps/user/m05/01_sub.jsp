<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>
<!-- container -->
<style>
	.cart_list {width:100%; font-size:14px;}				
	.cart_list tbody tr td {				 	
		line-height:45px; 
		text-align:center;					
	}
	.cart_list .L {
		text-align:left; padding-left:10px;
	}
	.cart_list tbody tr:nth-child(even) {
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
	
	.cart_list{
		border-top: none;
	}
	
	.ui-widget.ui-widget-content{
		border: none;
	}
	
	.ui-jqgrid tr.jqgfirstrow td{
		border-right-width : 0px;
	}

	.conArea .thr_area{
		margin: 0 auto;
		width:1000px;
	}
	.conArea ul.thr_menu{
	 
	}
	
	.conArea ul.thr_menu li{
		float: left; 
		width: 150px;
		height: 30px;
		line-height: 30px;
		border: 1px solid #d1d1d1;
		border-right : none;		
		border-bottom: none;
		text-align: center;
	}
	
	.conArea ul.thr_menu li:first-child{
		
	}
	.conArea ul.thr_menu li.on{
		background: #26995d;
		color: #fff;						
	}
	
	.conArea ul.thr_menu li a{				
		display: block;
		font-weight: 700;								
	}
	
	.conArea ul.thr_menu li.on a{
		color: #fff;
	}

</style>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#subMemberBtn").click(function() {
		
		if(!valCheck( 'id' ,'???????????? ???????????????.') ) return  false;
		
		if($('#id').val().length > 12 || $('#id').val().length < 6){
			alert('6~12?????? ????????? ???????????? ???????????????.');
			$('#id').focus();
			return  false;
		}
		
		if( $('#check_id').val == 0 ){
			alert('????????? ??????????????? ???????????????.');
			return  false;
		}
		
		if( objToStr($('#password').val() , '') != '' ){
			if(!valCheck( 're_password' ,'??????????????? ???????????????.') ) return false;
			if(!pwdCheck('password', 're_password') ) return false;
		}
		
		if(!valCheck( 'name' ,'????????? ???????????????.') ) return  false;
		
		$.ajax({
			url  : '01_sub_id_proc.do',
			type : 'POST',
			data : $('#frm').serialize(),
			error : function() {
				alert('????????? ??????????????????.\n???????????? ???????????????.');
			},
			success : function(data) {
				alert(data.msg);
				if(data.suc){
					$("#subGrid").trigger("reloadGrid");
					$('#frm').each(function(){
					    this.reset();
					});
				}
			}
		});
		return false;
	});
	
	
	$("#cancelBtn").click(function() {
		$('#frm').each(function(){
		    this.reset();
		});
		return false;
	});
	
	
	$("#dupleIdBtn").click(function() {
		if(!valCheck( 'id' ,'???????????? ???????????????.') ) return  false;
		
		if($('#id').val().length > 12 || $('#id').val().length < 6){
			alert('6~12?????? ????????? ???????????? ???????????????.');
			$('#id').focus();
			return false;
		}
		
		
		$.ajax({
			url : '01_duple_sub_id.do',
		    data : {
		    	id : $('#id').val()
		    },        
	        error: function(){
		    	alert('????????? ??????????????????.\n???????????? ???????????????.');
		    },
		    success: function(data){
		    	alert(data.msg);
		    	$('#check_id').val(data.check_id);		    	
		    }   
		});
		return false;
	});
	
	
	$("#subGrid").jqGrid({
  		//caption : '?????? ????????????',
  		//dataType : 'local', // ????????? ?????? ??????   		
  		url : '01_sub_list.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "99%",
  		height: "100%",
  		rowNum: 2000,				  	
  		colNames:[
  			'seqno', '?????????','??????', '??????' ,'????????????<span style="color:red;">(????????? ????????? ?????? ???????????????.)</span>',
  			'?????????', '??????'
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'id',			index:'id',			width:100,	align:"left" ,sortable : false},
  			{name:'name',		index:'name',		width:120,	align:"left" ,sortable : false
  				,editable:true
  			},
  			{name:'grade',		index:'grade',		width:120,	align:"center" ,sortable : false
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					value:"1:?????????;2:??????"  					
  				}
  				,formatter: 'select' 
  			},
  			{name:'password',	index:'password',	width:250,	align:"left" ,sortable : false
  				,editable:true
  			},
  			
  			{name:'reg_date2',	index:'reg_date2',	width:120,	align:"center" ,sortable : false},
  			
  			
  			{name:'delBtn',		index:'delBtn',	width:80,	align:"center" ,sortable : false},
  		],
		pager: "#subGridControl",
		multiselect: false,
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		cellEdit :true,
		cellurl : '01_sub_update_col.do',
		emptyrecords  : '',
		loadtext  : '???????????? ????????????????????????.',
		beforeSelectRow: function (rowid, e) {
		    var $self = $(this), iCol, cm,
		    $td = $(e.target).closest("tr.jqgrow>td"),
		    $tr = $td.closest("tr.jqgrow"),
		    p = $self.jqGrid("getGridParam");

		    if ($(e.target).is("input[type=checkbox]") && $td.length > 0) {
		       iCol = $.jgrid.getCellIndex($td[0]);
		       cm = p.colModel[iCol];
		       if (cm != null && cm.name === "cb") {
		           // multiselect checkbox is clicked
		           $self.jqGrid("setSelection", $tr.attr("id"), true ,e);
		       }
		    }
		    return false;
		},
		beforeSubmitCell : function(rowid, cellName, cellValue) { 
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		afterSaveCell : function(owid, name, val, iRow, iCol){
			/* 
			console.log('owid = ',owid );
			console.log('name = ',name );
			console.log('val = ',val );
			console.log('iRow = ',iRow );
			console.log('iCol = ',iCol );
			 */
			setTimeout(function(){
				$("#subGrid").trigger("reloadGrid");
			},300);

		},
		onCellSelect : function(row,iCol,cellcontent,e){
			var data = $("#subGrid").jqGrid('getRowData', row);
			//console.log(iCol);
			console.log('data = ',data);
			if(iCol == 6){
				if(!confirm('??????????????????????')){
					return false;
				}
				
				$.ajax({
					url : '01_del_sub_id.do',
				    data : data,        
			        error: function(){
				    	alert('????????? ??????????????????.\n???????????? ???????????????.');
				    },
				    success: function(data){
				    	alert(data.msg);	
				    	if(data.suc){
				    		$("#subGrid").trigger("reloadGrid");
				    	}
				    }   
				});
				
			}
		},
		loadComplete: function(data) {
			var rows = $("#subGrid").getDataIDs();
			
			for (var i = 0; i < rows.length; i++){
				
				var delBtn = '<span class="cO h25">??????</span>';
				
				$("#subGrid").setCell(rows[i] , 'delBtn', delBtn ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // ?????? cell ????????????
	    		
			}// for
			
			
		},
	});// cardGrid
	
});
</script>
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "???????????????";
		String sec_nm = "???????????????";
		String thr_nm = "???????????????";
		int fir_n = 5;
		int sub_n = 1;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="?????? ??????"></div>
	
	<!-- contents -->
	<div id="contents">
		<!-- ?????? -->
		
		<%-- ${userInfo} --%> 
		
		<div class="conArea">
			<div  class="thr_area" >
				<ul class="thr_menu">
					<li><a href="/m05/01.do">???????????????</a></li>
					<li  class="on"><a href="/m05/01_sub.do">??????????????????</a></li>
				</ul>
				<div style="clear: both;"></div>
			</div>
			
			<input type="hidden" name="part" id="part" value="${info.part}" />
			<!-- join_form01 -->
			<div class="join_form01">
				<p class="tit">* ???????????? ?????? ??????</p>
				
				<table id="subGrid" class="cart_list"></table>
			</div>
			
			<form action="sub_id_proc.do" id="frm" name="frm" >
				<div class="join_form02">
					<p class="tit">* ???????????? ??????</p>
					
					<table class="formT">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>?????????</th>
								<td>
									<input type="text" name="id" id="id" style="width:220px;">
									<a href="#" id="dupleIdBtn"><span class="h35 cB">????????????</span></a>
									<span class="t01">! 6~12????????? ???????????? ??????????????????. </span>
								</td>
							</tr>
							<tr>
								<th>????????????</th>
								<td>
									<input type="password" name="password" id="password"  style="width:310px;">
									<span class="t01">! ???????????? ????????? ????????? ????????????????????? ???????????????. </span>
								</td>
							</tr>
							<tr>
								<th>??????????????????</th>
								<td>
									<input type="password" name="re_password" id="re_password" style="width:310px;">
									<span class="t01">! ??????????????? ?????? ??? ???????????????. </span>
								</td>
							</tr>
							<tr>
								<th>??????</th>
								<td>
									<input type="text" name="name" id="name" style="width:200px;">
									<span class="t01">! ????????? ????????? ????????? ?????????.</span>
								</td>
							</tr>
						</tbody>
					</table>
					
					<!-- btnarea -->
					<div class="btn_area01">
						<a href="#" id="cancelBtn"><span class="cw h60">??????</span></a>
						<a href="#" id="subMemberBtn"><span class="cg h60">??????</span></a>
					</div>
					<!-- //btnarea -->
				</div>
			</form>
				
			

		</div>
		<!-- //?????? -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	