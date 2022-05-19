$(document).ready(function() {
		
  	$("#jqGrid").jqGrid({
  		url : '/admin/order/shop/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 50,
  		rowList: [20,50,100,500,1000,10000],
  		colNames:[
  			'순번'    , '경로'  ,'주문번호' , '상품명'   , '주문자' , 
  			'등급'    ,'한의원명'  ,'수취인' , '금액'    ,'입금'   ,
  			'결제방법' ,'계산서'  ,'주문일'   , '상태'    ,'송장'  , 
  			'알림톡'  , 'tot_cnt' ,'cancel_ing' , 'tak_sel_id' ,'temple_no',
  			'order_handphone','delivery_date2'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',			width:128,	align:"center"  ,sortable : false  , hidden:true},		  					  			
  			{name:'seqno',			index:'seqno',			width:60,	align:"center"  ,sortable : false , hidden:true},
  			{name:'order_no',		index:'order_no',		width:120,	align:"center"  ,sortable : false ,key: true},
  			{name:'goods_name',		index:'goods_name',		width:350,	align:"left"    ,sortable : false},
  			{name:'order_name',		index:'order_name',		width:100,	align:"center"  ,sortable : false},
  			
  			{name:'member_level',	index:'member_level',	width:100,	align:"center"    ,sortable : false
  				,editable:false 
  				,edittype:"select"
  				,editoptions:{
  					value:mem_code
  				}
  				,formatter: 'select' 
  			},
  			{name:'r_name',			index:'r_name',			width:150,	align:"left"    ,sortable : false},
  			{name:'o_name',			index:'o_name',			width:150,	align:"left"    ,sortable : false},
  			{name:'all_price',		index:'all_price',		width:70,	align:"right"   ,sortable : false,
  				formatter: 'integer', 
  				formatoptions:{thousandsSeparator:","}
  			},
  			{name:'pay_ing',		index:'pay_ing',		width:100,	align:"center"   ,sortable : false
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					value:"1:입금;2:미입금;3:방문결제;4:증정",
  					/* dataEvents: [{type: 'change', fn: function(e){
  						update_payment(this);}
                	}] */
  				}
  				,formatter: 'select'
  			},
  			
  			{name:'payment_kind_nm',	index:'payment_kind_nm',	width:100,	align:"center"  ,sortable : false},
  			{name:'o_paypart_nm',		index:'o_paypart_nm',		width:70,	align:"center"    ,sortable : false},
  			{name:'order_date2',		index:'order_date2',		width:180,	align:"center"    ,sortable : false},
  			{name:'order_ing',			index:'order_ing',			width:100,	align:"center"    ,sortable : false
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					 value:"1:주문처리중;2:배송준비;3:배송중;4:배송완료;5:환불/취소;6:예약발송;7:입금대기"
					,dataEvents: [{type: 'change', fn: function(e){
	  					update_state(this);}
                	}]
  				}		  				
  				,formatter: 'select'
  			},
  			{name:'deliveryno',	index:'deliveryno',	width:100,	align:"left"    ,sortable : false},
  			
  			{name:'talk_yn',	index:'talk_yn',	width:55,	align:"center"    ,sortable : false
  				,editable:false   				
  				,editoptions:{
  					 value:"y:발송;n:미발송"					
  				}		  				
  				,formatter: 'select'
  			},
  			{name:'tot_cnt',index:'tot_cnt',	width:128,	align:"center"  ,sortable : false , hidden:true},
  			{name:'cancel_ing',index:'cancel_ing',	width:128,	align:"center"  ,sortable : false , hidden:true},
  			{name:'tak_sel_id',	index:'tak_sel_id',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  			{name:'temple_no',	index:'temple_no',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  			
  			{name:'order_handphone',	index:'order_handphone',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  			{name:'delivery_date2',	index:'delivery_date2',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  		],
  		formatter : {
             integer : {thousandsSeparator: ",", defaultValue: '0'}
        },
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,				
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		loadComplete: function(data) {
			var rows = $("#jqGrid").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		        
		    	var goods_name = $("#jqGrid").getCell(rows[i],"goods_name");
		    	var tot_cnt    = $("#jqGrid").getCell(rows[i],"tot_cnt");
		    	
		    	
		    	if(tot_cnt > 1){
		    		goods_name += '외 '+(tot_cnt-1) + '품목';
		    	}
		    	
		    	$("#jqGrid").setCell(rows[i] , 'goods_name', goods_name ,{color:'blue',weightfont:'bold',cursor: 'pointer'});
		    	
		    	
		    	var pay_ing = new Number($("#jqGrid").getCell(rows[i],"pay_ing"));
		    	if(pay_ing == 1){
		    		$("#jqGrid").setCell(rows[i] , 'pay_ing', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	}else if(pay_ing == 3){
		    		$("#jqGrid").setCell(rows[i] , 'pay_ing', "" ,  {color:'green',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	}else{
		    		$("#jqGrid").setCell(rows[i] , 'pay_ing', "" ,  {color:'black',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	}
		    	
		    	var payment_kind_nm = $("#jqGrid").getCell(rows[i],"payment_kind_nm");				   
		    	if(payment_kind_nm == '카드결제'){
		    		$("#jqGrid").setCell(rows[i] , 'payment_kind_nm', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경	
		    	}else{
		    		$("#jqGrid").setCell(rows[i] , 'payment_kind_nm', "" ,  {color:'red',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	}
		    	
		    	var order_ing = new Number($("#jqGrid").getCell(rows[i],"order_ing"));
		    	if(order_ing == 1){
		    		$("#jqGrid").setCell(rows[i] , 'order_ing', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	}else if(order_ing == 3){
		    		$("#jqGrid").setCell(rows[i] , 'order_ing', "" ,  {color:'green',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	}else{
		    		$("#jqGrid").setCell(rows[i] , 'order_ing', "" ,  {color:'black',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	}
		    	
		    	var cancel_ing =  $("#jqGrid").getCell(rows[i],"cancel_ing");
		    	if(cancel_ing == 'i' || cancel_ing == 'y'){
		    		var goods_name = $("#jqGrid").getCell(rows[i],"goods_name");
		    		$("#jqGrid").setCell(rows[i],"goods_name", goods_name+"<font color='red'>[취소요청건]</font>")
		    	}
		    	
		    }
		    
		    var moneySum = $("#jqGrid").jqGrid('getCol','all_price', false, 'sum');
		    var orderCnt = $("#jqGrid").getGridParam("reccount");
		    
		    $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',o_name:'총금액 : '});
		    $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',all_price:moneySum});
            $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',goods_name:'총 : '+orderCnt+'건'});
		},
		onCellSelect : function(row,iCol,cellcontent,e){					 
			 var record = $("#jqGrid").jqGrid('getRowData', row);
			 
			 if(iCol == 4){
				 $.ajax({
				    url: "view.do",
				    data : record,
				    type : 'POST',
			        error: function(){
				    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				    },
				    success: function(data){
				    	console.log('222222');
				        $("#view_form").html(data);
				        $("#view_form" ).dialog( "open" );
				    }   
				});	
			 }
			 
			 if(iCol == 15){
				 var delivery_no = $("#jqGrid").getCell(row,"deliveryno");
				 var tak_sel_id = $("#jqGrid").getCell(row,"tak_sel_id");
				
				 var url = "https://tracker.delivery/#/"+tak_sel_id+"/"+delivery_no;
				 
				 if('kr.cjlogistics' == tak_sel_id){
					 url = 'http://nplus.doortodoor.co.kr/web/detail.jsp?slipno='+delivery_no
				 }
				 if('kr.lotte' == tak_sel_id){
					 url = 'http://www.deliverytracking.kr/?dummy=dummy&deliverytype=lotteglogis&keyword='+delivery_no
				 }
				 deliveryInfo(url);	
				 
			 }
		},
		footerrow: true, 
		userDataOnFooter : true,
		beforeSelectRow: function (rowid, e) {
		    var $self = $(this), iCol, cm,
		    $td = $(e.target).closest("tr.jqgrow>td"),
		    $tr = $td.closest("tr.jqgrow"),
		    p = $self.jqGrid("getGridParam");

		    if ($(e.target).is("input[type=checkbox]") && $td.length > 0) {
		       iCol = $.jgrid.getCellIndex($td[0]);
		       cm = p.colModel[iCol];
		       if (cm != null && cm.name === "cb") {
		           $self.jqGrid("setSelection", $tr.attr("id"), true ,e);
		       }
		    }
		    return false;
		},
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			return {"order_no":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		afterSaveCell: function(rowid,celname,value,iRow,iCol) {
		}, 				
	    cellEdit : true,
		cellurl : 'update_col.do',
	});
		  	
	  	$("#jqGrid").jqGrid('navGrid','#jqGridControl',
	  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	  	);
	  	
	  	
	  	$('#search_btn').click(function() {
	  		var search_value = $('#search_value').val();
			var search_title = $('#search_title').val();
			var search_order = $('#search_order').val();
			var search_level = $('#search_level').val();
			var search_sday  = $('#search_sday').val();
			var search_eday = $('#search_eday').val();
				
			
			if( search_sday.replace(/-/gi, "") > search_eday.replace(/-/gi, "") ){
				alert('검색 시작일은 검색종료일보다 클수 없습니다.');
				return;
			}
			var param = { 
				 search_value : search_value
				,search_title : search_title
				,search_order : search_order
				,search_level : search_level
				,search_sday  : search_sday
				,search_eday  : search_eday
			};
			
			$("#jqGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
			
			return false;
		});
	  	
	  	$('#search_all_btn').click(function(){
	  		$('#search_value').val("");
			$('#search_title').val("");
			$('#search_order').val("");
			$('#search_level').val("");
			$('#search_sday').val("");
			$('#search_eday').val("");		  	
			
			var param = {pageSearch   : 1};
			$("#jqGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
	  	});
	  	
	  	$('#del_btn').click(function(){
	  		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
	  		if( row.length <= 0 ){
	  			alert('1개 이상 선택하세요.');
	  			return false;
	  		}
	  		
	  		for(var i = 0 ; i <row.length ; i++){
  				var data =$("#jqGrid").jqGrid('getRowData', row[i]);
  				if(i == 0){
  					all_order_no  = data.order_no
  				}else{
  					all_order_no += ','+data.order_no	
  				}
  			}// for

  			console.log('data.a_seqno = ', all_order_no);
	  		
	  		if(!confirm('삭제하시겠습니까?')){
	  			return false;
	  		}
	  		
	  		$.ajax({
	  			url  : 'del.do',
	  			type : 'POST',
	  			data : {
	  				all_order_no : all_order_no,		  				
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
	  		
	  		
	  		return false;
	  	});
	  	
	  	
	  	
	  	
	  	$("#view_form").dialog({
	  		autoOpen: false,
            resizable: true,
            height: 850,
            width: 1200,
            modal: true,
            title: '약속처방 주문 내역',
            beforeClose: function(event, ui) { 
               console.log('beforeClose');
            },
            close : function(){            
            	$("#view_form").html("");
            },
            open: function(event, ui) { 
            	$('.ui-widget-overlay').bind('click', function(){
            		$("#view_form").dialog('close'); 
            	});
            },
            buttons: {	                
                "닫기": function () {
                    $(this).dialog("close");
                }
            }	
	  	});
	  	
	  	
	  	$("#takbae_form").dialog({
	  		autoOpen: false,
            resizable: true,
            height: 850,
            width: 1200,
            modal: true,
            title: '배송내역',
            beforeClose: function(event, ui) { 
               console.log('beforeClose');
            },
            close : function(){            
            	$("#takbae_form").html("");
            },
            open: function(event, ui) { 
            	$('.ui-widget-overlay').bind('click', function(){
            		$("#takbae_form").dialog('close'); 
            	});
            },
            buttons: {	                
                "닫기": function () {
                    $(this).dialog("close");
                }
            }	
	  	});
		  	
		  	
		 $.datepicker.setDefaults({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'yy-mm-dd'
		});
		$(".date").datepicker({});
	});
	
	
	function update_payment(th){
		console.log($(th).context.value);
		
		var data = $("#jqGrid").jqGrid('getRowData', $(th).attr('rowid'));
		
		$.ajax({
			url : 'update_payment.do',
		    data : {
		    	  payment : $(th).context.value
		    	 ,seqno   : data.seqno 
		    },        
	        error: function(){
		    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		    },
		    success: function(data){
		    	console.log(data)
		    	
		    }   
		});
		
		
	}
	
	function update_state(th){
		
		var data = $("#jqGrid").jqGrid('getRowData', $(th).attr('rowid'));
		$.ajax({
			url : 'update_order.do',
		    data : {
		    	  order_ing : $(th).context.value
		    	 ,seqno     : data.seqno 
		    },        
	        error: function(){
		    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		    },
		    success: function(data){
		    	console.log(data)
		    }   
		});
	}
	
	function state_batch(){
		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
		
		if( row.length > 0 ){
			
			var flag = confirm("일괄 처리 하겠습니까?");
			
			if(!flag){
				return;
			}
			
			for(var i = 0 ; i <row.length ; i++){
				var data =$("#jqGrid").jqGrid('getRowData', row[i]);
				if(i == 0){
					all_seqno  = data.seqno
				}else{
					all_seqno += ','+data.seqno	
				}
			}
			
			$.ajax({
				url : 'update_order.do',
			    data : {
			    	  order_ing : $('#state_batch').val()
			    	 ,seqno     : all_seqno 
			    },        
		        error: function(){
			    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			    },
			    success: function(data){
			    	alert(data.msg);
			    	if(data.suc){
			    		for(var i = 0 ; i <row.length ; i++){
							console.log( $('#state_batch').val() );
				    		$("#jqGrid").setCell(row[i],"order_ing", $('#state_batch').val())
				    		
					    	if($('#state_batch').val()  == 1){
					    		$("#jqGrid").setCell(row[i] , 'order_ing', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
					    	}else if($('#state_batch').val()  == 3){
					    		$("#jqGrid").setCell(row[i] , 'order_ing', "" ,  {color:'green',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
					    	}else{
					    		$("#jqGrid").setCell(row[i] , 'order_ing', "" ,  {color:'black',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
					    	}
				    		
						}
			    		
			    	}
			    }   
			});
		}else{
			alert('일괄처리할 데이터를 선택하세요.');
		}
	}
	
	function send_talk(){
		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
		
		if( row.length <=0 ){
			alert('알림톡 발송할 주문건을 선택하세요.');
			return false;
		}
		
		for(var i = 0 ; i <row.length ; i++){
			var data =$("#jqGrid").jqGrid('getRowData', row[i]);
			
			var tak_sel_id = data.tak_sel_id;
			var deliveryno = data.deliveryno;
			var temple_no  = data.temple_no;
			if(deliveryno == "" || temple_no == "" || tak_sel_id == ""){
				alert('택배정보를 입력하지 않는 주문건이 포함되어있습니다.\n택배정보를 입력한 주문건만 알림톡을 발송할수 있습니다.');
				return false;
			}
		}//for
		
		var s_cnt = 0;
		var f_cnt = 0;
		var t_cnt = 0;
		var all_seqno = "";
		
		for(var i = 0 ; i <row.length ; i++){
			var data =$("#jqGrid").jqGrid('getRowData', row[i]);
			send_talk_ajax(data);
			
			if(s_cnt == 0){
				all_seqno = data.seqno;
			}else{
				all_seqno = all_seqno+","+data.seqno;
			}
			s_cnt++;
			t_cnt++;		
		}
		
		if(s_cnt > 0){			
			alert('발송되었습니다.');
			$.ajax({
				url : 'update_talk_send.do',
			    data : {
			    	all_seqno     : all_seqno 
			    },        
		        error: function(){
		        	console.log('에러가 발생했습니다.\n관리자에 문의하세요.');
			    },
			    success: function(data){
			    	$("#jqGrid").trigger("reloadGrid");
			    }   
			});
		}else{
			alert('에러가 발생했습니다.\n다시 시도해주세요.');
		}
		console.log('all_seqno = ', all_seqno);
	}
	
	function send_talk_ajax(data){
	//	return true;
		$.ajax({
			url: "http://www.apiorange.com/api/send/notice.do",
			type: "POST",
			headers: {
				"Content-Type": "application/json; charset=utf-8",
				"Authorization": "EoFOPkPDznneCttAXMl3OvRWgbTQLYGPBY3cjj4lCSs="
			},
			data: JSON.stringify({
				tmp_number        : data.temple_no,
				kakao_sender      : '0437315075',
				kakao_name        : data.order_name,
				kakao_phone       : data.order_handphone,
				kakao_add1        : data.order_name,
				kakao_add2        : data.order_no,
				kakao_add3        : data.delivery_date2,
				kakao_add4        : data.deliveryno,
				kakao_add5        : "",
				kakao_add6        : "",
				kakao_add7        : "",
				kakao_add8        : "",
				kakao_add9        : "",
				kakao_add10       : "",
				kakao_080         : "N",
				kakao_res         : "",
				kakao_res_date    : "",
				TRAN_REPLACE_TYPE : ""
			}),
			success : function(data) {
				if (data && data.response_code == 200){
					console.log('성공 -->', data.seqno);
				}else {
					console.log('실패 <----', data.seqno);
				}
				return true;
			},
			error : function(request, status, error) {
				return false;
			}
		});
	}