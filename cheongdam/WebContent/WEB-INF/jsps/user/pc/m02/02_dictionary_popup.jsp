<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>	
	<title>청담원외탕전</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta http-equiv="Expires" content="-1" /> 
	<meta http-equiv="Pragma" content="no-cache" /> 
	<meta http-equiv="Cache-Control" content="No-Cache" />
	<meta name="title" content="청담원외탕전" />
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/style.css?${menu.pp}" />
</head>
<body>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!-- 방제사전 popup width:1000px; height:700px -->
<div class="dictionary_popup">
	<div class="tit">
		<span>방제사전</span>
		<h4>${view.s_name}</h4>
	</div>
	<!-- dictionary_view -->
	<table class="view01">
		<colgroup>
			<col width="200px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>처방명</th>
				<td>${view.b_name}  /  ${view.s_name}</td>
			</tr>
			<tr>
				<th>관련조문</th>
				<td>${fn:replace(view.s_jomun, newLineChar, "<br/>")}</td>
			</tr>
			<tr>
				<th>적응증</th>
				<td>${fn:replace(view.s_jukeung, newLineChar, "<br/>")}</td>
			</tr>
			<tr>
				<th>참고사항</th>
				<td>${fn:replace(view.s_chamgo, newLineChar, "<br/>")}</td>
			</tr>
		</tbody>
	</table>
	<table class="view02">
		<colgroup>
			<col width="*" />
			<col width="200px" />
			<col width="150px" />
			<col width="150px" />
			<col width="160px" />
		</colgroup>
		<thead>
			<tr>
				<th>약재명</th>
				<th>원산지</th>
				<th>표준량(g)</th>
				<th>단가(g)</th>
				<th>가격</th>
			</tr>
		</thead>
		<tbody>
			<c:set var = "sum0" value = "0" />
			<c:set var = "sum1" value = "0" />
        	<c:set var = "sum2" value = "0" />
        	<c:forEach var="list" items="${subList}">
				<c:set var="sum0" value = "${sum0 + list.dy_standard}" />
				<c:set var="sum1" value = "${sum1 + list.i_yak_danga}" />
				<c:set var="sum2" value = "${sum2 + list.tot_yak_danga}" />
				<tr>
					<td class="L">${list.yak_name}</td>
					<td>${list.yak_from}</td>
					<td>${list.dy_standard }</td>
					<td class="R"><fmt:formatNumber value="${list.yak_danga}" pattern=".00" type = "number" />원</td>
					<td class="R"><fmt:formatNumber value="${list.yak_danga * list.dy_standard}" pattern=".00" type = "number" />원</td>
				</tr>
			</c:forEach>
			
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2" class="Rtit">합계</td>
				<td><span><fmt:formatNumber value="${sum0}" type = "number"  /></span>g</td>
				<td class="R"><span><fmt:formatNumber value="${sum1}" type = "number"  /></span>원</td>
				<td class="R"><span><fmt:formatNumber value="${sum2}" type = "number"  /></span>원</td>
			</tr>
		</tfoot>
	</table>
	<!-- //dictionary_view -->
</div>

</body>
</html>