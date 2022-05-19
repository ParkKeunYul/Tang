$(document).ready(function() {
  	$("#jqGrid").jqGrid({
  		caption : '약속처방 상품 그룹코드',
  		//dataType : 'local', // 로딩시 최초 조회 		  		
  		datatype: "local", 
  		url : 'select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 5000,
  		//rowList: [20,50,100,500],
  		//rowList: [3],
  		colNames:[
  			'번호','그룹명' ,'노출여부' , '정렬순위' , '그룹코드' , '등록일'
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',	width:48,	align:"center"  ,sortable : false ,key: true , hidden:false },
  			{name:'group_name',	index:'group_name',	width:420,	align:"left"  ,sortable : false ,editable:false},
  			{name:'use_yn',	index:'use_yn',	width:50,	align:"center"  ,sortable : false
  				,editable:true
  				,edittype:"select"
				,editoptions:{
	  				value:"y:노출;n:미노출"
	  			}
	  			,formatter: 'select'
  			},
  			{name:'sort_seq',	index:'sort_seq',	width:50,	align:"center"  ,sortable : false 
  				,editable:true
  				,editoptions: {
  					 maxlength: 4
  					,dataEvents: [{
  						type: 'keydown',
  						fn: function(e) {
	  		            	try{init_yakjae_flag = false;}catch (e) {}
	  		                var key = e.charCode || e.keyCode;
	  		             	var tot = $("#jqGrid").getGridParam("records");
	  		             	console.log('selIRow= ', selIRow);
	  		                if (key == 9){					  		                	
	  		                	setTimeout(function () {			  	
	  		                		if(selIRow+1 > tot){
	  		                			$('#jqGrid').editCell(1,  4 , true);
										return false;
	  		                		}else{
	  		                			$('#jqGrid').editCell(selIRow+1,  4 , true);	
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
  				}
  			},
  			{name:'group_code',	index:'group_code',	width:120,	align:"center"  ,sortable : false},
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
		multiselect: true,
		cellEdit : true,
		editurl : 'select.do',
		cellurl : 'update_col.do',
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
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		beforeEditCell : function(rowid, cellname, value, iRow, iCol){
		    selICol = iCol;
		    selIRow = iRow;
		},
		loadComplete: function(data) {
			var rows = $("#jqGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#jqGrid").setCell(rows[i] , 'group_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			}
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('onCellSelect = >', iCol);
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
		}
	});
  	
  	$("#modForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 300,
        width: 550,
       // position: 'center',
        modal: true,
        title: '그룹 수정',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#modForm').html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#addForm").dialog('close'); 
        	});
        },
        buttons: {
            "수정": function () {
            	a_group_mod();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
  	
  	$("#addForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 300,
        width: 550,
       // position: 'center',
        modal: true,
        title: '그룹 추가',
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
            	a_group_add();
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
  			
  			if(!confirm('삭제하겠습니까?')){  				
  				return;
  			}
  			
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