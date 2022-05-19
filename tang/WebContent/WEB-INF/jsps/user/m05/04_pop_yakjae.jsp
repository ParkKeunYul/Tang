<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
	$(document).ready(function() {
		$('.popYajaeChangeBtn').click(function() {
			var rowId = "${bean.seqno}";
			var record = $('#jqGrid').jqGrid('getRowData', rowId);
						
			
			//console.log('record = ', record);
			var my_joje      = parseInt($("#jqGrid").getCell(rowId,"my_joje") );
			var group_code   = parseInt($("#jqGrid").getCell(rowId,"group_code") );
			var newRowId     = $(this).attr('attr4');
			
			
			var cnt = $("#jqGrid").getDataIDs();
			for (var i = 0; i < cnt.length; i++){
				if(newRowId ==cnt[i] ){
					alert($(this).attr('attr0')+'은 이미 등록된 약재입니다.');
    				return false;	
				}
			}// for i
			
			var a_yak_col = $('#a_yak_col').val();
			console.log('popYajaeChangeBtn = ', a_yak_col);
			
			var yak_name = $(this).attr('attr0') + ' <a href="#" attr="'+newRowId+'"  attr2="'+group_code+'" attr3="'+a_yak_col+'"  class="btn_change btn_change_'+newRowId+'"  ></a>';
			
			$("#jqGrid").setCell(rowId , 'seqno',  newRowId , null);
			$("#jqGrid").setCell(rowId , 'yak_name',  yak_name , null);
			$("#jqGrid").setCell(rowId , 'yak_code',  $(this).attr('attr5') , null);
			$("#jqGrid").setCell(rowId , 'yak_status', $(this).attr('attr1') , {color:'#222222',weightfont:'bold'});
			$("#jqGrid").setCell(rowId , 'yak_from', $(this).attr('attr2') , null);
			$("#jqGrid").setCell(rowId , 'yak_danga', $(this).attr('attr3') , null);			
			$("#jqGrid").setCell(rowId , 'danga', comma(parseInt($(this).attr('attr3')) * my_joje)+'원' , null);
			
			//changeRowid			
			//console.log( $("#"+rowId).attr("id", newRowId) );
			 $("#"+rowId).attr("id", newRowId);
			 $("#jqg_jqGrid_"+rowId).attr("id", "jqg_jqGrid_"+newRowId);
			 $('input[name=jqg_jqGrid_'+rowId+']').attr("name", "jqg_jqGrid_"+newRowId);
			
			 
			//danga  my_joje
			
			setTimeout(function(){
				tot_info();
				
				console.log('a_yak_col = ', a_yak_col);
				$('#jqGrid').editCell(a_yak_col, 5, true);
			},50);
			layer_yakjae_group(newRowId , group_code ,a_yak_col); 
			
			$('.yakjae_popup').hide();
			
			
			setTimeout(function(){
				yak_temp_save();
			},150);
			
			
			
			return false;
		});
		
		$("#popRepYakjaeBtn").click(function() {
			$('.yakjae_popup').hide();
			return false;
		});	
		
	});
</script>
<input type="hidden" id="a_yak_col" value="${bean.a_yak_col}" />
<table class="changelist">
	<colgroup>
		<col width="*" />
		<col width="70px" />
		<col width="100px" />
		<col width="80px" />
		<col width="70px" />
	</colgroup>
	<thead>
		<tr>
			<th>약재</th>
			<th>상태</th>
			<th>원산지</th>
			<th>단가(g)</th>
			<th>선택</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="list" items="${list}">
			<tr>
				<td>${list.yak_name}</td>
				<td>
					<c:if test="${list.yak_status eq 'y' }">처방가능</c:if>
					<c:if test="${list.yak_status ne 'y' }"><span class="fc01">처방불가</span></c:if>				
				</td>
				<td>${list.yak_from }</td>
				<td>${list.yak_danga }원</td>
				<td>
					<c:if test="${list.yak_status eq 'y' }">
						<a href="#" class="popYajaeChangeBtn" attr0="${list.yak_name}" attr1="${list.yak_status}" attr2="${list.yak_from}" attr3="${list.yak_danga}" attr4="${list.seqno}" attr5="${list.yak_code}"><img src="/assets/user/images/sub/btn_sel.png" alt="선택" /></a>
					</c:if>
				</td>
			</tr>		
		</c:forEach>
		<tr>
			<td colspan="5" style="text-align:center;padding:5px 0;">
				<a href="#" id="popRepYakjaeBtn"><span class="cBB h30">닫기</span></a>
			</td>
		</tr>
	</tbody>
</table>
