<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<script type="text/javascript">
	
	$(document).ready(function() {
		
	  	$("#jqGrid").jqGrid({
	  		//caption : '회원 등급 정보',
	  		//dataType : 'local', // 로딩시 최초 조회 		  		
	  		datatype: "local", 
	  		url : '/admin/base/memGrade/select.do',
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 100,
	  		//rowList: [20,50,100,500],
	  		//rowList: [3],
	  		colNames:[
	  			'번호' , '등급명' , '탕전할인률(%)', '약속할인률(%)', '마일리지(%)', '첩약가격',
	  			'탕전비','주수상반',  '증류탕전' ,'등록일'
	  		],
	  		colModel:[
	  			{name:'sort_seq',		index:'sort_seq',	width:48,	align:"center"  ,sortable : false ,key: true },
	  			{name:'member_nm',	index:'member_nm',	width:120,	align:"center"  ,sortable : false ,editable:false},
	  			{name:'per',		index:'per',		width:120,	align:"center"  ,sortable : false 
	  				,editable:true
	  				,editoptions: {
	  					dataEvents: [{
		  					type: 'keydown', 
		  		            fn: function(e) { 
		  		                var key = e.charCode || e.keyCode;
		  		             	var tot = $("#jqGrid").getGridParam("records");
		  		             		   
		  		                if (key == 9){
		  		                	setTimeout(function () {			  	
		  		                		if(selIRow+1 > tot){
		  		                			$('#jqGrid').editCell(1,  2 , true);
		  		                		}else{
		  		                			$('#jqGrid').editCell(selIRow+1,  2 , true);	
		  		                		}
		  		                  	},0);
		  		                }
		  		            }
		  				}]
	  				} 
	  				,formatter: 'integer'
	  	  			,formatoptions:{thousandsSeparator:","}
	  				, hidden:true
	  			},
	  			{name:'yak_per',		index:'yak_per',		width:120,	align:"center"  ,sortable : false , hidden:true
	  				,editable:true
	  				,editoptions: {
	  					dataEvents: [{
		  					type: 'keydown', 
		  		            fn: function(e) { 
		  		                var key = e.charCode || e.keyCode;
		  		             	var tot = $("#jqGrid").getGridParam("records");
		  		             		   
		  		                if (key == 9){
		  		                	setTimeout(function () {			  	
		  		                		if(selIRow+1 > tot){
		  		                			$('#jqGrid').editCell(1,  3 , true);
		  		                		}else{
		  		                			$('#jqGrid').editCell(selIRow+1,  3 , true);	
		  		                		}
		  		                  	},0);
		  		                }
		  		            }
		  				}]
	  				} 
	  				,formatter: 'integer'
	  	  			,formatoptions:{thousandsSeparator:","}
	  				
	  			},
	  			
	  			
	  			{name:'mile_per',	index:'mile_per',		width:120,	align:"right"  ,sortable : false  , hidden:true
	  				,editable:true
	  				,formatter: 'integer'
	  	  			,formatoptions:{thousandsSeparator:","}
	  			},
	  			{name:'yak_price',	index:'yak_price',		width:120,	align:"right"  ,sortable : false , hidden:true 
	  				,editable:true
	  				,formatter: 'integer'
	  	  			,formatoptions:{thousandsSeparator:","}
	  			},
	  			
	  			
	  			{name:'tang_price',	index:'tang_price',		width:120,	align:"right"  ,sortable : false , hidden:true
	  				,editable:true
	  				,formatter: 'integer'
	  	  			,formatoptions:{thousandsSeparator:","}
	  			},
	  			{name:'jusu_price',	index:'jusu_price',		width:120,	align:"right"  ,sortable : false , hidden:true
	  				,editable:true
	  				,formatter: 'integer'
	  	  			,formatoptions:{thousandsSeparator:","}
	  			},
	  			{name:'jeung_price',index:'jeung_price',		width:120,	align:"right"  ,sortable : false , hidden:true 
	  				,editable:true
	  				,formatter: 'integer'
	  	  			,formatoptions:{thousandsSeparator:","}
	  			},
	  			
	  			
	  			{name:'wdate2',		index:'wdate2',		width:200,	align:"center"  ,sortable : false}
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
			editurl : '/admin/base/memGrade/select.do',
			cellurl : '/admin/base/memGrade/update_col.do',
			beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
				console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
				return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
			},
			beforeEditCell : function(rowid, cellname, value, iRow, iCol){
			    selICol = iCol;
			    selIRow = iRow;
			},
			loadComplete: function(data) {
			},
		});
	  	
	  	//페이지 넘 
	  	/* jQuery("#jqGrid").jqGrid('navGrid','#jqGridControl',
	  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	  	); */
	  	
	  	
	  	$('.tipClick > a.name_tab').click(function(){
	  		$('.tooltipB').hide(); // 모든 알림창 닫기
	  		console.log($(this).next().show());
	  	});
		  	
	});
	
</script>
	
	
	<div class="con_tit">기본관리 &gt; 회원등급별 설정</div>
	
	<div class="conBox">
		<table id="jqGrid"></table>
	<!-- <div id="jqGridControl"></div> -->
	</div>
	

</html>