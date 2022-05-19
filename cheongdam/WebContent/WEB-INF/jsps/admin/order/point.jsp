<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">


<script type="text/javascript">
function update_state(th){
	
	var data = $("#jqGrid").jqGrid('getRowData', $(th).attr('rowid'));
	//console.log('data = ', data);
	$.ajax({
		url : 'update_notice.do',
	    data : {
	    	  notice_yn : $(th).context.value
	    	 ,seq       : data.seq 
	    },        
        error: function(){
	    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
	    },
	    success: function(data){
	    	alert(data.msg);
	    }   
	});
}


$(document).ready(function() {
	
  	$("#jqGrid").jqGrid({
  	//	caption : '개인공지팝업',
  		dataType : 'local', // 로딩시 최초 조회 
  		/* data: mydata,
  		datatype: "local", */
  		url : 'select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 15,
  		rowList: [20, 50 , 100, 500],
  		//rowList: [3],
  		colNames:[
  			'번호'     , '이름'    , '아이디'  , '상품명'   ,'결제금액'  ,
  			
  			'수량'   ,  '충전포인트' , '결제카드' ,'승인번호', '결제일',
  			
  			
  			'취소 관리자' , '취소일' , '상세', 'mem_seqno'
  				  			
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',		width:28,	align:"center" ,key: true  ,sortable : false  },
  			{name:'name',		index:'name',		width:88,	align:"left" ,sortable : false},
  			{name:'id',			index:'id',			width:88,	align:"left" ,sortable : false},
  			{name:'amount_title',		index:'amount_title',		width:200,	align:"left" ,sortable : false},
  			{name:'price',		index:'price',		width:100,	align:"right" ,sortable : false ,
  				formatter: 'integer', 
  				formatoptions:{thousandsSeparator:","}	
  			},
  			
  			
  			{name:'ea',			index:'ea',		  width:70,	align:"center" ,sortable : false,
  				formatter: 'integer', 
  				formatoptions:{thousandsSeparator:","}	
  			},
  			{name:'tot_point',	index:'tot_point',		width:100,	align:"right" ,sortable : false ,
  				formatter: 'integer', 
  				formatoptions:{thousandsSeparator:","}	
  			},
  			{name:'card_nm',	index:'card_nm',		width:100,	align:"center" ,sortable : false },
  			{name:'card_su_no',	index:'card_su_no',		width:100,	align:"center" ,sortable : false },  			
  			{name:'order_date2',	index:'order_date2',		width:150,	align:"center" ,sortable : false },
  			
  			{name:'card_cancel_id',	index:'card_cancel_id',		width:100,	align:"center" ,sortable : false },
  			{name:'card_cancel_date2',	index:'card_cancel_date2',		width:150,	align:"center" ,sortable : false },
  			{name:'cancel_btn',	index:'cancel_btn',		width:150,	align:"center" ,sortable : false },
  			{name:'mem_seqno',	index:'mem_seqno',		width:150,	align:"center" ,sortable : false, hidden:true },
  		
  		],
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seq',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: false,
		cellEdit : true,
		//cellsubmit : 'clientArray',
		//editurl : 'select.do',
		cellurl : 'update_col.do',
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
		    //console.log('p =  ',$(e.target).is("input[type=checkbox]"));

		    if ($(e.target).is("input[type=checkbox]") && $td.length > 0) {
		       iCol = $.jgrid.getCellIndex($td[0]);
		       cm = p.colModel[iCol];
		       if (cm != null && cm.name === "cb") {
		           // multiselect checkpouch is clicked
		           $self.jqGrid("setSelection", $tr.attr("id"), true ,e);
		       }
		    }
		    return false;
		},
		footerrow: true,
		loadComplete: function(data) {
			//console.log('loadComplete = ', data);
			var rows = $("#jqGrid").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		    	
		    	var amount_title   = $("#jqGrid").getCell(rows[i],"amount_title");
		    
		    	$("#jqGrid").setCell(rows[i] , 'cancel_btn', "[결제정보]" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    }
		    
		    
		    var moneySum = $("#jqGrid").jqGrid('getCol','price', false, 'sum');
		    var all_tot_point = $("#jqGrid").jqGrid('getCol','tot_point', false, 'sum');
		    var orderCnt = $("#jqGrid").getGridParam("reccount");
		    
		    $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',price:moneySum});
		    $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',tot_point:all_tot_point});
            $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',amount_title:'총 : '+orderCnt+'건'});
		    
		},
		 onCellSelect : function(row,iCol,cellcontent,e){
			console.log('onCellSelect = ', iCol);
			var data = $("#jqGrid").jqGrid('getRowData', row);	
			var ret = $("#jqGrid").getRowData(row);
			
			console.log('ret= ', ret);
			ret.order_seqno = ret.seqno;
			  if(iCol == 12){
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
	  	
  	//페이지 넘 
  	$("#jqGrid").jqGrid('navGrid','#jqGridControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
  	
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
           	$('#payinfoForm').html("");
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
  	
  	$('#addBtn').click(function() {  		
  		$.ajax({
		    url: "add.do",		    
		    type : 'POST',
	        error: function(){
		    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		    },
		    success: function(data){
		    	//console.log('data =', data);
		        $("#addForm").html(data);
		        $("#addForm" ).dialog( "open" );
		    }   
		});	
		//$("#group_addForm" ).dialog( "open" );
	});
  	
  	$('#search_btn').click(function() {
  		search();
		return false;
	});
  	
  	$("#search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			search();
		}
	});
	  	
});
function search(){
	var search_value = $('#search_value').val();
	var search_title = $('#search_title').val();
		
	var param = { 
		 search_value : search_value
		,search_title : search_title
	};
	
	$("#jqGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}



function close(){
	$(this).dialog("close");
}
</script>
<div class="con_tit">주문관리 &gt; 포인트</div>

<div class="conBox">
	<div id="addForm"></div>
	<div id="modForm"></div>
	
	<div class="inputArea disB">
		
		<select name="search_title" id="search_title">
			<option value="id">아이디</option>
			<option value="name">이름</option>
			<option value="title">상품명</option>
		</select>
		<input type="text" id="search_value" value="">
		<a href="#" id="search_btn" class="btn01">검색</a>
			
	</div>
	
	<table id="jqGrid"></table>
	<div id="jqGridControl"></div>
	
	<div id="payinfoForm"></div>
</div>


</html>
