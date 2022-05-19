<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">
<jsp:useBean id="now" class="java.util.Date" />
<style>
.ui-dialog .ui-dialog-buttonpane{
	padding: 0 0 0 0;
}
</style>
<!-- 
<script type="text/javascript" src="/assets/admin/js/jsp/item/box.js"> </script>
 -->
 
<%-- <script type="text/javascript" src="/assets/admin/js/zjsp/item/z_fast.js?${now}"></script> --%>
<script type="text/javascript">
$(document).ready(function() {
	
  	$("#jqGridTop").jqGrid({
  		//caption : '박스 관리 목록',
  		dataType : 'local', // 로딩시 최초 조회 
  		/* data: mydata,
  		datatype: "local", */
  		url : '/admin/item/fast/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 7,
  		rowList: [7,14,21],
  		//rowList: [3],
  		colNames:[
  			'번호'   ,  '처방명' , '가격'   , '탕전방식' ,'정렬순위',
  			
  			'약재'   , '노출여부' , '활성여부'  
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',			width:28,	align:"left" ,key: true , hidden:true},
  			{name:'tang_name',	index:'tang_name',		width:198,	align:"left"},
  			{name:'price'    ,	index:'price',		width:68,	align:"right"
  				,editable:false
  				,formatter: 'integer'
  	  			,formatoptions:{thousandsSeparator:","}
  	  			,editable:true
  			},
  			{name:'c_tang_type',	index:'c_tang_type',		width:98,	align:"center"
  				,edittype:"select"
  				,editoptions:{
  					 value:"1:첩약;2:무압력탕전;3:압력탕전"  						
  				}		  				
  				,formatter: 'select'
  			},
  			{name:'sort_seq',	index:'sort_seq',	width:60,	align:"center"  ,sortable : true , hidden:true 
  				,editable:false
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  			},
  			
  			{name:'yakjae'		 ,	index:'yakjae'	    ,	width:500,	align:"left", },
  			{name:'view_yn'		 ,	index:'view_yn'	    ,	width:90,	align:"center"
  				,editable:false 
  				,edittype:"select"
  				,editoptions:{
  					 value:"y:활성;n:비활성"					
  				}		  				
  				,formatter: 'select'
  			},
  			{name:'detail_view'		 ,	index:'detail_view'	    ,	width:90,	align:"center", },
  		],
		pager: "jqGridTopControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		cellEdit : true,
		editurl : '/admin/item/fast/select.do',
		cellurl : '/admin/item/fast/update_col.do',
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
		loadComplete: function(data) {
			//console.log('loadComplete = ', data);
			var rows = $("#jqGridTop").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		    	$("#jqGridTop").setCell(rows[i] , 'detail_view', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	
		    	
		    	var box_contents = $("#jqGridTop").getCell(rows[i],"box_contents");
		    	
		    	$("#jqGridTop").setCell(rows[i] , 'contents', box_contents); // 특정 cell 색상변경
		    	
		    }
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('onCellSelect = ', iCol); 
			console.log('onCellSelect = ', row);
			if(iCol == 8){
				 var data = $("#jqGridTop").jqGrid('getRowData', row);	
				 var ret = $("#jqGridTop").getRowData(row);
				 
				 console.log('ret = ', ret);
				 $.ajax({
				    url   : "/admin/item/fast/add.do",		    
				    type  : 'POST',
				    data  : ret,
			        error: function(){
				    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				    },
				    success: function(data){
				        $("#modForm").html(data);
				        $("#modForm" ).dialog( "open" );
				    }   
				});					
			} 
		},
	});
	  	
  	//페이지 넘 
  	$("#jqGridTop").jqGrid('navGrid','jqGridTopControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
  	
  	$("#modForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 900,
        width: 1800,
       // position: 'center',
        modal: true,
        title: '실속처방 추가',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#modForm').html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#modForm").dialog('close'); 
        	});
        },
        buttons: {
            "수정": function () {
            	a_goods_mod();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
  	
  	
  	$("#addForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 900,
        width: 1800,
       // position: 'center',
        modal: true,
        title: '실속처방 추가',
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
            	a_goods_add();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
  	
  	$('#addBoxBtn').click(function() {
  		$.ajax({
		    url: "/admin/item/fast/add.do",		    
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
  	
  	
  	$('#delBtn').click(function() {
  		var row = $("#jqGridTop").jqGrid('getGridParam','selarrrow');
  		console.log(row.length);
  		if( row.length > 0 ){		
  			
  			for(var i = 0 ; i <row.length ; i++){
  				var data =$("#jqGridTop").jqGrid('getRowData', row[i]);
  				if(i == 0){
  					all_seqno  = data.seqno
  				}else{
  					all_seqno += ','+data.seqno	
  				}
  			}// for
  			
  			$.ajax({
	  			url  : 'del.do',
	  			type : 'POST',
	  			data : {
	  				all_seqno : all_seqno,		  				
	  			},
	  			error : function() {
	  				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
	  			},
	  			success : function(data) {
	  				alert(data.msg);
	  				
	  				if(data.suc){
	  					$("#jqGridTop").trigger("reloadGrid");
	  				}
	  			}
	  		});
  				
  			
  		}else{
  			alert('삭제할 박스를 선택하세요.');
  		}
  	});
	  	
});


function getImgSrc(cellValue, options, rowObject){
	
	var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    
    var row_img = cellValue + "?"+ makeid();
	console.log('row_img = ', row_img);
	
	if(cellValue != '' && cellValue != null && cellValue !=  undefined){
		return "<img src='/upload/box/"+row_img+"' width='100px;' height='100px;' />";
	}else{
		return '';
	}
}

function close(){
	$(this).dialog("close");
}

function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
</script>

<div class="con_tit">아이템관리 &gt; 신속탕전</div>
<div class="conBox">
	<div class="inputArea disB">
		<a href="#" id="delBtn" class="btn03">선택삭제</a>
		<a href="#" id="addBoxBtn" class="btn02">탕전 추가</a>
	</div>
	
	<table id="jqGridTop"></table>
	<div id="jqGridTopControl"></div>
	<div id="addForm"></div>
	<div id="modForm"></div>
</div>



</html>