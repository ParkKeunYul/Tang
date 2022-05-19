$(document).ready(function() {
	$("#modBtn").click(function() {
		$('#mod_pop').bPopup({
			onOpen: function() {
               closeDaumPostcode();
               frmReset();
               $('#chart_num').focus();
            },
			onClose: function() {
				frmReset();
				closeDaumPostcode();
            }
		});
		return false;
	});
	
	$("#findAddrBtn").click(function() {
		find_addr('zipcode','address01', 'address02');
		return false;
	});
	
	$("#popupButton1").click(function() {
		if (!valCheck('name', '환자명을 입력하세요.')) return false;
		if (!valCheck('handphone01', '휴대폰번호를 입력하세요.')) return false;
		if (!valCheck('handphone03', '휴대폰번호를 입력하세요.')) return false;
		if (!valCheck('handphone02', '휴대폰번호를 입력하세요.')) return false;
		if (!valCheck('zipcode', '주소를 입력하세요.')) return false;
		
		$.ajax({
			url : '/m05/05_mod.do',
			type: 'POST',
			data : $("#frm").serialize(),
			error : function() {
				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			},
			success : function(data) {
				alert(data.msg);
				if (data.suc){					
					location.href= window.location.href;
				}
			}
		});
		return false;
	});
	
	
	
	var birth = $('.txt_birth').html() + '';
	$('.txt_age').html(  calcAge(birth));
	
	
	$("#preOrderGrid").jqGrid({
  		url : '/m05/05_patient_order.do?wp_seqno='+$('#seqno').val(),
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 5,
  		colNames:[
  			'번호', '처방일자', '처방명' , '첩수/수량', '금액',
  								  			
  			'첩','팩'
  		],
  		colModel:[
  			{name:'seqno',				index:'seqno',				width:28,	align:"center" ,key: true , hidden:true},
  			{name:'wdate2',				index:'wdate2',				width:250,	align:"center" ,sortable : false},
  			{name:'s_name',				index:'s_name',				width:380,	align:"left" ,sortable : false},
  			{name:'ea',					index:'ea',					width:160,	align:"center" ,sortable : false},
  			{name:'order_total_price',	index:'order_total_price',	width:160,	align:"center" ,sortable : false},
  			
  			{name:'c_chup_ea',			index:'c_chup_ea',			width:160,	align:"center"  , hidden:true},
  			{name:'c_pack_ea',			index:'c_pack_ea',			width:160,	align:"center"  , hidden:true},
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
				
				var wdate2     		   = $("#preOrderGrid").getCell(rows[i],"wdate2");
	    		var c_chup_ea     	   = $("#preOrderGrid").getCell(rows[i],"c_chup_ea")+'첩';
	    		var c_pack_ea     	   = $("#preOrderGrid").getCell(rows[i],"c_pack_ea")+'팩';
	    		var order_total_price  = $("#preOrderGrid").getCell(rows[i],"order_total_price");
	    		
	    		
	    		wdate2 = wdate2+ '<span style="display:inline-block;margin-left:10px;cursor:pointer;" class="cB h25">처방하기</span>';
	    		
	    		$("#preOrderGrid").setCell(rows[i] , 'wdate2', wdate2 , {padding: '0 0 0 15px'});
	    		$("#preOrderGrid").setCell(rows[i] , 's_name', '' , {padding: '0 0 0 15px'});
	    		
	    		$("#preOrderGrid").setCell(rows[i] , 'ea', c_chup_ea+'/'+c_pack_ea , null);
	    		$("#preOrderGrid").setCell(rows[i] , 'order_total_price', comma(order_total_price+'')+'원' , null);
	    		
			}// for
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			var data = $("#preOrderGrid").jqGrid('getRowData', row);
			console.log('data = ', data);
			if(iCol == 1){
				location.href='/m02/01_pre_order.do?tang_seqno='+data.seqno;
			}//
		}
	});// preOrderGrid
});



function calcAge(birth) {                 

    var date = new Date();

    var year  = date.getFullYear();
    var month = (date.getMonth() + 1);
    var day   = date.getDate();       

    if (month < 10) month = '0' + month;
    if (day < 10) day = '0' + day;

    var monthDay = month + day;

       

    birth = birth.replace('-', '').replace('-', '');
    console.log(birth.length);
    if(birth.length != 8 ){
    	return '';
    }
    console.log(birth.length);
    
    console.log('birth = ', birth);

    var birthdayy  = birth.substr(0, 4);
    var birthdaymd = birth.substr(4, 4);


    var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
    return '만'+age;

} 


function frmReset(){
	$('#frm').each(function(){this.reset();});
}