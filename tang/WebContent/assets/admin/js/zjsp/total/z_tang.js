$(document).ready(function() {
	$("#jqGrid").jqGrid({
  		//caption : '최근 로그인 정보',
  		//dataType : 'local', // 로딩시 최초 조회
  		datatype: 'json',
  		url : '/admin/total/tang/select.do',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 100000,
  		//rowList: [20,50,100,500],
  		//rowList: [3],
  		colNames:[
  			'mem_seqno', '한의원명'    , '주문횟수' , '<span style="font-weight:700;">총 주문금액</span>'   , '<span style="color:blue;">결제금액</span>' ,
  			'<span style="color:red;">할인금액</span>'   , '탕전금액'    , '주수상반' , '포장금액'     , '배달금액' , 
  			'<span style="font-weight:700;">약재금액</span>'   , '<span style="color:red;">약재할인금액</span>' , '<span style="color:blue;">약재결제금액</span>'
  		],
  		colModel:[
  			{name:'mem_seqno',		index:'mem_seqno',		width:48,	align:"center"  ,sortable : false ,hidden:true },
  			{name:'han_name',		index:'han_name',		width:200,	align:"left"  ,sortable : false},  			
  			{name:'cnt',			index:'cnt',			width:60,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			{name:'all_tot',		index:'all_tot',		width:90,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			{name:'order_tot',		index:'order_tot',		width:90,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			
  			{name:'sale_tot',		index:'sale_tot',		width:90,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			{name:'tang_tot',		index:'tang_tot',		width:90,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			{name:'jusu_tot',		index:'jusu_tot',		width:70,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			{name:'pojang_tot',		index:'pojang_tot',		width:90,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			{name:'delivery_tot',	index:'delivery_tot',	width:90,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			
  			{name:'yakjae_tot',		index:'yakjae_tot',		width:90,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			{name:'yakjae_sale_tot' ,index:'yakjae_sale_tot',width:90,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, },
  			{name:'yakjae_price_tot',index:'yakjae_price_tot',width:90,	align:"right"   ,sortable : false ,formatter: 'integer',formatoptions:{thousandsSeparator:","}, }
  			
  		],
		viewrecords: true,
		autowidth: true,				
		//sortname: 'seqno',
		//sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
		// cellEdit : true,
		loadComplete: function(data) {
			var rows = $("#jqGrid").getDataIDs();
			
			var  all_tot     = 0;
			var  order_tot   = 0;
			var  sale_tot    = 0;
			var  tang_tot    = 0;
			var  jusu_tot    = 0;
			
			var  pojang_tot       = 0;
			var  delivery_tot     = 0;
			var  yakjae_tot       = 0;
			var  yakjae_sale_tot  = 0;
			var  yakjae_price_tot = 0;
			
			for (var i = 0; i < rows.length; i++){
				all_tot           += new Number($("#jqGrid").getCell(rows[i],"all_tot"));
				order_tot         += new Number($("#jqGrid").getCell(rows[i],"order_tot"));
				sale_tot          += new Number($("#jqGrid").getCell(rows[i],"sale_tot"));
				tang_tot          += new Number($("#jqGrid").getCell(rows[i],"tang_tot"));
				jusu_tot          += new Number($("#jqGrid").getCell(rows[i],"jusu_tot"));
				
				pojang_tot        += new Number($("#jqGrid").getCell(rows[i],"pojang_tot"));
				delivery_tot      += new Number($("#jqGrid").getCell(rows[i],"delivery_tot"));
				yakjae_tot        += new Number($("#jqGrid").getCell(rows[i],"yakjae_tot"));
				yakjae_sale_tot   += new Number($("#jqGrid").getCell(rows[i],"yakjae_sale_tot"));
				yakjae_price_tot  += new Number($("#jqGrid").getCell(rows[i],"yakjae_price_tot"));
			}// for
			
			$('#all_tot').val( commaa( all_tot ) );
			$('#order_tot').val( commaa( order_tot ) );
			$('#sale_tot').val( commaa( sale_tot) );
			$('#tang_tot').val( commaa( tang_tot ) );
			$('#jusu_tot').val( commaa( jusu_tot ) );
			
			$('#pojang_tot').val( commaa( pojang_tot ) );
			$('#delivery_tot').val( commaa( delivery_tot ) );
			$('#yakjae_tot').val( commaa( yakjae_tot ) );
			$('#yakjae_sale_tot').val( commaa( yakjae_sale_tot) );
			$('#yakjae_price_tot').val( commaa( yakjae_price_tot ) );
			

		},
		onSelectRow : function(rowid, status, e){
			var record = $("#jqGrid").jqGrid('getRowData', rowid);
		}
	});
	
	$(".date").datepicker({});
	
	var today = getDay();
	$('#search_sday').val( today );
	$('#search_eday').val( today );
	
	
	$('#search_btn').click(function() {
		search();		
		return false;
	});
	
	$("#search_name").keydown(function(key) {
		if (key.keyCode == 13) {
			search();
		}
	});
	
	$("#export").on("click", function(){
		var search_sday    = $('#search_sday').val();
		var search_eday    = $('#search_eday').val();
		var search_name    = $('#search_name').val();
		
		location.href='excel.do?search_sday='+search_sday+"&search_eday="+search_eday+"&search_name="+search_name;
		
	});
	
	setTimeout(function(){
		search();	 
	},500);
});

function search(){
	var search_sday    = $('#search_sday').val();
	var search_eday    = $('#search_eday').val();
	var search_name    = $('#search_name').val();
	
	
	var param = { 
		 search_sday    : search_sday
		,search_eday    : search_eday
		,pageSearch     : 1
		,search_name    : search_name
	};
	
	$("#jqGrid").setGridParam({"postData": param ,datatype: "json", mtype: 'POST'}).trigger("reloadGrid",[{page : 1}]);
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

function commaa(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}