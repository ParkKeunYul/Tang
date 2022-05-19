var addDialog = {
	   addCaption: "관리자 등록"                            
      ,bSubmit: "등록"
      ,url: '/admin/base/manage/add.do'
      ,closeAfterAdd: true
      ,closeOnEscape: true
      //,resizable : true
      ,modal: true                           //모달창
      ,savekey : [true, 13]               //enter키  
      ,recreateForm:true                 //수정 및 등록 시 폼 재생성 - 필수
      ,width: "850"
      ,height: "400" 
      ,beforeInitData: function(formid) {
    	  console.log('beforeInitData = ',formid );
          //$("#grid").jqGrid('setColProp','adminID',{editable:true});
          //$("#grid").jqGrid('setColProp','adminName',{editable:true});
      }
      ,afterShowForm: function (formid) {
    	  console.log('afterShowForm = ',formid );
   		 //$("#grid").jqGrid('setColProp','adminID',{editable:false});
         //$("#grid").jqGrid('setColProp','adminName',{editable:false});
     },
     buttons: {
    	  "SUBMIT": function() { 
    	    $("form").submit();
    	  }, 
    	  "CANCEL": function() { 
    	    $(this).dialog("close");
    	  } 
    },
    close: function() {
      console.log('close');
    },
    open: function(event, ui) { 
    	$('.ui-widget-overlay').bind('click', function(){
    		console.log(1111111111);
    		$("#add_form").dialog('close'); 
    	});
    }

};   


$(document).ready(function() {
	
	  	$("#jqGrid").jqGrid({
	  		//caption : '탕전 관리자 목록',
	  		dataType : 'local', // 로딩시 최초 조회 
	  		/* data: mydata,
	  		datatype: "local", */
	  		url : '/admin/base/manage/select.do',
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 20,
	  		rowList: [1,2,20,5,500],
	  		//rowList: [3],
	  		colNames:['번호','아이디', '관리자이름', '등급','이메일' ,'등록일'],
	  		colModel:[
	  			{name:'a_seqno',		index:'a_seqno',	width:28,	align:"center"},
	  			{name:'a_id',			index:'a_id',		width:98,	align:"center"},
	  			{name:'a_name',			index:'a_name',		width:116,	align:"center"},
	  			{name:'a_level',		index:'a_level',	width:116,	align:"center"},
	  			{name:'a_email',		index:'a_email',	width:116,	align:"center"},
	  			{name:'a_date',			index:'a_date',		width:98,	align:"center" /* ,sorttype:"date" */}
	  		],
			pager: "#jqGridControl",
			viewrecords: true,
			autowidth: true,
			sortname: 'a_seqno',
			sortorder: "desc",
			viewrecords: true,
			loadtext  : '데이터를 불러오는중입니다.',
			emptyrecords  : '검색된 데이터가 없습니다',
			multiselect: true,
			// cellEdit : true,
			
			onCellSelect : function(row,iCol,cellcontent,e){
				   					 
				 if(iCol == 2){
					 var data = $("#jqGrid").jqGrid('getRowData', row);					
					 var ret = $("#jqGrid").getRowData(row)
					 console.log('onCellSelect = ', ret );
					 mod(data);					
					 					 
					 
				 }
			},
			/*
			 onSelectRow: function(row) {
				var data =$("#jqGrid").jqGrid('getRowData', row);
				
				console.log('onSelectRow = ', data);
				mod(data);
			}, */
			/* ondblClickRow: function (rowid, iRow, iCol) {
				
				if(iCol == 1){
					
				}
			}, */
			loadComplete: function(data) {
				//console.log('loadComplete = ', data);
				var rows = $("#jqGrid").getDataIDs(); 				
			    for (var i = 0; i < rows.length; i++){
			        
			    	
			    	
			    	$("#jqGrid").setCell(rows[i] , 'a_id', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	
			    	/* var a_id = $("#jqGrid").getCell(rows[i],"a_id");
			        if(a_id == "shoutoe"){
			            $("#jqGrid").jqGrid('setRowData',rows[i],'a_id', {color:'blue',weightfont:'bold'}); // 로우 색상변경
			        } */
			    }
			}
			
			// 추가,삭제 ,수정시 사용?
			,editurl: '/admin/base/manage/select',
		});
	  	
	  	//페이지 넘 
	  	$("#jqGrid").jqGrid('navGrid','#jqGridControl',
	  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	  	);
	  	
	  	
	  	$("#add_form").dialog({
	  		autoOpen: false,
            resizable: true,
            height: 650,
            width: 850,
           // position: 'center',
            modal: true,
            title: '관리가 추가',
            beforeClose: function(event, ui) { 
               console.log('beforeClose');
            },
            close : function(){            
            //	$("#jqGrid").trigger("reloadGrid");
            	$("#add_form").html("");
            },
            open: function(event, ui) { 
            	$('.ui-widget-overlay').bind('click', function(){
            		console.log(1111111111);
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
	  	
	  	$("#update_form").dialog({
	  		autoOpen: false,
            resizable: true,
            height: 650,
            width: 850,
           // position: 'center',
            modal: true,
            title: '관리자 수정',
            beforeClose: function(event, ui) { 
               console.log('beforeClose');
            },
            close : function(){            
               //$("#jqGrid").trigger("reloadGrid");
               	$("#update_form").html("");
            },
            open: function(event, ui) { 
            	$('.ui-widget-overlay').bind('click', function(){
            		$("#update_form").dialog('close'); 
            	});
            },
            buttons: {
                "수정": function () {
                	manage_mod();
                },
                "닫기": function () {
                    $(this).dialog("close");
                }
            }		
	  	});
});



/* $("#mainGrid").jqGrid("addRowData", rowId+1, rowData, 'first'); // 첫 행에 Row 추가
$("#mainGrid").jqGrid("addRowData", rowId+1, rowData, 'last'); // 마지막 행에 Row 추가 */


function close(){
	$(this).dialog("close");
}

function aaa(){
//	console.log('aaa', 111);
//	jQuery("#jqGrid").trigger("reloadGrid");
		
	var a_id = $('#search_a_id').val();
		
	var param = { 
		a_id       : a_id 
	   ,param11    :'222222222222'
	   ,pageSearch : 1
	};
	
	$("#jqGrid").setGridParam({"postData": param }).trigger("reloadGrid",[{page : 1}]);
}

function add(){
	$.ajax({
	    url: "/admin/base/manage/add.do",
	    success: function(data){
	        $("#add_form").html(data);
	        $("#add_form" ).dialog( "open" );
	    }   
	});
}

function mod(data){
	$.ajax({
	    url: "/admin/base/manage/mod.do",
	    data : {
	    	  a_id    : data.a_id
	    	 ,a_seqno : data.a_seqno 
	    },        
        error: function(){
	    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
	    },
	    success: function(data){
	    	console.log('222222');
	        $("#update_form").html(data);
	        $("#update_form" ).dialog( "open" );
	    }   
	});
}

function del(){
	var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
	console.log(row.length);
	if( row.length > 0 ){		
		
		for(var i = 0 ; i <row.length ; i++){
			var data =$("#jqGrid").jqGrid('getRowData', row[i]);
			if(i == 0){
				all_seqno  = data.a_seqno
			}else{
				all_seqno += ','+data.a_seqno	
			}
		}// for
		

		console.log('data.a_seqno = ', data.a_seqno);
		data.a_seqno = all_seqno
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
		    url               : "/admin/base/manage/del.do",
		    savekey           : [true, 13],
		    closeOnEscape     : true,
		    reloadAfterSubmit : true,
		    delData           : data		
		}
		
		
		$("#jqGrid").jqGrid('delGridRow',row[0],option);	
		
		
		
	}else{
		alert('삭제할 데이터를 선택하세요.');
	}
	
}