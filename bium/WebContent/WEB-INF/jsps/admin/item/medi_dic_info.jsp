<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>약재명 등록</title>	
	<script>
		$(document).ready(function() {
			$('#dic_modYakBtn').click(function() {
				
				var base_yak_code   = $('#base_yak_code').val();
				var rep_yakjae_coee = $('#rep_yakjae_coee').val();
				
				if(base_yak_code == rep_yakjae_coee){
					alert('동일한 약재로 변경할수 없습니다.');
					return false;
				}
				
				if(rep_yakjae_coee == ""){
					alert('변경할 약재를 선택하세요.');
					return false;
				}
				
				if(!confirm('변경하겠습니까?')){
					return false;
				}
				
				$.ajax({
					url : 'update_dic_yakjae.do',
					type : 'POST',
					data : {
						 base_yak_code   : base_yak_code
						,rep_yakjae_coee : rep_yakjae_coee
					},
					error : function() {
						alert('에러가 발생했습니다.\n관리자에 문의하세요.');
					},
					success : function(data) {
						alert(data.msg);
						if(data.suc){
							var call_type = $('#call_type').val();
							$("#"+call_type).trigger("reloadGrid");
			    			$("#dic_update_form").dialog('close');
						}
						
					}
				});
				
				//console.log('base_yak_code', base_yak_code);
				//console.log('rep_yakjae_coee', rep_yakjae_coee);
				return false;
			});
		});
	</script>
</head>
<body>

<form name="name_frm" method="post" id="name_frm" enctype="multipart/form-data" >
	<%-- <input type="hidden" name="seqno" id="seqno" value="${info.seqno }" />
	<input type="hidden" name="yak_code" id="yak_code" value="${info.yak_code }" />
	<input type="hidden" name="group_name" id="group_name" value="${param.search_group_name}" /> --%>
	
	<input type="hidden" name="call_type" id="call_type" value="${param.call_type }" />
	
	<%-- ${param} --%>
	<div class="inputArea disB">
	 	방제 등록된 약재  : <span style="font-weight: 700;color: blue;">${param.yak_name} (${param.yak_code})</span>  -->
	 	변경할 약재 : 
	 	<select name="rep_yakjae_coee" id="rep_yakjae_coee">
	 		<option value="">선택하세요.</option>
	 		<c:forEach var="list" items="${yak_list}">
	 			<option value="${list.yak_code}">${list.yak_name} (${list.yak_code})</option>
	 		</c:forEach>
	 	</select>
	 	<a href="#" id="dic_modYakBtn" class="btn03">변경</a>
	 	
	 	<input type="hidden" id="base_yak_code" value="${param.yak_code}" />
	 </div>
	
	<table class="basic01">
		<colgroup>
			<col width="70px" />
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<thead>
			<tr>
				<th>순번</th>
				<th>출전</th>
				<th>처방명</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${dic_list}">
				<c:set var="q" value="${q+1}"></c:set>
				<tr>
					<th>${q}</th>
					<td class="">${list.b_name}</td>
					<td class="tdL">${list.s_name}</td>					
				</tr>	
			</c:forEach>
					
		</tbody>
	</table>
</form>
</body>
</html>


