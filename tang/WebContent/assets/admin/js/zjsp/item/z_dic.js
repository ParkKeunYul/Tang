$(document).ready(function() {
	$("#groupGrid").jqGrid({
  		caption : '출전 그룹 List',
  		dataType : 'local', // 로딩시 최초 조회 
  		/* data: mydata,
  		datatype: "local", */
  		url : '/admin/item/dic/select_group.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 5,
  		//rowList: [10],
  		//rowList: [3],
  		colNames:['번호','그룹코드', '그룹명'],
  		colModel:[
  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true , hidden:true},
  			{name:'b_code',			index:'b_code',		width:98,	align:"center"},
  			{name:'b_name',			index:'b_name',		width:116,	align:"center"},  			
  		],
		pager: "#groupGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'a_seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
		loadComplete: function(data) {
			var rows = $("#groupGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#groupGrid").setCell(rows[i] , 'b_code', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				$("#groupGrid").setCell(rows[i] , 'b_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			}
		},
		onSelectRow: function(row) {
			
			var data =$("#groupGrid").jqGrid('getRowData', row);
			var html = "<font color='blue'>["+data.b_name+"]</font>";
			setTimeout(function(){
				$("#nameGrid").setGridParam({"postData": data ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
				$("#nameGrid").jqGrid('setCaption',  html+ " 그룹 약재정보");
			},80);
		}
	});	
	$("#groupGrid").jqGrid('navGrid','#groupGridControl',
		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	);
	
	
	$("#nameGrid").jqGrid({
  		caption : '처방명 List',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/admin/item/dic/select_name.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 5,
  		//rowList: [10],
  		//rowList: [3],
  		colNames:[
  			'번호','처방명','관련조문', '적응중', '참고사항',  			
  			'그룹코드', '그룹명'
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'s_name',		index:'s_name',		width:220,	align:"left"},
  			{name:'s_jomun',	index:'s_jomun',	width:550,	align:"left"
  				/* ,editable:true 
  				,edittype:"textarea"
  				,editoptions : {
  					 row :20
  					,cols:50
  					,style:'height:100px;'
  				} */
  			},  			
  			{name:'s_jukeung',	index:'s_jukeung',	width:208,	align:"left" , hidden:true},
  			{name:'s_chamgo',	index:'s_chamgo',	width:158,	align:"left"},
  			
  			{name:'b_code',	index:'b_code',	width:416,	align:"left" , hidden:true},
  			{name:'b_name',	index:'b_name',	width:416,	align:"left" , hidden:true}
  		],
  		cellEdit : true,
		pager: "#nameGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
		loadComplete: function(data) {
			var rows = $("#nameGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#nameGrid").setCell(rows[i] , 's_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			}// for
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			 
			 if(iCol == 1){
				 var data = $("#nameGrid").jqGrid('getRowData', row);					
				 var ret = $("#nameGrid").getRowData(row)
				 console.log('onCellSelect = ', ret );
				 name_mod(data);
			 }
		},
	});	
	$("#nameGrid").jqGrid('navGrid','#nameGridControl',
		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	);
	
	
	$("#allGrid").jqGrid({
  		caption : '모든 처방정보',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/admin/item/dic/select_all.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 10,
  		rowList: [10, 20,30, 50 ,100],
  		//rowList: [3],
  		colNames:[
  			'번호','처방명','출전',  			
  			'조문','적응중','참고','처방코드','그룹코드'
  		],
  		colModel:[
  			{name:'seqno',	index:'seqno',	width:28,	align:"center" ,key: true , hidden:true},
  			{name:'s_name',	index:'s_name',	width:250,	align:"left"},
  			{name:'b_name',	index:'b_name',	width:130,	align:"left"  },
  			
  			{name:'s_jomun',	index:'s_jomun',	width:16,	align:"left" , hidden:true},
  			{name:'s_jukeung',	index:'s_jukeung',	width:16,	align:"left" , hidden:true},
  			{name:'s_chamgo',	index:'s_chamgo',	width:16,	align:"left" , hidden:true},
  			{name:'s_code',	index:'s_code',	width:16,	align:"left" , hidden:true},
  			{name:'b_code',	index:'b_code',	width:16,	align:"left" , hidden:true}
  		],
		pager: "#allGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'a_seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
		loadComplete: function(data) {
			var rows = $("#allGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#allGrid").setCell(rows[i] , 's_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				$("#allGrid").setCell(rows[i] , 'b_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			}// for
		},
		onSelectRow: function(row) {
			var data =$("#allGrid").jqGrid('getRowData', row);
			var html = "<font color='blue'>["+data.s_name+"]</font>";
			setTimeout(function(){
				$("#priceGrid").setGridParam({"postData": data ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
				$("#priceGrid").jqGrid('setCaption',  html+ " 처방 단가");
			},100);
			
		}
	});	
	$("#allGrid").jqGrid('navGrid','#allGridControl',
		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	);
	
	
	
	$("#priceGrid").jqGrid({
  		caption : '처방 단가',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/admin/item/dic/select_detail_price.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: 440,
  		height: "100%",
  		rowNum: 1000000,  		
  		//rowList: [3],
  		colNames:[
  			'번호','약재명','원산지','표준량', 'g당단가',
  			'단가',
  			
  			'처방코드','딕비코드' ,'약재그룹코드','약재코드'  
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'yak_name',	index:'yak_name',	width:150,	align:"left"},
  			{name:'yak_from',	index:'yak_from',	width:80,	align:"center"  },
  			{name:'dy_standard',index:'dy_standard',width:50,	align:"right" ,editable:true},
  			{name:'yak_danga',	index:'yak_danga',	width:50,	align:"right" },
  			
  			{name:'danga',		index:'danga',		width:50,	align:"right" },
  			
  			{name:'s_code',	index:'s_code',	width:16,	align:"left" , hidden:true},
  			{name:'b_code',	index:'b_code',	width:16,	align:"left" , hidden:true},
  			{name:'group_code',	index:'group_code',	width:16,	align:"left" , hidden:true},
  			{name:'yak_code',	index:'yak_code',	width:16,	align:"left" , hidden:true}
  		],
		pager: "#priceGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'a_seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		cellEdit : true,
		cellurl : '/admin/item/dic/price_update_stan.do',
		footerrow: true, 
		userDataOnFooter : true,
		loadComplete: function(data) {
			var rows = $("#priceGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#priceGrid").setCell(rows[i] , 'yak_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				
			}// for
			
			 /*서머리*/
		    var dy_standardSum = $("#priceGrid").jqGrid('getCol','dy_standard', false, 'sum');
		    var dangadSum 	   = $("#priceGrid").jqGrid('getCol','danga', false, 'sum');
		    var yak_dangaSum   = $("#priceGrid").jqGrid('getCol','yak_danga', false, 'sum');
		    var priceCnt 	   = $("#priceGrid").getGridParam("reccount");

		    
            $("#priceGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',dy_standard:dy_standardSum});
            $("#priceGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',danga:dangadSum});
            $("#priceGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',yak_danga:yak_dangaSum});
            
            //$("#priceGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',han_name:'총금액 : '});
            $("#priceGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',yak_from:'총 : '+priceCnt+'건'});
			
		},
		beforeSelectRow: function (rowid, e) {/*멀티 트루할때 개별 체크 안되는 현상 방지*/
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
		afterSaveCell: function(rowid,celname,value,iRow,iCol) {
			$("#priceGrid").trigger("reloadGrid",[{page : 1}]);
		},		
		onCellSelect : function(row,iCol,cellcontent,e){					 
			 var record = $("#priceGrid").jqGrid('getRowData', row);
			 console.log(record);
			 if(iCol == 2){
				  $.ajax({
				    url: "/admin/item/dic/dic_update_item.do",
				    data : record,
				    type : 'POST',
			        error: function(){
				    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				    },
				    success: function(data){
				        $("#price_update_form").html(data);
				        $("#price_update_form" ).dialog( "open" );
				    }   
				});	
			 }
		},
	});	
	
	
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
        title: '출전 그룹명 추가',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#a_b_name').val("");
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
	
	
	$('#name_searchBtn').click(function() {
		var search_name_value = $('#search_name_value').val();
		
		var row = $("#groupGrid").jqGrid('getGridParam','selrow');
		if(row == null ||row == undefined){
			alert('출전 그룹 선택후에  처방명 검색이 가능합니다.');
			return;
		}
		
		var param ={
			 search_value : search_name_value
			,b_code       : row.b_code
		};
		$("#nameGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
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
        height: 470,
        width: 1000,
       // position: 'center',
        modal: true,
        title: '처방명 추가',
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
        height: 470,
        width: 1000,
       // position: 'center',
        modal: true,
        title: '처방명 수정',
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
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
	
	// 약재 등록폼
	$('#name_addBtn').click(function() {
		
		var row = $("#groupGrid").jqGrid('getGridParam','selrow');
		
		if(row == null ||row == undefined){
			alert('출전그룹 선택후에 처방 신규등록 가능합니다.');
			return;
		}
		
		var sel_group = $("#groupGrid").jqGrid('getRowData', row);
		console.log('sel_group = ', sel_group);
		
		var params = {
			 search_b_code : sel_group.b_code
			,search_b_name : sel_group.b_name
		};
		
		$.ajax({
		    url     : "/admin/item/dic/name_add.do",
		    data    : params,
		    type    : 'POST',
		    success : function(data){
		        $("#name_Form").html(data);
		        $("#name_Form" ).dialog( "open" );
		    }   
		});
	});
	
	
	//단가 수정 폼
	$("#price_update_form").dialog({
  		autoOpen: false,
        resizable: true,
        height: 500,
        width: 700,
       // position: 'center',
        modal: true,
        title: '단가 항목 교체',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#price_update_form').html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#price_update_form").dialog('close'); 
        	});
        },
        buttons: {
            /* "수정": function () {
            	price_item_update();
            }, */
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
	
	
	$('#priceItemDelBtn').click(function() {
		var row = $("#priceGrid").jqGrid('getGridParam','selarrrow');
		console.log(row.length);
		if( row.length > 0 ){		
			
			for(var i = 0 ; i <row.length ; i++){
				var data =$("#priceGrid").jqGrid('getRowData', row[i]);
				if(i == 0){
					all_seqno  = data.seqno
				}else{
					all_seqno += ','+data.seqno	
				}
			}// for
			

			console.log('data.a_seqno = ', data.a_seqno);
			data.seqno = all_seqno
			console.log('data.a_seqno = ', data.a_seqno);
		
			
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
				url     		  : "/admin/item/dic/dic_del_item_proc.do",
			    savekey           : [true, 13],
			    closeOnEscape     : true,
			    reloadAfterSubmit : true,
			    delData           : data		
			}
			$("#priceGrid").jqGrid('delGridRow',row[0],option);	
			
			
		}else{
			alert('삭제할 데이터를 선택하세요.');
		}
	});
	
	
	$("#allGridYak").jqGrid({
  		caption : '처방에 추가할수 있는 약재 정보',
  		url : '/admin/item/medi/select_all.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 5,
  		
  		colNames:[
  			'번호','약재명','약재코드', '원산지',
  			'기본값','g/당단가', '위치', '상태' , '약재설명',
  			'그룹코드', '그룹명'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true , hidden:true},
  			{name:'yak_name',		index:'yak_name',		width:200,	align:"left"},
  			
  			{name:'yak_code',		index:'yak_code',		width:208,	align:"center", hidden:true},
  			{name:'yak_from',		index:'yak_from',		width:116,	align:"center"},  			
  			{name:'yak_made',		index:'yak_made',		width:70,	align:"center"},
  			{name:'yak_danga',		index:'yak_danga',		width:90,	align:"right",formatter: 'integer',formatoptions:{thousandsSeparator:","}},
  			{name:'yak_place',		index:'yak_place',		width:80,	align:"center", hidden:true},
  			{name:'yak_status_nm',	index:'yak_status_nm',	width:116,	align:"center"},
  			{name:'yak_contents',	index:'yak_contents',	width:416,	align:"left", hidden:true},
  			
  			{name:'group_code',	index:'group_code',	width:416,	align:"left" , hidden:true},
  			{name:'group_name',	index:'group_name',	width:416,	align:"left" , hidden:true}
  		],
		pager: "#allGridYakControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		loadComplete: function(data) {
			var rows = $("#allGridYak").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#allGridYak").setCell(rows[i] , 'yak_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			}// for
		},
		onSelectRow: function(row) {
			var all_row = $("#allGrid").jqGrid('getGridParam','selrow');
			if(all_row == null || all_row == undefined){
				alert('처방정보를 선택후에 처방항목단가 추가를 하실수 있습니다.');
				return;
			}			
			var sel_all = $("#allGrid").jqGrid('getRowData', all_row);
			//console.log('sel_all= ', sel_all);
			
			var data =$("#allGridYak").jqGrid('getRowData', row);
			//console.log('data= ', data);
			var flag = confirm("선택된 ["+data.yak_name+"] 약재를 추가하겠습니까?");
			if(!flag){
				return;
			}
			
			var param = {
				 dy_name : data.yak_name
				,dy_from : data.yak_from			
				,dy_code : data.yak_code
				,b_code	 : sel_all.b_code
				,s_code  : sel_all.s_code
			}
			
			 $.ajax({
			    url: '/admin/item/dic/dic_add_item_proc.do',
			    data : param,
			    type : 'POST',
		        error: function(){
			    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			    },
			    success: function(data){
			       if(!data.suc){
			    	   alert(data.msg);
			       }else{
			    	 //  $("#priceGrid").trigger("reloadGrid");
			    	   $("#priceGrid").setGridParam({"postData": sel_all ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
			       }
			    }   
			});	
			
		}
	});	
	$("#allGridYak").jqGrid('navGrid','#allGridYakControl',
		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	);
	
	$('#addPriceSearchBtn').click(function() {
		var search_all_value = $('#addPrice_search_value').val();
		var search_all_title = $('#addPrice_search_title').val();
		var param ={
			 search_value : search_all_value
			,search_title : search_all_title 
		};
		$("#allGridYak").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
	});
	
	
});

function name_mod(data){
	
	data.search_b_code = data.b_code;
	data.search_b_name = data.b_name;
	
	$.ajax({
	    url     : "/admin/item/dic/name_add.do",
	    data    : data,
	    type    : 'POST',
	    success : function(data){
	        $("#name_mod_Form").html(data);
	        $("#name_mod_Form" ).dialog( "open" );
	    }   
	});
}


function group_add(){
	var a_b_name =$('#a_b_name').val();
	if(a_b_name == ''){
		alert('출전 그룹명을 입력하세요.');
		return;
	}
	
	$.ajax({
	    url: "/admin/item/dic/group_add.do",
	    data : {
	    	b_name   : a_b_name	    	 
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