$(document).ready(function() {
		
		  	$("#jqGrid").jqGrid({
		  		//caption : '최근 로그인 정보',
		  		//dataType : 'local', // 로딩시 최초 조회 		  		
		  		datatype: "local", 
		  		url : 'select.do',
		  		datatype: 'local',
		  		hidegrid: false,
		  		width: "100%",
		  		height: "100%",
		  		rowNum: 100000,
		  		//rowList: [20,50,100,500],
		  		//rowList: [3],
		  		colNames:[
		  			'yak_seqno', '번호' , '약재명' , '그룹명'   , '원산지' ,
		  			'g당단가'    , '사용량', '입고량' , 'yak_code'
		  		],
		  		colModel:[
		  			{name:'yak_seqno',		index:'yak_seqno',		width:48,	align:"center"  ,sortable : false ,hidden:true },
		  			{name:'num_txt',		index:'num_txt',		width:48,	align:"center"  ,sortable : false},
		  			{name:'yak_name',		index:'yak_name',		width:220,	align:"left"    ,sortable : false},
		  			{name:'group_name',		index:'group_name',		width:120,	align:"left"  	,sortable : false},
		  			{name:'yak_from',		index:'yak_from',		width:100,	align:"center"  ,sortable : false},
		  			
		  			{name:'yak_danga',		index:'yak_danga',		width:100,	align:"right"   ,sortable : false
		  				,formatter: 'integer',formatoptions:{thousandsSeparator:","},
		  			},
		  			{name:'use_cnt',		index:'use_cnt',		width:100,	align:"right"   ,sortable : false
		  				,formatter: 'integer',formatoptions:{thousandsSeparator:","},
		  			},
		  			{name:'part_cnt',		index:'part_cnt',		width:100,	align:"right"   ,sortable : false
		  				,formatter: 'integer',formatoptions:{thousandsSeparator:","},
		  			},
		  			{name:'yak_code',		index:'yak_code',		width:100,	align:"center"  ,sortable : false ,hidden:true},
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
					for (var i = 0; i < rows.length; i++){
						$("#jqGrid").setCell(rows[i] , 'num_txt', i+1); // 특정 cell 색상변경
					}// for
				},
				onSelectRow : function(rowid, status, e){
					var record = $("#jqGrid").jqGrid('getRowData', rowid);
					
					var search_sday    = $('#search_sday').val();
					var search_eday    = $('#search_eday').val();
					
					record.search_sday = search_sday;
					record.search_eday = search_eday;
					
					var html = "<font color='blue'>["+record.yak_name+"]</font>";
					
					$("#useGrid").jqGrid('setCaption',  html+ " 일짜별 사용량 정보[g]");
					$("#useGrid").setGridParam({"postData": record ,datatype: "json", mtype: 'POST'}).trigger("reloadGrid",[{page : 1}]);
					
					
					$("#addGrid").jqGrid('setCaption',  html+ " 입고현황");
					$("#addGrid").setGridParam({"postData": record ,datatype: "json", mtype: 'POST'}).trigger("reloadGrid",[{page : 1}]);
					
				}
			});
		  	
		  	//페이지 넘 
		  	jQuery("#jqGrid").jqGrid('navGrid','#jqGridControl',
		  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
		  	);
		  	
		  	
		  	$('#search_btn').click(function() {
		  		var search_sday    = $('#search_sday').val();
				var search_eday    = $('#search_eday').val();
				var search_yaknm   = $('#search_yaknm').val();
				var search_groupnm = $('#search_groupnm').val();
				var search_from    = $('#search_from').val();
				
					
				var param = { 
					 search_sday    : search_sday
					,search_eday    : search_eday
					,search_yaknm   : search_yaknm
					,search_groupnm : search_groupnm
					,search_from    : search_from
					,pageSearch     : 1
				};
				
				$("#jqGrid").setGridParam({"postData": param ,datatype: "json", mtype: 'POST'}).trigger("reloadGrid",[{page : 1}]);
				
				return false;
			});
		  	
		  	$.datepicker.setDefaults({
				changeMonth: true,
				changeYear: true,
				dateFormat: 'yy-mm-dd'
				//inline: true
			});
		  	
			$(".date").datepicker({});
			
			var today = getDay();
			
			$('#search_sday').val( today );
			//$('#search_sday').val( today.substr(0,8)+'01' );
			$('#search_eday').val( today );
			
			
			
			$("#useGrid").jqGrid({
		  		caption : ' 일짜별 사용량 정보[g]',
		  		//dataType : 'local', // 로딩시 최초 조회 		  		
		  		datatype: "local", 
		  		url : 'select_use.do',
		  		datatype: 'local',
		  		hidegrid: false,
		  		width: '90%',
		  		height: "100%",
		  		rowNum: 100000,
		  		//rowList: [20,50,100,500],
		  		//rowList: [3],
		  		colNames:[
		  			 '번호' , '날짜' , '사용량' 
		  		],
		  		colModel:[
		  			{name:'num_txt',	index:'num_txt',	width:50,	align:"center"  ,sortable : false},
		  			{name:'wdate',		index:'wdate',		width:120,	align:"center"  ,sortable : false},
		  			{name:'tot',		index:'tot',		width:100,	align:"right"   ,sortable : false
		  				,formatter: 'integer',formatoptions:{thousandsSeparator:","},
		  			}		  			
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
					
					var rows = $("#useGrid").getDataIDs();
					for (var i = 0; i < rows.length; i++){
						$("#useGrid").setCell(rows[i] , 'num_txt', i+1); // 특정 cell 색상변경
					}// for
				},
			});
			
			
			$("#addGrid").jqGrid({
		  		caption : ' 입고현황',
		  		//dataType : 'local', // 로딩시 최초 조회 		  		
		  		datatype: "local", 
		  		url : 'select_add.do',
		  		datatype: 'local',
		  		hidegrid: false,
		  		width: '90%',
		  		height: "100%",
		  		rowNum: 100000,
		  		//rowList: [20,50,100,500],
		  		//rowList: [3],
		  		colNames:[
		  			 '번호' , '날짜' , '입고량' 
		  		],
		  		colModel:[
		  			{name:'num_txt',	index:'num_txt',	width:50,	align:"center"  ,sortable : false},
		  			{name:'add_date',	index:'add_date',		width:120,	align:"center"  ,sortable : false},
		  			{name:'tot',		index:'tot',		width:100,	align:"right"   ,sortable : false
		  				,formatter: 'integer',formatoptions:{thousandsSeparator:","},
		  			}		  			
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
					var rows = $("#addGrid").getDataIDs();
					for (var i = 0; i < rows.length; i++){
						$("#addGrid").setCell(rows[i] , 'num_txt', i+1); // 특정 cell 색상변경
					}// for
				},
			});
	});
	
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