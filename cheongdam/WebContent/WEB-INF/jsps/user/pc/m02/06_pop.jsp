<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(document).ready(function() {
	$(".fast_btn_close").click(function() {
		$('#list_popup').hide();
		return false;
	});
});
</script>
<p><a href="#" class="btn_close fast_btn_close"><img src="/assets/user/pc/images/sub/btn_close03.png" alt="" /></a></p>
<p class="tit"><span> </span>상세정보</p>
<table class="poplist">
	<colgroup>
		<col width="90px" />
		<col width="*" />
		<col width="90px" />
		<col width="*" />
	</colgroup>
	<tbody>
		<tr>
			<th>처방명</th>
			<td class="b" colspan="3">${info.tang_name }</td>
		</tr>
		<tr>
			<th>탕전방식</th>
			<td class="b" colspan="3">
				<c:choose>
					<c:when test="${info.c_tang_type eq 2}">무압력탕전</c:when>
					<c:when test="${info.c_tang_type eq 3}">압력탕전</c:when>
					<c:otherwise>첩약</c:otherwise>
				</c:choose>
				<c:if test="${info.c_tang_check eq 13}">(주수상반)</c:if>
				<c:if test="${info.c_tang_check eq 14}">(증류)</c:if>
				<c:if test="${info.c_tang_check eq 15}">(발효)</c:if>
				<c:if test="${info.c_tang_check eq 16}">(재탕)</c:if>
				
			</td>			
		</tr>
		<tr>
			<th>첩수</th>
			<td class="b">${info.c_chup_ea }</td>
			<th>총약재량</th>
			<td class="b">${info.c_chup_ea * info.c_chup_g }g</td>
		</tr>
		<tr>
			<th>팩용량</th>
			<td class="b">${info.c_pack_ml}ml</td>
			<th>팩수</th>
			<td class="b">${info.c_pack_ea}팩</td>
		</tr>
		<tr>
			<th>파우치</th>
			<td class="b">${info.c_pouch_type_nm }</td>
			<th>박스</th>
			<td class="b">${info.c_box_type_nm }</td>
		</tr>
		<tr style="display: none;">
			<th>스티로폼 포장</th>
			<td class="b">${info.c_stpom_type }</td>
			<th>박스수량</th>
			<td class="b">${info.c_box_ea }</td>
		</tr>
		<tr>
			<th>약재정보</th>
			<td height=310 colspan="3">
				<div style="height: 320px;OVERFLOW-Y:auto;font-size: 14px;">
					<ul>
						<c:forEach var="list" items="${ylist}">
							<li style="">${list.yak_name}/${list.yak_from}/${list.my_joje}g</li>
						</c:forEach>
					</ul>
				</div>
			</td>
		</tr>
	</tbody>
</table>