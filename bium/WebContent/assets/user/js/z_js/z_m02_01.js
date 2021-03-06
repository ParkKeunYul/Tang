var patient_row = -1;
var lastRowId   = -1;


var a_base_joje_price = 9000;
var a_one_pack_pirce  = 150;
var a_box_price       = 0;
var a_pouch_price     = 0;
var a_jusu_price      = 6000;
var a_sti_price       = 0;
var a_yakjae_price    = 0;
var a_delivery_price  = 4000;

var a_tot_price       = 0;
var a_sale_price      = 0;
var a_sale_per        = 0;
var a_pay_tot_price   = 0;



var a_preOrderGrid_data; // 이전처방 환자 선택시 임시저장


var init_yakjae_flag = true;

var jqGridDataUrl = '/m05/04_select_main.do';

function InitPriceInfoSet(){
	/*최초세팅정보*/
	if($('#c_tang_type').val() == 1){
		$('#jusu_txt').hide();
		$('#c_tang_check13').prop("checked", false);
		$('#c_tang_check13').attr("disabled", true);
		
		$('#order_suju_price').val(0);
		$('#order_suju_price_txt').html('0');
		
		// 팩수
		$('#c_pack_ea').val(0);
		$('#c_pouch_type').val(0);
		$('#c_box_type').val(0);
		$('#c_stpom_type').val(0);
		
		$('#order_pojang_price').val(0);
		$('#order_pojang_price_txt').html(0);
		
		$('.tang_type_area').hide();
	}else{
		$('#jusu_txt').show();
		$('#c_tang_check13').attr("disabled", false);
		
	}
	$('#boxImgExp').attr('src', $("#c_box_type option:selected").attr('attr'));
	$('#pouchImgExp').attr('src', $("#c_pouch_type option:selected").attr('attr'));
	$('#order_tang_price').val(a_base_joje_price);
	$('#order_tang_price_txt').html( comma(a_base_joje_price+'') );
	
	
	if($('#d_type').val() == 6 ){
		a_delivery_price = 0;
	}
	
	$('#order_delivery_price').val(a_delivery_price);
	$('#order_delivery_price_txt').html( comma(a_delivery_price+'') );
	
	
	a_pouch_price = parseInt(objToStr($("#c_pouch_type option:selected").attr('attr2'),0));
	a_box_price   = parseInt(objToStr($("#c_box_type option:selected").attr('attr2'),0));
	a_sti_price   = parseInt(objToStr($("#c_stpom_type option:selected").attr('attr2'),0));
		
	
	var tot_pojang_price = a_pouch_price+a_box_price+a_sti_price + ( a_one_pack_pirce * parseInt(objToStr($('#c_pack_ea').val() ,0)) );
	$('#order_pojang_price').val(tot_pojang_price);
	$('#order_pojang_price_txt').html( comma(( tot_pojang_price)+'') );
	
	a_sale_per = parseInt( $('#sale_per').val() );
	
	//c_tang_check13
	if($("input:checkbox[name='c_tang_check13']").is(":checked")){
		$('#order_suju_price').val(a_jusu_price);
		$('#order_suju_price_txt').html(comma(a_jusu_price));
	}
	
	var cart_seqno = objToStr($('#cart_seqno').val() , ''); // 장바구니
	var tang_seqno = objToStr($('#tang_seqno').val() , ''); // 환자 이전처방
	var dic_seqno  = objToStr($('#dic_seqno').val() , '');  // 방제사전
	
	/*장바구니 수정 할경우*/
	if(cart_seqno == '' && tang_seqno == ''){  // 기본
		$('#c_bokyong_contents').val( $('#bok_name option:selected').attr('attr') );
		$('#c_joje_contents').val( $('#joje_name option:selected').attr('attr') );
		init_yakjae_flag = false;
	}else if(cart_seqno != '' && tang_seqno == ''){	 // 장바구니 	
		$('#bok_name').val('');
		$('#joje_name').val('');
		
		var param = {
			cart_seqno : cart_seqno
		};
		
		$("#jqGrid").setGridParam(
				{"postData": param,
				 datatype  : "json",
				 mtype     : 'POST',
				 url       : '/m02/01_cart_yajkae_list.do'	 
				}
		).trigger("reloadGrid",[{page : 1}]);
		
	}else{// 다른경로
		init_yakjae_flag = false;
	}
	
	
	if(tang_seqno != ''){
		$('#bok_name').val('');
		$('#joje_name').val('');
		
		var param = {
			tang_seqno : tang_seqno
		};
		
		$("#jqGrid").setGridParam(
				{"postData": param,
				 datatype  : "json",
				 mtype     : 'POST',
				 url       : '/m02/01_preorder_yajkae_list.do'	 
				}
		).trigger("reloadGrid",[{page : 1}]);
	}
	
	
	/*방제사전*/
	if(dic_seqno != ''){
		console.log('방제사전');
		var param = {
			seqno : dic_seqno
		};
		$("#jqGrid").setGridParam(
				{"postData": param,
				 datatype  : "json",
				 mtype     : 'POST',
				 url       : '/m02/01_dic_yajkae_list.do'	 
				}
		).trigger("reloadGrid",[{page : 1}]);
	}
	
	/*환자*/
	var  wp_seqno = objToStr($('#wp_seqno').val() , '');
	if(wp_seqno != ''){
		$('#w_name').attr('readonly', true);
	}
		
	setAllPriceSet();
}

function setAllPriceSet(){
	var order_yakjae_price   = parseInt(objToStr( $('#order_yakjae_price').val() , 0 ));
	var order_tang_price     = parseInt(objToStr( $('#order_tang_price').val() , 0 ));
	var order_suju_price     = parseInt(objToStr( $('#order_suju_price').val() , 0 ));
	var order_pojang_price   = parseInt(objToStr( $('#order_pojang_price').val() , 0 ));
	var order_delivery_price = parseInt(objToStr( $('#order_delivery_price').val() , 0 ));
	
	var order_total_price_temp = order_yakjae_price + order_tang_price + order_suju_price + order_pojang_price + order_delivery_price;
	var member_sale            = 0 ;
	
	if(a_sale_per != 0){
		member_sale = Math.ceil( (order_total_price_temp * a_sale_per) / 100);
	}
	
	
	
	var order_total_price      = order_total_price_temp - member_sale;
	
	
		
	$('#order_total_price_temp').val(order_total_price_temp);
	$('#order_total_price_temp_txt').html( comma(( order_total_price_temp)+'') );
	$('#member_sale').val(member_sale);
	$('#member_sale_txt').html( comma(( member_sale)+'') );
	$('#order_total_price').val(order_total_price);
	$('#order_total_price_txt').html( comma(( order_total_price)+'') );
	
	
	// 장바구니넘어왔을경우 
	//init_yakjae_flag = 
	var cart_seqno              = objToStr($('#cart_seqno').val() , '');
	var order_yakjae_price  	= $('#order_yakjae_price').val();
	var order_yakjae_price_cart = objToStr($('#order_yakjae_price_cart').val(), 0);
	
	
	
	if(init_yakjae_flag && cart_seqno != '' && order_yakjae_price != order_yakjae_price_cart && order_yakjae_price > 0 ){
		console.log('약재 가격변동이 발생함 = ', order_yakjae_price);
		console.log('약재 가격변동이 발생함 = ', order_yakjae_price_cart);
		init_yakjae_flag = false;
		$.ajax({
			url : '/m02/01_update_cart_yakjae.do',
			type : 'POST',
			data : {
				 cart_seqno 		 : cart_seqno
				,order_yakjae_price  : order_yakjae_price
				,order_total_price   : $('#order_total_price').val()
				,member_sale   		 : $('#member_sale').val() 
			},
			error : function() {},
			success : function(data) {
				console.log(data);
				if(data.suc){
					alert('금액이 변경된 약재가 있어,\n결제금액이 변경되었습니다.');
				}
				init_yakjae_flag = false;
			}
		});
	}// if
}

$(document).ready(function() {
	
	$("#c_pouch_type").change(function() {
		var c_pouch_type = $(this).val();
		
		$('.extend_img1').hide();
		
		var attr = $("#c_pouch_type option:selected").attr('attr');
		if(attr == undefined || attr ==  '' || attr == null){
			$('#pouchImgExp').attr('src','' );
		}else{
			$('#pouchImgExp').attr('src',attr );
		}
				
		a_pouch_price = parseInt(objToStr($("#c_pouch_type option:selected").attr('attr2'),0));
		
		$('#order_pojang_price').val(a_pouch_price+a_box_price+a_sti_price);
		$('#order_pojang_price_txt').html( comma(( a_pouch_price+a_box_price+a_sti_price )+'') );
		
		setAllPriceSet();
		
		return false;
	});
	
	$("#c_box_type").change(function() {
		var c_pouch_type = $(this).val();
		
		$('.extend_img2').hide();
		
		var attr =  $("#c_box_type option:selected").attr('attr');
		if(attr == undefined || attr ==  '' || attr == null){
			$('#boxImgExp').attr('src','' );
		}else{
			$('#boxImgExp').attr('src',attr );
		}
		a_box_price = parseInt(objToStr($("#c_box_type option:selected").attr('attr2'),0));
		
		$('#order_pojang_price').val(a_pouch_price+a_box_price+a_sti_price);
		$('#order_pojang_price_txt').html( comma(( a_pouch_price+a_box_price+a_sti_price )+'') );
		
		setAllPriceSet();
		
		return false;
	});
	
	$("#c_stpom_type").change(function() {
	
		a_sti_price = parseInt(objToStr($("#c_stpom_type option:selected").attr('attr2'),0));
		
		$('#order_pojang_price').val(a_pouch_price+a_box_price+a_sti_price);
		$('#order_pojang_price_txt').html( comma(( a_pouch_price+a_box_price+a_sti_price )+'') );
		
		setAllPriceSet();
		
		return false;
	});
	
	$("#c_chup_ea").change(function() {
		init_yakjae_flag = false;
		var c_chup_ea       = parseInt( $('#c_chup_ea').val() );
		var c_chup_ea_price = parseInt( $('#c_chup_ea_price').val() );
		var tot_chup_price = c_chup_ea * c_chup_ea_price;
		

		var tot_yakjae_joje_txt = parseFloat($('#tot_yakjae_joje_txt').html());
		var c_chup_g = c_chup_ea * tot_yakjae_joje_txt;
			c_chup_g = Math.floor(c_chup_g * 100)/100;
		
		$('#c_chup_g').val( c_chup_g );
		$('#order_yakjae_price').val( tot_chup_price );
		$('#order_yakjae_price_txt').html( comma(tot_chup_price+'') );
		
		setAllPriceSet();
		
	});
	
	$("#c_pack_ea").change(function() {
		console.log('c_pack_ea change');
		
		var tot_pojang_price = a_pouch_price+a_box_price+a_sti_price + ( a_one_pack_pirce * parseInt(objToStr($('#c_pack_ea').val() ,0)) );
		
		$('#order_pojang_price').val(tot_pojang_price);
		$('#order_pojang_price_txt').html( comma(( tot_pojang_price)+'') );
		
		setAllPriceSet();
	});
	
	
	
	$('#joje_name').change(function() {
		$('#c_joje_contents').val( $('#joje_name option:selected').attr('attr') );
	});
	
	$('#bok_name').change(function() {
		$('#c_bokyong_contents').val( $('#bok_name option:selected').attr('attr') );
	});
	
	$('#c_tang_type').change(function() {
		var c_tang_type = $('#c_tang_type').val();
		if(c_tang_type == 1){
			$('#jusu_txt').hide();
			$('#c_tang_check13').prop("checked", false);
			$('#c_tang_check13').attr("disabled", true);

			$('#order_suju_price').val(0);
			$('#order_suju_price_txt').html('0');
			
			$('#c_pack_ml').val(0);
			$('#c_tang_check13').attr("readonly", true);
			
			var tot_pojang_price = a_pouch_price+a_box_price+a_sti_price;
			$('#order_pojang_price').val(tot_pojang_price);
			$('#order_pojang_price_txt').html( comma(( tot_pojang_price)+'') );
			
			//$('#c_pack_ea').attr("disabled", true);
			
			
			// 팩수
			$('#c_pack_ea').val(0);
			$('#c_pouch_type').val(0);
			$('#c_box_type').val(0);
			$('#c_stpom_type').val(0);
			
			$('#order_pojang_price').val(0);
			$('#order_pojang_price_txt').html(0); 
			
			
			$('.tang_type_area').hide();
		}else{
			$('#jusu_txt').show();
			$('#c_tang_check13').attr("disabled", false);
			$('#c_tang_check13').attr("readonly", false);
			
			//$('#c_pack_ea').attr("disabled", false);
			$('.tang_type_area').show();
		}
		setAllPriceSet();
	});
	
	$('#c_tang_check13').change(function() {
		if($("#c_tang_check13").is(":checked")){
			$('#order_suju_price').val(a_jusu_price);
			$('#order_suju_price_txt').html( comma(a_jusu_price+'') );
        }else{
        	$('#order_suju_price').val(0);
    		$('#order_suju_price_txt').html('0');
        }
		setAllPriceSet();
	});
	
	
	$('#d_type').change(function() {
		
		a_delivery_price = 4000;
		
		var d_type = $('#d_type').val();
		if(d_type == 1){ // 원외 --> 한의원
			$('#d_from_name').val(a_addr2);
			$('#d_from_handphone01').val(a_tel1);
			$('#d_from_handphone02').val(a_tel2);
			$('#d_from_handphone03').val(a_tel3);
			$('#d_from_zipcode01').val(a_zip);
			$('#d_from_address01').val(a_addr1);
			$('#d_from_address02').val(a_addr2);
			
			$('#d_to_name').val( $('#han_han_name').val() );
			$('#d_to_handphone01').val( $('#han_handphone01').val() );
			$('#d_to_handphone02').val( $('#han_handphone02').val() );
			$('#d_to_handphone03').val( $('#han_handphone03').val() );
			$('#d_to_zipcode01').val( $('#han_zip').val() );
			$('#d_to_address01').val( $('#han_addr1').val() );
			$('#d_to_address02').val( $('#han_addr2').val() );
		}else if(d_type == 4){ // 원외 -> 환자
			$('#d_from_name').val(a_addr2);
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
			$('#d_from_name').val($('#han_han_name').val());
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
		}else if(d_type == 6){ // 방문 수령 배송비 0원처리
			$('#d_from_name').val(a_addr2);
			$('#d_from_handphone01').val(a_tel1);
			$('#d_from_handphone02').val(a_tel2);
			$('#d_from_handphone03').val(a_tel3);
			$('#d_from_zipcode01').val(a_zip);
			$('#d_from_address01').val(a_addr1);
			$('#d_from_address02').val(a_addr2);
			
			$('#d_to_name').val(a_addr2 );
			$('#d_to_handphone01').val( a_tel1 );
			$('#d_to_handphone02').val( a_tel2 );
			$('#d_to_handphone03').val( a_tel3 );
			$('#d_to_zipcode01').val( a_zip );
			$('#d_to_address01').val( a_addr1 );
			$('#d_to_address02').val( a_addr2 );
			
			a_delivery_price = 0;
		}else{
			$('#d_from_name').val('');
			$('#d_from_handphone01').val('');
			$('#d_from_handphone02').val('');
			$('#d_from_handphone03').val('');
			$('#d_from_zipcode01').val('');
			$('#d_from_address01').val('');
			$('#d_from_address01').val('');
			
			$('#d_to_name').val('' );
			$('#d_to_handphone01').val( '' );
			$('#d_to_handphone02').val( '' );
			$('#d_to_handphone03').val( '' );
			$('#d_to_zipcode01').val( '' );
			$('#d_to_address01').val( '' );
			$('#d_to_address02').val( '' );
		}
		
		$('#order_delivery_price').val(a_delivery_price);
		$('#order_delivery_price_txt').html( comma(a_delivery_price+'') );
		
		setAllPriceSet();
	});
	
	
	
	
	InitPriceInfoSet();// 가격정보 세팅
	
	
	
	$(".p_nm").click(function() {
		return false;
	});
	
	$("#p_listBtn").click(function() {
		$('.patient_search').show();
		$('.detail_info').hide();
		
		$('.patientArea li a').removeClass( 'sel' );
		$('.patientArea li.fir a').addClass( 'sel' );
		
		return false;
	});
	
	
	$(".order_option ul.tab4 li").click(function() {
		var index = $("ul.tab4 li").index(this);
		
		$("ul.tab4 li a").removeClass( 'sel' );
		$(this).children('a').addClass( 'sel' );
		
		$('.order_detail').hide();
		$('#orderOp'+index).show();
		
		return false;
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
	    		
	    		var sel_img = '<img src="/assets/user/images/sub/btn_list.png" style="cursor:pointer;" alt="선택" class="vm" />'; 
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
	/*환자검색 끝*/
	
	
	/*약재 처방 그리드*/
	
	$("#delItemBtn").click(function() {
		 try{init_yakjae_flag = false;}catch (e) {}
		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
		if( row.length <= 0 ){
			alert('한개이상 선택하세요.');
			return false;
		}
		
		 for(var i = (row.length-1); i>=0; i--) {
		     $('#jqGrid').jqGrid('delRowData', row[0])
		 }
		 
		 
		rows = $("#jqGrid").getDataIDs(); 		
		
		var tot_danga = 0;
		var tot_joje  = 0;
	    for (var i = 0; i < rows.length; i++){						    	
	    	var seqno     = parseInt($("#jqGrid").getCell(rows[i],"seqno"));
	    	
	    	var group_cnt = parseInt($("#jqGrid").getCell(rows[i],"group_cnt"));
	    	var yak_name  = $("#jqGrid").getCell(rows[i],"yak_name");
	    	
	    	if(group_cnt > 1){
	    		var group_code = $("#jqGrid").getCell(rows[i],"group_code");
	    		yak_name = yak_name.substring(0, yak_name.indexOf(' <a'));
	    		yak_name = yak_name + ' <a href="#" attr="'+rows[i]+'"  attr2="'+group_code+'" attr3="'+(i+1)+'"  class="btn_change btn_change_'+seqno+'"  ></a>';
	    	}
	    	
	    	$("#jqGrid").setCell(rows[i] , 'yak_name', yak_name , {padding: '0 0 0 10px'});
	    	
	    		    	
	    	$('.btn_change_'+seqno).unbind();
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
	    }// for i 
		 
		 setTimeout(function(){
			 tot_info();	 
		 },100);
		 
		 $('.yakjae_popup').hide();
		 return false;
	});
	/*약재 처방 끝*/
	
	
	/*이전처방 탭*/
	$("#preOrderGrid").jqGrid({
  		//caption : '모든 약재정보',
  		//dataType : 'local', // 로딩시 최초 조회   		
  		url : '/m05/05_select_patient.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 8,
  		colNames:[
  			'번호','환자명', '환자 주소' , '주소2'
  								  			
  		],
  		colModel:[
  			{name:'seqno',			index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
  			{name:'name',			index:'name',		width:90,	align:"left" ,sortable : false},
  			{name:'address01',		index:'address01',	width:358,	align:"left" ,sortable : false},
  			{name:'address02',		index:'address02',	width:63,	align:"center"  , hidden:true},
  		],
		pager: "#preOrderGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
		loadComplete: function(data) {
			var rows = $("#preOrderGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				
				$("#preOrderGrid").setCell(rows[i] , 'name', '' , {padding: '0 0 0 15px', color : '#0b6d3a', cursor:'pointer' });
	    		
	    		var address01     = $("#preOrderGrid").getCell(rows[i],"address01");
	    		var address02     = $("#preOrderGrid").getCell(rows[i],"address02");
	    		
	    		$("#preOrderGrid").setCell(rows[i] , 'address01', address01 + ' '+ address02 , null);
	    		
			}// for
			
		},
		onSelectRow : function(row,cellcontent,e){
			var data = $("#patientGrid").jqGrid('getRowData', row);
			
			a_preOrderGrid_data = data; // 전역변수 나중에 쓸모 있다
			
			 $('#list_popup03').show();
			
			 var param = {
				wp_seqno : data.seqno
			 };
			 console.log('onSelectRow =', param);
			 $("#patientDetailGrid").setGridParam({"postData": param ,datatype: "json",mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
			 
		},
	});// preOrderGrid
	
	$(".preorder_search_han2 li a").click(function() {
		console.log($(this).attr('attr'));
		preorder_search_btn('', $(this).attr('attr') );
		
		$('.preorder_search_han2 li a').removeClass('sel');
		$(this).addClass('sel');
		return false;
	});
	
	$("#preorderSearchBtn").click(function() {
		preorder_search_btn( $('#patient_search_value').val(), ''  );
		
		$('.preorder_search_han2 li a').removeClass('sel');
		$('.preorder_search_han2').children().first().children().addClass('sel');
		return false;
	});
	
	$("#preorder_search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			preorder_search_btn($('#preorder_search_value').val(), '' );
			
			$('.preorder_search_han2 li a').removeClass('sel');
			$('.preorder_search_han2').children().first().children().addClass('sel');
		}
	});
	
	$(".preorder_btn_close").click(function() {
		$('#list_popup03').hide();
		return false;
	});
	/*이전처방 탭*/
	
	
	$("#addrBtn1").click(function() {
		find_addr('d_from_zipcode01','d_from_address01', 'd_from_address02');
		return false;
	});
	
	$("#addrBtn2").click(function() {
		find_addr('d_to_zipcode01','d_to_address01', 'd_to_address02');
		return false;
	});
	
	
	/*환자 처방내역 이전처방 세팅*/
	$("#patientDetailGrid").jqGrid({
  		url : '/m05/05_patient_order.do',
  		datatype: "local",
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 6,
  		colNames:[
  			'번호', '처방명' , '배송주소',  '환자관리<br/>주소' ,'이전처방<br/>주소',
  								  			
  			'첩'				  , '팩' 				, 'wp_seqno' 	 , 'c_tang_type'      , 'c_tang_check13' ,
  			'c_chup_ea_price' , 'c_pack_ml'			, 'c_pouch_type' , 'c_box_type'		  , 'c_stpom_type'   ,
  			'c_joje_contents' , 'c_bokyong_contents', 'd_from_name'	 , 'd_from_address01' , 'd_from_address02' ,
  			'd_from_zipcode'  , 'd_from_handphone'	, 'd_to_name'	 , 'd_to_handphone'   , 'd_to_zipcode',
  			'd_to_address01'  , 'd_to_address02'    , 'd_type'       , 'c_joje_contents'  , 'c_bokyong_contents',
  			'b_name'
  		],
  		colModel:[
  			{name:'seqno',				index:'seqno',				width:28,	align:"center" ,key: true , hidden:true},
  			{name:'s_name',				index:'s_name',				width:115,	align:"left"   ,sortable : false},
  			{name:'d_to_address01',		index:'d_to_address01',		width:190,	align:"left" ,sortable : false},					  			
  			{name:'sel1',				index:'sel1',				width:55,	align:"center" ,sortable : false},
  			{name:'sel2',				index:'sel2',				width:55,	align:"center" ,sortable : false},
  			
  			{name:'c_chup_ea',			index:'c_chup_ea',			width:10,	align:"center"  , hidden:true},
  			{name:'c_pack_ea',			index:'c_pack_ea',			width:10,	align:"center"  , hidden:true},
  			{name:'wp_seqno',			index:'wp_seqno',			width:10,	align:"center"  , hidden:true},
  			{name:'c_tang_type',		index:'c_tang_type',			width:10,	align:"center"  , hidden:true},
  			{name:'c_tang_check13',		index:'c_tang_check13',			width:10,	align:"center"  , hidden:true},
  			
  			{name:'c_chup_ea_price',	index:'c_chup_ea_price',			width:10,	align:"center"  , hidden:true},					  			
  			{name:'c_pack_ml',			index:'c_pack_ml',			width:10,	align:"center"  , hidden:true},
  			{name:'c_pouch_type',		index:'c_pouch_type',		width:10,	align:"center"  , hidden:true},
  			{name:'c_box_type',			index:'c_box_type',			width:10,	align:"center"  , hidden:true},
  			{name:'c_stpom_type',		index:'c_stpom_type',		width:10,	align:"center"  , hidden:true},
  			
  			{name:'c_joje_contents',	index:'c_joje_contents',	width:10,	align:"center"  , hidden:true},					  			
  			{name:'c_bokyong_contents',	index:'c_bokyong_contents',	width:10,	align:"center"  , hidden:true},
  			{name:'d_from_name',		index:'d_from_name',		width:10,	align:"center"  , hidden:true},
  			{name:'d_from_address01',	index:'d_from_address01',	width:10,	align:"center"  , hidden:true},
  			{name:'d_from_address02',	index:'d_from_address02',	width:10,	align:"center"  , hidden:true},		
  			
  			{name:'d_from_zipcode',		index:'d_from_zipcode',		width:10,	align:"center"  , hidden:true},					  			
  			{name:'d_from_handphone',	index:'d_from_handphone',	width:10,	align:"center"  , hidden:true},
  			{name:'d_to_name',			index:'d_to_name',			width:10,	align:"center"  , hidden:true},
  			{name:'d_to_handphone',		index:'d_to_handphone',		width:10,	align:"center"  , hidden:true},
  			{name:'d_to_zipcode',		index:'d_to_zipcode',		width:10,	align:"center"  , hidden:true},
  			
  			{name:'d_to_address01',		index:'d_to_address01',		width:10,	align:"center"  , hidden:true},
  			{name:'d_to_address02',		index:'d_to_address02',		width:10,	align:"center"  , hidden:true},
  			{name:'d_type',				index:'d_type',		width:10,	align:"center"  , hidden:true},
  			{name:'c_joje_contents',	index:'c_joje_contents',		width:10,	align:"center"  , hidden:true},
  			{name:'c_bokyong_contents',	index:'c_bokyong_contents',		width:10,	align:"center"  , hidden:true},
  			
  			{name:'b_name',				index:'b_name',		width:10,	align:"center"  , hidden:true},
  			
  			
  			
  		],
		pager: "#patientDetailGridControl",
		viewrecords: true,
		autowidth: true,
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '',
		emptyrecords  : '',
		loadtext  : '데이터를 불러오는중입니다.',
		loadComplete: function(data) {
			var rows = $("#patientDetailGrid").getDataIDs();
			for (var i = 0; i < rows.length; i++){
				
				var sel1 = '<span class="h20 cB mr5">선택1</span>';
				var sel2 = '<span class="h20 cB mr5">선택2</span>';
				
				$("#patientDetailGrid").setCell(rows[i] , 'sel1', sel1 , {cursor:'pointer'});
				$("#patientDetailGrid").setCell(rows[i] , 'sel2', sel2 , {cursor:'pointer'});
				
			}// for
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			var data = $("#patientDetailGrid").jqGrid('getRowData',row);
			console.log('patientDetailGrid data = ', data);
			console.log('a_preOrderGrid_data  = ', a_preOrderGrid_data);
			
			
			if(iCol == 3 || iCol == 4){
				init_yakjae_flag = false;
				
				var p_seqno = data.seqno;
				
				// 환자정보 세팅
				selPatientInfo(a_preOrderGrid_data);
				
				// 배송정보 세팅
				var d_from_handphone =  (data.d_from_handphone).split('-');
				$('#d_from_name').val( data.d_from_name);
				$('#d_from_handphone01').val( d_from_handphone[0] );
				$('#d_from_handphone02').val( d_from_handphone[1] );
				$('#d_from_handphone03').val( d_from_handphone[2] );
				$('#d_from_zipcode01').val( data.d_from_zipcode );
				$('#d_from_address01').val( data.d_from_address01 );
				$('#d_from_address02').val( data.d_from_address02 );
				if(iCol == 3){ // 수취인을 선택된 환자정보로
					console.log('a_preOrderGrid_data = ', a_preOrderGrid_data);
					var d_to_handphone =  (a_preOrderGrid_data.handphone).split('-');
				
					$('#d_to_name').val( a_preOrderGrid_data.name);
					$('#d_to_handphone01').val( d_to_handphone[0] );
					$('#d_to_handphone02').val( d_to_handphone[1] );
					$('#d_to_handphone03').val( d_to_handphone[2] );
					$('#d_to_zipcode01').val( a_preOrderGrid_data.zipcode );
					$('#d_to_address01').val( a_preOrderGrid_data.address01 );
					$('#d_to_address02').val( a_preOrderGrid_data.address02 );
					
					
					$('#d_type').val( 3 ); // 일단 한의원 환자로 세팅
					
				}else{
					var d_to_handphone =  (data.d_to_handphone).split('-');
					$('#d_to_name').val( data.d_to_name);
					$('#d_to_handphone01').val( d_to_handphone[0] );
					$('#d_to_handphone02').val( d_to_handphone[1] );
					$('#d_to_handphone03').val( d_to_handphone[2] );
					$('#d_to_zipcode01').val( data.d_to_zipcode );
					$('#d_to_address01').val( data.d_to_address01 );
					$('#d_to_address02').val( data.d_to_address02 );
					
					$('#d_type').val( data.d_type);
				}
				
				// 탕전 옵션 세팅 해줘야함
				$('#s_name').val(data.s_name);
				$('#b_name').val(data.b_name);
				$('#c_tang_type').val(data.c_tang_type);//
				//$('#c_tang_check13').val(data.c_tang_check13);
				if(data.c_tang_check13 == 'y'){
					$('#c_tang_check13').prop("checked", true);
					$('#c_tang_check13').attr("disabled", false);
					$('#order_suju_price').val(a_jusu_price);
					$('#order_suju_price_txt').html( comma(a_jusu_price)+'' );
				}else{
					$('#c_tang_check13').prop("checked", false);
					$('#c_tang_check13').attr("disabled", true);
				}
				$('#c_chup_ea').val(data.c_chup_ea);//
				$('#c_pack_ml').val(data.c_pack_ml);//
				$('#c_pack_ea').val(data.c_pack_ea);//
				$('#c_pouch_type').val(data.c_pouch_type);//
				$('#c_box_type').val(data.c_box_type);//
				$('#c_stpom_type').val(data.c_stpom_type);//
				
				InitPriceInfoSet(); // 초기정보세팅을 이용하여 가격
				// 이전처방 조제 복용내용 살리기위해
				$('#joje_name').val('');
				$('#c_joje_contents').val(data.c_joje_contents);
				$('#bok_name').val('');
				$('#c_bokyong_contents').val(data.c_bokyong_contents);
				
				
				$.ajax({
					url : '/m02/01_pre_yajkae_list.do',
					type: 'POST',
					data : {
						p_seqno : p_seqno											
					},
					error : function() {
						alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					},
					success : function(list) {
						
						var jqRow    = 0;
						for(var i = 1; i <= $("#jqGrid").getGridParam("records") ; i++){
			    			$('#jqGrid').editCell(i,  5 , false);
			    			jqRow ++;
			    		}// 모두 닫기
						
			    		
						for(var k = 0; k < list.length ; k++){
							var duple = true;
							var cnt = $("#jqGrid").getDataIDs();
			    			for (var i = 0; i < cnt.length; i++){
			    				if(cnt[i] == list[k].seqno ){				    					
				    				duple = false;
			    				}
			    			}//
			    			
			    			if(duple){ // add
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
			   	    				,my_joje    : list[k].p_joje
			   	    				,danga      : list[k].tot_yak_danga+'원'
			   	    			};
			    				//console.log('addData = ', addData);
			    				$("#jqGrid").jqGrid("addRowData", addData.seqno, addData);
			    				
			    				
				    			if(list[k].group_cnt > 1){ // 여러단어 추가시
			    					var yak_name = list[k].yak_name + ' <a href="#" attr="'+list[k].seqno+'"  attr2="'+list[k].group_code+'"  attr3="'+jqRow+'"  class="btn_change btn_change_'+list[k].seqno+'"  ></a>';
			    					$("#jqGrid").setCell(list[k].seqno , 'yak_name',  yak_name , null);
			    					layer_yakjae_group(list[k].seqno , list[k].group_code ,jqRow ); //	
			    				}
				    			
				    			if(list[k].yak_status != 'y'){
				    				$("#jqGrid").setCell(addData.seqno  , 'yak_status', "" ,  {color:'red',weightfont:'bold'}); // 특정 cell 색상변경
				    			}
				    			
			    			}else{ // update plus
			    				
			    				var my_joje     = parseFloat( $("#jqGrid").getCell(list[k].seqno,"my_joje") );
			    				var danga       = parseFloat( $("#jqGrid").getCell(list[k].seqno,"danga").replace('원', '') );
			    				
			    				my_joje   = my_joje + parseFloat(list[k].p_joje);
			    				danga     = danga + parseFloat(list[k].yak_danga);
			    				
			    				$("#jqGrid").setCell(list[k].seqno , 'my_joje'  , my_joje , {padding: '0 25px 0 0'});
				    			$("#jqGrid").setCell(list[k].seqno , 'danga'    , comma(danga) +'원', {padding: '0 15px 0 0'});
			    			}// if duple
			    			
						}// for k
						
						setTimeout(function(){
							 tot_info();
							 $('#jqGrid').editCell(1,  5 , true);
						},100);
						alert('추가되었습니다.');
						$('#list_popup03').hide();
					}// sucess
				});
			}
		}
	});// patientDetailGrid
	/*환자 처방내역 이전처방 세팅*/
	
});


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

function preorder_search_btn(search_value , search_ch){
	$('#list_popup03').hide();
	var param = {
		 search_value  : search_value
		,search_type   : 'name'
		,search_ch     : search_ch
	};
	$("#preOrderGrid").setGridParam({"postData": param ,mtype: "POST"}).trigger("reloadGrid",[{page : 1}]);
}//

function yakjae_change_apply(tot_danga){
	
	$('#c_chup_ea_price').val(tot_danga);
	
	var c_chup_ea_price = parseInt( objToStr( $('#c_chup_ea_price').val(),0) );
	var c_chup_ea       = parseInt( $('#c_chup_ea').val() );
	
	var tot_chup_price = c_chup_ea * c_chup_ea_price;
	$('#order_yakjae_price').val( tot_chup_price );
	$('#order_yakjae_price_txt').html( comma(tot_chup_price+'') );
	
	setAllPriceSet();
	
}

function tot_info (){
	var tot_danga = 0;
	var tot_joje  = 0;
	var rows      = $("#jqGrid").getDataIDs();
	var c_chup_ea = parseInt( $('#c_chup_ea').val() );
	
	for (var i = 0; i < rows.length; i++){
		var my_joje   = parseFloat($("#jqGrid").getCell(rows[i],"my_joje") );
    	var yak_danga = parseFloat($("#jqGrid").getCell(rows[i],"yak_danga") );
    	
    	var danga = Math.ceil(my_joje * yak_danga);
    	
    	tot_danga = tot_danga + danga;
    	tot_joje  = tot_joje + my_joje;
    	
    	tot_joje  = Math.floor(tot_joje * 100)/100;
    	
    	$("#jqGrid").setCell(rows[i] , 'yak_name', '' , {padding: '0 0 0 10px'});
    	$("#jqGrid").setCell(rows[i] , 'yak_danga', '' , {padding: '0 15px 0 0'});
    	$("#jqGrid").setCell(rows[i] , 'my_joje'  , my_joje , {padding: '0 25px 0 0'});
		$("#jqGrid").setCell(rows[i] , 'danga'    , comma(danga) +'원', {padding: '0 15px 0 0'});
    	
	}// for
	
	$('#c_chup_g').val((tot_joje * c_chup_ea).toFixed(2));
	$('#tot_yakjae_joje_txt').text(comma(tot_joje+''));
	$('#tot_yakjae_danga_txt').text(comma(tot_danga+''));
	
	var all_yakjae_price = tot_danga * parseInt( $('#c_chup_ea').val() ) ;
	
	$('#order_yakjae_price').val( all_yakjae_price );
	$('#order_yakjae_price_txt').html( comma(all_yakjae_price + '')  );
	$('#c_chup_ea_price').val( tot_danga );
	
	setAllPriceSet();
}
