<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- contents -->
<div class="contents">
	<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>사전조제지시서 관리</span></p>

	<ul class="submenu w33">
		<li><a href="01.do">약속처방</a></li>
		<li><a href="02.do">약속처방 보관함</a></li>
		<li ><a href="03.do" class="sel">사전조제지시서 관리</a></li>
	</ul>

	<!-- 본문내용 -->
	<!-- 사전조제지시서 관리 -->
	<table class="order_view mb30">
		<colgroup>
			<col width="*" />
			<col width="120px" />
			<col width="120px" />
			<col width="130px" />
		</colgroup>
		<thead>
			<tr>
				<th>처방명</th>
				<th>남은수량</th>
				<th>추가</th>
				<th>마지막 겡신일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${list}">
				<tr>
					<td class="L">
						${list.p_name}
						<c:if test="${list.sale_type eq 2 }"> <span style="color:#fb665f;">(가맹점)</span></c:if>
					</td>
					<td><fmt:formatNumber value="${list.ea - list.order_cnt - list.cart_cnt }" pattern="#,###" /></td>
					<td><a href="#" onclick="window.open('01_preorder.do?p_seq=${list.goods_seqno}','사전조제지시','width=700, height=570, menubar=no, status=no, toolbar=no');"><span class="cB h25">추가하기</span></a></td>
					<td>${list.upt_date2}</td>
				</tr>	
			</c:forEach>
						
		</tbody>
	</table>
	<!-- // 사전조제지시서 관리 -->
	
	<!-- paging -->
	<div class="pt20">
	${navi}
	</div>
	<!-- //paging -->
	<!-- //본문내용 -->

</div>
<!-- // contents -->
		