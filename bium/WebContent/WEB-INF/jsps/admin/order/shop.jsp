<%@page import="kr.co.hany.common.Const"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">


<style>
	.a{
		text-decoration: underline;
	}
</style>


<% 
	String KAKAO_AUTH = Const.KAKAO_AUTH; 
	KAKAO_AUTH = "PQKZR4K4TWR0511";
%>
<jsp:useBean id="toDay" class="java.util.Date" />
<div style="display: none;">
	<fmt:formatDate value="${toDay}" pattern="yyyyMMddHHmmss" />
</div>
<script>
	var mem_code = "${mem_code}";
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="/assets/admin/js/jsp/order/shop.js?${toDay}"></script>
 <%-- 
 <script type="text/javascript" src="/assets/admin/js/zjsp/order/z_shop.js?${toDay}"></script>
  --%>
<script>
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
	
	if(!confirm('선택된 주문건을 발송하겠습니까?')){
		return false;
	}
	
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
		$.ajax({
			url : 'update_talk_send.do',
		    data : {
		    	all_seqno     : all_seqno 
		    },        
	        error: function(){
	        	//console.log('에러가 발생했습니다.\n관리자에 문의하세요.');
		    },
		    success: function(data){
		    	
		    }   
		});
		alert('발송되었습니다.');
		setTimeout(function(){
			$("#jqGrid").trigger("reloadGrid");
    	},550);
	}else{
		alert('에러가 발생했습니다.\n다시 시도해주세요.');
	}
	console.log('all_seqno = ', all_seqno);
}

function send_talk_ajax(data){
	console.log(data);
	
	var mb_handphone = (data.mb_handphone).replace('-', '');
	mb_handphone = mb_handphone.replace('-', '');
	console.log(mb_handphone);
	/* 
	alert(mb_handphone);
	alert(data.goods_name_new);
	 */
	$.ajax({
		url: "http://221.139.14.189/API/alimtalk_api",
		type: "POST",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		data:{
			api_key           : 'PQKZR4K4TWR0511',
			template_code     : 'SJT_078933',
			variable          : data.goods_name_new + '|' + data.deliveryno + '|' + data.tak_sel_nm + '|' + data.r_address ,
			callback          : '0519415104',
			dstaddr           : mb_handphone,
			//kakao_name        : data.order_name,
			next_type         : 1,
			send_reserve      : 0,			
		},
		success : function(data) {
			console.log(data);
			if (data && data.response_code == 100){
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


<%-- 

function send_talk_ajax(data){
	console.log(data);
		$.ajax({
			url: "http://www.apiorange.com/api/send/notice.do",
			type: "POST",
			headers: {
				"Content-Type": "application/json; charset=utf-8",
				"Authorization": "<%=KAKAO_AUTH%>"
			},
			data: JSON.stringify({
				tmp_number        : data.temple_no,
				kakao_sender      : '0519415104',
				kakao_name        : data.order_name,
				kakao_phone       : data.mb_handphone,
				kakao_add1        : data.goods_name,
				kakao_add2        : data.deliveryno,
				kakao_add3        : data.r_address,
				kakao_add4        : '',
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

 --%>

function excelDown(){
	
	var mya = $("#jqGrid").getDataIDs();
		 
	var data = $("#jqGrid").jqGrid('getRowData', mya[0]);
	
	var colNames = new Array();
	var ii = 0;
	
	for (var d in data){
		colNames[ii++] = d;
	}
	
	var columnHeader = $("#jqGrid").jqGrid('getGridParam', 'colNames')+'';
	var arrHeader    = columnHeader.split(',');
	var html         = '<table border="1"><tr>';
	
	for(var y= 1; y< arrHeader.length; y++){
		console.log(y , arrHeader[y])
		
		if(y != 2&&  y!= 16 &&  y!= 17 && y!=18 &&  y!= 19 && y!=21 && y!=22){
			var  top = arrHeader[y];
			if(top == 'delivery_date2'){
				top = '배송일'
			}
				
			html = html +'<td><b>'+ top + '</b></td>'	
		}
		
				
		//html = html +'<td><b>'+ encodeURIComponent( arrHeader[y] ) + '</b></td>'
	}
	
	html  = html +'</tr>';
	//console.log(html);
	//return;
	
	//console.log(mya.length);
	
	
	for(var i = 0 ; i< mya.length ; i++){
		var datac = $("#jqGrid").jqGrid('getRowData', mya[i]);
		html = html +'<tr>';
		
		//console.log(i , '--->' + colNames.length);
		//console.log(colNames.length);
		for(var j = 0; j<colNames.length; j++){
			if(j != 17&& j != 14 && j != 15 && j != 16 && j != 19 && j != 20){
				
				
				var txt_value = (datac[ colNames[j] ])  ;
				if(j == 4){
					txt_value =  $("#search_level  option[value='"+txt_value+"']").text() ;
				}
				
				if(j == 8){
					txt_value =  $("#search_pay  option[value='"+txt_value+"']").text() ;
				}
				
				
				
				if(j == 12){
					txt_value =  $("#search_order  option[value='"+txt_value+"']").text() ;
				}
				
				if(j == 22){
					txt_value ='미발송';
					if((datac[ colNames[j] ]) == 'y'){
						txt_value ='발송';
					}
				}
				
				/* 
				if(j == 4){
					txt_value =  $("#search_level  option[value='"+txt_value+"']").text() ;
				}
				 */
				html = html + '<td  style="mso-number-format:\'\@\'">' + txt_value + '</td>';	
			}
			//html = html + '<td>' + encodeURIComponent( datac[ colNames[j] ] ) + '</td>';
		}
		html = html +'</tr>';
	}// for
	
	
	html = html + '</table>';
	
	
	$('#csvBuffer').val(html);	
	$('#excelFrm').submit();
	
	console.log(111);
}
</script>
	<form id="excelFrm" name="excelFrm" action="gridExcelDown.do" method="post">
		<input type="hidden" name="csvBuffer" id="csvBuffer" />
		<input type="hidden" name="fileName" id="fileName" />
	</form>

	<div class="con_tit">주문관리 &gt; 약속처방</div>
	<div class="conBox">
		<div class="inputArea disB">
			<select name="search_member" id="search_member" style="margin-right: 5px;">
				<option value="">전체회원</option>
				<option value="4">가맹점</option>
				<option value="2">정회원</option>
			</select>
			
			<select name="search_sale" id="search_sale" style="margin-right: 5px;">
				<option value="">전체상품</option>
				<option value="2">가맹점상품</option>
				<option value="1">정회원상품</option>
			</select>
		
			기간 <input type="text" class="date" style="width: 80px;" id="search_sday"   /> 
			~ <input type="text" class="date"  style="width: 80px;" id="search_eday" />
			
			<select name="search_title" id="search_title">
				<option value="order_name">주문자</option>
				<option value="r_name">수취인</option>
				<option value="han_name">한의원명</option>
				<option value="order_phone">주문자 연락처</option>		
				<option value="order_handphone">알림톡연락처</option>				
				<option value="number_re">수신자연락처</option>
			</select>
			<input type="text" id="search_value" value="">
			
			진행상태 :
			<select name="search_order" id="search_order">
				 <option value="" >전체</option>
				 <option value="1">주문처리중</option>
				 <option value="2">배송준비</option>
				 <option value="3">배송중</option>
				 <option value="4">배송완료</option>
				 <option value="6">예약발송</option>
				 <option value="5">환불/취소</option>
				 <option value="7">입금대기</option>
			</select>
			
			등급 :
			<select name="search_level" id="search_level">
				 <option value="" >전체</option>
				 <c:forEach var="list" items="${mem_list}">
					<option value="${list.seqno}" >${list.member_nm}</option>
				</c:forEach>
			</select>
			
			결제방법
			<select name="search_pay" id="search_pay">
				 <option value="" >전체</option>
				 <option value="CARD">카드</option>
				 <option value="BANK">무통장입금</option>
				 <option value="Cms">계좌간편결제</option>				 
			</select>
			
			<a href="#" id="search_btn" class="btn01">검색</a>
			<a href="#" id="search_all_btn" class="btn01">전체 검색</a>
			<a href="#" id="del_btn"  class="btn01" style="background: red;border: 1px solid red;">선택삭제</a>
			
			<div style="height: 7px;"></div>
			상태처리 : 
			<select name="state_batch" id="state_batch">
				<option value="">선택</option>
				<option value="2">배송준비</option>
				<option value="3">배송중</option>
				<option value="4">배송완료</option>		
			</select>
			<a href="#" onclick="state_batch();" class="btn01">상태일괄처리</a>
			<a href="#" onclick="send_talk();" class="btn02">알림톡 발송</a>
			<a href="#" onclick="excelDown();" class="btn03">그리드 엑셀다운</a>
			
			<div style="display: none;">
				<select name="search_pay" id="search_pay">
					<option value="1">입금</option>
					<option value="2">미입금</option>
					<option value="3">방문결제</option>
					<option value="4">증정</option>
				</select>
			</div>
			
			<!-- <a href="#" onclick="send_talk2();" class="btn02">........</a> -->
		</div>
		
		<table id="jqGrid"></table>
		<div id="jqGridControl"></div>
		<div id="takbae_form"></div>
		
		<!-- value:"1:접수대기;2:입금대기;3:조제중;4:탕전중;5:발송;6:완료;7:환불취소;8:예약발송" -->
	</div>
	<div id="view_form"></div>
