<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">


<style>
	.a{
		text-decoration: underline;
	}
</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	var mem_code = "${mem_code}";
</script>

<!-- <script type="text/javascript" src="/assets/admin/js/zjsp/order/z_tang.js"></script> -->
<script type="text/javascript" src="/assets/admin/js/jsp/order/tang.js?20200220_1"></script>
<script type="text/javascript">

$(document).ready(function() {
	$('#onExcel').click(function(){
		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
		
		var all_seqno;
		if( row.length > 0 ){
			
			for(var i = 0 ; i <row.length ; i++){
				var data =$("#jqGrid").jqGrid('getRowData', row[i]);
				if(i == 0){
					all_seqno  = data.seqno
				}else{
					all_seqno += ','+data.seqno	
				}
			}
			
			location.href='tang_excel.do?all_seqno='+all_seqno+'&ex_sday='+$('#search_sday').val()+'&ex_eday='+$('#search_eday').val();
		}else{
			alert('1건이상 선택후 다운로드 가능합니다.');
		}
	});
});

</script>
	
	<div class="con_tit">주문관리 &gt; 탕전주문</div>
	<div class="conBox">
		<div class="inputArea disB">
			기간 <input type="text" class="date" style="width: 80px;" id="search_sday"   /> 
			~ <input type="text" class="date"  style="width: 80px;" id="search_eday" />
			
			<select name="search_title" id="search_title">
				<option value="name">주문자</option>
				<option value="d_to_name">수취인</option>
				<option value="han_name">한의원명</option>		
			</select>
			<input type="text" id="search_value" value="">
			
			진행상태 :
			<select name="search_order" id="search_order">
				 <option value="" >전체</option>
				 <option value="1">접수대기</option>
				 <option value="2">입금대기</option>
				 <option value="3">조제중</option>
				 <option value="4">탕전중</option>
				 <option value="5">발송</option>
				 <option value="8">예약발송</option>
				 <option value="6">완료</option>
				 <option value="7">환불취소</option>
			</select>
			
			등급 :
			<select name="search_level" id="search_level">
				 <option value="" >전체</option>
				 <c:forEach var="list" items="${mem_list}">
					<option value="${list.seqno}" >${list.member_nm}</option>
				</c:forEach>
			</select>
			
			
			<a href="#" id="search_btn" class="btn01">검색</a>
			<a href="#" id="search_all_btn"  class="btn01">전체 검색</a>
			<a href="#" id="del_btn"  class="btn01" style="background: red;border: 1px solid red;">선택삭제</a>
			<a href="#" onclick="send_talk();" class="btn02">알림톡 발송</a>
			<a href="#" id="onExcel" class="btn03">엑셀다운</a>
			<div style="height: 3px;"></div>
			<select name="state_batch" id="state_batch">
				<option value="">선택</option>
				<option value="3">조제중</option>
				<option value="4">탕전중</option>
				<option value="5">발송</option>		
			</select>
			<a href="#" onclick="state_batch();" class="btn01">상태일괄처리</a>
			
			<select name="pay_batch" id="pay_batch">
				<option value="">선택</option>
				<option value="1">입금</option>
				<option value="2">미입금</option>
				<option value="3">방문결제</option>		
				<option value="4">증정</option>
			</select>
			<a href="#" onclick="pay_batch();" class="btn01">입금일괄처리</a>
			
		</div>
		
		<table id="jqGrid"></table>
		<div id="jqGridControl"></div>
		<div id="view_form"></div>
		
		<div id="takbae_form"></div>
		
		<!--value:"1:입금;2:미입금;3:방문결제;4:증정",-->
		<!-- value:"1:접수대기;2:입금대기;3:조제중;4:탕전중;5:발송;6:완료;7:환불취소;8:예약발송" -->
		
	</div>
</html>