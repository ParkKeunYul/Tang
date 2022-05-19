<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">


<style>
	.a{
		text-decoration: underline;
	}
</style>

<script>

function getYYYYmm(){
	
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	if(mm<10) {
	    mm='0'+mm
	} 
	return yyyy+"/"+mm;
	
}

var sel_data = null;

$(document).ready(function() {
	
	$('#search_month').val( getYYYYmm() );
	
	
	
	$.datepicker.setDefaults({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'yy/mm'
	});
	$(".date").datepicker({});
	
	
	$("#memberGrid").jqGrid({  		  		 
  		url : 'select_member.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 1000,  		
  		//rowList: [3],
  		colNames:[
  			'mem_seqno', '아이디', '성명' , '한의원명' ,'search_month'
  		],
  		colModel:[
  			{name:'mem_seqno',		index:'mem_seqno',		width:48,	align:"center"  ,sortable : false ,key: true , hidden:true },
  			{name:'id',				index:'id',				width:90,	align:"left"    ,sortable : false},
  			{name:'name',			index:'name',			width:100,	align:"left"  ,sortable : false},  			
  			{name:'han_name',		index:'han_name',			width:110,	align:"left"  ,sortable : false},
  			{name:'search_month',	index:'search_month',			width:110,	align:"left"  ,sortable : false , hidden:true },
  		],
		pager: "#memberControl",
		viewrecords: true,
		autowidth: true,				
		//sortname: 'seqno',
		//sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
		//cellEdit : true,
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		loadComplete: function(data) {
			var rows = $("#memberGrid").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		    	var member_level = new Number($("#memberGrid").getCell(rows[i],"member_level"));
		    	
		    	$("#memberGrid").setCell(rows[i] , 'id', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	
		    }//
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
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('iCol= ', iCol);
			var data = $("#memberGrid").jqGrid('getRowData', row);
			console.log('data= ', data);
			
			$('#txt_search_month').html(data.han_name+" ["+data.search_month+"]");
			
			var param = { 
				 search_seqno : data.mem_seqno
				,search_month : data.search_month
			};
			
			$("#eaGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
			
			sel_data = data;
		}
	});
	
	
	$("#eaGrid").jqGrid({  		  		 
  		url : 'select_ea.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 1000,  		
  		//rowList: [3],
  		colNames:[
  			'goods_seq', 'mem_seqno', '상품명', '주문수량' , '출력수량' ,
  			'search_month'
  		],
  		colModel:[
  			{name:'goods_seq',		index:'goods_seq',		width:48,	align:"center"  ,sortable : false ,key: true , hidden:true },
  			{name:'mem_seqno',		index:'mem_seqno',		width:48,	align:"center"  ,sortable : false , hidden:true },
  			{name:'goods_name',		index:'goods_name',		width:310,	align:"left"    ,sortable : false},
  			{name:'ea',				index:'ea',				width:50,	align:"center"  ,sortable : false},  			
  			{name:'print_ea',		index:'print_ea',				width:50,	align:"center"  ,sortable : false,
  				editable:true,
  				formatter: 'integer', 
  				formatoptions:{thousandsSeparator:","}	
  			},
  			{name:'search_month',	index:'search_month',	width:110,	align:"left"  ,sortable : false , hidden:true },
  		],
		pager: "#memberControl",
		viewrecords: true,
		autowidth: true,				
		//sortname: 'seqno',
		//sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
		cellEdit : true,
		cellurl  : 'update_col.do',
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			console.log('rowid = ', rowid);
			var data = $("#eaGrid").jqGrid('getRowData', rowid);
			console.log('data = ', data);
								
			//console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			console.log('-->', {"mem_seqno":data.mem_seqno, "cellName":cellName, "cellValue": cellValue,"goods_name":data.goods_name, "search_month": data.search_month});
			return {"mem_seqno":data.mem_seqno, "cellName":cellName, "cellValue": cellValue,"goods_name":data.goods_name, "search_month": data.search_month, "goods_seq" : data.goods_seq}
		},
		loadComplete: function(data) {
			var rows = $("#memberGrid").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		    	
		    	var member_level = new Number($("#eaGrid").getCell(rows[i],"member_level"));
		    	
		    	$("#eaGrid").setCell(rows[i] , 'id', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	
		    }//
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
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('iCol= ', iCol);
			var data = $("#eaGrid").jqGrid('getRowData', row);
			console.log('data= ', data);
			
		}
	});
	
	
	$('#searchBtn').click(function() {
		search();
		return false;
	});
	
	
	$('#printBtn').click(function() {
		var rows = $("#eaGrid").getDataIDs();
		
		if(rows.length  == 0){
			alert('출력할 대상이 없습니다.');
			return false;
		}
		
		
  		var width  = 1024;
 	    var height = 900;
		var left2  = window.pageXOffset + parseInt( ( $(window).width()/2 )  - (width/2)  );
 	    var top2   = window.pageYOffset + parseInt( ( $(window).height()/2 ) - (height/2) );
  		
 	    
 	    var url = "print.do?search_seqno="+sel_data.mem_seqno+"&search_month="+sel_data.search_month;
  		window.open ( url,"print_pre","toolbar=no, location=no, directories=no,resizable=no,left="+left2+",top="+top2+", width="+width+", height="+height+",scrollbars=yes")
		
		
		return false;
	});
	
	search();
});

function search(){
	var param = {
		search_month : $('#search_month').val() 
	}
	$("#memberGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}
</script>

<script type="text/javascript">
</script>
	<div class="con_tit">아이템관리 &gt; 사전조제지시서 출력</div>
	<div class="conBox">
		
		<div>
			<div style="width:300px;float: left;">
				<div class="inputArea disB">
					검색월 : <input type="text" class="date" style="width: 80px;" id="search_month" name="search_month"  readonly="readonly" /> 									
					<a href="#" id="searchBtn" class="btn01">조회</a>
				</div>
				<table id="memberGrid"></table>
			</div>			
			<div style="width:700px;float: left;padding-left: 10px;">
				<p style="font-size: 20px;font-weight: 700;height: 35px;margin-bottom: 10px;line-height: 35px;display: inline-block;"><span id="txt_search_month" style="font-size: 20px;font-weight: 700;color: blue;"></span>월 주문현황</p>
				<a href="#" id="printBtn" class="btn01">출력</a>
				<table id="eaGrid"></table>			
			</div>
		</div>
		
		<!-- value:"1:접수대기;2:입금대기;3:조제중;4:탕전중;5:발송;6:완료;7:환불취소;8:예약발송" -->
		
		
	</div>
</html>