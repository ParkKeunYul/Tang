$(document).ready(function() {
	$("#cartGrid").jqGrid({
  		//caption : '모든 약재정보',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/m05/02_mycart_list.do?',
  		postData : {
  			search_sub_seqno : $('#search_sub_seqno').val()
  		},
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 20,				  	
  		colNames:[
  			'번호', '처방일자', '묶음' ,'환자명' , '처방명', 
  			'배송주소' ,'총금액' , '할인금액' , '결제금액' ,
  			'팩수',
  			
  			
  			'증상' , 'd_cnt' , 'c_tang_type' , 'bunch_cnt' , 'bunch_addr',
  			'c_pack_ea' ,'bunch_pack_ea' , 'd_type'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'wdate2',			index:'wdate2',		width:85,	align:"center" ,sortable : false},				  			
  			{name:'dBtn',			index:'dBtn',		width:60,	align:"center" ,sortable : false},
  			{name:'w_name',			index:'w_name',		width:100,	align:"center" ,sortable : false},
  			{name:'s_name',			index:'s_name',		width:270,	align:"left" ,sortable : false},
  			
  			{name:'full_d_to_addr',			 index:'full_d_to_addr'			,width:400,	align:"left" ,sortable : false},
  			{name:'order_total_price_temp'	,index:'order_total_price_temp'	,width:130,	align:"right" ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} ,sortable : false, hidden:true},
  			{name:'member_sale'		  		,index:'member_sale'			,width:100,	align:"right" ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} ,sortable : false, hidden:true},
  			{name:'order_total_price' 		,index:'order_total_price'		,width:100,	align:"right" ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} ,sortable : false},
  			
  			
  			{name:'c_pack_ea' 		,index:'c_pack_ea'		,width:60,	align:"center" ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} ,sortable : false},
  			
  			
  			
  			
  			
  			{name:'contents',			index:'contents',		width:10,	align:"center"  , hidden:true},
  			{name:'d_cnt',				index:'d_cnt',		width:10,	align:"center"  , hidden:true},
  			{name:'c_tang_type',				index:'c_tang_type',		width:10,	align:"center"  , hidden:true},
  			{name:'bunch_cnt',			index:'bunch_cnt',		width:10,	align:"center"  , hidden:true},
  			{name:'bunch_addr',			index:'bunch_addr',		width:10,	align:"center"  , hidden:true},
  			
  			{name:'c_pack_ea',			index:'c_pack_ea',		width:10,	align:"center"  , hidden:true},
  			{name:'bunch_pack_ea',		index:'bunch_pack_ea',		width:10,	align:"center"  , hidden:true},
  			{name:'d_type',		index:'d_type',		width:10,	align:"center"  , hidden:true},
  		],
		pager: "#cartGridControl",
		multiselect: true,
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
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
		onCellSelect : function(row,iCol,cellcontent,e){
			var data = $("#cartGrid").jqGrid('getRowData', row);
			if(iCol == 3){
				
				var dBtn = objToStr(data.dBtn, '');
				if(dBtn ==''){
					return;	
				}
				console.log(data);
				$.ajax({
					url : '/m05/02_add_bunch.do',
					type : 'POST',
					data : {
						seqno : data.seqno
					},
					error : function() {
						alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					},
					success : function(data) {
						alert(data.msg);
						if (data.suc) {
							$("#cartGrid").setGridParam({"postData": {} ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
							$("#bundleGrid").setGridParam({"postData": {} ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
						}
					}
				});
			}else if(iCol == 5){
				console.log('data5 = ', data);
				location.href='/m02/01_cart_update.do?cart_seqno='+data.seqno;
				
			}
		},
		loadComplete: function(data) {
			var rows = $("#cartGrid").getDataIDs();
			
			
			var mem_sub_grade    = objToStr( $('#mem_sub_grade').val(), '');
			
			var cart_tot_price = 0;
			
			for (var i = 0; i < rows.length; i++){
	    		var member_sale      		= parseInt($("#cartGrid").getCell(rows[i],"member_sale"));
	    		var order_total_price       = parseInt($("#cartGrid").getCell(rows[i],"order_total_price"));
	    		var order_total_price_temp  = member_sale + order_total_price;
	    		
	    		var order_total_price       = parseInt($("#cartGrid").getCell(rows[i],"order_total_price"));
	    		var full_d_to_addr 			= $("#cartGrid").getCell(rows[i],"full_d_to_addr");
	    		var c_tang_type 			= $("#cartGrid").getCell(rows[i],"c_tang_type");

	    		var bunch_cnt      			= parseInt($("#cartGrid").getCell(rows[i],"bunch_cnt")); 
	    		var bunch_addr      		= $("#cartGrid").getCell(rows[i],"bunch_addr");
	    		var c_pack_ea      			= parseInt($("#cartGrid").getCell(rows[i],"c_pack_ea"));
	    		var bunch_pack_ea      		= parseInt($("#cartGrid").getCell(rows[i],"bunch_pack_ea"));
	    		
	    		var d_type      		= parseInt($("#cartGrid").getCell(rows[i],"d_type"));
	    		
	    		
	    		console.log(d_type);
	    		
	    		var dBtn = '';
	    		var dBtnOpt = {};
	    		if(bunch_cnt  == 0 && d_type != 6){
	    			var d_cnt       = parseInt($("#cartGrid").getCell(rows[i],"d_cnt"));
		    		if(d_cnt > 1 && c_tang_type != '1' ){
		    			dBtn ='<span class="cB h20">묶음</span>';
		    			dBtnOpt = {cursor : 'pointer'};
		    		}
	    		}else if(bunch_cnt == 1 && d_type != 6){
	    			//if(full_d_to_addr == bunch_addr && c_tang_type != '1' && (c_pack_ea + bunch_pack_ea) <= 60){
	    			if(full_d_to_addr == bunch_addr && c_tang_type != '1' && (c_pack_ea ) <= 60){
	    				dBtn ='<span class="cB h20">묶음</span>';
	    				dBtnOpt = {cursor : 'pointer'};
	    			}
	    		}
	    							    		
	    		$("#cartGrid").setCell(rows[i] , 'dBtn', dBtn ,  dBtnOpt);
	    		$("#cartGrid").setCell(rows[i] , 's_name', '' ,  {padding:'0 0 0 10px',color:'#159aa4',cursor : 'pointer'});
	    		$("#cartGrid").setCell(rows[i] , 'full_d_to_addr', '' ,  '');
	    		
	    		
	    		if(mem_sub_grade == 2){
	    			$("#cartGrid").setCell(rows[i] , 'order_total_price', '******' ,  {padding:'0 10px 0 0'});
				}else{
					$("#cartGrid").setCell(rows[i] , 'order_total_price', '' ,  {padding:'0 10px 0 0'});
				}
	    		
	    		cart_tot_price += order_total_price;
			}// for
			
			$('#cart_tot_price').html( comma(cart_tot_price+'') );
			
		},
	});// cardGrid
	
	$('#cartDelBtn').click(function() {
		var row = $("#cartGrid").jqGrid('getGridParam','selarrrow');
		if( row.length <=0){
			alert('한개 이상 선택하세요.');
			return false;
		}
		
		for(var i = 0 ; i <row.length ; i++){
			var data =$("#cartGrid").jqGrid('getRowData', row[i]);
			if(i == 0){
				all_seqno  = data.seqno
			}else{
				all_seqno += ','+data.seqno	
			}
		}// for
		
		if(!confirm('삭제하시겠습니까?')){
			return false;
		}
		
		$.ajax({
			url : '/m05/02_del_cart.do',
			type : 'POST',
			data : {
				seqno : all_seqno
			},
			error : function() {
				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			},
			success : function(data) {
				if (data.suc) {
					$("#cartGrid").setGridParam({"postData": {} ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
					$("#bundleGrid").setGridParam({"postData": {} ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
				}
			}
		});
		
		return false;				
	});
	
	$('#orderType1Btn').click(function() {
		var row = $("#cartGrid").jqGrid('getGridParam','selarrrow');
		if( row.length <=0){
			alert('한개 이상 선택하세요.');
			return false;
		}
		
		for(var i = 0 ; i <row.length ; i++){
			var data =$("#cartGrid").jqGrid('getRowData', row[i]);
			if(i == 0){
				all_seqno  = data.seqno
			}else{
				all_seqno += ','+data.seqno	
			}
		}// for
		
		$('#all_seqno').val(all_seqno);
		
		$('#frm').submit();
		return false;
	});
	
	$("#bundleGrid").jqGrid({
  		//caption : '모든 약재정보',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/m05/02_mycart_bundle_list.do',
  		postData : {
  			search_sub_seqno : $('#search_sub_seqno').val()
  		},
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 20,				  	
  		colNames:[
  			'번호', '처방일자' ,'환자명' , '처방명', '배송주소' ,
  			'총금액' , '할인금액' , '결제금액' ,
  			
  			
  			'증상' , 'd_cnt' , 'c_tang_type' , '팩수'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'wdate2',			index:'wdate2',		width:85,	align:"center" ,sortable : false},				  			
  			{name:'w_name',			index:'w_name',		width:100,	align:"center" ,sortable : false},
  			{name:'s_name',			index:'s_name',		width:270,	align:"left" ,sortable : false},				  			
  			{name:'full_d_to_addr',	index:'full_d_to_addr'			,width:400,	align:"left" ,sortable : false},
  			
  			{name:'order_total_price_temp'	,index:'order_total_price_temp'	,width:130,	align:"right" ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} ,sortable : false, hidden:true},
  			{name:'member_sale'		  		,index:'member_sale'			,width:100,	align:"right" ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} ,sortable : false, hidden:true},
  			{name:'order_total_price' 		,index:'order_total_price'		,width:100,	align:"right" ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} ,sortable : false},
  			
  			{name:'contents',			index:'contents',		width:10,	align:"center"  , hidden:true},
  			{name:'d_cnt',				index:'d_cnt',		width:10,	align:"center"  , hidden:true},
  			{name:'c_tang_type',		index:'c_tang_type',		width:10,	align:"center"  , hidden:true},
  			{name:'c_pack_ea' 		,index:'c_pack_ea'		,width:60,	align:"center" ,formatter: 'integer' ,formatoptions:{thousandsSeparator:","} ,sortable : false}
  			
  		],
		pager: "#bundleGridControl",
		multiselect: true,
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
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
			var rows = $("#bundleGrid").getDataIDs();
			var cart_tot_price = 0;
			
			for (var i = 0; i < rows.length; i++){
	    		var member_sale      		= parseInt($("#bundleGrid").getCell(rows[i],"member_sale"));
	    		var order_total_price       = parseInt($("#bundleGrid").getCell(rows[i],"order_total_price"));
	    		var order_total_price_temp  = member_sale + order_total_price;
	    		
	    		var order_total_price       = parseInt($("#bundleGrid").getCell(rows[i],"order_total_price"));
	    		var full_d_to_addr 			= $("#bundleGrid").getCell(rows[i],"full_d_to_addr");
	    		
	    		$("#bundleGrid").setCell(rows[i] , 's_name', '' ,  {padding:'0 0 0 10px'});
	    		$("#bundleGrid").setCell(rows[i] , 'full_d_to_addr', '' ,  '');
	    		//$("#bundleGrid").setCell(rows[i] , 'order_total_price', '' ,  {padding:'0 10px 0 0'});
	    		
	    		var mem_sub_grade    = objToStr( $('#mem_sub_grade').val(), '');
	    		if(mem_sub_grade == 2){
	    			$("#bundleGrid").setCell(rows[i] , 'order_total_price', '******' ,  {padding:'0 10px 0 0'});
				}else{
					$("#bundleGrid").setCell(rows[i] , 'order_total_price', '' ,  {padding:'0 10px 0 0'});
				}
	    		
	    		cart_tot_price += order_total_price;
			}// for
			
			$('#bunch_cart_tot_price').html( comma(cart_tot_price+'') );
		},
		
	});// bundelGrid
	
	$('#cancelBtn').click(function() {
		var row = $("#bundleGrid").jqGrid('getGridParam','selarrrow');
		if( row.length <=0){
			alert('한개 이상 선택하세요.');
			return false;
		}
		
		for(var i = 0 ; i <row.length ; i++){
				var data =$("#bundleGrid").jqGrid('getRowData', row[i]);
				if(i == 0){
					all_seqno  = data.seqno
				}else{
					all_seqno += ','+data.seqno	
				}
			}// for
			
			$.ajax({
			url : '/m05/02_cancel_bunch.do',
			type : 'POST',
			data : {
				seqno : all_seqno
			},
			error : function() {
				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			},
			success : function(data) {
				alert(data.msg);
				if (data.suc) {
					$("#cartGrid").setGridParam({"postData": {} ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
					$("#bundleGrid").setGridParam({"postData": {} ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
				}
			}
		});
		
		return false;				
	});
	$('#orderPlusBtn').click(function() {
		var row = $("#bundleGrid").jqGrid('getGridParam','selarrrow');
		if( row.length !=2){
			alert('묶음배송은 주문상품 2개를 선택해야 합니다.');
			return false;
		}
		
		for(var i = 0 ; i <row.length ; i++){
				var data =$("#bundleGrid").jqGrid('getRowData', row[i]);
				if(i == 0){
					all_seqno  = data.seqno
				}else{
					all_seqno += ','+data.seqno	
				}
			}// for
			
		$('#all_plus_seqno').val(all_seqno);
			console.log($('#pfrm').attr('action'));
			$('#pfrm').submit();
		return false;
	});
	
	
	$('#search_sub_seqno').change(function() {
		$("#cartGrid").setGridParam({"postData": {search_sub_seqno : $(this).val()} ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
		$("#bundleGrid").setGridParam({"postData": {search_sub_seqno : $(this).val()} ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
	});
	
});