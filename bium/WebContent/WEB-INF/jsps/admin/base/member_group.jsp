<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<script type="text/javascript">
var a_mem_code  = "0:가입신청;${mem_code}";
var a_group_code = "${group_code}";
	
	$(document).ready(function() {
		
	  	$("#jqGrid").jqGrid({
	  		//caption : '회원 등급 정보',
	  		//dataType : 'local', // 로딩시 최초 조회 		  		
	  		datatype: "local", 
	  		url : '/admin/base/memGroup/select.do',
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 1000,
	  		//rowList: [20,50,100,500],
	  		//rowList: [3],
	  		colNames:[
	  			'번호' , '그룹명' , '할인율' , '등록일' 
	  		],
	  		colModel:[
	  			{name:'seqno',		index:'a_seqno',	width:48,	align:"center"  ,sortable : false ,key: true },
	  			{name:'group_nm',	index:'group_nm',	width:200,	align:"left"  ,sortable : false ,editable:true},
	  			{name:'sale_per',	index:'sale_per',	width:80,	align:"center"  ,sortable : false 
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
	  				
	  			},
	  			{name:'upt_date2',		index:'upt_date2',		width:100,	align:"center"  ,sortable : false}
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
			editurl : '/admin/base/memGroup/select.do',
			cellurl : '/admin/base/memGroup/update_col.do',
			beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
				console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
				return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
			},
			beforeEditCell : function(rowid, cellname, value, iRow, iCol){
			    selICol = iCol;
			    selIRow = iRow;
			},
			loadComplete: function(data) {
				//'/admin/base/member/select.do',
			},
			onCellSelect : function(row,iCol,cellcontent,e){
				console.log('iCol= ', iCol);
				var data = $("#jqGrid").jqGrid('getRowData', row);
				//console.log(data);
				
				$("#memList").setGridParam({"postData": {search_group : data.seqno} ,datatype: "json", mtype: 'POST'}).trigger("reloadGrid",[{page : 1}]);
			},
		});
	  	
	  	
	  	$("#add_form").dialog({
	  		autoOpen: false,
            resizable: true,
            height: 250,
            width: 450,
           // position: 'center',
            modal: true,
            title: '그룹 추가',
            beforeClose: function(event, ui) { 
               console.log('beforeClose');
            },
            close : function(){            
            //	$("#jqGrid").trigger("reloadGrid");
            	$("#add_form").html("");
            },
            open: function(event, ui) { 
            	$('.ui-widget-overlay').bind('click', function(){
            		$("#add_form").dialog('close'); 
            	});
            },
            buttons: {
                "저장": function () {
                	manage_add();
                },
                "닫기": function () {
                    $(this).dialog("close");
                }
            }	
	  	});
	  	
	  	
	  	$("#memList").jqGrid({
	  		//caption : '회원관리',
	  		//dataType : 'local', // 로딩시 최초 조회 		  		
	  		datatype: "local", 
	  		url : '/admin/base/member/select.do',
	  		//datatype: 'json',
	  		datatype: 'local',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 1000,
	  		//rowList: [20,50,100,500],
	  		//rowList: [3],
	  		colNames:[
	  			'번호', '아이디', '이름', '한의원명', '등급', 
	  			'라이센스','이메일','실무자','회원구분','그룹', 
	  			'가입일'
	  		],
	  		colModel:[
	  			{name:'seqno',			index:'a_seqno',		width:48,	align:"center"  ,sortable : false ,key: true , hidden:true},
	  			{name:'id',				index:'id',				width:120,	align:"left"    ,sortable : false},
	  			{name:'name',			index:'name',			width:120,	align:"left"  ,sortable : false
	  				,editable:true
	  			},
	  			{name:'han_name',		index:'han_name',		width:200,	align:"left"    ,sortable : false
	  				,editable:true
	  			},
	  			{name:'member_level',	index:'member_level',	width:200,	align:"center"  ,sortable : false
	  				,editable:true
	  				,edittype:'select'
	  				,formatter: 'select'
	  				,editoptions:{
	  					 value:a_mem_code	
	  				} 		  				
	  			},  			
	  			{name:'license_no',		index:'license_no',		width:80,	align:"center"    ,sortable : false, hidden:true
	  				,editable:true
	  			},
	  			{name:'email',		index:'email',		width:180,	align:"left"    ,sortable : false , hidden:true
	  				,editable:true
	  			},
	  			{name:'sub_id_confirm',		index:'sub_id_confirm',		width:80,	align:"center"    ,sortable : false
	  				,editable:true
	  				,edittype:'select'
	  				,formatter: 'select'
	  				,editoptions:{
	  					 value:"y:승인;n:미승인"	
	  				}
	  			},
	  			{name:'part',		index:'part',		width:130,	align:"center"    ,sortable : false
	  				,editable:true
	  				,edittype:'select'
	  				,formatter: 'select'
	  				,editoptions:{
	  					 value:"1:한의원(개원의);2:한의사(미개원의);3:한의대생"	
	  				}
	  			},		  			
	  			{name:'group_code',		index:'group_code',		width:150,	align:"center"  ,sortable : false
	  				,editable:true
	  				,edittype:'select'
	  				,formatter: 'select'
	  				,editoptions:{
	  					value: a_group_code	
	  				}
	  			},
	  			{name:'wdate2',			index:'wdate',			width:200,	align:"center"  ,sortable : false}
	  		],
			//pager: "#jqGridControl",
			viewrecords: true,
			autowidth: true,				
			//sortname: 'seqno',
			//sortorder: "desc",
			viewrecords: true,
			loadtext  : '데이터를 불러오는중입니다.',
			emptyrecords  : '검색된 데이터가 없습니다',
			multiselect: false,
			cellEdit : true,
			editurl : '/admin/base/member/select.do',
			cellurl : '/admin/base/member/update_col.do',
			beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
				console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
				return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
			},
			loadComplete: function(data) {
				var rows = $("#memList").getDataIDs(); 				
			    /* for (var i = 0; i < rows.length; i++){
			    	var member_level = new Number($("#memList").getCell(rows[i],"member_level"));
			    	
			    	$("#memList").setCell(rows[i] , 'id', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	
			    }// */
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
		});
		  	
	});
	
	
	function add(){
		$.ajax({
		    url: "add.do",
		    success: function(data){
		        $("#add_form").html(data);
		        $("#add_form" ).dialog( "open" );
		    }   
		});
	}
	
</script>
	
	
	<div class="con_tit">기본관리 &gt; 회원그룹관리 </div>
	
	<div class="conBox">
		<ul>
			<li style="width: 39%;float: left;">
				<div style="padding-bottom: 10px;">
					<a href="#" onclick="add();" class="btn02">추가</a>
				</div>
				
				<table id="jqGrid"></table>				
				<div id="add_form"></div>
			</li>
			<li style="width: 3%;float: left;">&nbsp;</li>
			<li style="width: 58%;float: left;">
				<div style="padding-bottom: 10px;height: 33px;">
					<!-- <a href="#" onclick="add();" class="btn02">추가</a> -->
				</div>
				<table id="memList"></table>
			</li>
		</ul>
			
	<!-- <div id="jqGridControl"></div> -->
	</div>
		
		

</html>