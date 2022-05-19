var lastRowId=-1;

$(document).ready(function() {
	
	$('.LArea, #container').click(function() {
		$('.yakjae_popup').hide();
	});
	
	if( objToStr( $('#my_seqno').val() ) != '' ){
		var param = { 
			my_seqno    : $('#my_seqno').val()
		};
		$("#jqGrid").setGridParam({"postData": param ,datatype: "json", mtype: 'POST'}).trigger("reloadGrid",[{page : 1}]);
	}
	
	$(".order_option ul.tab4 li").click(function() {
		var index = $("ul.tab4 li").index(this);
		
		if(index >= 3){
			return false;
		}
		
		$("ul.tab4 li a").removeClass( 'sel' );
		$(this).children('a').addClass( 'sel' );
		
		$('.order_detail').hide();
		$('#orderOp'+index).show();
		
		return false;
	});
	
	$("#tab4LayerClose").click(function() {
		$('#tab4Layer').hide();
		return false;
	});
	
	
	$("div.before_dictionary table.list tbody tr td a").click(function() {
		$('#tab4Layer').show();
		return false;
	});
	
	$("#delItemBtn").click(function() {
		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
		if( row.length <= 0 ){
			alert('한개이상 선택하세요.');
			return false;
		}
		
		 for(var i = (row.length-1); i>=0; i--) {
		     $('#jqGrid').jqGrid('delRowData', row[0])
		 }
		// $('#cb_jqGrid').prop("checked", false);
		 setTimeout(function(){
			 tot_info();	 
		 },100);
		 
		 $('.yakjae_popup').hide();
		 return false;
	});
	/*처방내용 끝*/
	
	/*나의처방끝*/
});


function tot_info(){
	var tot_danga = 0;
	var tot_joje  = 0;
	var rows      = $("#jqGrid").getDataIDs();
	
	for (var i = 0; i < rows.length; i++){
		var my_joje   = parseFloat($("#jqGrid").getCell(rows[i],"my_joje") );
    	var yak_danga = parseFloat($("#jqGrid").getCell(rows[i],"yak_danga") );
    	
    	//var danga = my_joje * yak_danga;
    	var danga = Math.ceil(my_joje * yak_danga);
    	
    	tot_danga = tot_danga + danga;
    	tot_joje  = tot_joje + my_joje;
    	
    	$("#jqGrid").setCell(rows[i] , 'yak_name', '' , {padding: '0 0 0 10px'});
    	$("#jqGrid").setCell(rows[i] , 'yak_danga', '' , {padding: '0 15px 0 0'});
    	$("#jqGrid").setCell(rows[i] , 'my_joje'  , my_joje , {padding: '0 25px 0 0'});
		$("#jqGrid").setCell(rows[i] , 'danga'    , comma(danga) +'원', {padding: '0 15px 0 0'});
	}// for
	$('#tot_yakjae_joje_txt').text(comma(tot_joje));
	$('#tot_yakjae_danga_txt').text(comma(tot_danga));
}

function setAllPriceSet(){ // 탕전 처방용
	
}
function yakjae_change_apply(){ // 탕전 처방용
	
}

