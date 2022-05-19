$(document).ready(function() {
	$("#groupGrid").jqGrid({
  		caption : '약재그룹 List',
  		dataType : 'local', // 로딩시 최초 조회 
  		/* data: mydata,
  		datatype: "local", */
  		url : '/admin/item/medi/select_group.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 5,
  		//rowList: [10],
  		//rowList: [3],
  		colNames:['번호','그룹코드', '그룹명', '약재수','삭제',],
  		colModel:[
  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true, hidden: true },
  			{name:'group_code',		index:'group_code',		width:140,	align:"center"},
  			{name:'group_name',		index:'group_name',		width:206,	align:"center",editable:true},
  			{name:'yak_cnt',		index:'yak_cnt',		width:90,	align:"center"},
  			{name:'del_btn',		index:'del_btn',		width:70,	align:"center"},
  			
  		],
		pager: "#groupGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",		
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		cellEdit : true,
		editurl : '/admin/item/medi/select_group.do',
		cellurl : '/admin/item/medi/update_col_group.do',
		multiselect: false,
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
		beforeEditCell : function(rowid, cellname, value, iRow, iCol){
		    selICol = iCol;
		    selIRow = iRow;
		},
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		loadComplete: function(data) {
			var rows = $("#groupGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#groupGrid").setCell(rows[i] , 'group_code', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				//$("#groupGrid").setCell(rows[i] , 'group_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				
				var yak_cnt = $("#groupGrid").getCell(rows[i],"yak_cnt");
				console.log('yak_cnt = ', yak_cnt);
				if(yak_cnt == 0){
					$("#groupGrid").setCell(rows[i] , 'del_btn', "[ 삭제 ]" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				}
				
			}
		},
		/*onSelectRow: function(row) {
			var data =$("#groupGrid").jqGrid('getRowData', row);
			var html = "<font color='blue'>["+data.group_name+"]</font>";
			setTimeout(function(){
				$("#nameGrid").setGridParam({"postData": data ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
				$("#nameGrid").jqGrid('setCaption',  html+ " 그룹 약재정보");
			},80);
			
		}*/
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('iCol =', iCol);
			
			var record = $("#groupGrid").jqGrid('getRowData', row);
			
			if(iCol == 1 || iCol == 3 || iCol == 4){
				var data =$("#groupGrid").jqGrid('getRowData', row);
				var html = "<font color='blue'>["+data.group_name+"]</font>";
				setTimeout(function(){
					$("#nameGrid").setGridParam({"postData": data ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
					$("#nameGrid").jqGrid('setCaption',  html+ " 그룹 약재정보");
				},80);
			}
			
			if(iCol == 4){
				
				console.log('record.del_btn 11= ', record.del_btn);
				
				if(record.del_btn == '[ 삭제 ]'){
					if(!confirm('삭제하겠습니까?')){
						return false;
					}
					
					 $.ajax({
					    url     : "/admin/item/medi/del_yak_group.do",
					    data    : record,
					    type    : 'POST',
					    success : function(data){
					        alert(data.msg);
					        if(data.suc){
					        	$("#groupGrid").trigger("reloadGrid");
					        	//$("#nameGrid").trigger("reloadGrid");
					        }
					    }   
					});
				 }
			}
		}
	});	
	$("#groupGrid").jqGrid('navGrid','#groupGridControl',
		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	);
	
	
	$("#nameGrid").jqGrid({
  		caption : '그룹 약재정보',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/admin/item/medi/select_name.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 5,
  		//rowList: [10],
  		//rowList: [3],
  		colNames:[
  			'번호','약재명', '약재코드', '원산지', '기본값', 
  			'g/당단가', '위치', '상태','방제사전등록건', 
  			'삭제','그룹코드', '그룹명' , 'yak_status'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true , hidden:true},
  			{name:'yak_name',		index:'yak_name',		width:220,	align:"left"},
  			{name:'yak_code',		index:'yak_code',		width:208,	align:"center"},
  			{name:'yak_from',		index:'yak_from',		width:116,	align:"center"},  			
  			{name:'yak_made',		index:'yak_made',		width:70,	align:"center"},
  			
  			{name:'yak_danga',		index:'yak_danga',		width:90,	align:"right",formatter: 'integer',formatoptions:{thousandsSeparator:","}},
  			{name:'yak_place',		index:'yak_place',		width:80,	align:"center"},
  			{name:'yak_status_nm',	index:'yak_status_nm',	width:116,	align:"center"},
  			{name:'dic_cnt',		index:'dic_cnt',		width:140,	align:"center"
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  				,sortable : false
  			},
  			
  			{name:'del_btn',		index:'del_btn',		width:116,	align:"center", sortable : false },
  			{name:'group_code',	index:'group_code',	width:416,	align:"left" , hidden:true},
  			{name:'group_name',	index:'group_name',	width:416,	align:"left" , hidden:true},
  			{name:'yak_status',	index:'yak_status',	width:416,	align:"left" , hidden:true},
  			
  		],
		pager: "#nameGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
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
			var rows = $("#nameGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#nameGrid").setCell(rows[i] , 'yak_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				
				
				var dic_cnt = $("#nameGrid").getCell(rows[i],"dic_cnt");
				if(dic_cnt > 0){
					$("#nameGrid").setCell(rows[i] , 'dic_cnt', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				}else{
					$("#nameGrid").setCell(rows[i] , 'dic_cnt', "" ,  null); // 특정 cell 색상변경
				}
				
				var yak_status = $("#nameGrid").getCell(rows[i],"yak_status");
				if(yak_status != 'y' && dic_cnt <= 0){
					console.log(yak_status , dic_cnt);
					$("#nameGrid").setCell(rows[i] , 'del_btn', "[ 삭제 ]" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				}
				
			}// for
		},
		
		onCellSelect : function(row,iCol,cellcontent,e){
			 console.log('iCol =', iCol);
			 var data = $("#nameGrid").jqGrid('getRowData', row);
			 if(iCol == 1){
				 var ret = $("#nameGrid").getRowData(row)
				 console.log('onCellSelect = ', ret );
				 name_mod(data);
			 }else if(iCol == 8){
				 if(data.dic_cnt > 0){
					 data.call_type = 'nameGrid';
					 $.ajax({
					    url     : "/admin/item/medi/dic_info.do",
					    data    : data,
					    type    : 'POST',
					    success : function(rtn){
					        $("#dic_update_form").html(rtn);
					        $("#dic_update_form" ).dialog( "open" );
					    }   
					});
				 }
			 }else if(iCol == 9){
				 
				 console.log('record.del_btn 999= ', data.del_btn);
				 
				 if(!confirm('삭제하겠습니까?')){
					 return false;
				 }
				 
				 if(data.del_btn == '[ 삭제 ]'){
					 $.ajax({
					    url     : "/admin/item/medi/del_yakjae.do",
					    data    : data,
					    type    : 'POST',
					    success : function(rtn){
					        alert(rtn.msg);
					        if(rtn.suc){
					        	$("#nameGrid").trigger("reloadGrid");
					        }
					    }   
					});
				 }
			 }
		},
	});	
	$("#nameGrid").jqGrid('navGrid','#nameGridControl',
		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	);
	
	
	$("#allGrid").jqGrid({
  		caption : '모든 약재정보21',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/admin/item/medi/select_all.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 20,
  		rowList: [20,50,100,500,1000],
  		colNames:[
  			'번호','약재명', '원산지',
  			'기본값','g/당단가',  '상태' , '약재설명','위치',
  			'그룹코드', '그룹명' ,'방제사전등록건', '약재코드' ,'약재이미지', '삭제'  
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true },
  			{name:'yak_name',		index:'yak_name',		width:200,	align:"left"},
  			{name:'yak_from',		index:'yak_from',		width:116,	align:"center"
  				,editable:true
  				,sortable : false
  			},  			
  			{name:'yak_made',		index:'yak_made',		width:70,	align:"center"
  				,editable:true
  				,sortable : false
  			},
  			{name:'yak_danga',		index:'yak_danga',		width:90,	align:"right"
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  				,editable:true
  				,sortable : false
  			},
  			
  			{name:'yak_status',	index:'yak_status',	width:116,	align:"center"
  				,editable:true
  				,sortable : false
  				,edittype:"select"
				,editoptions:{
  					value:"y:처방가능;n:약재품절;c:처방불가"
  				}
  				,formatter: 'select' 
  			},
  			{name:'yak_contents',	index:'yak_contents',	width:416,	align:"left" , hidden:true},
  			{name:'yak_place',		index:'yak_place',		width:80,	align:"center"
  				,editable:true
  				,sortable : false
  			},
  			
  			{name:'group_code',	index:'group_code',	width:416,	align:"left" , hidden:true},
  			{name:'group_name',	index:'group_name',	width:416,	align:"left" , hidden:true},
  			{name:'dic_cnt',		index:'dic_cnt',		width:140,	align:"center"
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  				,sortable : false
  			},
  			{name:'yak_code',		index:'yak_code',		width:208,	align:"center",sortable : false},
  			{name:'yak_image',		index:'yak_image',		width:116,	align:"center", formatter: getImgSrc,sortable : false },
  			{name:'del_btn',		index:'del_btn',		width:116,	align:"center", sortable : false },
  			
  		],
		pager: "#allGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		cellEdit : true,
		editurl : '/admin/item/medi/select_all.do',
		cellurl : '/admin/item/medi/update_col_yak.do',
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
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
			var rows = $("#allGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#allGrid").setCell(rows[i] , 'yak_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				
				var dic_cnt = $("#allGrid").getCell(rows[i],"dic_cnt");
				if(dic_cnt > 0){
					$("#allGrid").setCell(rows[i] , 'dic_cnt', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				}else{
					$("#allGrid").setCell(rows[i] , 'dic_cnt', "." ,  null); // 특정 cell 색상변경
				}
				
				var yak_status = $("#allGrid").getCell(rows[i],"yak_status");
				if(yak_status != 'y' && dic_cnt <= 0){
					console.log(yak_status , dic_cnt);
					$("#allGrid").setCell(rows[i] , 'del_btn', "[ 삭제 ]" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				}
				
			}// for
		},
		onCellSelect : function(row,iCol,cellcontent,e){
		     console.log(iCol);
		     var record = $("#allGrid").jqGrid('getRowData', row);
			 if(iCol == 1){
				 var ret = $("#allGrid").getRowData(row)
				 console.log('onCellSelect = ', ret );
				 name_mod(record);
			 }else if(iCol == 10){
				 if(record.dic_cnt > 0){
					 record.call_type = 'allGrid';
					 $.ajax({
					    url     : "/admin/item/medi/dic_info.do",
					    data    : record,
					    type    : 'POST',
					    success : function(data){
					        $("#dic_update_form").html(data);
					        $("#dic_update_form" ).dialog( "open" );
					    }   
					});
				 }
			 }else if(iCol == 13){
				 
				 console.log('record.del_btn 13= ', record.del_btn);
				 
				 if(record.del_btn == '[ 삭제 ]'){
					 
					 if(!confirm('삭제하겠습니까?')){
						 return false;
					 }
					 
					 $.ajax({
					    url     : "/admin/item/medi/del_yakjae.do",
					    data    : record,
					    type    : 'POST',
					    success : function(data){
					        alert(data.msg);
					        if(data.suc){
					        	$("#allGrid").trigger("reloadGrid");
					        }
					    }   
					});
				 }
			 }
		},
	});	
	$("#allGrid").jqGrid('navGrid','#allGridControl',
		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	);
	
	
	$('#group_addBtn').click(function() {
		$("#group_addForm" ).dialog( "open" );
	});
	
	$("#group_addForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 170,
        width: 350,
       // position: 'center',
        modal: true,
        title: '그룹명 추가',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           //$("#jqGrid").trigger("reloadGrid");
           	$("#update_form").html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#group_addForm").dialog('close'); 
        	});
        },
        buttons: {
            "저장": function () {
            	group_add();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
	
	
	
	$('#group_searchBtn').click(function() {
		var search_group_value = $('#search_group_value').val();
		var param ={
			search_value : search_group_value 
		};
		$("#groupGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
	});
	
	
	
	$('#all_searchBtn').click(function() {
		var search_all_value = $('#search_all_value').val();
		var search_all_title = $('#search_all_title').val();
		var param ={
			 search_value : search_all_value
			,search_title : search_all_title 
		};
		$("#allGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
	});
	
	
	
	$("#name_Form").dialog({
  		autoOpen: false,
        resizable: true,
        height: 570,
        width: 860,
       // position: 'center',
        modal: true,
        title: '약재명 추가',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$("#name_Form").html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#name_Form").dialog('close'); 
        	});
        },
        buttons: {
            "저장": function () {
            	a_name_add();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
	
	// 약재수정폼
	$("#name_mod_Form").dialog({
  		autoOpen: false,
        resizable: true,
        height: 670,
        width: 860,
       // position: 'center',
        modal: true,
        title: '약재명 수정',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$("#name_mod_Form").html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#name_mod_Form").dialog('close'); 
        	});
        },
        buttons: {
            "수정": function () {
            	a_name_mod();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
	
	// 약재 등록폼
	$('#name_addBtn').click(function() {
		
		var row = $("#groupGrid").jqGrid('getGridParam','selrow');
		
		if(row == null ||row == undefined){
			alert('그룹명 선택후에 약재정보를 신규등록 가능합니다.');
			return;
		}
		
		var sel_group = $("#groupGrid").jqGrid('getRowData', row);
		console.log('sel_group = ', sel_group);
		
		var params = {
			 search_group_code : sel_group.group_code
			,search_group_name : sel_group.group_name
		};
		
		$.ajax({
		    url     : "/admin/item/medi/name_add.do",
		    data    : params,
		    type    : 'POST',
		    success : function(data){
		        $("#name_Form").html(data);
		        $("#name_Form" ).dialog( "open" );
		    }   
		});
	});
	
	
	// 약재수정폼
	$("#dic_update_form").dialog({
  		autoOpen: false,
        resizable: true,
        height: 670,
        width: 860,
       // position: 'center',
        modal: true,
        title: '방제사전 약재정보',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$("#dic_update_form").html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#dic_update_form").dialog('close'); 
        	});
        },
        buttons: {
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
	
});

function name_mod(data){
	
	data.search_group_code = data.group_code;
	data.search_group_name = data.group_name;
	
	$.ajax({
	    url     : "/admin/item/medi/name_add.do",
	    data    : data,
	    type    : 'POST',
	    success : function(data){
	        $("#name_mod_Form").html(data);
	        $("#name_mod_Form" ).dialog( "open" );
	    }   
	});
}


function group_add(){
	var group_name =$('#a_group_name').val();
	if(group_name == ''){
		alert('약재 그룹명을 입력하세요.');
		return;
	}
	
	$.ajax({
	    url: "/admin/item/medi/group_add.do",
	    data : {
	    	group_name   : group_name	    	 
	    },
	    type: 'POST',
        error: function(){
	    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
	    },
	    success: function(data){
	    	alert(data.msg);
	    	
	    	if(data.suc){	    		
	    		$("#groupGrid").trigger("reloadGrid",[{page : 1}]);
	    		$('#group_addForm').dialog("close");
	    	}
	    }   
	});
}

// cell에 이미지 생성
function getImgSrc(cellValue, options, rowObject){
	
	if(cellValue != '' && cellValue != null && cellValue !=  undefined){
		return "<img src='/upload/item/"+cellValue+"' width='70px;' height='70px;' />";
	}else{
		return '';
	}
}