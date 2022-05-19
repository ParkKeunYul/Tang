<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
	$(document).ready(function() {
		$('#jojeCancelBtn').click(function() {
			$('#jojeFrm').each(function(){
			    this.reset();
			 });
			return false;
		});
		$('#jojeSaveBtn').click(function() {
			if (!valCheck('jpop_name', '조제지시명을 입력하세요.')) return false;
			if (!valCheck('jpop_contents', '내용을 입력하세요.')) return false;
			
			$.ajax({
				url   : '/m02/04_pop_joje_proc.do',
				data  : $("#jojeFrm").serialize(),
				type  : 'POST',
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(data) {
					alert(data.msg);
					if(data.suc){
						location.href='/m02/04.do';	
					}
				}
			});
			
			return false;
		});
	});
</script>
<!-- layer_popup 조제지시사항  수정, 입력 -->
<span class="b-close"><img src="/assets/user/images/sub/btn_close02.png" alt="닫기" /></span>
<p class="ptit">조제지시사항</p>
<div class="content pformT">
	<p class="pcomment02">* 탕전실에 지시할 내용을 미리 정리해 놓으면 편리합니다.</p>
	<form action="/m02/04_pop_joje_proc.do" name="jojeFrm" id="jojeFrm" method="post">
		<input type="hidden" name="seqno"  value="${j_view.seqno}" />
		<input type="hidden" name="action" value="${j_bean.action}" />
		<table>			
			<colgroup>
				<col width="120px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>조제지시명</th>
					<td>
						<input type="text" name="name" id="jpop_name" style="width:350px;" value="${j_view.name}" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="contents" id="jpop_contents" style="width:350px; height:150px;resize:none;">${j_view.contents}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- btnarea -->
		<div class="btn_area01 pt15 mb0">
			<a href="#" id="jojeSaveBtn" ><span  class="h34 cg">저장</span></a>
			<a href="#" id="jojeCancelBtn"><span class="h34 cglay">취소</span></a>
		</div>
	</form>
	<!-- //btnarea -->		
</div>
<!-- //layer_popup 조제지시사항 불러오기 -->