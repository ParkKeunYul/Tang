<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<script type="text/javascript" src="/assets/common/smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<style>
	.tbv th, .tbv td{
		border-right: 1px solid #c9c9c9;
		
	}
	
	 .orderlist02 {width:100%; font-size:14px;}
	 .orderlist02 thead tr th {background:#e8e8e8; border-bottom:1px solid #dddddd; padding:10px 0 10px 0; font-weight:700; text-align:center;}
	 .orderlist02 tbody tr td {padding:5px 0 6px 0; border-bottom:1px solid #dddddd; line-height:32px; text-align:center;}
	 .orderlist02 .L {text-align:left; padding-left:10px;}
	 .orderlist02 tbody tr td:nth-child(6), .LArea .orderlist02 tbody tr td:nth-child(7) {text-align:right; padding-right:15px;}
	 .orderlist02 tbody tr:nth-child(even) {background:#f9f9f9;}
	 .orderlist02 tfoot tr td {background:#444444; color:#ffffff; text-align:right; padding:0px 20px 0px 20px; font-size:16px;}
	 .orderlist02 tfoot tr td:first-child {text-align:left;}	
	 .orderlist02 [type="text"] {height:25px !important; background:#f5f5f5 !important; text-align:right; padding-right:5px !important;}
	 .h30 {height:30px; line-height:30px; display:inline-block; font-size:12px; font-weight:700; padding:0 15px; margin-right:5px;}
	 .h34 {height:34px; line-height:34px; display:inline-block; font-size:14px; padding:0 13px; }
	 .cBB {border:1px solid #444444; background:#ffffff;}
	 .cBB:hover {background:#fbfbfb;}
	 .cB {background:#444444; color:#ffffff;}
	 .cB:hover {background:#000000;}
	 .cbg {background:#4f7561; color:#ffffff;}
	 .cbg:hover {background:#518469;}
	 
	 
	 .order_option {height:450px; position:relative;}
	 .order_option [type="text"] {height:30px !important; margin:0 !important; vertical-align: top;}
	 .order_option .searchA {width:100%; display:inline-block; padding:0 0 0 10px;}
	 .order_option .searchA select {height:34px; padding:2px 0 0 3px; font-size:13px; vertical-align: top;}
	 .order_option .searchA a span {margin-left:-4px;}
	 
	 .search_han1 {display:inline-block; float:right; border-top:1px solid #dddddd; border-right:1px solid #dddddd; font-size:14px;}
	.search_han1 li {float:left;}
	.search_han1 li a {width:35px; line-height:35px; display:inline-block; background:#ffffff; border-bottom:1px solid #dddddd; border-left:1px solid #dddddd; text-align:center;}
	.search_han1 li:first-child a {width:50px; }
	.search_han1 .sel {background:#26995d; color:#ffffff; border:none;}
	
	.search_han2 {display:inline-block; border-top:1px solid #dddddd; border-right:1px solid #dddddd; font-size:13px; margin:10px 0 0 0 ;}
	.search_han2 li {float:left;}
	.search_han2 li a {width:28px; line-height:30px; display:inline-block; background:#ffffff; border-bottom:1px solid #dddddd; border-left:1px solid #dddddd; text-align:center;}
	.search_han2 li:first-child a {width:55px; }
	.search_han2 .sel {background:#26995d; color:#ffffff; border:none;}
	
	#jqGrid input[name=my_joje]{
		height: 16px;
		text-align: right;
		font-size: 15px;
		background:#f5f5f5 !important;
		width: 45px !important;
	}
	
	.basic01 tbody tr td{
		padding: 5px 0;
	}
	.basic01 .tdL{
		padding: 5px 15px;
	}
	
	.basic01 [type="text"], .basic01 select{
		height: 25px;
	}
</style>
<script>
var patient_row = -1;
var lastRowId   = -1;

function a_goods_add(){
	var ajax_url = "add_proc.do";
	a_goods_proc(ajax_url);
}

function a_goods_mod(){
	var ajax_url = "mod_proc.do";
	a_goods_proc(ajax_url);
}

function a_goods_proc(ajax_url){
	
	

	if(! valCheck('tang_name','처방명을 입력해 주세요.')){
		return;
	} 

	if(! valCheck('price','판매가격을 입력해 주세요.')){
		return;
	}
	
	if(isNaN($('#price').val())) {
		alert('처방비용은 숫자만 입력 가능합니다.');
		return
	}

	
	/* 
	if(! valCheck('c_pack_ml','팩 용량을 선택하세요.')){
		return;
	}

	if(! valCheck('c_pack_ea','팩수를 선택하세요')){
		return;
	}
	 */
	 
	if(! valCheck('c_box_ea','포장박스 수량을 입력하세요.')){
		return;
	}
	
	var rows = $("#jqGrid").getDataIDs();
	console.log(rows.length );
	for(var i = 0; i <= rows.length ; i++){
		$('#jqGrid').editCell(i,  5 , false);
	}
	
	
	for (var i = 0; i < rows.length; i++){
		var record = $('#jqGrid').jqGrid('getRowData', rows[i]);
		
		if( record.yak_status != 'y' ){
			alert('주문이 불가능한 약재가 포함되어 있습니다.');
			$('#jqGrid').editCell((i+1),  5 , true);
			return false;
		}
		
		if( objToStr(record.my_joje, 0)  == 0 ){
			alert('조재량은 0g 이상이여야 합니다.');
			$('#jqGrid').editCell((i+1),  5 , true);
			return false;
		}
	}//		
	
	var jsonNewData = [];
	for (var i = 0; i < rows.length; i++){
		var record = $('#jqGrid').jqGrid('getRowData', rows[i]);
		jsonNewData.push(JSON.stringify(record));
	}//
	$('#json_option').val(jsonNewData);
	
	
	
	$("#a_goods_frm").attr("action", ajax_url);
		
	var content = oEditors.getById["p_contents"].getIR();
	$('#p_contents').val(content);
	
	
	$('#a_goods_frm').ajaxForm({		        
		url : ajax_url,
        enctype : "multipart/form-data",
        beforeSerialize: function(){
             // form을 직렬화하기전 엘레먼트의 속성을 수정할 수도 있다.            
        },
        beforeSubmit : function() {
        	//action에 걸어주었던 링크로 가기전에 실행 ex)로딩중 표시를 넣을수도 있다.
        },

        success : function(data) {		             
            //console.log("data =  ", data);
            alert(data.msg);
             if(data.suc){
            	if(ajax_url == 'add_proc.do'){
            		$("#jqGridTop").trigger("reloadGrid",[{page : 1}]);
            		$("#addForm").dialog('close');
            	}else{
            		$("#jqGridTop").trigger("reloadGrid");
            		//$("#modForm").dialog('close');
            	}
            }
        }		        
    });	
	$("#a_goods_frm").submit();
}

var oEditors = [];
$(document).ready(function() {
	$("#jqGrid").jqGrid({
  		url : 'detail_yakjae.do?seqno='+ $('#seqno').val(),
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: 363,
  		rowNum: 100,					  		
  		colNames:[
  			'번호 ','약재명', '상태', '원산지', '조재량', 
  			'g당단가', '<div style="padding-left:15px;">가격</div>' ,'group_cnt' ,'group_code',
  			'yak_code'
  		],
  		colModel:[
  			{name:'seqno'       ,index:'seqno'      ,width:180,	align:"left" 	,sortable : false ,editable:false ,key: true ,hidden:true },
  			{name:'yak_name'    ,index:'yak_name'   ,width:190,	align:"left" 	,sortable : false ,editable:false  },
  			{name:'yak_status'  ,index:'yak_status' ,width:70,	align:"center" 	,sortable : false ,editable:false
  				,edittype:"select"
  				,formatter: 'select'
					,editoptions:{
						value:"y:가능;n:불가;c:불가"
					}
  			},
  			{name:'yak_from'    ,index:'yak_from'   ,width:123,	align:"center" 	,sortable : false ,editable:false},
  			{name:'my_joje' 	,index:'my_joje'    ,width:90,	align:"right" 	,sortable : false 
  				,editable:true
  				,editoptions: {
  					 maxlength: 4
  					,dataEvents: [{
	  					type: 'keydown', 
	  		            fn: function(e) {
	  		            	try{init_yakjae_flag = false;}catch (e) {}
	  		                var key = e.charCode || e.keyCode;
	  		             	var tot = $("#jqGrid").getGridParam("records");
	  		                if (key == 9){					  		                	
	  		                	setTimeout(function () {			  	
	  		                		if(selIRow+1 > tot){
	  		                			$('#jqGrid').editCell(1,  5 , true);
										console.log('selIRow = ', selIRow);
										return false;
	  		                		}else{
	  		                			$('#jqGrid').editCell(selIRow+1,  5 , true);	
										console.log('selIRow = ', selIRow);
										return false;
	  		                		}	  		                		
	  		                  	},50);	
								return false;
	  		                }
	  		            }
  					},{
  						type: 'focus',
  						fn: function(e) {
  							$('input[name='+e.target.name+']').select();
  							return false;
  						}
	  				}]
  				  ,dataInit: function(element) {
	  	               $(element).keyup(function(){
		  	               var val1 = element.value;
		  	               
		  	               try{init_yakjae_flag = false;}catch (e) {}
		  	               
		  	               var num = new Number(val1);
		  	               if(isNaN(num)){		
		  	               	 element.value  = $(this).val().replace(/[^0-9]/g,"");
		  	               }
		  	               
		  	               if(lastRowId != -1){
						    	var record = $('#jqGrid').jqGrid('getRowData', lastRowId);
								var my_joje   = parseFloat( objToStr(element.value, 0));
						    	var yak_danga = parseFloat(record.yak_danga );
						    	var danga     = Math.ceil(my_joje * yak_danga);
								
						    	$("#jqGrid").setCell(lastRowId , 'danga', comma(danga+'')+'원' , {padding: '0 0 0 0'});
								
								var rows = $("#jqGrid").getDataIDs();
								
								var tot_danga = 0;
								var tot_joje  = 0;
							    for (var i = 0; i < rows.length; i++){
							    	
							    	if(i == (selIRow -1) ){
							    		tot_danga = Math.ceil(tot_danga + danga);
							    		tot_joje  = tot_joje + my_joje;
							    	}else{
							    		var r_my_joje   = parseFloat($("#jqGrid").getCell(rows[i],"my_joje") );
							    			r_my_joje   = parseFloat( r_my_joje );
								    	var r_yak_danga = parseFloat($("#jqGrid").getCell(rows[i],"yak_danga") );
								    	
								    	var r_danga = Math.ceil(r_my_joje * r_yak_danga);
								    	
								    	tot_danga = tot_danga + r_danga;
								    	tot_joje  = tot_joje  + r_my_joje;
								    	
								    	tot_joje  = Math.floor(tot_joje * 100)/100;
								    	
							    	}
							    }
							    
							    var c_chup_ea = parseInt( $('#c_chup_ea').val() );
							    
							    $('#c_chup_g').val((tot_joje * c_chup_ea).toFixed(2));
							    $('#tot_yakjae_joje_txt').text(comma(tot_joje+''));												    
						    	$('#tot_yakjae_danga_txt').text(comma(tot_danga+''));
						    	
						    	yakjae_change_apply(tot_danga);
						    }
  	                
  	                });
  	                
  				  }
  				 }
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  			},
  			
  			{name:'yak_danga'	,index:'yak_danga'	,width:90,	align:"right" 	,sortable : false ,editable:false
  				,formatter: 'integer'
	  	  		,formatoptions:{thousandsSeparator:","}
  			},
  			{name:'danga'		,index:'danga' 			,width:100,	align:"right" 	,sortable : false ,editable:false},
  			{name:'group_cnt'	,index:'group_cnt' 		,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  			{name:'group_code'	,index:'group_code' 	,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  			{name:'yak_code'	,index:'group_code' 	,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  		],
  		formatter : {
             integer : {thousandsSeparator: ",", defaultValue: '0'}
        },
		//pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,				
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		cellEdit :true,
		cellsubmit : 'clientArray',
		beforeSubmitCell : function(rowid, cellName, cellValue) { 
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		beforeEditCell : function(rowid, cellname, value, iRow, iCol){
			selICol   = iCol;
		    selIRow   = iRow;
		    lastRowId = rowid;
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
		           $self.jqGrid("setSelection", $tr.attr("id"), true ,e);
		       }
		    }
		    return false;
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			
		},
		loadComplete: function(data) {
			setTimeout(function(){
				  tot_info();
				 $('#jqGrid').editCell(1,  5 , true);  		                		
			},50);
		},
		onCellSelect : function(row,iCol,cellcontent,e){					 
			 var record = $("#jqGrid").jqGrid('getRowData', row);
			 console.log(iCol);
			 
			 if(iCol == 7){
				 /* 
				 if(record.sql == 'add'){
					 $("#jqGrid").jqGrid("delRowData", record.seqno);
					 return;
				 }
				 
				  $.ajax({
				    url: "del_option.do",
				    data : record,
				    type : 'POST',
			        error: function(){
				    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				    },
				    success: function(data){
				    	alert(data.msg)
				    	if(data.suc){
				    		$("#jqGrid").trigger("reloadGrid");
				    	}
				    }   
				}); */
			 }
			 
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
		           $self.jqGrid("setSelection", $tr.attr("id"), true ,e);
		       }
		    }
		    return false;
		},
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			return {"order_no":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		afterSaveCell: function(rowid,celname,value,iRow,iCol) {}, 				
	    cellEdit : true,
	    cellsubmit : 'clientArray',
		//cellurl : 'update_col.do',
	});
	
	
	$("#yakjaeGrid").jqGrid({
		url : 'select_yakjae.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: 300,
  		rowNum: 13,
  		colNames:[
  			'번호','약재명', '상태' ,'원산지', '단가',
  			'선택',
  			
  			'약재코드', '기본값', '위치',  '약재설명', '그룹코드', 
  			'그룹명' , 'yak_danga' ,'group_cnt'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true , hidden:true},
  			{name:'yak_name',		index:'yak_name',		width:138,	align:"left"},
  			{name:'yak_status'     ,index:'yak_status' 		,width:60,	align:"center" 	,sortable : false ,editable:false
  				,edittype:"select"
  				,formatter: 'select'
					,editoptions:{
						value:"y:가능;n:불가;c:불가"
					}
  			},
  			{name:'yak_from',		index:'yak_from',		width:95,	align:"center"},
  			{name:'yak_danga_won',	index:'yak_danga_won',	width:80,	align:"right"},
  			{name:'sel_img',		index:'sel_img',		width:60,	align:"center"},
  			
  			
  			{name:'yak_code',		index:'yak_code',		width:208,	align:"center"  , hidden:true},
  			{name:'yak_made',		index:'yak_made',		width:70,	align:"center" , hidden:true},
  			{name:'yak_place',		index:'yak_place',		width:80,	align:"center" , hidden:true},
  			{name:'yak_contents',	index:'yak_contents',	width:416,	align:"left" , hidden:true},
  			{name:'group_code',	index:'group_code',	width:416,	align:"left" , hidden:true},
  			{name:'group_name',	index:'group_name',	width:416,	align:"left" , hidden:true},
  			{name:'yak_danga',		index:'yak_danga',		width:80,	align:"right",formatter: 'integer',formatoptions:{thousandsSeparator:","} , hidden:true},
  			{name:'group_cnt',		index:'group_cnt',		width:80,	align:"right",formatter: 'integer',formatoptions:{thousandsSeparator:","} , hidden:true},
  		],
		pager: "#yakjaeGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
		loadComplete: function(data) {
			
			var mem_sub_grade    = objToStr( $('#mem_sub_grade').val(), '');
			
			var rows = $("#yakjaeGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#yakjaeGrid").setCell(rows[i] , 'yak_name', "" ,  {padding: '0 0 0 0'}); 
				
				
				var yak_status = $("#yakjaeGrid").getCell(rows[i],"yak_status");
		    	if(yak_status != 'y'){
		    		$("#yakjaeGrid").setCell(rows[i] , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); 
		    	}
		    	
		    	var yak_danga_won = $("#yakjaeGrid").getCell(rows[i],"yak_danga");
		    	
		    	$("#yakjaeGrid").setCell(rows[i] , 'yak_danga_won', yak_danga_won+'원' , {padding: '0 0 0 0'});
		    	
		    	
		    		
	    		var seqno      = $("#yakjaeGrid").getCell(rows[i],"seqno");
	    		var yak_name   = $("#yakjaeGrid").getCell(rows[i],"yak_name");
	    		var yak_from   = $("#yakjaeGrid").getCell(rows[i],"yak_from");
	    		var yak_danga  = $("#yakjaeGrid").getCell(rows[i],"yak_danga");
	    		var group_code = $("#yakjaeGrid").getCell(rows[i],"group_code");
	    		var group_cnt  = $("#yakjaeGrid").getCell(rows[i],"group_cnt");
	    		var yak_code   = $("#yakjaeGrid").getCell(rows[i],"yak_code");
	    		var yak_status   = $("#yakjaeGrid").getCell(rows[i],"yak_status");
	    		
	    		
	    		var info = seqno+"||"+yak_name+"||"+yak_from+"||"+yak_danga+"||"+group_code+"||"+group_cnt+"||"+yak_code+"||"+yak_status;
	    		
	    		var sel_img = '<a href="#" attr="'+info+'"  class="addYakjaeBtn"><img src="/assets/user/pc/images/sub/btn_list.png" alt="선택" class="vm" /></a>'; 
	    		$("#yakjaeGrid").setCell(rows[i] , 'sel_img', sel_img , null);
	    		
	    		
	    		if(mem_sub_grade == 2){
	    			$("#yakjaeGrid").setCell(rows[i] , 'yak_danga_won', '***,***' , null);
				}
	    		
			}
			
			setTimeout(function(){
	    		$('.addYakjaeBtn').bind('click',function(){
	    			try{init_yakjae_flag = false;}catch (e) {}
	    			
	    			var info = $(this).attr('attr').split('||');
	    			
	    			console.log('info = ', info);
	    			
	    			var cnt = $("#jqGrid").getDataIDs();
	    			var jqRow    = 0;
	    			for (var i = 0; i < cnt.length; i++){
	    				console.log('cnt[i] = ', cnt[i] + " : ");
	    				console.log('jqGrid = ', $("#jqGrid").getRowData(cnt[i]).group_code );
	    				//$("#jqGrid").getCell(cnt[i],"group_code")
	    				//if(info[0] == cnt[i] || info[4] == $("#jqGrid").getRowData(cnt[i]).group_code ){
	    				if(info[0] == cnt[i]){
	    					setTimeout(function () {			  	
	    	    				$('#jqGrid').editCell(i+1,  5 , true);  		                		
	                      	},50);
		    				return false;	
	    				}
	    				jqRow ++;
	    			}
	    			jqRow ++;
	    			
	    			var addData = {
	    				 seqno      : info[0]
	    				,yak_name   : info[1]
	    				,yak_from   : info[2]
	    				,yak_danga  : info[3]
	    				,group_code : info[4]
	    				,group_cnt  : info[5]
	    				,yak_code   : info[6]
	    			    ,yak_status : info[7]
	    				,my_joje    : 0
	    				,danga      : 0+'원'
	    			};
	    			//console.log('addData = ', addData);
					$("#jqGrid").jqGrid("addRowData", addData.seqno, addData); 
	    			
    		
    				/* 
	    			$("#jqGrid").setCell(addData.seqno , 'yak_name', '' , {padding: '0 0 0 10px'});
	    			$("#jqGrid").setCell(addData.seqno , 'my_joje', '' , {padding: '0 25px 0 0'});
	    			$("#jqGrid").setCell(addData.seqno , 'yak_danga', '' , {padding: '0 15px 0 0'});
	    			$("#jqGrid").setCell(addData.seqno , 'danga', '' , {padding: '0 15px 0 0'});
	    			 */
	    			
	    			if(info[7] != 'y'){
	    				$("#jqGrid").setCell(addData.seqno  , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); // 특정 cell 색상변경
	    			}
	    			
	    			var jqCnt = $("#jqGrid").getDataIDs();
	    			setTimeout(function () {			  	
	    				$('#jqGrid').editCell(jqCnt.length,  5 , true);  		                		
                  	},10);	
	    			
		    		return false;
				});
    		},100);
		},
	});
  	
  	$('#goodsBtnOption').click(function(){
  		var rows = $("#jqGrid").getDataIDs(); 
  		
  		var seqno = $("#jqGrid").getCell(rows[rows.length-1],"seqno");
  		
  		if(seqno == undefined || seqno == '' || seqno == null){
  			seqno = 0;
  		}
  		
  		
  		var addData = {
  			 seqno       : parseInt(seqno) + 1
  			,box_price   : 0
  			,use_yn      : 'y'
  			,sort_seq    : rows.length+1
  			,sql         : 'add'
  			,goods_seqno : $('#p_seq').val()
  			,edit        : "<span style='color:red;cursor: pointer;'>[ 삭제  ]</span>"
  		}
  		
  		console.log('addData = ', addData);
  		
  		$("#jqGrid").jqGrid("addRowData", addData.seqno, addData);	
  	});
	
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "p_contents",
		sSkinURI: "/assets/common/smart/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["contents"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	
	$("#price , #sort_seq").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	}).on("focusout", function() {
	    var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        $(this).val(x);
	    }
	}).on("focus", function() {
		var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        $(this).val(x);
	    }
	});
	
	$("#yakjaeMultiSearchBtn").click(function() {
		yakjae_multi_search_btn( $('#yakjae_multi_value') );
		return false;
	});
	
	$("#yakjae_multi_value").keydown(function(key) {
		if (key.keyCode == 13) {
			yakjae_multi_search_btn(  $('#yakjae_multi_value')  );
		}
	});
	
	$("#yakjaeSearchBtn").click(function() {
		yakjae_search_btn( $('#yakjae_search_value').val(), ''  );
		
		$('.yakjae_search_han2 li a').removeClass('sel');
		$('.yakjae_search_han2').children().first().children().addClass('sel');
		return false;
	});
	
	$(".yakjae_search_han2 li a").click(function() {
		console.log($(this).attr('attr'));
		yakjae_search_btn('', $(this).attr('attr') );
		
		$('.yakjae_search_han2 li a').removeClass('sel');
		$(this).addClass('sel');
		return false;
	});
	
	$("#delItemBtn").click(function() {
		 try{init_yakjae_flag = false;}catch (e) {}
		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
		
		if( row.length <= 0 ){
			alert('한개이상 선택하세요.');
			return false;
		}
		
		if( $("#jqGrid").getDataIDs().length == row.length ){
			$('#jqGrid').jqGrid('clearGridData');			
		}else{
			for(var i = (row.length-1); i>=0; i--) {
			      $('#jqGrid').jqGrid('delRowData', row[0]) 
			}
		}
		setTimeout(function(){
			tot_info();
		},50);
		 
		 /* 
		rows = $("#jqGrid").getDataIDs(); 		
		
		var tot_danga = 0;
		var tot_joje  = 0;
		 
	    for (var i = 0; i < rows.length; i++){						    	
	    	var seqno     = parseInt($("#jqGrid").getCell(rows[i],"seqno"));
	    	
	    	var group_cnt = parseInt($("#jqGrid").getCell(rows[i],"group_cnt"));
	    	var yak_name  = $("#jqGrid").getCell(rows[i],"yak_name");
	    	
	    	if(group_cnt > 1){
	    		var group_code = $("#jqGrid").getCell(rows[i],"group_code");
	    		yak_name = yak_name.substring(0, yak_name.indexOf(' <a'));	    		
	    	}
	    	
	    	$("#jqGrid").setCell(rows[i] , 'yak_name', yak_name , {padding: '0 0 0 10px'});
	    }
	     */
		return false;
	});
	
	
	$(".dic_search_han2 li a").click(function() {
		console.log($(this).attr('attr'));
		dic_search_btn('', $(this).attr('attr') );
		
		$('.dic_search_han2 li a').removeClass('sel');
		$(this).addClass('sel');
		return false;
	});
	
	$(".dic_btn_close li a").click(function() {
		$('.dic_search_han2 li a').removeClass('sel');
		$(this).addClass('sel');
		return false;
	});
	
	
	$("#dic_search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			dic_search_btn($('#dic_search_value').val(), '' );
			
			$('.dic_search_han2 li a').removeClass('sel');
			$('.dic_search_han2').children().first().children().addClass('sel');
		}
	});
	
	$(".dic_btn_close").click(function() {
		$('#list_popup01').hide();
		return false;
	});
	
	$("#dic_pop_detail").click(function(){
		var popupX = (window.screen.width / 2) - (1000 / 2);
		var popupY = (window.screen.height / 2) - (700 / 2);
		
		$('#list_popup01').hide();
		
		window.open($(this).attr('href'),'window팝업','width=1000, height=700, menubar=no, status=no, toolbar=no,left='+popupX);
		return false;
	});
	
	$("#dicGrid").jqGrid({
		url : 'select_dic.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: 300,
  		rowNum: 13,
  		colNames:[
  			'번호','처방명', '출전' ,'선택 ',
  			'약재코드', 's_jomun' ,'item_list'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'s_name',			index:'s_name',		width:275,	align:"left"},
  			{name:'b_name',			index:'b_name',		width:105,	align:"center"},
  			{name:'sel_img',		index:'sel_img',	width:63,	align:"center"},
  			
  			
  			{name:'s_jukeung',		index:'s_jukeung',		width:208,	align:"center"  , hidden:true},
  			{name:'s_jomun',		index:'s_jomun',		width:208,	align:"center"  , hidden:true},
  			{name:'item_list',		index:'item_list',		width:208,	align:"center"  , hidden:true},
  		],
		pager: "#dicGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
		loadComplete: function(data) {
			var rows = $("#dicGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				
				$("#dicGrid").setCell(rows[i] , 's_name', '' , {padding: '0 0 0 15px', color : '#0b6d3a', cursor:'pointer' });
				
	    		var seqno      = $("#dicGrid").getCell(rows[i],"seqno");
	    		var s_name     = $("#dicGrid").getCell(rows[i],"s_name");
	    		var info 	   = seqno+"||"+s_name;
	    		var sel_img = '<img src="/assets/user/pc/images/sub/btn_list.png" style="cursor:pointer;" alt="선택" class="vm" />'; 
	    		$("#dicGrid").setCell(rows[i] , 'sel_img', sel_img , null);
			}
			
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			var data = $("#dicGrid").jqGrid('getRowData', row);
			 try{init_yakjae_flag = false;}catch (e) {}
			 if(iCol == 1){
				 $("#dic_txt_sname").html(data.s_name);
				 $("#dic_txt_bname").html(data.b_name);
				 $("#dic_txt_jomun").html(data.item_list);
				 $('#list_popup01').show();
				 
				 
				 $('#dic_pop_detail').attr('href', '/m02/02_dictionary_popup.do?seqno='+data.seqno);
			 }else if(iCol == 3){
				 
				 $('#b_name').val(data.b_name);
				 $('#s_name').val(data.s_name);
				 
				 $.ajax({
					url : 'dic_sublist.do',
					type: 'POST',
					data : {
						seqno : row,
					},
					error : function() {
						alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					},
					success : function(list) {
						
						var jqRow    = 0;
						for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
			    			$('#jqGrid').editCell(i,  5 , false);
			    			jqRow ++;
			    		}
						
						$('#s_name').val(data.s_name);
						
						
						for(var k = 0; k < list.length ; k++){
							var duple = true;
							var cnt = $("#jqGrid").getDataIDs();
			    			for (var i = 0; i < cnt.length; i++){
			    				if(cnt[i] == list[k].seqno ){				    					
				    				duple = false;
			    				}
			    			}
							
			    			
			    			if(duple){ 
			    				jqRow ++;
			    				
			    				var addData = {
			   	    				 seqno      : list[k].seqno
			   	    				,yak_name   : list[k].yak_name
			   	    				,yak_code   : list[k].yak_code
			   	    				,yak_from   : list[k].yak_from
			   	    				,yak_danga  : list[k].yak_danga
			   	    				,group_code : list[k].group_code
			   	    				,group_cnt  : list[k].group_cnt
			   	    			    ,yak_status : list[k].yak_status
			   	    				,my_joje    : list[k].dy_standard
			   	    			};
			    				$("#jqGrid").jqGrid("addRowData", addData.seqno, addData);
			    				
			    				
				    			if(list[k].group_cnt > 1){ 
			    					var yak_name = list[k].yak_name + ' <a href="#" attr="'+list[k].seqno+'"  attr2="'+list[k].group_code+'"   attr3="'+jqRow+'"   class="btn_change btn_change_'+list[k].seqno+'"  ></a>';
			    					$("#jqGrid").setCell(list[k].seqno , 'yak_name',  yak_name , null);
			    					/* layer_yakjae_group(list[k].seqno , list[k].group_code ,jqRow); */ 	
			    				}
				    			
				    			if(list[k].yak_status != 'y'){
				    				$("#jqGrid").setCell(addData.seqno  , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); 
				    			}
				    			
			    			}else{ 
			    				
			    				var my_joje     = parseFloat( $("#jqGrid").getCell(list[k].seqno,"my_joje") );
			    				var danga       = parseFloat( $("#jqGrid").getCell(list[k].seqno,"danga").replace('원', '') );
			    				
			    				my_joje   = my_joje + parseFloat(list[k].dy_standard);
			    				danga     = danga + parseFloat(list[k].yak_danga);
			    				
			    				
			    				/* 
			    				$("#jqGrid").setCell(list[k].seqno , 'my_joje'  , my_joje , {padding: '0 25px 0 0'});
				    			$("#jqGrid").setCell(list[k].seqno , 'danga'    , danga +'원', {padding: '0 15px 0 0'});
				    			 */
			    			}
						}
						setTimeout(function(){
							  tot_info();
		    				 $('#jqGrid').editCell(1,  5 , true);  		                		
						},50);
					}
				});
			 }
		},
	});
	
	
	$("#c_chup_ea").change(function(){
		
		for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
			$('#jqGrid').editCell(i,  5 , false);	
		}
		setTimeout(function(){
			tot_info();
		},60);
	});
	
	
	$("#c_tang_type").change(function(){
		type_change_action();
	});
	type_change_action();
});


function type_change_action(){
	var c_tang_type = $('#c_tang_type').val();
	
	if(c_tang_type == 1){
		$('#tangtype_area').hide();
		
		$('#c_tang_check13').prop("checked", false);
		$('#c_tang_check13').attr("disabled", true);
		
		$('#c_tang_check14').prop("checked", false);
		$('#c_tang_check14').attr("disabled", true);
		
		$('#c_tang_check15').prop("checked", false);
		$('#c_tang_check15').attr("disabled", true);
		
		
		$('#c_tang_check16').prop("checked", false);
		$('#c_tang_check16').attr("disabled", true);
		
		$('.tang_type_area').hide();
		
	}else{
		$('#tangtype_area').show();
		$('.tang_type_area').show();
		
		$('#c_tang_check13').attr("disabled", false);
		$('#c_tang_check13').attr("readonly", false);
		
		$('#c_tang_check14').attr("disabled", false);
		$('#c_tang_check14').attr("readonly", false);
		
		$('#c_tang_check15').attr("disabled", false);
		$('#c_tang_check15').attr("readonly", false);
		
		$('#c_tang_check16').attr("disabled", false);
		$('#c_tang_check16').attr("readonly", false);
	}
}

function tot_info (){
	var tot_danga = 0;
	var tot_joje  = 0;
	var rows      = $("#jqGrid").getDataIDs();
	var c_chup_ea = parseInt( $('#c_chup_ea').val() );
	
	for (var i = 0; i < rows.length; i++){
		var my_joje   = parseFloat($("#jqGrid").getCell(rows[i],"my_joje") );
    	var yak_danga = parseFloat($("#jqGrid").getCell(rows[i],"yak_danga") );
    	
    	var danga = Math.ceil(my_joje * yak_danga);
    	
    	tot_danga = tot_danga + danga;
    	tot_joje  = tot_joje + my_joje;
    	
    	tot_joje  = Math.floor(tot_joje * 100)/100;
    	
    	$("#jqGrid").setCell(rows[i] , 'yak_name', '' , {padding: '0 0 0 0px'});
    	$("#jqGrid").setCell(rows[i] , 'yak_danga', '' , {padding: '0 0px 0 0'});
    	$("#jqGrid").setCell(rows[i] , 'my_joje'  , my_joje , {padding: '0 0px 0 0'});
		$("#jqGrid").setCell(rows[i] , 'danga'    , comma(danga) +'원', {padding: '0 0px 0 0'});
    	
	}// for
	
	$('#c_chup_g').val((tot_joje * c_chup_ea).toFixed(2));
	$('#tot_yakjae_joje_txt').text(comma(tot_joje+''));
	$('#tot_yakjae_danga_txt').text(comma(tot_danga+''));
	
	var all_yakjae_price = tot_danga * parseInt( $('#c_chup_ea').val() ) ;
	
	$('#order_yakjae_price').val( all_yakjae_price );
	$('#order_yakjae_price_txt').html( comma(all_yakjae_price + '')  );
	$('#c_chup_ea_price').val( tot_danga );
	
	/* setAllPriceSet(); */
}

function yakjae_search_btn(search_value , search_ch){
	var param = {
		 search_value  : search_value
		,search_ch     : search_ch
	};
	$("#yakjaeGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}

function yakjae_multi_search_btn(search){
	if(search.val() == null || search.val() == ''){
		alert('약재명을 입력하세요.');
		search.focus();
		return false;
	}
	
	$.ajax({
		url : 'add_yakjae_multi.do',
		type: 'POST',
		data : {
			search_value : search.val(),
		},
		error : function() {
			alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		},
		success : function(list) {
			
			var jqRow    = 0;
			for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
    			$('#jqGrid').editCell(i,  5 , false);
    			jqRow ++;
    		}
			
			for(var k = 0; k < list.length ; k++){
				console.log('yakjae_multi_search_btn = ', list[k]);
				
				var duple = true;
				var cnt = $("#jqGrid").getDataIDs();
				
    			for (var i = 0; i < cnt.length; i++){
    				if(cnt[i] == list[k].seqno  ){				    					
	    				duple = false;
    				}
    			}
    			
    			if(duple){
    				jqRow ++;
    				
    				var addData = {
	    				 seqno      : list[k].seqno
	    				,yak_name   : list[k].yak_name
	    				,yak_code   : list[k].yak_code
	    				,yak_from   : list[k].yak_from
	    				,yak_danga  : list[k].yak_danga
	    				,group_code : list[k].group_code
	    				,group_cnt  : list[k].group_cnt
	    			    ,yak_status : list[k].yak_status
	    				,my_joje    : 0
	    				,danga      : 0+'원'
	    			};
					$("#jqGrid").jqGrid("addRowData", addData.seqno, addData); 
	    				
    				
    				
    				if(list[k].yak_status != 'y'){
	    				$("#jqGrid").setCell(addData.seqno  , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); 
	    			}
    			}
			}
			search.val('');			
		}
	});
}

function objToStr(val, rep) {
	try {
		if (val == null || val == "" || val == undefined) {

			if (rep != undefined && rep != null) {
				return rep;
			} else {
				return '';
			}
		}
	} catch (e) {
		return '';
	}
	return val;
}

function yakjae_change_apply(tot_danga){
	
	 
	$('#c_chup_ea_price').val(tot_danga);
	
	var c_chup_ea_price = parseInt( objToStr( $('#c_chup_ea_price').val(),0) );
	var c_chup_ea       = parseInt( $('#c_chup_ea').val() );
	
	var tot_chup_price = c_chup_ea * c_chup_ea_price;
	$('#order_yakjae_price').val( tot_chup_price );
	$('#order_yakjae_price_txt').html( comma(tot_chup_price+'') );
	/*
	setAllPriceSet();
	 */
}

function dic_search_btn(search_value , search_ch){
	var param = {
		 search_value  : search_value
		,search_title  : 's_name'
		,search_ch     : search_ch
	};
	$("#dicGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}


</script>

<form action="" id="a_goods_frm" name="a_goods_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" id="seqno" value="${info.seqno }" />
	<input type="hidden" name="json_option" id="json_option" value="" />
	<input type="hidden" name="c_chup_ea_price" id="c_chup_ea_price" value="${info.c_chup_ea_price }" />
	
	<%-- ${info } --%>
	<table class="basic01">
		<colgroup>
			<col width="100px" />
			<col width="*" />
			<col width="100px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>처방명</th>
				<td class="tdL"><input type=text size=30 name="tang_name" id="tang_name" size=50 value="${info.tang_name}" style="width:90%;" ></td>
				<th>활성/메인노출</th>
				<td class="tdL" >
					<select name="view_yn" id="view_yn">
						<option value="y" <c:if test="${info.view_yn eq 'y' }">selected="selected"</c:if>>활성</option>
						<option value="n" <c:if test="${info.view_yn eq 'n' }">selected="selected"</c:if>>비활성</option>
					</select> / 
					<select name="main_yn" id="main_yn">
						<option value="y" <c:if test="${info.main_yn eq 'y' }">selected="selected"</c:if>>노출</option>
						<option value="n" <c:if test="${info.main_yn eq 'n' }">selected="selected"</c:if>>미노출</option>
					</select>
				</td>
			</tr>
			<tr>	
				<th>판매가격</th>
				<td class="tdL"><input type=text name=price size=10  id="price" value="${info.price}" style="width:150px;" > 원</td>
				<th>탕전방식</th>
				<td class="tdL">
					<select name="c_tang_type" id="c_tang_type">
						<option value="1"  <c:if test="${info.c_tang_type eq 1 }">selected="selected"</c:if>>첩약</option>
						<option value="2"  <c:if test="${info.c_tang_type eq 2 }">selected="selected"</c:if>>무압력탕전</option>
						<option value="3"  <c:if test="${info.c_tang_type eq 3 }">selected="selected"</c:if>>압력탕전</option>
					</select>
					<span style="display: none;" id="tangtype_area">
						<input type="radio" name="c_tang_check" id="c_tang_check13" value="13"  <c:if test="${info.c_tang_check eq 13 }">checked="checked"</c:if> >
						<label for="c_tang_type13">주수상반</label>
						
						<input type="radio" name="c_tang_check" id="c_tang_check14" value="14" <c:if test="${info.c_tang_check eq 14 }">checked="checked"</c:if>>
						<label for="c_tang_check14">증류</label>
						
						<input type="radio" name="c_tang_check" id="c_tang_check15" value="15" <c:if test="${info.c_tang_check eq 15 }">checked="checked"</c:if>>
						<label for="c_tang_type15">발효</label>
						
						<input type="radio" name="c_tang_check" id="c_tang_check16" value="16" <c:if test="${info.c_tang_check eq 16 }">checked="checked"</c:if>>
						<label for="c_tang_type16">재탕</label>
					</span>
					
				</td>
			</tr>
			<tr>
				<th>첩수 / 총약재량</th>
				<td class="tdL">
					<select name="c_chup_ea" id="c_chup_ea"  style="width:85px;">
						<option value="0">선택</option>
						<c:forEach var="i" step="1" begin="1" end="120">
							<option value="${i}"  <c:if test="${info.c_chup_ea eq i }">selected="selected"</c:if>  >${i}</option>
						</c:forEach>
					</select>첩
					 / 
					<input type=text name=c_chup_g id="c_chup_g" size=10 value="${info.c_chup_g }" style="width:60px;background-color: grey;" readonly="readonly">g
				</td>
				
				<th>출전</th>
				<td class="tdL"><input type=text name=jo_from size=30 id="jo_from" value="${info.jo_from }" style="width:90%;"></td>
				
				
			</tr>
			<tr style="display:none;" class="tang_type_area">
				<th>파우치선택</th>
				<td class="tdL">
					<select name="c_pouch_type" id="c_pouch_type"  style="width:360px;">
						<option value="0" attr2="0">선택안함</option>
						<c:forEach var="list" items="${pouch_list}">
							<option value="${list.seqno}"  attr="/upload/pouch/${list.pouch_image}"  attr2=${list.pouch_price }  <c:if test="${info.c_pouch_type eq list.seqno }">selected="selected"</c:if>  >${list.pouch_name}(${list.pouch_price})</option>
						</c:forEach>
					</select>
				</td>
				<th>박스선택</th>
				<td class="tdL">
					<select name="c_box_type" id="c_box_type"  style="width:360px;">
						<option value="0" attr2="0">선택안함</option>
						<c:forEach var="list" items="${box_list}">
							<option value="${list.seqno}" attr="/upload/box/${list.box_image}"  attr2=${list.box_price }  <c:if test="${info.c_box_type eq list.seqno }">selected="selected"</c:if> >${list.box_name}(${list.box_price})</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr style="display:none;" class="tang_type_area">
				<th>스티로폼</th>
				<td class="tdL">
					<select name="c_stpom_type" id="c_stpom_type"  style="width:360px;">
						<option value="0" attr2="0">선택안함</option>
						<c:forEach var="list" items="${sty_list}">
							<option value="${list.seqno}" attr2="${list.price}"  <c:if test="${info.c_stpom_type eq list.seqno }">selected="selected"</c:if>  >${list.sty_name}(${list.price})</option>
						</c:forEach>
					</select>
				</td>
				<th>팩용량/팩수</th>
				<td class="tdL">
					<select name="c_pack_ml" id="c_pack_ml"  style="width:160px;">
						<option value="0">선택</option>
						<option value="50"   <c:if test="${info.c_pack_ml eq 50 }">selected="selected"</c:if>>50ml</option>
	                    <option value="60"   <c:if test="${info.c_pack_ml eq 60 }">selected="selected"</c:if>>60ml</option>
						<option value="70"   <c:if test="${info.c_pack_ml eq 70 }">selected="selected"</c:if>>70ml</option>
						<option value="80"   <c:if test="${info.c_pack_ml eq 80 }">selected="selected"</c:if>>80ml(유아)</option>
						<option value="90"   <c:if test="${info.c_pack_ml eq 90 }">selected="selected"</c:if>>90ml</option>
						<option value="100"  <c:if test="${info.c_pack_ml eq 100 }">selected="selected"</c:if>>100ml(소아)</option>
						<option value="110"  <c:if test="${info.c_pack_ml eq 110 }">selected="selected"</c:if>>110ml</option>
						<option value="120"  <c:if test="${info.c_pack_ml eq 120 }">selected="selected"</c:if>>120ml(성인)</option>
						<option value="130"  <c:if test="${info.c_pack_ml eq 130 }">selected="selected"</c:if>>130ml</option>
						<option value="140"  <c:if test="${info.c_pack_ml eq 140 }">selected="selected"</c:if> >140ml</option>
					</select>
					 /
					 <select name="c_pack_ea" id="c_pack_ea"  style="width:85px;">
						<option value="0">선택</option>
						<c:forEach var="i" step="1" begin="1" end="120">
							<option value="${i}"  <c:if test="${info.c_pack_ea eq i }">selected="selected"</c:if>  >${i}</option>
						</c:forEach>
					</select>팩
				</td>
				
				
			</tr>
			<tr>
				<th>포장박스</th>
				<td class="tdL">
					<select name="c_box_ea" id="c_box_ea"  style="width:85px;">
						<c:forEach var="i" step="1" begin="1" end="10">
							<option value="${i}"  <c:if test="${info.c_box_ea eq i }">selected="selected"</c:if>  >${i}</option>
						</c:forEach>
					</select>
				</td>				
			</tr>
			<tr style="height:300px;">
				<th  valign="top">약재구성</th>
				<td class="tdL" valign="top" colspan="3" style="padding : 0 2px 0 2px;">
					<table>
						<tr>
							<td style="width:700px;" valign="top" >
								<table id="jqGrid"></table>
								<table class="orderlist02" >
									<colgroup>
										<col width="24px" />
										<col width="*" />
										<col width="70px" />
										<col width="120px" />
										<col width="90px" />
										<col width="90px" />
										<col width="110px" />
									</colgroup>								
									<tfoot>
										<tr>
											<td colspan="3" style="border-color:grey;border-bottom:none;border-right:none;">
												<div><a href="#" id="delItemBtn"><span class="cBB h30">선택 삭제</span></a></div>
											</td>
											<td class="b" style="border-color:grey;border-bottom:none;border-right:none;">소개</td>
											<td style="border-color:grey;border-bottom:none;border-right:none;">
												<span class="b" id="tot_yakjae_joje_txt">0</span>g
											</td>
											<td colspan="2" style="border-color:grey;border-bottom:none;border-right:none;">
													<span class="b" id="tot_yakjae_danga_txt">0</span>원										
											</td>
										</tr>
									</tfoot>
								</table>
							</td>
							<td>
								<div class="order_option" style="">
									<!-- 약재추가 -->
									<div class="yakjae order_detail" id="orderOp0" style="" id="">
										<div class="searchA">
											<p>
												<input type="text" id="yakjae_search_value" style="width:115px;" />
												<a href="#" id="yakjaeSearchBtn"><span id="" class="h34 cB mr5">검색</span></a>
												<input type="text" id="yakjae_multi_value"  placeholder="띄어쓰기로 여러약재 추가" style="width:180px;" />
												<a href="#" id="yakjaeMultiSearchBtn"><span id="" class="h34 cbg">바로처방</span></a>
											</p>
											<ul class="search_han2 yakjae_search_han2">
												<li><a href="#" attr="" class="fir sel">전체</a></li>
												<li><a href="#" attr="ㄱ">ㄱ</a></li>
												<li><a href="#" attr="ㄴ">ㄴ</a></li>
												<li><a href="#" attr="ㄷ">ㄷ</a></li>
												<li><a href="#" attr="ㄹ">ㄹ</a></li>
												<li><a href="#" attr="ㅁ">ㅁ</a></li>
												<li><a href="#" attr="ㅇ">ㅇ</a></li>
												<li><a href="#" attr="ㅂ">ㅂ</a></li>
												<li><a href="#" attr="ㅅ">ㅅ</a></li>
												<li><a href="#" attr="ㅈ">ㅈ</a></li>
												<li><a href="#" attr="ㅊ">ㅊ</a></li>
												<li><a href="#" attr="ㅋ">ㅋ</a></li>
												<li><a href="#" attr="ㅍ">ㅍ</a></li>
												<li><a href="#" attr="ㅎ">ㅎ</a></li>
											</ul>
										</div>
										<table id="yakjaeGrid" class="orderlistGrid"></table>
										<div id="yakjaeGridControl"></div>
									</div>
									<!-- // 약재추가 -->
								</div>
							</td>
							<td>
								<div class="order_option">
								
									<div class="searchA">
										<p>
											<input type="text" id="dic_search_value" style="width:355px;" />
											<a href="#" id="dicSearchBtn"><span id="" class="h34 cB mr5">처방검색</span></a>
										</p>
										<ul class="search_han2 dic_search_han2">
											<li><a href="#" attr="" class="fir sel">전체</a></li>
											<li><a href="#" attr="ㄱ">ㄱ</a></li>
											<li><a href="#" attr="ㄴ">ㄴ</a></li>
											<li><a href="#" attr="ㄷ">ㄷ</a></li>
											<li><a href="#" attr="ㄹ">ㄹ</a></li>
											<li><a href="#" attr="ㅁ">ㅁ</a></li>
											<li><a href="#" attr="ㅇ">ㅇ</a></li>
											<li><a href="#" attr="ㅂ">ㅂ</a></li>
											<li><a href="#" attr="ㅅ">ㅅ</a></li>
											<li><a href="#" attr="ㅈ">ㅈ</a></li>
											<li><a href="#" attr="ㅊ">ㅊ</a></li>
											<li><a href="#" attr="ㅋ">ㅋ</a></li>
											<li><a href="#" attr="ㅍ">ㅍ</a></li>
											<li><a href="#" attr="ㅎ">ㅎ</a></li>
										</ul>
									</div>
									
									<table id="dicGrid" class="orderlistGrid"></table>
									<div id="dicGridControl"></div>
									
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr>
				<th rowspan="3">상품상세</th>
				<td rowspan="3" class="tdL"><textarea name=p_contents id="p_contents" rows=4 cols=103>${info.p_contents}</textarea></td>
				<th>상품사진1	</th>
				<td class="tdL" valign="top">
					<input type=file name=image1 id="image1" size=40 >
					<c:if test="${not empty info.image1 }">
						<br/><img src="/upload/goods/${info.image1 }" alt="" width="60px;" height="60px;" />
						${info.image1 }
					</c:if>
				</td>
			</tr>
			<tr>
				<th>상품사진2</th>
				<td  class="tdL" valign="top">
					<input type=file name=image2 id="image2" size=40 >
					<c:if test="${not empty info.image2 }">
						<br/><img src="/upload/goods/${info.image2 }" alt=""  width="60px;" height="60px;"/>
						${info.image2 }
					</c:if>
				</td>
			</tr>
			<tr>
				<th>상품사진3</th>
				<td  class="tdL" valign="top">
					<input type=file name=image3 id="image3" size=40 >
					<c:if test="${not empty info.image3 }">
						<br/><img src="/upload/goods/${info.image3 }" alt=""  width="60px;" height="60px;"/>
						${info.image3 }
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</form>