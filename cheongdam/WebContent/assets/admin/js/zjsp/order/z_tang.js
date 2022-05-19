$(document).ready(function() {
		
  	$("#jqGrid").jqGrid({
  		url : '/admin/order/tang/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 50,
  		rowList: [20,50,100,500,1000,10000],
  		//rowList: [3],
  		colNames:[
  			'순번','주문번호','주문유형', '처방명', '주문자', '복용자', 
  			'수취인','등급', '한의원명', '금액', '입금' ,
  			'결제방법' ,'결제방법' ,'계산서' ,'주문일', '상태' ,
  			'송장' , '알림톡',
  			
  			'bunch', 'cancel_ing' ,'tak_sel_id' , 'order_handphone' , 'delivery_date2',
  			
  			'temple_no'
  		],
  		colModel:[
  			// key tr에 id 먹여줌
  			{name:'seqno',		index:'seqno',		width:128,	align:"center"  ,sortable : false ,key: true , hidden:true},		  					  			
  			{name:'order_no',	index:'order_no',	width:138,	align:"center"  ,sortable : false },
  			{name:'order_type',	index:'order_type',	width:60,	align:"center"  ,sortable : false 
  				,editable:false 
  				,edittype:"select"
  				,editoptions:{
  					 value:"1:일반;2:실속"					
  				}		  				
  				,formatter: 'select'
  			},
  			{name:'s_name',		index:'u_s_name',	width:350,	align:"left"    ,sortable : false},
  			{name:'name',		index:'name',		width:100,	align:"center"  ,sortable : false
  				,editable:true
  			},
  			{name:'w_name',		index:'w_name',		width:100,	align:"left"    ,sortable : false},
  			
  			{name:'d_to_name',	index:'d_to_name',	width:100,	align:"left"    ,sortable : false},		  			
  			{name:'member_level',		index:'member_level',		width:100,	align:"center"    ,sortable : false
  				,editable:false 
  				,edittype:"select"
				,editoptions:{
  					value:mem_code
  				}
  				,formatter: 'select' 
  			},
  			{name:'han_name',			index:'han_name',			width:150,	align:"left"  ,sortable : false
  				,editable:true
  			},
  			{name:'order_total_price',	index:'order_total_price',	width:70,	align:"right"    ,sortable : false , 
  				formatter: 'integer', 
  				formatoptions:{thousandsSeparator:","}, 
  				summaryType:'sum', 		  				
  			},		  			
  			{name:'payment',			index:'payment',			width:100,	align:"center"  
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					value:"1:입금;2:미입금;3:방문결제;4:증정",
  					dataEvents: [{type: 'change', fn: function(e){
  						update_payment(this);}
                	}]
  				}
  				,formatter: 'select' 
  			},	
  			
  			{name:'payment_kind',	index:'payment_kind',		width:100,	align:"center"  ,sortable : false, hidden:true},
  			{name:'payment_kind_nm',index:'payment_kind_nm',	width:100,	align:"center"  ,sortable : false},
  			{name:'cash_bill_nm',	index:'cash_bill_nm',		width:50,	align:"center"  ,sortable : false},
  			{name:'order_date2',	index:'order_date2',		width:190,	align:"center"  ,sortable : false},
  			{name:'order_ing',		index:'order_ing',			width:100,	align:"center"  ,sortable : false
  				,editable:true 
  				,edittype:"select"
  				,editoptions:{
  					 value:"1:접수대기;2:입금대기;3:조제중;4:탕전중;5:발송;6:완료;7:환불취소;8:예약발송"
					,dataEvents: [{type: 'change', fn: function(e){
	  					update_state(this);}
                	}]
  				}		  				
  				,formatter: 'select'
  			},		  			
  			{name:'delivery_no',	index:'delivery_no',	width:120,	align:"center"  ,sortable : false},
  			{name:'talk_yn',	index:'talk_yn',	width:55,	align:"center"    ,sortable : false
  				,editable:false   				
  				,editoptions:{
  					 value:"y:발송;n:미발송"					
  				}		  				
  				,formatter: 'select'
  			},
  			/*{name:'c_more_tang_nm',	index:'c_more_tang',	width:60,	align:"center"  ,sortable : false},*/
  			
  			{name:'bunch',	index:'bunch',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  			{name:'cancel_ing',	index:'cancel_ing',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  			{name:'tak_sel_id',	index:'tak_sel_id',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  			{name:'order_handphone',	index:'order_handphone',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  			{name:'delivery_date2',	index:'delivery_date2',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  			
  			{name:'temple_no',	index:'temple_no',	width:128,	align:"center"  ,sortable : false  , hidden:true},
  		],
  		formatter : {
             integer : {thousandsSeparator: ",", defaultValue: '0'}
        },
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,				
		//sortname: 'seqno',
		//sortorder: "desc",
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		loadComplete: function(data) {
			var rows = $("#jqGrid").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		        
		    	var payment = new Number($("#jqGrid").getCell(rows[i],"payment"));
		    	
		    	
		    	if(payment == 1){
		    		$("#jqGrid").setCell(rows[i] , 'payment', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경	
		    	}else{
		    		$("#jqGrid").setCell(rows[i] , 'payment', "" ,  {color:'red',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	}
		    					    
		    	var payment_kind = $("#jqGrid").getCell(rows[i],"payment_kind");				   
		    	if(payment_kind == 'Card'){
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
		    	
		    	$("#jqGrid").setCell(rows[i] , 's_name', "" ,  {'text-decoration': 'underline',color:'#396B93',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	
		    	//$("#jqGrid").setCell(rows[i] , 's_name', "" ,  {color:'#396B93',weightfont:'bold',cursor: 'pointer', text-decoration: 'underline'}); // 특정 cell 색상변경
		    	
		    	var bunch = $("#jqGrid").getCell(rows[i],"bunch");
		    	if(bunch != 'n'){
		    		var s_name = $("#jqGrid").getCell(rows[i],"s_name");				    		
		    		$("#jqGrid").setCell(rows[i],"s_name", s_name+"<font color='red'>[묶음]</font>")
		    	}				
		    	
		    	var cancel_ing =  $("#jqGrid").getCell(rows[i],"cancel_ing");
		    	if(cancel_ing == 'i' || cancel_ing == 'y'){
		    		var s_name = $("#jqGrid").getCell(rows[i],"s_name");
		    		$("#jqGrid").setCell(rows[i],"s_name", s_name+"<font color='red'>[취소요청건]</font>")
		    	}
		    }
		    
		    /*서머리*/
		    var moneySum = $("#jqGrid").jqGrid('getCol','order_total_price', false, 'sum');
		    var orderCnt = $("#jqGrid").getGridParam("reccount");

		    
            $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',order_total_price:moneySum});
            $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',han_name:'총금액 : '});
            $("#jqGrid").jqGrid('footerData','set',{fldArtikelcode:'Summary',s_name:'총 : '+orderCnt+'건'});
		    
            /* $('table.ui-jqgrid-ftable td:eq(0)').hide(); */
           

		},
		onCellSelect : function(row,iCol,cellcontent,e){					 
			 var record = $("#jqGrid").jqGrid('getRowData', row);
			 if( iCol == 4){
				 $.ajax({
				    url: "/admin/order/tang/view.do",
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
			 
			 if(iCol == 16){
				 var delivery_no = $("#jqGrid").getCell(row,"delivery_no");
				 var tak_sel_id = $("#jqGrid").getCell(row,"tak_sel_id");
				
				 if(delivery_no != null && delivery_no != '' &&tak_sel_id != null && tak_sel_id != ''){
					 var url = "https://tracker.delivery/#/"+tak_sel_id+"/"+delivery_no;						
					 deliveryInfo(url);	 
				 }
			 }
		},
		footerrow: true, 
		userDataOnFooter : true,
		/* grouping:true,
	   	groupingView : {
	   		groupField : ['order_total_price'],
	   		groupSummary : [true],
	   	}, */
		/*멀티 트루할때 개별 체크 안되는 현상 방지*/
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
		afterSaveCell: function(rowid,celname,value,iRow,iCol) {
			/* console.log('beforeSaveCell = ', rowid);
			console.log('beforeSaveCell = ', celname);
			console.log('beforeSaveCell = ', value);
			console.log('beforeSaveCell = ', iRow);
			console.log('beforeSaveCell = ', iCol);
			
			
			var data = $("#jqGrid").jqGrid('getRowData', rowid);
			
			if(iCol == 10){ // 입금상태 10번쨰
				update_payment(data);					
			}
			
			if(iCol == 15){ // 접수 상태
				update_state(data);
			} */
			
		}, 				
	    /* afterSubmitCell : function(res) {
			console.log(res);
	    }, */
	    cellEdit : true,
	    //cellsubmit : 'clientArray',  // ajax요청 보내지 않는다  remote ajax 요청 보낸다
		cellurl : '/admin/order/tang/update_col.do',
		//repeatitems: false
	});
		  	
	  	//페이지 넘 
	  	jQuery("#jqGrid").jqGrid('navGrid','#jqGridControl',
	  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
	  	);
	  	
	  	
	  	$('#search_btn').click(function() {
	  		var search_value = $('#search_value').val();
			var search_title = $('#search_title').val();
			var search_order = $('#search_order').val();
			var search_level = $('#search_level').val();
			var search_sday  = $('#search_sday').val();
			var search_eday = $('#search_eday').val();
			var search_type = $('#search_type').val();
			
			
				
			
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
				,search_type  : search_type
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
  					all_seqno  = data.seqno
  				}else{
  					all_seqno += ','+data.seqno	
  				}
  			}// for

  			console.log('data.a_seqno = ', all_seqno);
	  		
	  		if(!confirm('삭제하시겠습니까?')){
	  			return false;
	  		}
	  		
	  		
	  		$.ajax({
	  			url  : 'del.do',
	  			type : 'POST',
	  			data : {
	  				all_seqno : all_seqno,		  				
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
           // position: 'center',
            modal: true,
            title: '탕전 주문 내역',
            beforeClose: function(event, ui) { 
               console.log('beforeClose');
            },
            close : function(){            
            //	$("#jqGrid").trigger("reloadGrid");
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
           // position: 'center',
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
			//inline: true
		});
		$(".date").datepicker({});
		
		
	});
	
	
	function send_talk(){
		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
		
		if( row.length <=0 ){
			alert('알림톡 발송할 주문건을 선택하세요.');
			return false;
		}
		
		for(var i = 0 ; i <row.length ; i++){
			var data =$("#jqGrid").jqGrid('getRowData', row[i]);
			
			var tak_sel_id = data.tak_sel_id;
			var delivery_no = data.delivery_no;
			var temple_no  = data.temple_no;
			if(delivery_no == "" || temple_no == "" || tak_sel_id == ""){
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
			
			send_talk_ajax(data)
			if(s_cnt == 0){
				all_seqno = data.seqno;
			}else{
				all_seqno = all_seqno+","+data.seqno;
			}
			s_cnt++;							
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
			alert('알림톡 전송이 제대로 되지 않았습니다.');
		}
		/*
		for(var i = 0 ; i <row.length ; i++){
			var data =$("#jqGrid").jqGrid('getRowData', row[i]);
			
			
			console.log(data);
			if( send_talk_ajax(data) ){			
				if(s_cnt == 0){
					all_seqno = data.seqno;
				}else{
					all_seqno = all_seqno+","+data.seqno;
				}
				s_cnt++;
			}else{
				f_cnt++;
			}
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
			alert('알림톡 전송이 제대로 되지 않았습니다.');
		}	*/	
		
		
	}

	function send_talk_ajax(data){
		
		/*
		console.log(data.temple_no);
		console.log(data.name);
		console.log(data.order_handphone);
		console.log(data.name);
		console.log(data.order_no);
		console.log(data.delivery_date2);
		console.log(data.delivery_no);
		*/
		$.ajax({
			url: "http://www.apiorange.com/api/send/notice.do",
			type: "POST",
			headers: {
				"Content-Type": "application/json; charset=utf-8",
				"Authorization": "bc0Yl8Ijyp8fGdj24aCw9VeNLgeZZfNGtzxp98yJ9Ds="
			},
			data: JSON.stringify({
				tmp_number        : data.temple_no,
				kakao_sender      : '0542421079',
				kakao_name        : data.name,
				kakao_phone       : data.order_handphone,
				kakao_add1        : data.name,
				kakao_add2        : data.order_no,
				kakao_add3        : data.delivery_date2,
				kakao_add4        : data.delivery_no,
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
				console.log('send_talk_ajax = ',data);
				if (data && data.response_code == 200){
					console.log('성공 -->', data);
				}else {
					console.log('실패 <----', data);
				}
				return true;
			},
			error : function(request, status, error) {
				return false;
			}
		});
	}

	
	function update_payment(th){
		console.log($(th).context.value);
		
		
		var data = $("#jqGrid").jqGrid('getRowData', $(th).attr('rowid'));
		//console.log('data = ', data);
		
		$.ajax({
			url : '/admin/order/tang/update_payment.do',
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
		//console.log('update_state = ', th);
		
		var data = $("#jqGrid").jqGrid('getRowData', $(th).attr('rowid'));
		//console.log('data = ', data);
		$.ajax({
			url : '/admin/order/tang/update_order.do',
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
				url : '/admin/order/tang/update_order.do',
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
	
	function pay_batch(){
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
				url : '/admin/order/tang/batch_pay.do',
			    data : {
			    	  payment   : $('#pay_batch').val()
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
				    		$("#jqGrid").setCell(row[i],"payment", $('#pay_batch').val())
					    	if($('#pay_batch').val()  == 2){
					    		$("#jqGrid").setCell(rows[i] , 'payment', "" ,  {color:'red',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
					    	}else{
					    		$("#jqGrid").setCell(rows[i] , 'payment', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
					    	}
				    		
						}
			    		
			    	}
			    }   
			});
			
		}else{
			alert('일괄처리할 데이터를 선택하세요.');
		}
	}
	