<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">사전조제지시서</p>
		<div class="lnbDepth">
			<ul>
				<li><a href="01.do">약속처방</a></li>
				<li><a href="02.do">약속처방 보관함</a></li>
				<li class="sel"><a href="03.do">사전조제지시서</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<div class="contents" id="contents">
		<!-- 사전조제지시서 관리 -->
		<table class="askList">
			<colgroup>
				<col width="*" />
				<col width="13%" />
				<col width="28%" />
				<col width="18%" />
			</colgroup>
			<thead>
				<tr>
					<th>처방명</th>
					<th>수량</th>
					<th>마지막 겡신일</th>
					<th>추가</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
					<tr>
						<td class="L">${list.p_name}</td>
						<td><fmt:formatNumber value="${list.ea - list.order_cnt - list.cart_cnt }" pattern="#,###" /></td>
						<td>${list.upt_date2}</td>
						<td><a href="#" class="btnTypeBasic sizeXS colorOrange"  onclick="window.open('/m/m03/01_preorder.do?p_seq=${list.goods_seqno}','사전조제지시','width=700, height=570, menubar=no, status=no, toolbar=no');"><span class="cO h25">추가</span></a></td>
					</tr>	
				</c:forEach>
				<%-- 
				<tr>
					<td class="L">경옥고</td>
					<td>100</td>
					<td>2019-12-08</td>
					<td>
						<a href="popup01.html" class="btnTypeBasic sizeXS colorOrange"><span>추가</span></a>
					</td>
				</tr>
				 --%>
			</tbody>
		</table>
		<!-- // 사전조제지시서 관리 -->
		
		${navi}
	</div>
	<!-- //본문 -->

</div>
<!-- //container -->