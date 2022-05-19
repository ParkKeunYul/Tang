$(document).ready(function() {
		
		$("#allGrid").jqGrid({
	  		caption : '모든 약재정보 <span style="color:red;">(약재를 선택후 입고 정보를 입력할수 있습니다.)</span>',
	  		//dataType : 'local', // 로딩시 최초 조회   		
	  		url : '/admin/item/medi/select_all.do',
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 25,
	  		rowList: [10, 25 , 50 , 100],
	  		//rowList: [3],
	  		colNames:[
	  			'번호','약재명','약재이미지', '약재코드', '원산지',
	  			'기본값','g/당단가', '위치', '상태' , '약재설명',
	  			'그룹코드', '그룹명'
	  		],
	  		colModel:[
	  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true , hidden:true},
	  			{name:'yak_name',		index:'yak_name',		width:200,	align:"left"},
	  			{name:'yak_image',		index:'yak_image',		width:116,	align:"center", formatter: getImgSrc  , hidden:true},
	  			{name:'yak_code',		index:'yak_code',		width:208,	align:"left"},
	  			{name:'yak_from',		index:'yak_from',		width:116,	align:"center"},  			
	  			
	  			{name:'yak_made',		index:'yak_made',		width:70,	align:"center"
	  				,editable:true
	  			},
	  			{name:'yak_danga',		index:'yak_danga',		width:90,	align:"right"
	  				,formatter: 'integer',formatoptions:{thousandsSeparator:","}
	  				,editable:true
	  			},
	  			{name:'yak_place',		index:'yak_place',		width:80,	align:"center",editable:true},
	  			{name:'yak_status',		index:'yak_status',	width:116,	align:"center" 
	  				,editable:true
	  				,edittype:"select"
	  				,editoptions:{
	  					 value:"y:처방가능;n:처방불가"  						
	  				}		  				
	  				,formatter: 'select'
	  			},
	  			{name:'yak_contents',	index:'yak_contents',	width:416,	align:"left" , hidden:true},
	  			
	  			{name:'group_code',	index:'group_code',	width:416,	align:"left" , hidden:true},
	  			{name:'group_name',	index:'group_name',	width:416,	align:"left" , hidden:true}
	  		],
			pager: "#allGridControl",
			viewrecords: true,
			autowidth: true,
			sortname: 'a_seqno',
			sortorder: "desc",
			viewrecords: true,
			loadtext  : '데이터를 불러오는중입니다.',
			emptyrecords  : '검색된 데이터가 없습니다',
			cellEdit : true,
			cellurl : '/admin/item/medi/update_col_yak.do',
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
			beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
				console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
				return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
			},
			loadComplete: function(data) {
				var rows = $("#allGrid").getDataIDs();
				for (var i = 0; i < rows.length; i++){
					$("#allGrid").setCell(rows[i] , 'yak_name', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
				}// for
			},
			onCellSelect : function(row,iCol,cellcontent,e){
				//console.log('onCellSelect = ', iCol);
				 if(iCol == 1){
					 var data = $("#allGrid").jqGrid('getRowData', row);					
					 var param = $("#allGrid").getRowData(row)
					 
					 param.yak_seqno = param.seqno;
					 var html = "<font color='blue'>["+param.yak_name+"]</font>";
					 $("#invenGrid").jqGrid('setCaption',  html+ " 약재 입고정보");
					 $("#invenGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
					 
					 
					// console.log('param = ', param);
					 $('#a_yak_name').html(param.yak_name);
					 $('#a_yak_seqno').val(param.seqno);
					 $('#a_yak_code').val(param.yak_code);
					 
					 $('.input_form').slideDown();
				 }
			},
		});	
		$("#allGrid").jqGrid('navGrid','#allGridControl',
			{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
		);
		
		$('#all_searchBtn').click(function() {
			search_all();
		});
		
		$("#invenGrid").jqGrid({
	  		caption : '약재 입고정보',
	  		//dataType : 'local', // 로딩시 최초 조회   		
	  		url : 'select.do',
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 10,
	  		rowList: [10, 25 , 50 , 100 , 10000],
	  		//rowList: [3],
	  		colNames:[
	  			'번호','입고일','입고 수량(g)', '등록자' , '등록일'
	  		],
	  		colModel:[
	  			{name:'seqno',			index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
	  			{name:'add_date',		index:'add_date',	width:200,	align:"center"
	  				,editable:true
	  				,editoptions: { 
	  					dataInit: function (elem) { 
	  						$(elem).datepicker({
	  							dateFormat: 'yy-mm-dd'
	  						}); 
	  					} 
	  				}
	  			},
	  			{name:'ea',				index:'ea',			width:100,	align:"right",
	  				editable:true,
	  				formatter: 'integer', 
	  				formatoptions:{thousandsSeparator:","}, 
	  				summaryType:'sum',
	  			},
	  			{name:'a_id',			index:'a_id',		width:100,	align:"center"},
	  			{name:'wdate2',			index:'wdate2',		width:200,	align:"center"}
	  		],
			pager: "#invenGridControl",
			viewrecords: true,
			autowidth: true,
			sortname: 'a_seqno',
			sortorder: "desc",
			viewrecords: true,
			loadtext  : '데이터를 불러오는중입니다.',
			emptyrecords  : '검색된 데이터가 없습니다',
			footerrow: true, 
			userDataOnFooter : true,
			multiselect: true,
			cellEdit : true,
			cellurl : 'update_col.do',
			//editurl : 'select.do',
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
				}// for
				
				var tot_ea = $("#invenGrid").jqGrid('getCol','ea', false, 'sum');
			    var cnt    = $("#invenGrid").getGridParam("reccount");
			    
			    $("#invenGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',ea:tot_ea});
                $("#invenGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',add_date:'총 : '+cnt+'건'});
			},
			onCellSelect : function(row,iCol,cellcontent,e){
				console.log('onCellSelect = ', iCol);
				 if(iCol == 1){
					 var data = $("#allGrid").jqGrid('getRowData', row);					
					 var ret = $("#allGrid").getRowData(row)
					 console.log('onCellSelect = ', ret );
					
				 }
			},
			beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
				console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
				return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
			},
			afterSubmitCell : function(res) {  
				try{
					if(res.responseJSON.suc){
						$("#invenGrid").trigger("reloadGrid",[{page : 1}]);
					}	
				}catch (e) {
					console.log('afterSubmitCell err');
				}
			}
		});
		
		$('#delBtn').click(function() {
	  		var row = $("#invenGrid").jqGrid('getGridParam','selarrrow');
	  		console.log(row.length);
	  		if( row.length > 0 ){		
	  			
	  			for(var i = 0 ; i <row.length ; i++){
	  				var data =$("#invenGrid").jqGrid('getRowData', row[i]);
	  				if(i == 0){
	  					all_seqno  = data.seqno
	  				}else{
	  					all_seqno += ','+data.seqno	
	  				}
	  			}// for
	  			

	  			console.log('data.a_seqno = ', data.seqno);
	  			data.seqno = all_seqno
	  			console.log('data.a_seqno = ', data.seqno);
	  		
	  			
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
	  			
	  			console.log('data = ', data);
	  			
	  			$("#invenGrid").jqGrid('delGridRow',row[0],option);	
	  			
	  		}else{
	  			alert('삭제할 수량을 선택하세요.');
	  		}
	  	});
		
		
		$(".date").datepicker({});
		
		$('#a_add_date').val(getDay());
		
		
		$('#yakAddBtn').click(function(){
			onAdd();
		});
		
	});
	
	function onAdd(){
		if(! valCheck('a_ea','입고수량을 입력하세요.')){
			return;
		}
		
		if(! valNum('a_ea')){
			return;
		}
		
		if(!confirm('저장하겠습니까?')){
			return false;
		}
		
		$.ajax({
		    url  : 'add_proc.do',
		    type : "POST",
		    data : $("#addFrm").serialize(),
		    error: function(){
		    	alert('에러가 발생했습니다. 관리자에 문의하세요.');
		    },
		    success: function(data){
				alert(data.msg);
				if(data.suc){
					$("#invenGrid").trigger("reloadGrid",[{page : 1}]);
					$('#a_add_date').val(getDay());
					$('#a_ea').val(0);
				}
		    }
		});
	}
	
	function search_all(){
		var search_all_value = $('#search_all_value').val();
		var search_all_title = $('#search_all_title').val();
		var param ={
			 search_value : search_all_value
			,search_title : search_all_title 
		};
		$("#allGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
	}
	
	// cell에 이미지 생성
	function getImgSrc(cellValue, options, rowObject){
		
		if(cellValue != '' && cellValue != null && cellValue !=  undefined){
			return "<img src='/upload/item/"+cellValue+"' width='70px;' height='70px;' />";
		}else{
			return '';
		}
	}
	
	function getDay(){
		var d = new Date();
		
		var year  = d.getFullYear();
		var month = (d.getMonth() + 1);
		var day   = d.getDate();
		var hh =  d.getHours();
		var mm =  d.getMinutes();
		var ss =  d.getSeconds();
		
		if(month<10){
			month = '0'+ month;
		}
		if(day<10){
			day = '0'+ day;
		}
		if(hh<10){
			hh = '0'+ hh;
		}
		if(mm<10){
			mm = '0'+ mm;
		}
		if(ss<10){
			ss = '0'+ ss;
		}

		return year +'-'+month+'-'+day;
	}