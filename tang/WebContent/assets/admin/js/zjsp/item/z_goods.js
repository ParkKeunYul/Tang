$(document).ready(function() {
		
	  	$("#jqGrid").jqGrid({
	  		//caption : '회원 등급 정보',
	  		//dataType : 'local', // 로딩시 최초 조회 		  		
	  		datatype: "local", 
	  		url : 'select.do',
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 30,
	  		rowList: [15,30,50,100,500],
	  		colNames:[
	  			'번호', '상품명','판매가'  , '처방상태'  , '황성화'
	  			,'등록일'
	  		],
	  		colModel:[
	  			{name:'p_seq',		index:'p_seq',		width:48,	align:"center"  ,sortable : false ,key: true  },
	  			{name:'p_name',		index:'p_name',		width:420,	align:"left"  ,sortable : false ,editable:false},
	  			{name:'p_price',	index:'p_price',	width:120,	align:"right"  ,sortable : false 
	  				,editable:true
	  				,formatter: 'integer'
	  				,formatoptions:{thousandsSeparator:","}
	  			},
	  			{name:'p_ea',		index:'p_ea',		width:120,	align:"center"  ,sortable : false
	  				,editable:true 
	  				,edittype:"select"
	  				,editoptions:{
	  					 value:"처방가능:처방가능;처방불가:처방불가"  						
	  				}		  				
	  				,formatter: 'select'
	  			},		  					  			
	  			{name:'view_yn',	index:'view_yn',	width:120,	align:"center"  ,sortable : false
	  				,editable:true 
	  				,edittype:"select"
	  				,editoptions:{
	  					 value:"y:활성;n:비활성"  						
	  				}		  				
	  				,formatter: 'select'
	  			},
	  			
	  			{name:'wdate2',		index:'wdate2',		width:200,	align:"center"  ,sortable : false}
	  		],
			pager: "#jqGridControl",
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
				return {"p_seq":rowid, "cellName":cellName, "cellValue": cellValue}
			},
			beforeEditCell : function(rowid, cellname, value, iRow, iCol){
			    selICol = iCol;
			    selIRow = iRow;
			},
			loadComplete: function(data) {
				var rows = $("#jqGrid").getDataIDs(); 				
			    for (var i = 0; i < rows.length; i++){
			    	$("#jqGrid").setCell(rows[i] , 'p_seq', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	$("#jqGrid").setCell(rows[i] , 'p_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	
			    }
			},
			onCellSelect : function(row,iCol,cellcontent,e){
				console.log('onCellSelect = ', iCol); 
				if(iCol == 1 || iCol == 2){
					var data = $("#jqGrid").jqGrid('getRowData', row);	
					var ret = $("#jqGrid").getRowData(row)
					 
					 console.log('ret = ', ret);
					 $.ajax({
					    url   : "mod.do",		    
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
	  	
	  	//페이지 넘 
	  	$("#jqGrid").jqGrid('navGrid','#jqGridControl',
	  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	  	);
	  	
	  	$('#search_btn').click(function() {
	  		var search_value = $('#search_value').val();
			var search_title = $('#search_title').val();
			
			var param = { 
				 search_value : search_value
				,search_title : search_title
			};
			
			$("#jqGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
			
			return false;
		});
	  	
	  	$('#addGoodsBtn').click(function() {
	  		$.ajax({
			    url: "add.do",		    
			    type : 'POST',
		        error: function(){
			    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			    },
			    success: function(data){
			    	//console.log('data= ', data);
			        $("#addForm").html(data);
			        $("#addForm" ).dialog( "open" );
			    }   
			});	
		});
	  	
	  	$("#addForm").dialog({
	  		autoOpen: false,
	        resizable: true,
	        height: 800,
	        width: 1200,
	       // position: 'center',
	        modal: true,
	        title: '상품 추가',
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
	            	a_goods_add();
	            },
	            "닫기": function () {
	                $(this).dialog("close");
	            }
	        }		
	  	});
	  	
	  	$("#modForm").dialog({
	  		autoOpen: false,
	        resizable: true,
	        height: 800,
	        width: 1200,
	       // position: 'center',
	        modal: true,
	        title: '상품 수정',
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
	            	a_goods_mod();
	            },
	            "닫기": function () {
	                $(this).dialog("close");
	            }
	        }		
	  	});
	});