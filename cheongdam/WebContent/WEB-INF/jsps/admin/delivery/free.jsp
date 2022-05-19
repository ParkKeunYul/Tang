<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<!-- <script type="text/javascript" src="/assets/admin/js/jsp/delivery/base.js"> </script> -->
<script>
$(document).ready(function() {
	
  	$("#jqGrid").jqGrid({
  	//	caption : '택배사 정보',
  		//dataType : 'local', // 로딩시 최초 조회 		  		
  		datatype: "local", 
  		url : 'select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "700",
  		height: "100%",
  		rowNum: 100,
  		//rowList: [20,50,100,500],
  		//rowList: [3],
  		colNames:[
  			'배송비 무료 처방비용합계(이상)' , '택배가격' 
  		],
  		colModel:[
  			{name:'price',		index:'price',	width:450,	align:"right"  ,sortable : false
  				,formatter: 'integer'
  	  			,formatoptions:{thousandsSeparator:","}
  				,editable:true
  			},
  			{name:'box',		index:'box',	width:250,	align:"right"  ,sortable : false
  				,formatter: 'integer'
  	  			,formatoptions:{thousandsSeparator:","}
  				,editable:true
  			}
  		],
		//pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,				
		//sortname: 'seqno',
		//sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
		cellEdit : true,
		editurl : 'select.do',
		cellurl : 'update_col.do',
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			//console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		afterSubmitCell   : function(res) {
			console.log('afterSubmitCell = ', res.responseJSON.suc);
			
			if(res.responseJSON.suc){
				 $("#jqGrid").trigger("reloadGrid");
				 
				 return [true,'저장되었습니다.'];
			}else{
				return [true,'다시 시도해주세요'];
			}							
		},
		beforeEditCell : function(rowid, cellname, value, iRow, iCol){
		    selICol = iCol;
		    selIRow = iRow;
		},
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
		loadComplete: function(data) {
		},
	});
  	
  	//페이지 넘 
  	/* jQuery("#jqGrid").jqGrid('navGrid','#jqGridControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	); */ 
  	
  	
  	$("#addForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 370,
        width: 650,
       // position: 'center',
        modal: true,
        title: '택배사 추가',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#addForm').html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#addForm").dialog('close'); 
        	});
        },
        buttons: {
            "추가": function () {
            	a_base_add();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
  	
  	$('#addBtn').click(function() {
  		$.ajax({
		    url: "add.do",		    
		    type : 'POST',
	        error: function(){
		    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		    },
		    success: function(data){
		        $("#addForm").html(data);
		        $("#addForm" ).dialog( "open" );
		    }   
		});	
		//$("#group_addForm" ).dialog( "open" );
	});
	  	
});
</script>
	
	<div class="con_tit">택배관리 &gt; 배송비관리</div>
	
	<div class="conBox">
		<div id="addForm"></div>
		<div id="modForm"></div>
		
		<!-- <div class="inputArea disB">
			<a href="#" id="addBtn" class="btn02">택배사 추가</a>
		</div> -->
		<div style="width: 300px;">
			<table id="jqGrid" style="width:300px;"></table>
		</div>
	</div>

</html>