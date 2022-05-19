$(document).ready(function() {
	
  	$("#jqGrid").jqGrid({
  		//caption : '박스 관리 목록',
  		dataType : 'local', // 로딩시 최초 조회 
  		/* data: mydata,
  		datatype: "local", */
  		url : '/admin/item/amount/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 7,
  		rowList: [7,14,21, 100],
  		//rowList: [3],
  		colNames:[
  			'번호','정렬순서', '상품명',  '가격', '부여포인트', '노출여부',
  			'detail' , 'image'
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',		width:38,	align:"left" ,key: true , hidden:true},
  			{name:'sort_seq',	index:'sort_seq',		width:38,	align:"center" ,sortable : true
				,formatter: 'integer'
				,formatoptions:{thousandsSeparator:","}
				,editable:true
			},
  			{name:'title',		index:'title',		width:500,	align:"left" ,sortable : true},
  			/*
  			{name:'box_size',	index:'box_size',		width:68,	align:"center"
  				,editable:true
  			},
  			*/
  			{name:'price',	index:'price',		width:58,	align:"right"  ,sortable : true 
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  				,editable:true
  			},
  			{name:'point',	index:'point',		width:58,	align:"right"  ,sortable : true 
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  				,editable:true
  			},
  			{name:'show_yn',	index:'show_yn',		width:58,	align:"center"  ,sortable : true
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					 value:"y:노출;n:감춤"
  					/* ,dataEvents: [{type: 'change', fn: function(e){
  						//	update_payment(this);
  						}
                   	}] */
  				}
  				,formatter: 'select'	
  		    },
  		    
  		  {name:'detail',		index:'detail',		width:38,	align:"left"  , hidden:true},
  		  {name:'image',		index:'image',		width:38,	align:"left"  , hidden:true}
  		],
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'sort_seq',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		cellEdit : true,
		editurl : '/admin/item/amount/select.do',
		cellurl : '/admin/item/amount/update_col.do',
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
			var rows = $("#jqGrid").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		    	$("#jqGrid").setCell(rows[i] , 'title', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	
		    	/*
		    	var box_contents = $("#jqGrid").getCell(rows[i],"box_contents");
		    	
		    	$("#jqGrid").setCell(rows[i] , 'contents', box_contents); // 특정 cell 색상변경
		    	*/
		    	
		    }
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('onCellSelect = ', iCol); 
			if(iCol == 3){
				 var data = $("#jqGrid").jqGrid('getRowData', row);	
				 var ret = $("#jqGrid").getRowData(row);
				 
				 console.log('ret = ', ret);
				 $.ajax({
				    url   : "/admin/item/amount/add.do",		    
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
  	$("#jqGrid").jqGrid('navGrid','#jqGridControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
  	
  	$("#modForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 870,
        width: 1000,
       // position: 'center',
        modal: true,
        title: '수정',
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
            	a_box_mod();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
  	
  	
  	$("#addForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 870,
        width: 1000,
       // position: 'center',
        modal: true,
        title: '추가',
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
            	a_box_add();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
  	
  	$('#addAmountBtn').click(function() {
  		$.ajax({
		    url: "/admin/item/amount/add.do",		    
		    type : 'POST',
	        error: function(){
		    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		    },
		    success: function(data){
		        $("#addForm").html(data);
		        $("#addForm" ).dialog( "open" );
		    }   
		});	
		
	});
  	
  	
  	$('#delBtn').click(function() {
  		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
  		console.log(row.length);
  		if( row.length > 0 ){		
  			
  			for(var i = 0 ; i <row.length ; i++){
  				var data =$("#jqGrid").jqGrid('getRowData', row[i]);
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
	  					$("#jqGrid").trigger("reloadGrid");
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