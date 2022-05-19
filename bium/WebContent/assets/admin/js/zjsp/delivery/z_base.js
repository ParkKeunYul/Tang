$(document).ready(function() {
	
  	$("#jqGrid").jqGrid({
  	//	caption : '택배사 정보',
  		//dataType : 'local', // 로딩시 최초 조회 		  		
  		datatype: "local", 
  		url : 'select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 100,
  		//rowList: [20,50,100,500],
  		//rowList: [3],
  		colNames:[
  			'번호', '택배사영', '가격','기본택배 사용여부','사용여부','조회코드', 
  			'등록일', 
  		],
  		colModel:[
  			{name:'seqno',		index:'a_seqno',	width:48,	align:"center"  ,sortable : false ,key: true },
  			{name:'delivery_nm',index:'delivery_nm',width:120,	align:"left" 	,sortable : false ,editable:true},
  			{name:'price',		index:'price',		width:120,	align:"right"  ,sortable : false  , hidden: true
  				,editable:true
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  			},
  			{name:'sel_yn',		index:'sel_yn',		width:120,	align:"center"  ,sortable : false 
  				,editable:true
  				,edittype:"select"
  				,formatter: 'select'
  				,editoptions:{
  					value:"y:사용중;n:미사용"
  				}
  			},
  			{name:'use_yn',		index:'use_yn',		width:120,	align:"center"  ,sortable : false ,hidden: true
  				,editable:true
  				,edittype:"select"
  				,formatter: 'select'
  				,editoptions:{
  					value:"y:사용중;n:미사용"
  				}
  			},
  			{name:'id',		index:'id',		width:200,	align:"center"  ,sortable : false},
  			
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