$(document).ready(function() {
	$("#jqGrid").jqGrid({
  		datatype: "local", 
  		url : '/m03/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: '99%',
  		height: "99%",
  		rowNum: 9,
  		colNames:[
  			'주문순번'  , '수취인','우편번호'  , '주소'  , '휴대폰',
  			'처방일' ,'적용'
  		],
  		colModel:[
  			{name:'seqno',		index:'seqno',			width:68,	align:"center"  ,sortable : false ,key: true  },
  			{name:'r_name',		index:'r_name',			width:100,	align:"center"  ,sortable : false },
  			{name:'r_zipcode',	index:'r_zipcode',		width:50,	align:"center"  ,sortable : false },
  			{name:'r_address',	index:'r_address',		width:270,	align:"left"  	,sortable : false },
  			{name:'r_handphone',index:'r_handphone',	width:120,	align:"center"  ,sortable : false },
  			
  			
  			{name:'order_date3', index:'order_date2',	width:80,	align:"center"  ,sortable : false},
  			{name:'btn',		 index:'btn',			width:60,	align:"center"  ,sortable : false}
  		],
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,				
		//sortname: 'seqno',
		//sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		multiselect: false,
		cellEdit : false,
		loadComplete: function(data) {
			var rows = $("#jqGrid").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		    	var a_btn = '<span class="cO h25">적용</span>';
		    	$("#jqGrid").setCell(rows[i] , 'btn', a_btn ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경									    										    	
		    }
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('iCol = ', iCol);
			if(iCol == 6){
				var data = $("#jqGrid").jqGrid('getRowData', row);	
				console.log('data = ', data);
				
				$('#r_address01').val( objToStr(data.r_address , '') );
				$('#r_zipcode').val( objToStr(data.r_zipcode , '') );
				
				var r_handphone = objToStr(data.r_handphone , '');
				if(r_handphone != ''){
					 var jbSplit = r_handphone.split('-');
					 $('#r_handphone01').val( jbSplit[0] );
					 $('#r_handphone02').val( jbSplit[1] );
					 $('#r_handphone03').val( jbSplit[2] );
						
				}else{
					$('#r_handphone01').val( '' );
					$('#r_handphone02').val( '' );
					$('#r_handphone03').val( '' );	
				}											
				$('#r_name').val( objToStr(data.r_name , '') );
				
				$('#r_address02').val('');
				setTimeout(function(){
					$('#r_address02').focus();						
		    	},50);
				$('.lately_wrap').fadeOut();
				
			}
		}
	});
	
	$("#jqGrid").jqGrid('navGrid','#jqGridControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
	
	$("#latelyCloseBtn").click(function() {
		$('.lately_wrap').hide();
		return false;
	});
	
	$("#search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			search();
		}
	});
	
	$("#searchBtn").click(function() {
		search();
		return false;
	});
});
	
function search(){
	var param = {
			 pageSearch   : 1
			,search_value : $('#search_value').val()
			,search_title : $('#search_title').val()
	};
	$("#jqGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}