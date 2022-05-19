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
  		//caption : '파우치 관리 목록',
  		dataType : 'local', // 로딩시 최초 조회 
  		/* data: mydata,
  		datatype: "local", */
  		url : 'select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 15,
  		rowList: [15,20,30],
  		//rowList: [3],
  		colNames:[
  			'번호'    , '제목'    , '이미지'  , '시작일'     ,  '종료일' ,  
  			'가로크기' , '세로크기' ,'Top 여백' , 'Left여백'  ,  '활성화' ,
  			'타겟'    , '링크'
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',			width:28,	align:"center" ,key: true },
  			{name:'title',		index:'title',			width:358,	align:"left"},
  			{name:'upfile',		index:'upfile',		width:100,	align:"center", formatter: getImgSrc},
  			{name:'start_date',	index:'start_date',		width:120,	align:"center"
  				,editable:true
  				,editoptions: { 
  					dataInit: function (elem) { 
  						$(elem).datepicker({
  							dateFormat: 'yymmdd'
  						}); 
  					} 
  				}
  			},
  			{name:'end_date',	index:'end_date',		width:80,	align:"center"
  				,editable:true
  				,editoptions: { 
  					dataInit: function (elem) { 
  						$(elem).datepicker({
  							dateFormat: 'yymmdd'
  						}); 
  					} 
  				}
  			},
  			
  			
  			{name:'w_size'	,	index:'w_size',			width:80,	align:"center"
  				,editable:true
  				,formatter: 'integer' 
  				,formatoptions:{thousandsSeparator:","}
  			},
  			{name:'h_size'	,	index:'h_size',			width:80,	align:"center"
  				,editable:true
  				,formatter: 'integer' 
  	  			,formatoptions:{thousandsSeparator:","}
  			},
  			{name:'top_size',	index:'top_size',		width:80,	align:"center"
  				,editable:true
  				,formatter: 'integer' 
  	  			,formatoptions:{thousandsSeparator:","}
  			},
  			{name:'left_size',	index:'left_size',		width:80,	align:"center"
  				,editable:true
  				,formatter: 'integer' 
  	  			,formatoptions:{thousandsSeparator:","}
  			},
  			{name:'view_yn',	index:'view_yn',		width:120,	align:"center"
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					 value:"y:활성;n:비활성"						
                }
  				,formatter: 'select'
  			},
  			
  			{name:'yn_win',	index:'yn_win',		width:120,	align:"center"
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					 value:"y:새창;n:본문"						
                }
  				,formatter: 'select'
  					, hidden:true
  			},
  			{name:'yn_link',		index:'yn_link',			width:358,	align:"left" , hidden:true},
  		],
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seq',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		cellEdit : true,
		//cellsubmit : 'clientArray',
		//editurl : 'select.do";
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
		    	$("#jqGrid").setCell(rows[i] , 'title', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    }
		},
		 onCellSelect : function(row,iCol,cellcontent,e){
			console.log('onCellSelect = ', iCol); 
			  if(iCol == 2){
				 var data = $("#jqGrid").jqGrid('getRowData', row);					
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
		},
	});
	  	
  	//페이지 넘 
  	$("#jqGrid").jqGrid('navGrid','#jqGridControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
  	
  	$("#modForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 700,
        width: 1000,
       // position: 'center',
        modal: true,
        title: '게시글 수정',
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
        height: 700,
        width: 1000,
       // position: 'center',
        modal: true,
        title: '글작성',
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
  			
  			console.log('data.seq = ', data.seq);
  			data.seqno = all_seqno
  			console.log('data.seq = ', data.seq);
  		
  			
  			var width = 290;
  	        var height = 150;

  	        var left2 = window.pageXOffset + parseInt( ( $(window).width()/2 )  - (width/2)  );
  	        var top2  = window.pageYOffset + parseInt( ( $(window).height()/2 ) - (height/2) );
  			
  			
  			var option = {
  				modal             : true,
  				width             : width,
  				height            : height,
  				left              : left2,
  				top               : top2,
  			    url               : "del.do",
  			    savekey           : [true, 13],
  			    closeOnEscape     : true,
  			    reloadAfterSubmit : true,
  			    delData           : data		
  			}
  			
  			
  			$("#jqGrid").jqGrid('delGridRow',row[0],option);	
  			
  		}else{
  			alert('삭제할 파우치를 선택하세요.');
  		}
  	});
	  	
});

function getImgSrc(cellValue, options, rowObject){
	
	if(cellValue != '' && cellValue != null && cellValue !=  undefined){
		return "<img src='/upload/popup/all/"+cellValue+"' width='100px;' height='100px;' />";
	}else{
		return '';
	}
}


function close(){
	$(this).dialog("close");
}
