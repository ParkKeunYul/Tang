$(document).ready(function() {
	
  	$("#jqGrid").jqGrid({
  		//caption : '박스 관리 목록',
  		dataType : 'local', // 로딩시 최초 조회 
  		/* data: mydata,
  		datatype: "local", */
  		url : '/admin/item/box/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 7,
  		rowList: [7,14,21],
  		//rowList: [3],
  		colNames:[
  			'번호', '제품명',  '사이즈',  '가격' , '재고량', 
  			'설명' ,'이미지1', '이미지2', '이미지3' ,'설명ori'
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',			width:28,	align:"left" ,key: true , hidden:true},
  			{name:'box_name',	index:'box_name',		width:98,	align:"left"},
  			{name:'box_size',	index:'box_size',		width:68,	align:"center"
  				,editable:true
  			},
  			{name:'box_price',	index:'box_price',		width:58,	align:"right" 
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  				,editable:true
  			},
  			{name:'box_status',	index:'box_status',		width:58,	align:"center"
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					 value:"y:재고충분;n:재고부족"
  					/* ,dataEvents: [{type: 'change', fn: function(e){
  						//	update_payment(this);
  						}
                   	}] */
  				}
  				,formatter: 'select'	
  		    },
  		    
  			{name:'box_contents',	index:'box_contents',	width:300,	align:"left"
  				,editable:true 
  				,edittype:"textarea"
  				,editoptions : {
 	  					 row :20
 	  					,cols:60
 	  					,style:'height:100px;'
 	  				}
  		    },
  			{name:'box_image',		index:'box_image',		width:100,	align:"center", formatter: getImgSrc},
  			{name:'box_image2',		index:'box_image2',		width:100,	align:"center", formatter: getImgSrc , hidden:true},
  			{name:'box_image3',		index:'box_image3',		width:100,	align:"center", formatter: getImgSrc , hidden:true},
  			{name:'contents',		index:'contents',		width:300,	align:"left" , hidden:true}
  		],
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		cellEdit : true,
		editurl : '/admin/item/box/select.do',
		cellurl : '/admin/item/box/update_col.do',
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
		    	$("#jqGrid").setCell(rows[i] , 'box_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	
		    	
		    	var box_contents = $("#jqGrid").getCell(rows[i],"box_contents");
		    	
		    	$("#jqGrid").setCell(rows[i] , 'contents', box_contents); // 특정 cell 색상변경
		    	
		    }
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('onCellSelect = ', iCol); 
			if(iCol == 2){
				 var data = $("#jqGrid").jqGrid('getRowData', row);	
				 var ret = $("#jqGrid").getRowData(row);
				 
				 console.log('ret = ', ret);
				 $.ajax({
				    url   : "/admin/item/box/add.do",		    
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
        height: 570,
        width: 850,
       // position: 'center',
        modal: true,
        title: '박스추가',
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
        height: 570,
        width: 850,
       // position: 'center',
        modal: true,
        title: '박스추가',
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
  	
  	$('#addBoxBtn').click(function() {
  		$.ajax({
		    url: "/admin/item/box/add.do",		    
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