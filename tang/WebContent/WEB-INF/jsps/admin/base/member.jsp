<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	var a_mem_code = "0:가입신청;${mem_code}";
	var a_shop_code = "${shop_code}";
</script>
	<!-- 
	<script type="text/javascript" src="/assets/admin/js/zjsp/base/z_member.js?1112"> </script>
	
	 -->
	<script type="text/javascript" src="/assets/admin/js/jsp/base/member.js?1122212"> </script>
	<script>
		$(document).ready(function() {
			$('#out_btn').click(function() {
		  		var all_seqno= '';
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
				
				console.log('all_seqno =', all_seqno);
				
				
				if(!confirm('탈퇴 처리 하겠습니까?')){
		  			return false;
		  		}
				
				$.ajax({
		  			url  : 'out_member.do',
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
		  		})
			});
		})
	</script>
	<div class="con_tit">기본관리 &gt; 회원관리</div>
	
	
	<div class="conBox">
		<div class="inputArea disB">
			<select name="search_title" id="search_title">
				<option value="id">아이디</option>
				<option value="name">이름</option>
				<option value="han_name">한의원명</option>		
			</select>
			<input type="text" id="search_value" value="">
			<a href="#" id="search_btn" class="btn01">검색 </a>
			<a href="#" id="out_btn" class="btn03" style="color: red !important;">회원탈퇴</a>
		</div>
		
		<div id="modForm"></div>
		<table id="jqGrid"></table>
		<div id="jqGridControl"></div>
	</div>

</html>