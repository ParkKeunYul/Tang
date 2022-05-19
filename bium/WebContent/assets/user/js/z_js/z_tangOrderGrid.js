

$(document).ready(function() {
	$("#container").click(function() {
		$('.yakjae_popup').hide();
	});

	$("div.yakjae_popup").click(function() {	
		setTimeout(function(){
			$('.yakjae_popup').show()
		},5);
	});
	
	$("#jqGrid").jqGrid({
  		url : '/m05/04_select_main.do',
  		datatype: "local", 
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 100,
  		colNames:[
  			'번호 ','약재명', '상태', '원산지', '조재량', 
  			'g당단가', '<div style="padding-left:15px;">가격</div>' ,'group_cnt' ,'group_code',
  			'yak_code'
  		],
  		colModel:[
  			{name:'seqno'       ,index:'seqno'      ,width:180,	align:"left" 	,sortable : false ,editable:false ,key: true ,hidden:true },
  			{name:'yak_name'    ,index:'yak_name'   ,width:180,	align:"left" 	,sortable : false ,editable:false  },
  			{name:'yak_status'  ,index:'yak_status' ,width:70,	align:"center" 	,sortable : false ,editable:false
  				,edittype:"select"
  				,formatter: 'select'
					,editoptions:{
						value:"y:가능;n:불가;c:불가"
					}
  			},
  			{name:'yak_from'    ,index:'yak_from'   ,width:123,	align:"center" 	,sortable : false ,editable:false},
  			{name:'my_joje' 	,index:'my_joje'    ,width:90,	align:"right" 	,sortable : false 
  				,editable:true
  				,editoptions: {
  					 maxlength: 4
  					,dataEvents: [{
	  					type: 'keydown', 
	  		            fn: function(e) {
	  		            	try{init_yakjae_flag = false;}catch (e) {}
	  		                var key = e.charCode || e.keyCode;
	  		             	var tot = $("#jqGrid").getGridParam("records");
	  		                if (key == 9){					  		                	
	  		                	setTimeout(function () {			  	
	  		                		if(selIRow+1 > tot){
	  		                			$('#jqGrid').editCell(1,  5 , true);
										console.log('selIRow = ', selIRow);
										return false;
	  		                		}else{
	  		                			$('#jqGrid').editCell(selIRow+1,  5 , true);	
										console.log('selIRow = ', selIRow);
										return false;
	  		                		}	  		                		
	  		                  	},50);	
								return false;
	  		                }
	  		            }
  					},{
  						type: 'focus',
  						fn: function(e) {
  							$('input[name='+e.target.name+']').select();
  							return false;
  						}
	  				}]
  				  ,dataInit: function(element) {
	  	               $(element).keyup(function(){
		  	               var val1 = element.value;
		  	               
		  	               try{init_yakjae_flag = false;}catch (e) {}
		  	               
		  	               var num = new Number(val1);
		  	               if(isNaN(num)){		
		  	               	 element.value  = $(this).val().replace(/[^0-9]/g,"");
		  	               }
		  	               
		  	               if(lastRowId != -1){
						    	var record = $('#jqGrid').jqGrid('getRowData', lastRowId);
								var my_joje   = parseFloat( objToStr(element.value, 0));
						    	var yak_danga = parseFloat(record.yak_danga );
						    	var danga     = Math.ceil(my_joje * yak_danga);
								
								$("#jqGrid").setCell(lastRowId , 'danga', comma(danga+'')+'원' , {padding: '0 15px 0 0'});
								
								var rows = $("#jqGrid").getDataIDs();
								
								var tot_danga = 0;
								var tot_joje  = 0;
							    for (var i = 0; i < rows.length; i++){
							    	
							    	if(i == (selIRow -1) ){
							    		tot_danga = Math.ceil(tot_danga + danga);
							    		tot_joje  = tot_joje + my_joje;
							    	}else{
							    		var r_my_joje   = parseFloat($("#jqGrid").getCell(rows[i],"my_joje") );
							    			r_my_joje   = parseFloat( r_my_joje );
								    	var r_yak_danga = parseFloat($("#jqGrid").getCell(rows[i],"yak_danga") );
								    	
								    	var r_danga = Math.ceil(r_my_joje * r_yak_danga);
								    	
								    	tot_danga = tot_danga + r_danga;
								    	tot_joje  = tot_joje  + r_my_joje;
								    	
								    	tot_joje  = Math.floor(tot_joje * 100)/100;
								    	
							    	}
							    }
							    
							    var c_chup_ea = parseInt( $('#c_chup_ea').val() );
							    
							    $('#c_chup_g').val((tot_joje * c_chup_ea).toFixed(2));
							    $('#tot_yakjae_joje_txt').text(comma(tot_joje+''));												    
						    	$('#tot_yakjae_danga_txt').text(comma(tot_danga+''));
						    	
						    	yakjae_change_apply(tot_danga);
						    }
  	                
  	                });
  	                
  				  }
  				 }
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  			},
  			
  			{name:'yak_danga'	,index:'yak_danga'	,width:90,	align:"right" 	,sortable : false ,editable:false
  				,formatter: 'integer'
	  	  		,formatoptions:{thousandsSeparator:","}
  			},
  			{name:'danga'		,index:'danga' 			,width:100,	align:"right" 	,sortable : false ,editable:false},
  			{name:'group_cnt'	,index:'group_cnt' 		,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  			{name:'group_code'	,index:'group_code' 	,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  			{name:'yak_code'	,index:'group_code' 	,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  		],
		viewrecords: true,
		autowidth: true,				
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',				
		emptyrecords : '',
		multiselect: true,
		cellEdit :true,
		cellsubmit : 'clientArray',
		beforeSubmitCell : function(rowid, cellName, cellValue) { 
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		beforeEditCell : function(rowid, cellname, value, iRow, iCol){
			selICol   = iCol;
		    selIRow   = iRow;
		    lastRowId = rowid;
		},
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
		onCellSelect : function(row,iCol,cellcontent,e){
			
		},
		loadComplete: function(data) {
			var rows = $("#jqGrid").getDataIDs(); 		
			
			var tot_danga = 0;
			var tot_joje  = 0;
		    for (var i = 0; i < rows.length; i++){						    	
		    	var seqno     = parseInt($("#jqGrid").getCell(rows[i],"seqno"));
		    	
		    	var group_cnt = parseInt($("#jqGrid").getCell(rows[i],"group_cnt"));
		    	var yak_name  = $("#jqGrid").getCell(rows[i],"yak_name");
		    	
		    	if(group_cnt > 1){
		    		var group_code = $("#jqGrid").getCell(rows[i],"group_code");
		    		yak_name = yak_name + ' <a href="#" attr="'+rows[i]+'"  attr2="'+group_code+'" attr3="'+(i+1)+'"  class="btn_change btn_change_'+seqno+'"  ></a>';
		    	}
		    	
		    	
		    	$("#jqGrid").setCell(rows[i] , 'yak_name', yak_name , {padding: '0 0 0 10px'});
		    	
		    	
		    	var my_joje = $("#jqGrid").getCell(rows[i],"my_joje");
		    	$("#jqGrid").setCell(rows[i] , 'my_joje', "" , {padding: '0 25px 0 0'});
		    	
		    	var yak_status = $("#jqGrid").getCell(rows[i],"yak_status");
		    	if(yak_status != 'y'){
		    		$("#jqGrid").setCell(rows[i] , 'yak_status', "" ,  {color:'red',weightfont:'bold'});
		    	}
		    	
		    	
	    		$('.btn_change_'+seqno).bind('click',function() {
		    		var top = $(this).position().top;
		    		var left = $(this).position().left;
		    		
		    		$.ajax({
						url : '/m05/04_pop_yakjae.do',
						type: 'POST',
						data : {
							 seqno      : $(this).attr('attr')
							,group_code : $(this).attr('attr2')
							,a_yak_col  : $(this).attr('attr3')
						},
						error : function() {
							alert('에러가 발생했습니다.\n관리자에 문의하세요.');
						},
						success : function(html) {
							try{init_yakjae_flag = false;}catch (e) {}
							
							$('.yakjae_popup').html(html);
							$('.yakjae_popup').css("top",top+ 73 );
				    		$('.yakjae_popup').css("left",left);
				    		$('.yakjae_popup').show();
				    		
				    		for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
				    			$('#jqGrid').editCell(i,  5 , false);	
				    		}
						}
					});
		    		return false;
				});
		    }
		    
		    setTimeout(function(){
				tot_info();	 
			},50);
		    
	    	if(rows.length > 0){
	    		setTimeout(function(){
	    			 $('#jqGrid').editCell(1,  5 , true);
	    		},150);
	    	}
		},
		aftersavefunc: function( old_id ) {
			console.log('aftersavefunc = ',old_id);
		}
	});
	
	
	$("#yakjaeGrid").jqGrid({
  		url : '/m05/04_select_yakjae.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 8,
  		colNames:[
  			'번호','약재명', '상태' ,'원산지', '단가',
  			'선택',
  			
  			'약재코드', '기본값', '위치',  '약재설명', '그룹코드', 
  			'그룹명' , 'yak_danga' ,'group_cnt'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true , hidden:true},
  			{name:'yak_name',		index:'yak_name',		width:138,	align:"left"},
  			{name:'yak_status'     ,index:'yak_status' 		,width:60,	align:"center" 	,sortable : false ,editable:false
  				,edittype:"select"
  				,formatter: 'select'
					,editoptions:{
						value:"y:가능;n:불가;c:불가"
					}
  			},
  			{name:'yak_from',		index:'yak_from',		width:95,	align:"center"},
  			{name:'yak_danga_won',	index:'yak_danga_won',	width:80,	align:"right"},
  			{name:'sel_img',		index:'sel_img',		width:60,	align:"center"},
  			
  			
  			{name:'yak_code',		index:'yak_code',		width:208,	align:"center"  , hidden:true},
  			{name:'yak_made',		index:'yak_made',		width:70,	align:"center" , hidden:true},
  			{name:'yak_place',		index:'yak_place',		width:80,	align:"center" , hidden:true},
  			{name:'yak_contents',	index:'yak_contents',	width:416,	align:"left" , hidden:true},
  			{name:'group_code',	index:'group_code',	width:416,	align:"left" , hidden:true},
  			{name:'group_name',	index:'group_name',	width:416,	align:"left" , hidden:true},
  			{name:'yak_danga',		index:'yak_danga',		width:80,	align:"right",formatter: 'integer',formatoptions:{thousandsSeparator:","} , hidden:true},
  			{name:'group_cnt',		index:'group_cnt',		width:80,	align:"right",formatter: 'integer',formatoptions:{thousandsSeparator:","} , hidden:true},
  		],
		pager: "#yakjaeGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
		loadComplete: function(data) {
			var rows = $("#yakjaeGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				$("#yakjaeGrid").setCell(rows[i] , 'yak_name', "" ,  {padding: '0 0 0 15px'}); 
				
				
				var yak_status = $("#yakjaeGrid").getCell(rows[i],"yak_status");
		    	if(yak_status != 'y'){
		    		$("#yakjaeGrid").setCell(rows[i] , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); 
		    	}
		    	
		    	var yak_danga_won = $("#yakjaeGrid").getCell(rows[i],"yak_danga");
		    	$("#yakjaeGrid").setCell(rows[i] , 'yak_danga_won', yak_danga_won+'원' , {padding: '0 15px 0 0'});
		    	
		    	
		    		
	    		var seqno      = $("#yakjaeGrid").getCell(rows[i],"seqno");
	    		var yak_name   = $("#yakjaeGrid").getCell(rows[i],"yak_name");
	    		var yak_from   = $("#yakjaeGrid").getCell(rows[i],"yak_from");
	    		var yak_danga  = $("#yakjaeGrid").getCell(rows[i],"yak_danga");
	    		var group_code = $("#yakjaeGrid").getCell(rows[i],"group_code");
	    		var group_cnt  = $("#yakjaeGrid").getCell(rows[i],"group_cnt");
	    		var yak_code   = $("#yakjaeGrid").getCell(rows[i],"yak_code");
	    		var yak_status   = $("#yakjaeGrid").getCell(rows[i],"yak_status");
	    		
	    		
	    		var info = seqno+"||"+yak_name+"||"+yak_from+"||"+yak_danga+"||"+group_code+"||"+group_cnt+"||"+yak_code+"||"+yak_status;
	    		
	    		var sel_img = '<a href="#" attr="'+info+'"  class="addYakjaeBtn"><img src="/assets/user/images/sub/btn_list.png" alt="선택" class="vm" /></a>'; 
	    		$("#yakjaeGrid").setCell(rows[i] , 'sel_img', sel_img , null);
			}
			
			setTimeout(function(){
	    		$('.addYakjaeBtn').bind('click',function(){
	    			try{init_yakjae_flag = false;}catch (e) {}
	    			
	    			var info = $(this).attr('attr').split('||');
	    			
	    			var cnt = $("#jqGrid").getDataIDs();
	    			var jqRow    = 0;
	    			for (var i = 0; i < cnt.length; i++){
	    				if(info[0] ==cnt[i] ){
	    					setTimeout(function () {			  	
	    	    				$('#jqGrid').editCell(i+1,  5 , true);  		                		
	                      	},50);
		    				return false;	
	    				}
	    				jqRow ++;
	    			}
	    			jqRow ++;
	    			
	    			var addData = {
	    				 seqno      : info[0]
	    				,yak_name   : info[1]
	    				,yak_from   : info[2]
	    				,yak_danga  : info[3]
	    				,group_code : info[4]
	    				,group_cnt  : info[5]
	    				,yak_code   : info[6]
	    			    ,yak_status : info[7]
	    				,my_joje    : 0
	    				,danga      : 0+'원'
	    			};
	    			console.log('addData = ', addData);
					$("#jqGrid").jqGrid("addRowData", addData.seqno, addData); 
	    			
    				if(info[5] > 1){				    					
    					var yak_name = info[1] + ' <a href="#" attr="'+info[0]+'"  attr2="'+info[4]+'"  attr3="'+(jqRow)+'"  class="btn_change btn_change_'+info[0]+'"  ></a>';
    					$("#jqGrid").setCell(info[0] , 'yak_name',  yak_name , null);
    					layer_yakjae_group(info[0] , info[4] ,jqRow); 	
    				}
    				
	    			$("#jqGrid").setCell(addData.seqno , 'yak_name', '' , {padding: '0 0 0 10px'});
	    			$("#jqGrid").setCell(addData.seqno , 'my_joje', '' , {padding: '0 25px 0 0'});
	    			$("#jqGrid").setCell(addData.seqno , 'yak_danga', '' , {padding: '0 15px 0 0'});
	    			$("#jqGrid").setCell(addData.seqno , 'danga', '' , {padding: '0 15px 0 0'});
	    			
	    			
	    			if(info[7] != 'y'){
	    				$("#jqGrid").setCell(addData.seqno  , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); // 특정 cell 색상변경
	    			}
	    			
	    			var jqCnt = $("#jqGrid").getDataIDs();
	    			setTimeout(function () {			  	
	    				$('#jqGrid').editCell(jqCnt.length,  5 , true);  		                		
                  	},50);	
	    			
		    		return false;
				});
    		},100);
		},
	});
	
	$("#dicGrid").jqGrid({
  		url : '/m05/04_select_dic.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 8,
  		colNames:[
  			'번호','처방명', '출전' ,'선택 ',
  			'약재코드', 's_jomun' ,'item_list'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'s_name',			index:'s_name',		width:275,	align:"left"},
  			{name:'b_name',			index:'b_name',		width:105,	align:"center"},
  			{name:'sel_img',		index:'sel_img',	width:63,	align:"center"},
  			
  			
  			{name:'s_jukeung',		index:'s_jukeung',		width:208,	align:"center"  , hidden:true},
  			{name:'s_jomun',		index:'s_jomun',		width:208,	align:"center"  , hidden:true},
  			{name:'item_list',		index:'item_list',		width:208,	align:"center"  , hidden:true},
  		],
		pager: "#dicGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
		loadComplete: function(data) {
			var rows = $("#dicGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				
				$("#dicGrid").setCell(rows[i] , 's_name', '' , {padding: '0 0 0 15px', color : '#0b6d3a', cursor:'pointer' });
				
	    		var seqno      = $("#dicGrid").getCell(rows[i],"seqno");
	    		var s_name     = $("#dicGrid").getCell(rows[i],"s_name");
	    		var info 	   = seqno+"||"+s_name;
	    		var sel_img = '<img src="/assets/user/images/sub/btn_list.png" style="cursor:pointer;" alt="선택" class="vm" />'; 
	    		$("#dicGrid").setCell(rows[i] , 'sel_img', sel_img , null);
			}
			
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			var data = $("#dicGrid").jqGrid('getRowData', row);
			 try{init_yakjae_flag = false;}catch (e) {}
			 if(iCol == 1){
				 $("#dic_txt_sname").html(data.s_name);
				 $("#dic_txt_bname").html(data.b_name);
				 $("#dic_txt_jomun").html(data.item_list);
				 $('#list_popup01').show();
				 
				 
				 $('#dic_pop_detail').attr('href', '/m02/02_dictionary_popup.do?seqno='+data.seqno);
			 }else if(iCol == 3){
				 
				 $('#b_name').val(data.b_name);
				 $('#s_name').val(data.s_name);
				 
				 $.ajax({
					url : '/m02/02_dic_sublist.do',
					type: 'POST',
					data : {
						seqno : row,
					},
					error : function() {
						alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					},
					success : function(list) {
						var jqRow    = 0;
						for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
			    			$('#jqGrid').editCell(i,  5 , false);
			    			jqRow ++;
			    		}
						
						$('#s_name').val(data.s_name);
						
						
						for(var k = 0; k < list.length ; k++){
							var duple = true;
							var cnt = $("#jqGrid").getDataIDs();
			    			for (var i = 0; i < cnt.length; i++){
			    				if(cnt[i] == list[k].seqno ){				    					
				    				duple = false;
			    				}
			    			}
							
			    			
			    			if(duple){ 
			    				jqRow ++;
			    				
			    				var addData = {
			   	    				 seqno      : list[k].seqno
			   	    				,yak_name   : list[k].yak_name
			   	    				,yak_code   : list[k].yak_code
			   	    				,yak_from   : list[k].yak_from
			   	    				,yak_danga  : list[k].yak_danga
			   	    				,group_code : list[k].group_code
			   	    				,group_cnt  : list[k].group_cnt
			   	    			    ,yak_status : list[k].yak_status
			   	    				,my_joje    : list[k].dy_standard
			   	    			};
			    				$("#jqGrid").jqGrid("addRowData", addData.seqno, addData);
			    				
			    				
				    			if(list[k].group_cnt > 1){ 
			    					var yak_name = list[k].yak_name + ' <a href="#" attr="'+list[k].seqno+'"  attr2="'+list[k].group_code+'"   attr3="'+jqRow+'"   class="btn_change btn_change_'+list[k].seqno+'"  ></a>';
			    					$("#jqGrid").setCell(list[k].seqno , 'yak_name',  yak_name , null);
			    					layer_yakjae_group(list[k].seqno , list[k].group_code ,jqRow); 	
			    				}
				    			
				    			if(list[k].yak_status != 'y'){
				    				$("#jqGrid").setCell(addData.seqno  , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); 
				    			}
				    			
			    			}else{ 
			    				
			    				var my_joje     = parseFloat( $("#jqGrid").getCell(list[k].seqno,"my_joje") );
			    				var danga       = parseFloat( $("#jqGrid").getCell(list[k].seqno,"danga").replace('원', '') );
			    				
			    				my_joje   = my_joje + parseFloat(list[k].dy_standard);
			    				danga     = danga + parseFloat(list[k].yak_danga);
			    				
			    				$("#jqGrid").setCell(list[k].seqno , 'my_joje'  , my_joje , {padding: '0 25px 0 0'});
				    			$("#jqGrid").setCell(list[k].seqno , 'danga'    , danga +'원', {padding: '0 15px 0 0'});
			    			}
						}
						setTimeout(function(){
							 tot_info();
		    				 $('#jqGrid').editCell(1,  5 , true);  		                		
						},100);
						alert('추가되었습니다.');
					}
				});
			 }
		},
	});
	
	
	$("#myDicGrid").jqGrid({
  		url : '/m05/04_select_mydic.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 8,
  		colNames:[
  			'번호','처방명', '출전' ,'선택 ',
  			
  			'약재코드', 's_jomun' ,'item_list'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'s_name',			index:'s_name',		width:275,	align:"left"},
  			{name:'b_name',			index:'b_name',		width:105,	align:"center"},
  			{name:'sel_img',		index:'sel_img',	width:63,	align:"center"},
  			
  			
  			{name:'s_jukeung',		index:'s_jukeung',		width:208,	align:"center"  , hidden:true},
  			{name:'s_jomun',		index:'s_jomun',		width:208,	align:"center"  , hidden:true},
  			{name:'item_list',		index:'item_list',		width:208,	align:"center"  , hidden:true},
  		],
		pager: "#myDicGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
		loadComplete: function(data) {
			var rows = $("#myDicGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				
				$("#myDicGrid").setCell(rows[i] , 's_name', '' , {padding: '0 0 0 15px', color : '#0b6d3a', cursor:'pointer' });
				
	    		var seqno      = $("#myDicGrid").getCell(rows[i],"seqno");
	    		var s_name     = $("#myDicGrid").getCell(rows[i],"s_name");
	    		var info 	   = seqno+"||"+s_name;
	    		
	    		var sel_img = '<img src="/assets/user/images/sub/btn_list.png" style="cursor:pointer;" alt="선택" class="vm" />'; 
	    		$("#myDicGrid").setCell(rows[i] , 'sel_img', sel_img , null);
			}
			
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			var data = $("#myDicGrid").jqGrid('getRowData', row);
			 try{init_yakjae_flag = false;}catch (e) {}
			 if(iCol == 1){
				 console.log('myDicGrid data = ', data);
				 $("#mydic_txt_sname").html(data.s_name);
				 $("#mydic_txt_bname").html(data.b_name);
				 $("#mydic_txt_jomun").html(data.item_list);
				 
				 $('#list_popup02').show();
				 
				 $('#mydic_pop_detail').attr('href', '/m05/04_dictionary_popup.do?seqno='+data.seqno);
				 
			 }else if(iCol == 3){
				 console.log('data = ', data);
				 $('#s_name').val(data.s_name);
				 $('#b_name').val(data.b_name);
				$.ajax({
					url : '/m05/04_mydic_yakjaeInfo.do',
					type: 'POST',
					data : {
						my_seqno : data.seqno,
					},
					error : function() {
						alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					},
					success : function(list) {
						var jqRow    = 0;
						for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
			    			$('#jqGrid').editCell(i,  5 , false);
			    			jqRow ++;
			    		}
						
						for(var k = 0; k < list.length ; k++){
							
							var duple = true;
							var cnt = $("#jqGrid").getDataIDs();
			    			for (var i = 0; i < cnt.length; i++){
			    				if(cnt[i] == list[k].seqno ){				    					
				    				duple = false;
			    				}
			    			}
			    			
			    			if(duple){
			    				jqRow ++;
			    				
			    				var addData = {
			   	    				 seqno      : list[k].seqno
			   	    				,yak_name   : list[k].yak_name
			   	    				,yak_code   : list[k].yak_code
			   	    				,yak_from   : list[k].yak_from
			   	    				,yak_danga  : list[k].yak_danga
			   	    				,group_code : list[k].group_code
			   	    				,group_cnt  : list[k].group_cnt
			   	    			    ,yak_status : list[k].yak_status
			   	    				,my_joje    : list[k].my_joje
			   	    				,danga      : list[k].tot_yak_danga+'원'
			   	    			};
			    				$("#jqGrid").jqGrid("addRowData", addData.seqno, addData);
			    				
				    			if(list[k].group_cnt > 1){ 
			    					var yak_name = list[k].yak_name + ' <a href="#" attr="'+list[k].seqno+'"  attr2="'+list[k].group_code+'"  attr3="'+jqRow+'"   class="btn_change btn_change_'+list[k].seqno+'"  ></a>';
			    					$("#jqGrid").setCell(list[k].seqno , 'yak_name',  yak_name , null);
			    					layer_yakjae_group(list[k].seqno , list[k].group_code ,jqRow); 	
			    				}
				    			
				    			if(list[k].yak_status != 'y'){
				    				$("#jqGrid").setCell(addData.seqno  , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); 
				    			}
				    			
			    			}else{
			    				
			    				var my_joje     = parseFloat( $("#jqGrid").getCell(list[k].seqno,"my_joje") );
			    				var danga       = parseFloat( $("#jqGrid").getCell(list[k].seqno,"danga").replace('원', '') );
			    				
			    				my_joje   = my_joje + parseFloat(list[k].my_joje);
			    				danga     = danga   + parseFloat(list[k].tot_yak_danga);
			    				
			    				$("#jqGrid").setCell(list[k].seqno , 'my_joje'  , my_joje , {padding: '0 25px 0 0'});
				    			$("#jqGrid").setCell(list[k].seqno , 'danga'    , danga +'원', {padding: '0 15px 0 0'});
			    				
			    			} 
						}
						setTimeout(function(){
							 tot_info();
							 $('#jqGrid').editCell(1,  5 , true);
						},100);
						alert('추가되었습니다.');
					}
				});
						
			 }
		},
	});
	
	
	$("#yakjaeGrid").jqGrid('navGrid','#yakjaeGridControl',
		{add:false,del:false,edit:false,search:false,refresh:false,position:'left'}	  				  	
	);					
	
	
	$("#yakjaeSearchBtn").click(function() {
		yakjae_search_btn( $('#yakjae_search_value').val(), ''  );
		
		$('.yakjae_search_han2 li a').removeClass('sel');
		$('.yakjae_search_han2').children().first().children().addClass('sel');
		return false;
	});
	
	$("#yakjae_search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			yakjae_search_btn($('#yakjae_search_value').val(), '' );
			
			$('.yakjae_search_han2 li a').removeClass('sel');
			$('.yakjae_search_han2').children().first().children().addClass('sel');
		}
	});
	
	$(".yakjae_search_han2 li a").click(function() {
		console.log($(this).attr('attr'));
		yakjae_search_btn('', $(this).attr('attr') );
		
		$('.yakjae_search_han2 li a').removeClass('sel');
		$(this).addClass('sel');
		return false;
	});
	
	
	$("#yakjaeMultiSearchBtn").click(function() {
		yakjae_multi_search_btn( $('#yakjae_multi_value') );
		return false;
	});
	
	$("#yakjae_multi_value").keydown(function(key) {
		if (key.keyCode == 13) {
			yakjae_multi_search_btn(  $('#yakjae_multi_value')  );
		}
	});
	
	
	$(".dic_search_han2 li a").click(function() {
		console.log($(this).attr('attr'));
		dic_search_btn('', $(this).attr('attr') );
		
		$('.dic_search_han2 li a').removeClass('sel');
		$(this).addClass('sel');
		return false;
	});
	
	$(".dic_btn_close li a").click(function() {
		$('.dic_search_han2 li a').removeClass('sel');
		$(this).addClass('sel');
		return false;
	});
	
	
	$("#dic_search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			dic_search_btn($('#dic_search_value').val(), '' );
			
			$('.dic_search_han2 li a').removeClass('sel');
			$('.dic_search_han2').children().first().children().addClass('sel');
		}
	});
	
	$(".dic_btn_close").click(function() {
		$('#list_popup01').hide();
		return false;
	});
	
	$("#dic_pop_detail").click(function(){
		var popupX = (window.screen.width / 2) - (1000 / 2);
		var popupY = (window.screen.height / 2) - (700 / 2);
		
		$('#list_popup01').hide();
		
		window.open($(this).attr('href'),'window팝업','width=1000, height=700, menubar=no, status=no, toolbar=no,left='+popupX);
		return false;
	});
	
	$(".myDic_search_han2 li a").click(function() {
		
		mydic_search_btn('', $(this).attr('attr') );
		
		$('.myDic_search_han2 li a').removeClass('sel');
		$(this).addClass('sel');
		return false;
	});
	
	$("#mydic_search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			mydic_search_btn($('#mydic_search_value').val(), '' );
			
			$('.myDic_search_han2 li a').removeClass('sel');
			$('.myDic_search_han2').children().first().children().addClass('sel');
		}
	});
	
	$("#mydicSearchBtn").click(function() {
		mydic_search_btn( $('#mydic_search_value').val(), ''  );
		
		$('.myDic_search_han2 li a').removeClass('sel');
		$('.myDic_search_han2').children().first().children().addClass('sel');
		return false;
	});
	
	
	$("#mydic_pop_detail").click(function(){
		var popupX = (window.screen.width / 2) - (1000 / 2);
		var popupY = (window.screen.height / 2) - (700 / 2);
		
		$('#list_popup02').hide();
		
		window.open($(this).attr('href'),'window팝업','width=1000, height=700, menubar=no, status=no, toolbar=no,left='+popupX);
		return false;
	});
	
	$(".mydic_btn_close").click(function() {
		$('#list_popup02').hide();
		return false;
	});	
	
});




function mydic_search_btn(search_value , search_ch){
	var param = {
		 search_value  : search_value
		,search_title  : 's_name'
		,search_ch     : search_ch
	};
	$("#myDicGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}


function validNum(val, nm, valref){
	if($.isNumeric(val)){
		
	}else{
       alert('숫자만 입력가능합니다.');
	}
}


function yakjae_multi_search_btn(search){
	if(search.val() == null || search.val() == ''){
		alert('약재명을 입력하세요.');
		search.focus();
		return false;
	}
	
	$.ajax({
		url : '/m05/04_add_yakjae_multi.do',
		type: 'POST',
		data : {
			search_value : search.val(),
		},
		error : function() {
			alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		},
		success : function(list) {
			
			var jqRow    = 0;
			for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
    			$('#jqGrid').editCell(i,  5 , false);
    			jqRow ++;
    		}
			
			for(var k = 0; k < list.length ; k++){
				console.log('yakjae_multi_search_btn = ', list[k]);
				
				var duple = true;
				var cnt = $("#jqGrid").getDataIDs();
				
    			for (var i = 0; i < cnt.length; i++){
    				if(cnt[i] == list[k].seqno  ){				    					
	    				duple = false;
    				}
    			}
    			
    			if(duple){
    				jqRow ++;
    				
    				var addData = {
	    				 seqno      : list[k].seqno
	    				,yak_name   : list[k].yak_name
	    				,yak_code   : list[k].yak_code
	    				,yak_from   : list[k].yak_from
	    				,yak_danga  : list[k].yak_danga
	    				,group_code : list[k].group_code
	    				,group_cnt  : list[k].group_cnt
	    			    ,yak_status : list[k].yak_status
	    				,my_joje    : 0
	    				,danga      : 0+'원'
	    			};
					$("#jqGrid").jqGrid("addRowData", addData.seqno, addData); 
	    				
    				if(list[k].group_cnt > 1){ 
    					var yak_name = list[k].yak_name + ' <a href="#" attr="'+list[k].seqno+'"  attr2="'+list[k].group_code+'" attr3="'+jqRow+'"  class="btn_change btn_change_'+list[k].seqno+'"  ></a>';
    					$("#jqGrid").setCell(list[k].seqno , 'yak_name',  yak_name , null);
    					layer_yakjae_group(list[k].seqno , list[k].group_code ,jqRow ); 
    				}
    				
    				if(list[k].yak_status != 'y'){
	    				$("#jqGrid").setCell(addData.seqno  , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); 
	    			}
	    			
    			}
			}
			search.val('');
			setTimeout(function(){
				 tot_info();	 
			},100);
		}
	});
}

function yakjae_search_btn(search_value , search_ch){
	var param = {
		 search_value  : search_value
		,search_ch     : search_ch
	};
	$("#yakjaeGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}


function dic_search_btn(search_value , search_ch){
	var param = {
		 search_value  : search_value
		,search_title  : 's_name'
		,search_ch     : search_ch
	};
	$("#dicGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}

function layer_yakjae_group(seqno, group_code , jqRow) {
	
	setTimeout(function() {
		$('.btn_change_' + seqno).bind('click',function() {
			var top = $(this).position().top;
			var left = $(this).position().left;

			$.ajax({
				url : '/m05/04_pop_yakjae.do',
				type : 'POST',
				data : {
					 seqno      : seqno
					,group_code : group_code
					,a_yak_col  : jqRow
				},
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(html) {
					$('.yakjae_popup').html(html);
					$('.yakjae_popup').css("top", top + 73);
					$('.yakjae_popup').css("left", left);
					$('.yakjae_popup').show();

					for (var i = 1; i <= $("#jqGrid").getGridParam("records"); i++) {
						$('#jqGrid').editCell(i, 5, false);
					}
				}
			});
			return false;
		});
	}, 100);
}