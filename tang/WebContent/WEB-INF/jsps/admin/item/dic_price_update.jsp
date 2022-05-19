<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>약재수정</title>	
	<script>
		
	$(document).ready(function() {
		
		var ajax_url = '/admin/item/dic/select_dic_update_item.do';
			ajax_url+= '?group_code='+$('#price_group_code').val();
			ajax_url+= '&yak_code='+$('#yak_code').val();
			
		$("#priceModGrid").jqGrid({
	  		caption : '동일 약재그룹 목록',
	  		dataType : 'local', // 로딩시 최초 조회 	  		
	  		url : ajax_url,
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 10,
	  		//rowList: [10],
	  		//rowList: [3],
	  		colNames:[
	  			'번호',
	  			'약재명','원산지', 'g단당가','상태', '상태값',
	  			'약재코드'
	  		],
	  		colModel:[
	  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true , hidden:true},
	  			{name:'yak_name',		index:'yak_name',		width:298,	align:"left"},
	  			{name:'yak_from',		index:'yak_from',		width:116,	align:"center"},  			
	  			{name:'yak_danga',		index:'yak_danga',		width:116,	align:"center"},
	  			{name:'yak_status_nm',	index:'yak_status_nm',		width:116,	align:"center"},
	  			{name:'yak_status',		index:'yak_status',		width:116,	align:"center" , hidden:true },
	  			{name:'yak_code',		index:'yak_code',		width:116,	align:"center" , hidden:true },
	  		],
			pager: "#priceModGridControl",
			viewrecords: true,
			autowidth: true,
			sortname: 'seqno',
			sortorder: "desc",
			viewrecords: true,
			loadtext  : '데이터를 불러오는중입니다.',
			emptyrecords  : '검색된 데이터가 없습니다',
			//multiselect: true,
			loadComplete: function(data) {
				var rows = $("#priceModGrid").getDataIDs();
				for (var i = 0; i < rows.length; i++){
					var yak_status = $("#priceModGrid").getCell(rows[i],"yak_status");
					if(yak_status == 'y'){
						$("#priceModGrid").setCell(rows[i] , 'yak_status_nm', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경	
					}else{
						$("#priceModGrid").setCell(rows[i] , 'yak_status_nm', "" ,  {color:'red',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
					}
					
				}// for
			},
			onCellSelect : function(row,iCol,cellcontent,e){					 
				 var record = $("#priceModGrid").jqGrid('getRowData', row);
				 if(iCol == 4){					
					 record.new_yak_code = record.yak_code;
					 record.s_code 		 = $('#price_s_code').val();
					 record.seqno 		 = $('#price_seqno').val();
					// console.log('record = ', record);
					 
					 var flag = confirm("선택된 약제로 교체하겠습니까?");
					 if(!flag){
						return;
					 }
					 
					  $.ajax({
					    url: '/admin/item/dic/dic_update_item_proc.do',
					    data : record,
					    type : 'POST',
				        error: function(){
					    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					    },
					    success: function(data){
					       if(!data.suc){
					    	   alert(data.msg);
					       }else{
					    	   $("#priceGrid").trigger("reloadGrid");
					    	   $('#price_update_form').dialog("close");
					       }
					    }   
					});	
				 }
			},
		});	
		$("#priceModGrid").jqGrid('navGrid','#priceModGridControl',
			{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
		);
	})
	
	
	</script>
</head>
<body>
	<input type="hidden" id="price_group_code" value="${price_param.group_code }" />
	<input type="hidden" id="price_yak_code"   value="${price_param.yak_code }" />
	<input type="hidden" id="price_s_code"     value="${price_param.s_code }" />
	<input type="hidden" id="price_b_code"     value="${price_param.b_code }" />
	<input type="hidden" id="price_seqno"      value="${price_param.seqno }" />
	
	<table id="priceModGrid"></table>
	<div id="priceModGridControl"></div>
	
</body>
</html>

