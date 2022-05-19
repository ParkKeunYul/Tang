<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>

<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<%

	Date today = new Date();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

%>
<%-- <script type="text/javascript" src="/assets/admin/js/jsp/item/amount.js?a=<%=sdf.format(today)%>"> </script> --%>
<%-- <script type="text/javascript" src="/assets/admin/js/zjsp/item/amount.js?a=<%=sdf.format(today)%>"> </script> --%>
<script>
$(document).ready(function() {
	$("#jqGrid").jqGrid({
  		//caption : '박스 관리 목록',
  		dataType : 'local', // 로딩시 최초 조회 
  		/* data: mydata,
  		datatype: "local", */
  		url : '/admin/item/amountHis/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 30,
  		rowList: [10,30,50, 100, 500, 1000, 2000],
  		//rowList: [3],
  		colNames:[
  			'번호','순번','아이디','이름', '충전포인트' , '차감포인트',
  			'적립 및 사용처' ,'등록일' ,'기능', 
  			
  			'use_reason' , 'amount_seqno' , 'mem_seqno' ,'seqno'
  		],
  		colModel:[
  			{name:'seqno',	  	  index:'seqno',		width:38,	align:"left" ,key: true , hidden:true},
  			{name:'a_num',	  	  index:'a_num',		width:78,	align:"center"  ,sortable : false  },
  			{name:'mem_id',	 	  index:'mem_id',		width:100,	align:"center" ,sortable : false},
  			{name:'mem_name',	  index:'mem_name',		width:100,	align:"center" ,sortable : false},
			{name:'p_point',	  index:'p_point',		width:100,	align:"center" ,sortable : false ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} },			
			{name:'m_point',	  index:'m_point',		width:100,	align:"center" ,sortable : false ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} },
						
			{name:'reason',	  	  index:'reason',		width:250,	align:"left" ,sortable : false},
			{name:'reg_date2',	  index:'reg_date2',		width:150,	align:"center" ,sortable : false},
			{name:'btn_info',	  index:'btn_info',		width:150,	align:"center" ,sortable : false},
			
			{name:'use_reason',	  index:'use_reason',		width:250,	align:"left" ,sortable : false , hidden:true},			
			{name:'amount_seqno', index:'amount_seqno',		width:250,	align:"left" ,sortable : false , hidden:true},
			{name:'mem_seqno',	  index:'mem_seqno',		width:250,	align:"left" ,sortable : false , hidden:true},
			{name:'order_seqno',  index:'order_seqno',		width:250,	align:"left" ,sortable : false , hidden:true},
  			
  		],
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'sort_seq',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		cellEdit : true,
		editurl : '/admin/item/amountHis/select.do',
	//	cellurl : '/admin/item/amountHis/update_col.do',
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		/* afterSubmitCell : function(res) {
			console.log('>>>>', res.responseJSON);
			console.log('>>>>', (res.responseJSON.suc));
			//if(!res.responseJSON.suc){
			//	alert(res.responseJSON.msg);
			//}
		}, */
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
		footerrow: true,
		loadComplete: function(data) {
			var rows = $("#jqGrid").getDataIDs();
			
			var records = data.records;
			var page    = data.page;
			var cnt     = data.cnt;
			
			records = records -((page-1) * cnt);
		    for (var i = 0; i < rows.length; i++){
		    	$("#jqGrid").setCell(rows[i] , 'a_num', records-- , {});
		    	
		    	
		    	var p_point     = $("#jqGrid").getCell(rows[i],"p_point");
		    	var m_point     = $("#jqGrid").getCell(rows[i],"m_point");
		    	var reason      = $("#jqGrid").getCell(rows[i],"reason");
		    	var use_reason  = $("#jqGrid").getCell(rows[i],"use_reason");
		    	var amount_seqno= $("#jqGrid").getCell(rows[i],"amount_seqno");
		    	var pp_seqno    = $("#jqGrid").getCell(rows[i],"pp_seqno");
		    	var mem_id      = $("#jqGrid").getCell(rows[i],"mem_id");
		    	var order_seqno      = $("#jqGrid").getCell(rows[i],"order_seqno");
		    	
		    	console.log(i, mem_id);
		    	$("#jqGrid").setCell(rows[i] , 'mem_id', mem_id ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	
		    	if(p_point > 0){
		    		$("#jqGrid").setCell(rows[i] , 'p_point', "" ,  {color:'blue'}); // 특정 cell 색상변경
		    	}
		    	if(m_point > 0){
		    		$("#jqGrid").setCell(rows[i] , 'm_point', "" ,  {color:'red'}); // 특정 cell 색상변경
		    		
		    		
		    		var msg_reason = reason;
		    		if(pp_seqno > 0){
		    			reason = 	reason + '[ '+use_reason +' ]' ;
		    		}
		    		
		    		$("#jqGrid").setCell(rows[i] , 'reason', reason ,  '');
		    	}
		    	
		    	if(order_seqno > 0){
		    		$("#jqGrid").setCell(rows[i] , 'btn_info',  '[ 신용카드 결제정보  ]' ,  {color:'blue',weightfont:'bold',cursor: 'pointer'});
		    	}
		    }
		    
		    
		    var all_p_point = $("#jqGrid").jqGrid('getCol','p_point', false, 'sum');
		    var all_m_point = $("#jqGrid").jqGrid('getCol','m_point', false, 'sum');
		    var orderCnt    = $("#jqGrid").getGridParam("reccount");
		    
		    console.log('orderCnt = ', orderCnt);
		    
		    $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',p_point:all_p_point});
		    $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',m_point:all_m_point});
            $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',reason:'총 : '+orderCnt+'건'});
		    
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('onCellSelect = ', iCol);
			var data = $("#jqGrid").jqGrid('getRowData', row);	
			var ret = $("#jqGrid").getRowData(row);
			
			
			
			if(iCol == 3){
				ret.seqno = ret.mem_seqno;	
				
				
				$.ajax({
				    url   : "/admin/base/member/mod.do",		    
				    type  : 'POST',
				    data  : ret,
			        error: function(){
				    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				    },
				    success: function(data){
				        $("#memberForm").html(data);
				        $("#memberForm" ).dialog( "open" );
				    }   
				});	
			}else if(iCol == 9 && ret.amount_seqno > 0){
				
				 $.ajax({
				    url   : "/admin/item/amountHis/payinfo.do",		    
				    type  : 'POST',
				    data  : ret,
			        error: function(){
				    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				    },
				    success: function(data){
				    //	console.log(data);
				    	///$("#payinfoForm").dialog('close');
				    
				        $("#payinfoForm").html(data);
				        $("#payinfoForm" ).dialog( "open" );
				    }   
				});			
			}
		},
	});
	
	
	$("#payinfoForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 670,
        width: 850,
       // position: 'center',
        modal: true,
        title: '결제정보',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#modForm').html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#payinfoForm").dialog('close'); 
        	});
        },
        buttons: {
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
	
	$("#addForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 420,
        width: 1150,
       // position: 'center',
        modal: true,
        title: '포인트추가 및 차감',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#modForm').html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#payinfoForm").dialog('close'); 
        	});
        },
        buttons: {
        	"저장": function () {
            	a_point_proc();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
	
	
	$("#addAmountBtn").click(function() {
		$.ajax({
		    url   : "/admin/item/amountHis/point_add.do",		    
		    type  : 'POST',
	        error: function(){
		    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		    },
		    success: function(data){
		        $("#addForm").html(data);
		        $("#addForm" ).dialog( "open" );
		    }   
		})
	});
	
	$("#memberForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 800,
        width: 1200,
       // position: 'center',
        modal: true,
        title: '회원정보관리',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#memberForm').html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#memberForm").dialog('close'); 
        	});
        },
        buttons: {
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
	
	
	$('#search_btn').click(function() {
		searchClick();		
		return false;
	});
	
	 $("#search_value").keydown(function(key) {
         if (key.keyCode == 13) {
        	 searchClick();
         }
     });


});

function searchClick(){
	var search_value = $('#search_value').val();
	var search_title = $('#search_title').val();
	var search_type  = $('#search_type').val();
	
	var param = { 
		 search_value : search_value
		,search_title : search_title
		,search_type  : search_type
	};
	
	$("#jqGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}
</script>


<div class="con_tit">아이템관리 &gt; 포인트 충전-사용관리</div>
<div class="conBox">
	<div class="inputArea disB">
		<select name="search_type" id="search_type">
			<option value="">포인트전체</option>
			<option value="card">카드충전</option>			
			<option value="ms">결제차감</option>
			<option value="ps">일반충전</option>
		</select>
		
		<select name="search_title" id="search_title">
			<option value="mem_name">이름</option>
			<option value="mem_id">아이디</option>
		</select>
		<input type="text" id="search_value" value="">
		<a href="#" id="search_btn" class="btn01">검색</a>
	
		<a href="#" id="addAmountBtn" class="btn02">포인트 추가 및 차감</a>
	</div>
	
	<table id="jqGrid"></table>
	<div id="jqGridControl"></div>
	<div id="addForm"></div>
	<div id="memberForm"></div>
	<div id="payinfoForm"></div>
</div>



</html>