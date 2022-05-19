function initLayerPosition(element_layer){
		var width = 1000; 
	    var height = 600; 
	    var borderWidth = 5; 
	
	    // 위에서 선언한 값들을 실제 element에 넣는다.
	    element_layer.style.width = width + 'px';
	    element_layer.style.height = height + 'px';
	    element_layer.style.border = borderWidth + 'px solid';
	    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	    element_layer.style.left  = '210px';
	    element_layer.style.top  = '100px';
	   // element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	   // element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
	}
	
	function closeDaumPostcode(){
		$('.find_addr_layer_pop').hide();
	} 

	$(document).ready(function() {				
		
		/*약속처방*/
		$("#shopGrid").jqGrid({
	  		url : '/admin/order/shop/select.do',
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 7,
	  		//rowList: [20,50,100,500],
	  		//rowList: [3],
	  		colNames:[
	  			'순번'    , '경로'  ,'주문번호' , '상품명'   , '주문자' , 
	  			'등급'    ,'한의원명'  ,'수취인' , '금액'    ,'입금'   ,
	  			'결제방법' ,'계산서'  ,'주문일'   , '상태'    ,'송장'  , 
	  			'메세지'  , 'tot_cnt'
	  		],
	  		colModel:[
	  			// key tr에 id 먹여줌
	  			{name:'seqno',			index:'seqno',			width:128,	align:"center"  ,sortable : false  , hidden:true},		  					  			
	  			{name:'seqno',			index:'seqno',			width:60,	align:"center"  ,sortable : false , hidden:true},
	  			{name:'order_no',		index:'order_no',		width:110,	align:"center"  ,sortable : false ,key: true},
	  			{name:'goods_name',		index:'goods_name',		width:350,	align:"left"    ,sortable : false},
	  			/* {name:'mem_name',		index:'mem_name',		width:100,	align:"center"  ,sortable : false}, */
	  			{name:'order_name',		index:'order_name',		width:100,	align:"center"  ,sortable : false},
	  			
	  			{name:'member_level',	index:'member_level',	width:100,	align:"center"    ,sortable : false , hidden:true
	  				,editable:false 
	  				,edittype:"select"
	  				,editoptions:{
	  					value:"${mem_code}"
	  				}
	  				,formatter: 'select' 
	  			},
	  			{name:'han_name',			index:'han_name',			width:150,	align:"left"    ,sortable : false},
	  			{name:'r_name',			index:'r_name',			width:150,	align:"left"    ,sortable : false},
	  			{name:'all_price',		index:'all_price',		width:70,	align:"right"   ,sortable : false,
	  				formatter: 'integer', 
	  				formatoptions:{thousandsSeparator:","}
	  			},
	  			{name:'pay_ing',		index:'pay_ing',		width:100,	align:"center"   ,sortable : false
	  				,editable:false 
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
	  			{name:'o_paypart_nm',		index:'o_paypart_nm',		width:70,	align:"center"    ,sortable : false ,hidden:true},
	  			{name:'order_date2',		index:'order_date2',			width:180,	align:"center"    ,sortable : false},
	  			{name:'order_ing',			index:'order_ing',			width:100,	align:"center"    ,sortable : false
	  				,editable:false 
	  				,edittype:"select"
	  				,editoptions:{
	  					 value:"1:주문처리중;2:배송준비;3:배송중;4:배송완료;5:환불/취소;6:예약발송;7:입금대기"
  						,dataEvents: [{type: 'change', fn: function(e){
		  					update_state(this);}
                    	}]
	  				}		  				
	  				,formatter: 'select'
	  			},
	  			{name:'deliveryno',	index:'deliveryno',	width:100,	align:"left"    ,sortable : false , hidden:true},
	  			
	  			{name:'s_name',	index:'u_s_name',	width:100,	align:"left"    ,sortable : false , hidden:true},
	  			{name:'tot_cnt',index:'tot_cnt',	width:128,	align:"center"  ,sortable : false , hidden:true}
	  		],
	  		formatter : {
	             integer : {thousandsSeparator: ",", defaultValue: '0'}
	        },
	        sortname: 'seqno',
			sortorder: "desc",
			viewrecords: true,
			autowidth: true,				
			loadtext  : '데이터를 불러오는중입니다.',
			emptyrecords  : '검색된 데이터가 없습니다',
			multiselect: false,
			loadComplete: function(data) {
				var rows = $("#shopGrid").getDataIDs(); 				
			    for (var i = 0; i < rows.length; i++){
			        
			    	var goods_name = $("#shopGrid").getCell(rows[i],"goods_name");
			    	var tot_cnt    = $("#shopGrid").getCell(rows[i],"tot_cnt");
			    	
			    	//console.log('tot_cnt = ', tot_cnt);
			    	
			    	if(tot_cnt > 1){
			    		goods_name += '외 '+(tot_cnt-1) + '품목';
			    	}
			    	
			    	$("#shopGrid").setCell(rows[i] , 'goods_name', goods_name ,{color:'blue',weightfont:'bold',cursor: 'pointer'});
			    	
			    	
			    	var pay_ing = new Number($("#shopGrid").getCell(rows[i],"pay_ing"));
			    	if(pay_ing == 1){
			    		$("#shopGrid").setCell(rows[i] , 'pay_ing', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	}else if(pay_ing == 3){
			    		$("#shopGrid").setCell(rows[i] , 'pay_ing', "" ,  {color:'green',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	}else{
			    		$("#shopGrid").setCell(rows[i] , 'pay_ing', "" ,  {color:'black',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	}
			    	
			    	var payment_kind_nm = $("#shopGrid").getCell(rows[i],"payment_kind_nm");				   
			    	if(payment_kind_nm == '카드결제'){
			    		$("#shopGrid").setCell(rows[i] , 'payment_kind_nm', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경	
			    	}else{
			    		$("#shopGrid").setCell(rows[i] , 'payment_kind_nm', "" ,  {color:'red',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	}
			    	
			    	var order_ing = new Number($("#shopGrid").getCell(rows[i],"order_ing"));
			    	if(order_ing == 1){
			    		$("#shopGrid").setCell(rows[i] , 'order_ing', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	}else if(order_ing == 3){
			    		$("#shopGrid").setCell(rows[i] , 'order_ing', "" ,  {color:'green',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	}else{
			    		$("#shopGrid").setCell(rows[i] , 'order_ing', "" ,  {color:'black',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	}
			    	
			    	var cancel_ing =  $("#shopGrid").getCell(rows[i],"cancel_ing");
			    	if(cancel_ing == 'i' || cancel_ing == 'y'){
			    		var goods_name = $("#shopGrid").getCell(rows[i],"goods_name");
			    		$("#shopGrid").setCell(rows[i],"goods_name", goods_name+"<font color='red'>[취소요청건]</font>")
			    	}
			    	
			    }
			    
			},
			onCellSelect : function(row,iCol,cellcontent,e){					 
				 var record = $("#shopGrid").jqGrid('getRowData', row);
				 if(iCol == 3){
					 $.ajax({
					    url: "/admin/order/shop/view.do",
					    data : record,
					    type : 'POST',
				        error: function(){
					    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					    },
					    success: function(data){
					        $("#shop_form").html(data);
					        $("#shop_form" ).dialog( "open" );
					    }   
					});	
				 }
			},
		    cellEdit : false,
		});
		
		$("#shop_form").dialog({
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
            //	$("#memberGrid").trigger("reloadGrid");
            	$("#shop_form").html("");
            },
            open: function(event, ui) { 
            	$('.ui-widget-overlay').bind('click', function(){
            		$("#shop_form").dialog('close'); 
            	});
            },
            buttons: {	                
                "닫기": function () {
                    $(this).dialog("close");
                }
            }	
	  	});
		
		/*최근 가입회원*/
		$("#memberGrid").jqGrid({
	  		//caption : '회원관리',
	  		//dataType : 'local', // 로딩시 최초 조회 		  		
	  		datatype: "local", 
	  		url : '/admin/base/member/select.do',
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 7,
	  		///rowList: [20,50,100,500],
	  		//rowList: [3],
	  		colNames:[
	  			'일련번호', '번호', '아이디', '이름', '한의원명', '등급', 
	  			'라이센스','이메일','실무자','회원구분','그룹', 
	  			'가입일'
	  		],
	  		colModel:[
	  			{name:'a_num',			index:'a_num',		width:78,	align:"center"  ,sortable : false  },
	  			{name:'seqno',			index:'a_seqno',		width:48,	align:"center"  ,sortable : false ,key: true , hidden:true},
	  			{name:'id',				index:'id',				width:120,	align:"left"    ,sortable : false},
	  			{name:'name',			index:'name',			width:120,	align:"center"  ,sortable : false , hidden:true},
	  			{name:'han_name',		index:'han_name',		width:200,	align:"left"    ,sortable : false , hidden:true},
	  			{name:'member_level',	index:'member_level',	width:200,	align:"center"  ,sortable : false , hidden:true},
	  			
	  			{name:'license_no',		index:'license_no',		width:80,	align:"center"    ,sortable : false  , hidden:true
	  				,editable:false
	  			},
	  			{name:'email',		index:'email',		width:180,	align:"left"    ,sortable : false
	  				,editable:false
	  			},
	  			{name:'sub_id_confirm',		index:'sub_id_confirm',		width:80,	align:"center"    ,sortable : false
	  				,editable:false
	  				,edittype:'select'
	  				,formatter: 'select'
	  				,editoptions:{
	  					 value:"y:승인;n:미승인"	
	  				}
	  			},
	  			{name:'part',		index:'part',		width:130,	align:"center"    ,sortable : false
	  				,editable:false
	  				,edittype:'select'
	  				,formatter: 'select'
	  				,editoptions:{
	  					 value:"1:한의원(개원의);2:한의사(미개원의);3:한의대생"	
	  				}
	  			},		  			
	  			{name:'group_code',		index:'group_code',		width:150,	align:"center"  ,sortable : false , hidden:true},
	  			{name:'wdate2',			index:'wdate',			width:200,	align:"center"  ,sortable : false}
	  		],
			pager: "#memberGridControl",
			viewrecords: true,
			autowidth: true,				
			sortname: 'seqno',
			sortorder: "desc",
			viewrecords: true,
			loadtext  : '데이터를 불러오는중입니다.',
			emptyrecords  : '검색된 데이터가 없습니다',
			multiselect: false,
			cellEdit : false,
			//editurl : '/admin/base/member/select.do',
			//cellurl : '/admin/base/member/update_col.do',
			beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
				console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
				return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
			},
			loadComplete: function(data) {
				var rows = $("#memberGrid").getDataIDs(); 			
				var records = data.records;
				
			    for (var i = 0; i < rows.length; i++){
			    	var member_level = new Number($("#memberGrid").getCell(rows[i],"member_level"));
			    	$("#memberGrid").setCell(rows[i] , 'a_num', records-- , {});
			    	
			    	$("#memberGrid").setCell(rows[i] , 'id', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    	
			    }//
			},
			onCellSelect : function(row,iCol,cellcontent,e){
				console.log('iCol= ', iCol);
				if(iCol == 2){
					var data = $("#memberGrid").jqGrid('getRowData', row);					
					var ret = $("#memberGrid").getRowData(row)
					 $.ajax({
					    url   : "/admin/base/member/mod.do",		    
					    type  : 'POST',
					    data  : ret,
				        error: function(){
					    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					    },
					    success: function(data){
					        $("#memberForm").html(data);
					        $("#memberForm" ).dialog( "open" );
					    }   
					});	
				}
			}
		});
		
		$("#memberForm").dialog({
	  		autoOpen: false,
	        resizable: true,
	        height: 800,
	        width: 1200,
	       // position: 'center',
	        modal: true,
	        title: '회원정보관리',
	        beforeClose: function(event, ui) { 
	           console.log('beforeClose');
	        },
	        close : function(){            
	           	$('#memberForm').html("");
	        },
	        open: function(event, ui) { 
	        	$('.ui-widget-overlay').bind('click', function(){
	        		$("#memberForm").dialog('close'); 
	        	});
	        },
	        buttons: {
	            "수정": function () {
	            	a_member_proc('memberGrid');
	            },
	            "닫기": function () {
	                $(this).dialog("close");
	            }
	        }		
	  	});
		
		/*최근문의사항*/
		$("#qnaGrid").jqGrid({
	  		dataType : 'local', // 로딩시 최초 조회 
	  		url : '/admin/board/qna/select_list.do',
	  		datatype: 'json',
	  		hidegrid: false,
	  		width: "100%",
	  		height: "100%",
	  		rowNum: 15,
	  		rowList: [15,20,30],
	  		//rowList: [3],
	  		colNames:[
	  			'번호',  '제목', '처리상태' , '작성자', '조회'
	  			,'작성일',
	  			
	  			'board_name' ,  'ref' , 'ref_step' , 'ref_level', 'content',
	  			'ori_name1' , 're_name1' , 'ori_name2' , 're_name2' , 'ori_name3' 
	  			,'re_name3'    
	  		],
	  		colModel:[
	  			{name:'seq',		index:'seqno',		width:28,	align:"center" ,key: true },
	  			{name:'title',		index:'title',		width:558,	align:"left"},
	  			{name:'re_com',		index:'re_com',		width:100,	align:"center"
	  				,editable:false 
	  				,edittype:"select"
	  				,editoptions:{
	  					 value:"y:답변완료;n:대기중"
	  				}
	  				,formatter: 'select'	
	  			},
	  			{name:'mem_nm',		index:'mem_nm',		width:120,	align:"center"},
	  			{name:'hit',		index:'hit',		width:80,	align:"center" , hidden:true},
	  			
	  			{name:'reg_date_ymd',	index:'reg_date_ymd',		width:120,	align:"center"},
	  			
	  			
	  			{name:'board_name',	index:'board_name',		width:120,	align:"center" , hidden:true},
	  			{name:'ref',	index:'ref',		width:120,	align:"center", hidden:true},
	  			{name:'ref_step',	index:'ref_step',		width:120,	align:"center", hidden:true},
	  			{name:'ref_level',	index:'ref_level',		width:120,	align:"center", hidden:true},
	  			{name:'content',	index:'content',		width:120,	align:"center", hidden:true},
	  			
	  			{name:'ori_name1',	index:'ori_name1',		width:120,	align:"center", hidden:true},
	  			{name:'re_name1',	index:'re_name1',		width:120,	align:"center", hidden:true},
	  			{name:'ori_name2',	index:'ori_name2',		width:120,	align:"center", hidden:true},
	  			{name:'re_name2',	index:'re_name2',		width:120,	align:"center", hidden:true},
	  			{name:'ori_name3',	index:'ori_name3',		width:120,	align:"center", hidden:true},
	  			
	  			{name:'re_name3',	index:'re_name3',		width:120,	align:"center", hidden:true}
	  			
	  		],
			viewrecords: true,
			autowidth: true,
			sortname: 'seq',
			sortorder: "desc",
			viewrecords: true,
			loadtext  : '데이터를 불러오는중입니다.',
			emptyrecords  : '검색된 데이터가 없습니다',
			multiselect: false,
			cellEdit : false,
			cellsubmit : 'clientArray',
			loadComplete: function(data) {
				//console.log('loadComplete = ', data);
				var rows = $("#qnaGrid").getDataIDs(); 				
			    for (var i = 0; i < rows.length; i++){
			    	$("#qnaGrid").setCell(rows[i] , 'title', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    }
			},
			onCellSelect : function(row,iCol,cellcontent,e){
				console.log('onCellSelect = ', iCol); 
				 if(iCol == 1){
					 var data = $("#qnaGrid").jqGrid('getRowData', row);					
					 var ret = $("#qnaGrid").getRowData(row)
					 $.ajax({
					    url   : "/admin/board/qna/mod.do",		    
					    type  : 'POST',
					    data  : ret,
				        error: function(){
					    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					    },
					    success: function(data){
					        $("#qnaForm").html(data);
					        $("#qnaForm" ).dialog( "open" );
					    }   
					});					
				}  
			},
		});
		
		$("#qnaForm").dialog({
	  		autoOpen: false,
	        resizable: true,
	        height: 800,
	        width: 1000,
	       // position: 'center',
	        modal: true,
	        title: '게시글 수정',
	        beforeClose: function(event, ui) { 
	           console.log('beforeClose');
	        },
	        close : function(){            
	           	$('#qnaForm').html("");
	        },
	        open: function(event, ui) { 
	        	$('.ui-widget-overlay').bind('click', function(){
	        		$("#qnaForm").dialog('close'); 
	        	});
	        },
	        buttons: {
	            "수정": function () {
	            	a_board_main('/admin/board/qna/mod_proc.do');
	            },
	            "닫기": function () {
	                $(this).dialog("close");
	            }
	        }		
	  	});
	});