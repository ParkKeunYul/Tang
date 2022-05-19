$(document).ready(function() {
	$("#layelyPop").jqGrid({
  		datatype: "local", 
  		url : '/m02/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: '99%',
  		height: "99%",
  		rowNum: 9,
  		colNames:[
  			'주문순번'  , '수취인','우편번호'  , '주소'  , '휴대폰',
  			'처방일' ,'적용' , 'd_to_address01' , 'd_to_address02'
  		],
  		colModel:[
  			{name:'seqno',		   index:'seqno',			width:68,	align:"center"  ,sortable : false ,key: true  },
  			{name:'d_to_name',		index:'d_to_name',			width:100,	align:"center"  ,sortable : false },
  			{name:'d_to_zipcode',	index:'d_to_zipcode',		width:50,	align:"center"  ,sortable : false },
  			{name:'d_to_address',	index:'d_to_address',		width:270,	align:"left"  	,sortable : false },
  			{name:'d_to_handphone', index:'d_to_handphone',	width:120,	align:"center"  ,sortable : false },
  			
  			
  			{name:'order_date3', index:'order_date2',	width:80,	align:"center"  ,sortable : false},
  			{name:'btn',		 index:'btn',			width:60,	align:"center"  ,sortable : false},
  			
  			{name:'d_to_address01',	index:'d_to_address01',		width:270,	align:"left"  	,sortable : false, hidden:true },
  			{name:'d_to_address02',	index:'d_to_address02',		width:270,	align:"left"  	,sortable : false, hidden:true },
  		],
		pager: "#layelyPopControl",
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
			var rows = $("#layelyPop").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		    	var a_btn = '<span class="cO h25">적용</span>';
		    	$("#layelyPop").setCell(rows[i] , 'btn', a_btn ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경									    										    	
		    }
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('iCol = ', iCol);
			if(iCol == 6){
				var data = $("#layelyPop").jqGrid('getRowData', row);	
				console.log('data = ', data);
				
				$('#d_to_address01').val( objToStr(data.d_to_address01 , '') );
				$('#d_to_address02').val( objToStr(data.d_to_address02 , '') );
				$('#d_to_zipcode01').val( objToStr(data.d_to_zipcode , '') );
				
				var d_to_handphone = objToStr(data.d_to_handphone , '');
				if(d_to_handphone != ''){
					 var jbSplit = d_to_handphone.split('-');
					 $('#d_to_handphone01').val( jbSplit[0] );
					 $('#d_to_handphone02').val( jbSplit[1] );
					 $('#d_to_handphone03').val( jbSplit[2] );
						
				}else{
					$('#d_to_handphone01').val( '' );
					$('#d_to_handphone02').val( '' );
					$('#d_to_handphone03').val( '' );	
				}											
				$('#d_to_name').val( objToStr(data.d_to_name , '') );
				$('.lately_wrap').fadeOut();
			}
		}
	});
	
	$("#layelyPop").jqGrid('navGrid','#layelyPopControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
	
	$("#latelyCloseBtn").click(function() {
		$('.lately_wrap').hide();
		return false;
	});
	
	$("#searchBtn").click(function() {
		search();
		return false;
	});
	
	$("#search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			search();
		}
	});
});

function search(){
	var param = {
			 pageSearch   : 1
			,search_value : $('#search_value').val()
			,search_title : $('#search_title').val()
	};
	$("#layelyPop").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}