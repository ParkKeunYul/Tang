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
  			'번호'     , '이름'    , '아이디'  , '제목'      , '결제금액'  ,
  			'활성화여부' , '결제여부' , '등록일'  , '기능'  	, 'admin_confirm'		  			
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',		width:28,	align:"center" ,key: true  ,sortable : false  },
  			{name:'name',		index:'name',		width:88,	align:"left" ,sortable : false},
  			{name:'id',			index:'id',			width:88,	align:"left" ,sortable : false},
  			{name:'title',		index:'title',		width:358,	align:"left" ,sortable : false},
  			{name:'price',		index:'price',		width:100,	align:"right" ,sortable : false ,
  				formatter: 'integer', 
  				formatoptions:{thousandsSeparator:","}, 
  			},
  			
  			{name:'view_yn',	index:'view_yn',		width:120,	align:"center" ,sortable : false
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					 value:"y:활성;n:비활성"						
                }
  				,formatter: 'select'
  			},
  			{name:'pay_yn',	index:'pay_yn',		width:120,	align:"center" ,sortable : false
  				,editoptions:{
  					 value:"y:결제완료;n:결제전"						
                }
  				,formatter: 'select'
  			},
  			{name:'upt_date2',		index:'upt_date2',			width:150,	align:"center"  ,sortable : false},  			
  			{name:'edit',			index:'edit',			width:150,	align:"center"  ,sortable : false},
  			{name:'admin_confirm',	index:'admin_confirm',			width:150,	align:"center"  ,sortable : false, hidden:true}
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
		loadComplete: function(data) {
			//console.log('loadComplete = ', data);
			var rows = $("#jqGrid").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		    	
		    	
		    	
		    	var pay_yn = $("#jqGrid").getCell(rows[i],"pay_yn");
		    	if(pay_yn == 'n'){
		    		$("#jqGrid").setCell(rows[i] , 'edit', "[ 삭제 ]" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	}
		    	
		    	var title         = $("#jqGrid").getCell(rows[i],"title");
		    	var admin_confirm = $("#jqGrid").getCell(rows[i],"admin_confirm");
		    	var pay_yn        = $("#jqGrid").getCell(rows[i],"pay_yn");
		    	
		    	if(admin_confirm == 'n' && pay_yn == 'y'){
		    		title = '<span style="color:red;font-weight:700;">( new ) </span>'+ title
		    	}
		    	$("#jqGrid").setCell(rows[i] , 'title', title ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    }
		},
		 onCellSelect : function(row,iCol,cellcontent,e){
			console.log('onCellSelect = ', iCol);
			var data = $("#jqGrid").jqGrid('getRowData', row);
			  if(iCol == 3){
				 					
				 var ret = $("#jqGrid").getRowData(row);
				 $.ajax({
				    url   : "add.do",		    
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
			else if(iCol == 8 && data.pay_yn == 'n'){
				if(!confirm('삭제하겠습니까?') ) return;
				
				$.ajax({
				    url   : "del.do",		    
				    type  : 'POST',
				    data  : data,
			        error: function(){
				    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				    },
				    success: function(data){
				    	alert(data.msg);
				    	if(data.suc){
				    		$("#jqGrid").trigger("reloadGrid");
				    	}
				    }   
				});	
				
			}
		},
	});
	  	
  	//페이지 넘 
  	$("#jqGrid").jqGrid('navGrid','#jqGridControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
  	
  	$("#modForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 850,
        width: 1200,
       // position: 'center',
        modal: true,
        title: '개인공지 수정',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#modForm').html("");
           	$("#jqGrid").trigger("reloadGrid");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#modForm").dialog('close'); 
        	});
        },
        buttons: {
            "수정": function () {
            	a_popup_mod();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
  	
  	$("#addForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 800,
        width: 1200,
       // position: 'center',
        modal: true,
        title: '개인공지 작성',
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
            "작성": function () {
            	a_popup_add();
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
	var search_view  = $('#search_view').val();
	var search_pay   = $('#search_pay').val();
		
	var param = { 
		 search_value : search_value
		,search_title : search_title
		,search_view  : search_view
		,search_pay   : search_pay
	};
	
	$("#jqGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}



function close(){
	$(this).dialog("close");
}
</script>
<div class="con_tit">주문관리 &gt; 개인결제 관리</div>

<div class="conBox">
	<div id="addForm"></div>
	<div id="modForm"></div>
	
	<div class="inputArea disB">
		활성화여부 : 
		<select name="search_view" id="search_view">
			<option value="">전체</option>
			<option value="n">비활성</option>
			<option value="y">활성화</option>		
		</select>
	
		결제여부 : 
		<select name="search_pay" id="search_pay">
			<option value="">전체</option>
			<option value="n">결제전</option>
			<option value="y">결제완료</option>		
		</select>
		
		<select name="search_title" id="search_title">
			<option value="id">아이디</option>
			<option value="name">이름</option>
			<option value="han_name">한의원명</option>		
			<option value="title">제목</option>
		</select>
		<input type="text" id="search_value" value="">
		<a href="#" id="search_btn" class="btn01">검색</a>
	
		<a href="#" id="addBtn" class="btn02">새로등록</a>
	</div>
	
	<table id="jqGrid"></table>
	<div id="jqGridControl"></div>
</div>


</html>