
var a_sale_per = 0; 
$(document).ready(function() {
	
	a_sale_per = parseInt( $('#sale_per').val() );
	//$('#c_joje_contents').val( $('#joje_name option:selected').attr('attr') );
	$('#c_bokyong_contents').val( $('#bok_name option:selected').attr('attr') );
	
	$("#jqGrid").jqGrid({
  		
  		datatype: "local", 
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 100,
  		colNames:[
  			'번호 ','약재명', '상태', '원산지', '조재량', 
  			'g당단가', '<div style="padding-left:15px;">가격</div>' ,'group_cnt' ,'group_code',
  			'yak_code' , 'tot_yak_danga'
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
  				,formatter: 'integer'
  				,formatoptions:{thousandsSeparator:","}
  			},
  			
  			{name:'yak_danga'	,index:'yak_danga'	,width:90,	align:"right" 	,sortable : false ,editable:false
  				,formatter: 'integer'
	  	  		,formatoptions:{thousandsSeparator:","}
  				,hidden:true
  			},
  			{name:'danga'		,index:'danga' 			,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  			{name:'group_cnt'	,index:'group_cnt' 		,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  			{name:'group_code'	,index:'group_code' 	,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  			{name:'yak_code'	,index:'group_code' 	,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  			{name:'tot_yak_danga'	,index:'tot_yak_danga' 	,width:100,	align:"right" 	,sortable : false ,editable:false ,hidden:true},
  		],
		viewrecords: true,
		autowidth: true,				
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',				
		emptyrecords : '',
		multiselect: false,
		cellEdit :false,
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
			
			var my_joje = 0;
			
			for (var i = 0; i < rows.length; i++){
				
				 my_joje += parseFloat($("#jqGrid").getCell(rows[i],"my_joje"));
				 
				 var tot_yak_danga = $("#jqGrid").getCell(rows[i],"tot_yak_danga");
				 
				 console.log('tot_yak_danga = '+i, tot_yak_danga);
				$("#jqGrid").setCell(rows[i] , 'yak_name', "" ,  {padding: '0 0 0 10px'});
				$("#jqGrid").setCell(rows[i] , 'my_joje', "" ,  {padding: '0 30px 0 0px'});
				$("#jqGrid").setCell(rows[i] , 'danga', tot_yak_danga ,  null);
			};
			
			$('#tot_yakjae_joje_txt').html(my_joje);
			
			//load_jqgird_after();
		},
		aftersavefunc: function( old_id ) {
			console.log('aftersavefunc = ',old_id);
		}
	});
	
	
	
	/*환자검색*/
	$("#patientGrid").jqGrid({
  		//caption : '모든 약재정보',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/m05/05_select_patient.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 5,
  		//rowList: [10],
  		//rowList: [3],
  		colNames:[
  			'번호','환자명','성별/나이', '연락처' ,'최근처방일 ',
  			
  			 '선택',
  			
  			'증상', '성별' , 'birth_year' , '집전화' , '만나이',
  			'우편', '주소1', '주소2'       , 'etc1'  , 'etc2',
  			'진단', '체형' , '차트번호'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'name',			index:'name',		width:110,	align:"left"},
  			{name:'info',			index:'info',		width:80,	align:"center"},
  			{name:'handphone',		index:'handphone',	width:110,	align:"center"},
  			{name:'last_order',		index:'last_order',	width:100,	align:"center"},
  			
  			{name:'sel_img',		index:'sel_img',		width:60,	align:"center"},
  			
  			
  			{name:'contents',		index:'contents',		width:208,	align:"center"  , hidden:true},
  			{name:'sex',			index:'sex',		width:208,	align:"center"  , hidden:true},
  			{name:'birth_year',		index:'birth_year',		width:208,	align:"center"  , hidden:true},
  			{name:'tel',			index:'tel',		width:208,	align:"center"  , hidden:true},
  			{name:'age',			index:'age',		width:208,	align:"center"  , hidden:true},
  			
  			{name:'zipcode',		index:'zipcode',		width:208,	align:"center"  , hidden:true},
  			{name:'address01',		index:'address01',		width:208,	align:"center"  , hidden:true},
  			{name:'address02',		index:'address02',		width:208,	align:"center"  , hidden:true},
  			{name:'etc1',			index:'etc1',		width:208,	align:"center"  , hidden:true},
  			{name:'etc2',			index:'etc2',		width:208,	align:"center"  , hidden:true},
  			
  			{name:'jindan',			index:'jindan',		width:208,	align:"center"  , hidden:true},
  			{name:'size',			index:'size',		width:208,	align:"center"  , hidden:true},
  			{name:'chart_num',		index:'chart_num',		width:208,	align:"center"  , hidden:true},
  		],
		pager: "#patientGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
		loadComplete: function(data) {
			var rows = $("#patientGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				
	    		var seqno      = $("#patientGrid").getCell(rows[i],"seqno");
	    		var sex        = $("#patientGrid").getCell(rows[i],"sex");
	    		var birth_year = $("#patientGrid").getCell(rows[i],"birth_year");
	    		var name 	   = $("#patientGrid").getCell(rows[i],"name");
	    		
	    		var age        = calcAge(birth_year);
	    		var info 	   = sex+"/"+age;
	    		
	    		$("#patientGrid").setCell(rows[i] , 'name', '' , {padding: '0 0 0 15px', color : '#0b6d3a', cursor:'pointer' });
	    		$("#patientGrid").setCell(rows[i] , 'info',  info , null);
	    		$("#patientGrid").setCell(rows[i] , 'age',  age , null);
	    		
	    		var sel_img = '<img src="/assets/user/pc/images/sub/btn_list.png" style="cursor:pointer;" alt="선택" class="vm" />'; 
	    		$("#patientGrid").setCell(rows[i] , 'sel_img', sel_img , null);
			}// for
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			 try{init_yakjae_flag = false;}catch (e) {}
			var data = $("#patientGrid").jqGrid('getRowData', row);
			//console.log('data =', data);
			if(iCol  == 1){
				patient_row = row;
				
				$('.patient_search').hide();
				$('.detail_info').show();
				
				$('.patientArea li a').removeClass( 'sel' );
				$('.patientArea li.sec a').addClass( 'sel' );
				
				$('.p_name_txt').html(data.name);
				$('.p_chart_txt').html(data.chart_num);
				$('.p_info_txt').html(data.info);
				$('.p_sex_txt').html(data.sex);
				$('.p_tel_txt').html(data.tel);
				$('.p_handphnoe_txt').html(data.handphone);
				$('.p_zipcode_txt').html(data.zipcode);
				$('.p_address01_txt').html(data.address01);
				$('.p_address02_txt').html(data.address02);
				$('.p_size_txt').html(data.size.replace(/(\n|\r\n)/g, ''));
				$('.p_jindan_txt').html(data.jindan.replace(/(\n|\r\n)/g, ''));
				$('.p_contents_txt').html(data.contents.replace(/(\n|\r\n)/g, ''));
				$('.p_etc1_txt').html(data.etc1.replace(/(\n|\r\n)/g, ''));					
				
				
				
			}else if(iCol  == 5){										
		//		console.log('환자선택');
				selPatientInfo(data);
			}
		}
	});// 환자그리드
	
	
	$('#patientSelectBtn').click(function() {
		var data = $("#patientGrid").jqGrid('getRowData', patient_row);
		selPatientInfo(data);
		return false;
	});
	
	$('#patientSearchBtn').click(function() {
		var param = { 
			 search_type    : $('#pat_search_titile').val()
			,search_value   : $('#pat_search_value').val()
		};
		$("#patientGrid").setGridParam({"postData": param ,datatype: "json", mtype: 'POST'}).trigger("reloadGrid",[{page : 1}]);
		return false;
	});
	
	$("#pat_search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			var param = { 
				 search_type    : $('#pat_search_titile').val()
				,search_value   : $('#pat_search_value').val()
			};
			$("#patientGrid").setGridParam({"postData": param ,datatype: "json", mtype: 'POST'}).trigger("reloadGrid",[{page : 1}]);
		}
	});
	
	
	$('#patientDelBtn').click(function() {
		$('#wp_seqno').val('');
		$('#w_jindan').val('');
		$('#w_name').val('');
		$('#w_name_sel').val('');
		$('#w_age').val('');
		$('#w_birthyear').val('');
		$('#w_etc01').val('');
		$('#w_etc02').val('');
		$('#w_address01').val('');
		$('#w_address02').val('');
		$('#w_zipcode').val('');
		$('#w_contents').val('');
		$('#w_sex').val('');
		
		$('#w_name').attr('readonly', false);
		//$('#w_contents').attr('readonly', false);
		$('#w_name').focus();
		return false;
	});
	
	$("#p_listBtn").click(function() {
		$('.patient_search').show();
		$('.detail_info').hide();
		
		$('.patientArea li a').removeClass( 'sel' );
		$('.patientArea li.fir a').addClass( 'sel' );
		
		return false;
	});
	
	/*환자검색 끝*/
	
	
	
	/*이전처방 탭*/
	$("#fastGrid").jqGrid({
  		//caption : '모든 약재정보',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/m02/06_select_fast.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 8,
  		colNames:[
  			'시퀀스', '처방명', '탕전방식', '판매가격' , '선택',
  					
  			//기타정보
  			'첩수', '총약재량' ,'팩용량', '팩겟수', '파우치',
  			'박스', '스티로폼','출전' , '첩당가격' , '박스수량', 
  			'주수'
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',			width:28,	align:"center" ,key: true , hidden:true},
  			{name:'tang_name',		index:'tang_name',		width:218,	align:"left" ,sortable : false},
  			{name:'c_tang_type',	index:'c_tang_type',	width:80,	align:"center" ,sortable : false
  				,edittype:"select"
  				,editoptions:{
  					 value:"1:첩약;2:무압력탕전;3:압력탕전"  						
  				}		  				
  				,formatter: 'select'
  			},
  			{name:'price',			index:'price',			width:90,	align:"right" ,sortable : false,
  				formatter: 'integer', 
  				formatoptions:{thousandsSeparator:","},
  			},
  			{name:'sel_img',		index:'sel_img',		width:60,	align:"center" ,sortable : false},
  			
  			// 기타
  			{name:'c_chup_ea',		index:'c_chup_ea',		width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'c_chup_g',		index:'c_chup_g',		width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'c_pack_ml',		index:'c_pack_ml',		width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'c_pack_ea',		index:'c_pack_ea',		width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'c_pouch_type',	index:'c_pouch_type',	width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'c_box_type',		index:'c_box_type',		width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'c_stpom_type',	index:'c_stpom_type',	width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'jo_from',		index:'jo_from',		width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'c_chup_ea_price',		index:'c_chup_ea_price',		width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'c_box_ea',		index:'c_box_ea',		width:60,	align:"center" ,sortable : false , hidden : true},
  			{name:'c_tang_check',		index:'c_tang_check',		width:60,	align:"center" ,sortable : false , hidden : true}
  			
  			
  		],
		pager: "#fastGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
		loadComplete: function(data) {
			var rows = $("#fastGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				
				var seqno      = $("#fastGrid").getCell(rows[i],"seqno");
				var info       = seqno;
				
				
				$("#fastGrid").setCell(rows[i] , 'tang_name', '' , {padding: '0 0 0 15px', color : '#0b6d3a', cursor:'pointer' });
				$("#fastGrid").setCell(rows[i] , 'c_tang_type', '' , {padding: '0 0 0 3px' });
				$("#fastGrid").setCell(rows[i] , 'price', '' , {color : '#ea0c0c',padding: '0 12px 0 0' });
				
				var sel_img = '<img src="/assets/user/pc/images/sub/btn_list.png" alt="선택" class="vm"  style="cursor: pointer;"/>';
				
				$("#fastGrid").setCell(rows[i] , 'sel_img', sel_img , null);
			}// for
			
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			
			var data = $("#fastGrid").jqGrid('getRowData', row);
			
			console.log('data = ', data);
			console.log('iCol = ', iCol);
			console.log('row = ', row);
			
			
			if(iCol == 1){ // 상세보기
				//$('#list_popup').show();
				$.ajax({
					url : '/m02/06_pop.do',
					type: 'POST',
					data : {
						seqno : data.seqno
					},
					error : function() {
						alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					},
					success : function(res) {
						$('#list_popup').html(res);
						
						$('#list_popup').css('top', (207+( (row -1) *33 ))+'px');
						
						$('#list_popup').show();
					}
				});
			}
			else if(iCol == 4){
				$('#c_tang_type').val(data.c_tang_type);
				$('#c_chup_ea').val(data.c_chup_ea);
				$('#c_chup_ea_price').val(data.c_chup_ea_price);
				$('#c_chup_g').val(data.c_chup_g);
				$('#c_box_ea').val(data.c_box_ea);
				$('#s_name').val(data.tang_name);
				$('#b_name').val(data.jo_from);
				
				
				$('#c_tang_check13').prop("checked", false);
				$('#c_tang_check14').prop("checked", false);
				$('#c_tang_check15').prop("checked", false);
				$('#c_tang_check16').prop("checked", false);
				
				
				$('#c_tang_check'+data.c_tang_check).prop("checked", true);
				
				
				var member_sale = 0;
				if(a_sale_per != 0){
					member_sale = Math.ceil( (data.price * a_sale_per) / 100);
				}
				
				$('#order_total_price_temp').val(data.price);
				$('#member_sale').val(member_sale);
				$('#order_total_price').val(data.price - member_sale);
				
				
				$('#order_total_price_temp_txt').html( comma(( data.price)+'') );
				$('#member_sale_txt').html( comma(( member_sale)+'') );
				$('#order_total_price_txt').html( comma(( data.price - member_sale)+'') );
				
				
				
				if(data.c_tang_type == 1){
					$('#jusu_txt').hide();
					$('.tang_type_area').hide();
					
					$('#c_pack_ml').val('');
					$('#c_box_type').val('');
					$('#c_stpom_type').val('');
					$('#c_pouch_type').val('');
					$('#c_pack_ea').val('');
				}else{
					$('#jusu_txt').show();
					$('.tang_type_area').show();
					$('#c_pack_ml').val(data.c_pack_ml);
					$('#c_box_type').val(data.c_box_type);
					$('#c_stpom_type').val(data.c_stpom_type);
					$('#c_pouch_type').val(data.c_pouch_type);
					$('#c_pack_ea').val(data.c_pack_ea);
				}
				
				var box_attr =  $("#c_box_type option:selected").attr('attr');
				if(box_attr == undefined || box_attr ==  '' || box_attr == null){
					$('#boxImgExp').attr('src','' );
				}else{
					$('#boxImgExp').attr('src',box_attr );
				}
				
				var pouch_attr = $("#c_pouch_type option:selected").attr('attr');
				if(pouch_attr == undefined || pouch_attr ==  '' || pouch_attr == null){
					$('#pouchImgExp').attr('src','' );
				}else{
					$('#pouchImgExp').attr('src',pouch_attr );
				}
				
				
				
				var param = { 
					  t_seqno : data.seqno		
					 ,seqno   : data.seqno
				};								
				
				$("#jqGrid").setGridParam(
						{"postData": param,
						 datatype  : "json",
						 mtype     : 'POST',
						 url       : '/m02/select_fast_yakjae.do'	 
						}
				).trigger("reloadGrid",[{page : 1}]);
			}
			return;
		}
		
	});// preOrderGrid
	
	
	$("#fastTangBtn").click(function() {
		fast_search_btn( $('#fast_search_value').val(), ''  );
		
		$('.fast_search_han2 li a').removeClass('sel');
		$('.fast_search_han2').children().first().children().addClass('sel');
		return false;
	});
	
	$("#fast_search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			fast_search_btn($('#fast_search_value').val(), '' );
			
			$('.fast_search_han2 li a').removeClass('sel');
			$('.fast_search_han2').children().first().children().addClass('sel');
		}
	});
	
	$(".fast_search_han2 li a").click(function() {
		
		fast_search_btn('', $(this).attr('attr') );
		
		$('.fast_search_han2 li a').removeClass('sel');
		$(this).addClass('sel');
		return false;
	});
	
	
$('#d_type').change(function() {
		
		var d_type    = $('#d_type').val();
		var han_name  = $('#han_han_name').val();
		var user_name = $('#user_name').val();
		if(han_name == '' || han_name == null  || han_name == undefined){
			han_name = user_name;
		}
		
		if(d_type == 1 || d_type == 6){ // 원외 --> 한의원			
			$('#d_from_name').val(a_tang_name);
			$('#d_from_handphone01').val(a_tel1);
			$('#d_from_handphone02').val(a_tel2);
			$('#d_from_handphone03').val(a_tel3);
			$('#d_from_zipcode01').val(a_zip);
			$('#d_from_address01').val(a_addr1);
			$('#d_from_address02').val(a_addr2);
			
			$('#d_to_name').val( han_name );
			$('#d_to_handphone01').val( $('#han_handphone01').val() );
			$('#d_to_handphone02').val( $('#han_handphone02').val() );
			$('#d_to_handphone03').val( $('#han_handphone03').val() );
			$('#d_to_zipcode01').val( $('#han_zip').val() );
			$('#d_to_address01').val( $('#han_addr1').val() );
			$('#d_to_address02').val( $('#han_addr2').val() );
		}else if(d_type == 4){ // 원외 -> 환자
			$('#d_from_name').val(a_tang_name);
			$('#d_from_handphone01').val(a_tel1);
			$('#d_from_handphone02').val(a_tel2);
			$('#d_from_handphone03').val(a_tel3);
			$('#d_from_zipcode01').val(a_zip);
			$('#d_from_address01').val(a_addr1);
			$('#d_from_address02').val(a_addr2);
			
			$('#d_to_name').val( $('#w_name_sel').val() );
			$('#d_to_handphone01').val( $('#w_cel1_sel').val() );
			$('#d_to_handphone02').val( $('#w_cel2_sel').val() );
			$('#d_to_handphone03').val( $('#w_cel3_sel').val() );
			$('#d_to_zipcode01').val( $('#w_zipcode').val() );
			$('#d_to_address01').val( $('#w_address01').val() );
			$('#d_to_address02').val( $('#w_address02').val() );
		}else if(d_type == 3){ // 한의원 -> 환자
			$('#d_from_name').val( han_name );
			$('#d_from_handphone01').val( $('#han_handphone01').val() );
			$('#d_from_handphone02').val( $('#han_handphone02').val() );
			$('#d_from_handphone03').val( $('#han_handphone03').val() );
			$('#d_from_zipcode01').val( $('#han_zip').val() );
			$('#d_from_address01').val( $('#han_addr1').val() );
			$('#d_from_address02').val( $('#han_addr2').val() );
			
			$('#d_to_name').val( $('#w_name_sel').val() );
			$('#d_to_handphone01').val( $('#w_cel1_sel').val() );
			$('#d_to_handphone02').val( $('#w_cel2_sel').val() );
			$('#d_to_handphone03').val( $('#w_cel3_sel').val() );
			$('#d_to_zipcode01').val( $('#w_zipcode').val() );
			$('#d_to_address01').val( $('#w_address01').val() );
			$('#d_to_address02').val( $('#w_address02').val() );
		/*}else if(d_type == 6){ // 방문 수령 배송비 0원처리
			$('#d_from_name').val(a_tang_name);
			$('#d_from_handphone01').val(a_tel1);
			$('#d_from_handphone02').val(a_tel2);
			$('#d_from_handphone03').val(a_tel3);
			$('#d_from_zipcode01').val(a_zip);
			$('#d_from_address01').val(a_addr1);
			$('#d_from_address02').val(a_addr2);
			
			$('#d_to_name').val(a_tang_name );
			$('#d_to_handphone01').val( a_tel1 );
			$('#d_to_handphone02').val( a_tel2 );
			$('#d_to_handphone03').val( a_tel3 );
			$('#d_to_zipcode01').val( a_zip );
			$('#d_to_address01').val( a_addr1 );
			$('#d_to_address02').val( a_addr2 );*/
			
			
		}else if(d_type == 7){ // 직접수령
			$('#d_from_name').val('');
			$('#d_from_handphone01').val('');
			$('#d_from_handphone02').val('');
			$('#d_from_handphone03').val('');
			$('#d_from_zipcode01').val('');
			$('#d_from_address01').val('');
			$('#d_from_address02').val('');
			
			$('#d_to_name').val('' );
			$('#d_to_handphone01').val( '' );
			$('#d_to_handphone02').val( '' );
			$('#d_to_handphone03').val( '' );
			$('#d_to_zipcode01').val( '' );
			$('#d_to_address01').val( '' );
			$('#d_to_address02').val( '' );
			
			
		}else{
			$('#d_from_name').val('');
			$('#d_from_handphone01').val('');
			$('#d_from_handphone02').val('');
			$('#d_from_handphone03').val('');
			$('#d_from_zipcode01').val('');
			$('#d_from_address01').val('');
			$('#d_from_address02').val('');
			
			$('#d_to_name').val('' );
			$('#d_to_handphone01').val( '' );
			$('#d_to_handphone02').val( '' );
			$('#d_to_handphone03').val( '' );
			$('#d_to_zipcode01').val( '' );
			$('#d_to_address01').val( '' );
			$('#d_to_address02').val( '' );
		}
	
	});


	$("#addrBtn1").click(function() {
		find_addr('d_from_zipcode01','d_from_address01', 'd_from_address02');
		return false;
	});
	
	$("#addrBtn2").click(function() {
		find_addr('d_to_zipcode01','d_to_address01', 'd_to_address02');
		return false;
	});
	
	$('#joje_name').change(function() {
	//	$('#c_joje_contents').val( $('#joje_name option:selected').attr('attr') );
	});
	
	$('#bok_name').change(function() {
		$('#c_bokyong_contents').val( $('#bok_name option:selected').attr('attr') );
	});
	
	
	cart_yakjae_setting();
});


function cart_yakjae_setting(){
	
	
	var cart_seqno = $('#cart_seqno').val();
	console.log('cart_yakjae_reload --  ',cart_seqno);
	if(cart_seqno > 0){
		
		
		var param = { 
			cart_seqno   : cart_seqno
		};
		
		console.log('param= ', param);
		
		$("#jqGrid").setGridParam(
				{"postData": param,
				 datatype  : "json",
				 mtype     : 'POST',
				 url       : '/m02/01_cart_yajkae_list.do'	 
				}
		).trigger("reloadGrid",[{page : 1}]);
		
		
		console.log($('#c_tang_type_temp').val());
		
		if($('#c_tang_type_temp').val() == 1){
			$('#jusu_txt').hide();
			$('.tang_type_area').hide();
			
			$('#c_pack_ml').val('');
			$('#c_box_type').val('');
			$('#c_stpom_type').val('');
			$('#c_pouch_type').val('');
			$('#c_pack_ea').val('');
		}else{
			$('#jusu_txt').show();
			$('.tang_type_area').show();
			/*
			$('#c_pack_ml').val(data.c_pack_ml);
			$('#c_box_type').val(data.c_box_type);
			$('#c_stpom_type').val(data.c_stpom_type);
			$('#c_pouch_type').val(data.c_pouch_type);
			$('#c_pack_ea').val(data.c_pack_ea);
			*/
		}
	}
	
}

function fast_search_btn(search_value , search_ch){
	var param = {
		 search_value  : search_value
		,search_ch     : search_ch
	};
	$("#fastGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}

function calcAge(birth) {                 
	//console.log('birth = ', birth);
    var date = new Date();

    var year  = date.getFullYear();
    var month = (date.getMonth() + 1);
    var day   = date.getDate();       

    if (month < 10) month = '0' + month;
    if (day < 10) day = '0' + day;

    var monthDay = month + day;

    birth = birth.replace('-', '').replace('-', '');
   // console.log(birth.length);
    if(birth.length != 8 ){
    	return '';
    }
  //  console.log(birth.length);

    var birthdayy  = birth.substr(0, 4);
    var birthdaymd = birth.substr(4, 4);


    var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
    return age;
}

function selPatientInfo(data){
	
	$('#wp_seqno').val(data.seqno);
	
	
	var b_sex = '';
	if(data.sex == '여'||data.sex == '여자'){
		b_sex ='w'
	}else if(data.sex == '남'||data.sex == '남자'){
		b_sex ='m'
	}
	
	$('#w_sex').val(b_sex);
	$('#w_jindan').val(data.jindan);
	$('#w_name').val(data.name);
	$('#w_name_sel').val(data.name);
	$('#w_age').val(data.age);
	$('#w_birthyear').val(data.birth_year);
	$('#w_etc01').val(data.etc1);
	$('#w_etc02').val(data.etc2);
	$('#w_address01').val(data.address01);
	$('#w_address02').val(data.address02);
	$('#w_zipcode').val(data.zipcode);
	$('#w_contents').val(data.contents);
	
	try{
		var handphone = data.handphone.split('-');
		$('#w_cel1_sel').val(handphone[0]);
		$('#w_cel2_sel').val(handphone[1]);
		$('#w_cel3_sel').val(handphone[2]);
	}catch (e) {}
	//handphone
	
	
	$('#w_name').attr('readonly', true);
	//$('#w_contents').attr('readonly', true);
}