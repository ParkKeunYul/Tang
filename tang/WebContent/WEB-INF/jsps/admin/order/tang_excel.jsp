<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"
%><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%

Date now = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");

String file_name = "탕전주문내역";


response.setHeader("Content-Disposition", "attachment; filename="+new String((file_name).getBytes("KSC5601"),"8859_1")+"_"+sdf.format(now)+".xls");
response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>탕전주문내역</title>
</head>
<body>
<table border="0">
	<tr>
		<td colspan="4" style="text-align:right">${param.ex_sday } ~ ${param.ex_eday }</td>
	</tr>
</table>

<table border="1">
	<tr>
		<th width="100px" >No.</th>
		<th width="300px">고객명</th>
		<th width="300px">주문자</th>
		<th width="300px">복용자</th>
		<th width="300px">주문일</th>
		<th width="300px">처방명</th>
		<th width="300px">약재비</th>
		<th width="300px">탕전비</th>
		<th width="300px">주수상반</th>
		<th width="300px">포장비</th>
		<th width="300px">배송비</th>
		<th width="300px">총비용</th>
	</tr>
	
	
	<c:forEach var="list" items="${list}">
		<c:set var="q" value="${q+1}"></c:set>
		
		<c:set var="sum1" value="${sum1 + list.order_yakjae_price }"></c:set>
		<c:set var="sum2" value="${sum2 + list.order_tang_price}"></c:set>
		<c:set var="sum3" value="${sum3 + list.order_suju_price}"></c:set>
		<c:set var="sum4" value="${sum4 + list.order_pojang_price }"></c:set>
		<c:set var="sum5" value="${sum5 + list.order_delivery_price}"></c:set>
		<c:set var="sum6" value="${sum6 + list.order_total_price+list.member_sale}"></c:set>
		
		<tr>
			<td width="100px" style="text-align:center">${q}</td>			
			<td width="300px" >${list.mb_name}</td>
			<td width="300px" >${list.name}</td>
			<td width="300px" >${list.w_name}</td>
			<td width="300px" align="center" style="mso-number-format:'\@'">${list.order_date2}</td>
			<td width="300px" align="left" >${list.s_name}</td>
			<td width="300px" align="right" ><fmt:formatNumber value="${list.order_yakjae_price}" pattern="#,###" /></td>
			<td width="300px" align="right" ><fmt:formatNumber value="${list.order_tang_price}" pattern="#,###" /></td>
			<td width="300px" align="right" >
				<c:choose>
					<c:when test="${empty list.order_suju_price || list.order_suju_price eq ''}">0</c:when>
					<c:otherwise><fmt:formatNumber value="${list.order_suju_price}" pattern="#,###" /></c:otherwise>
				</c:choose>
				
			</td>
			<td width="300px" align="right" ><fmt:formatNumber value="${list.order_pojang_price}" pattern="#,###" /></td>
			<td width="300px" align="right" ><fmt:formatNumber value="${list.order_delivery_price}" pattern="#,###" /></td>
			<td width="300px" align="right" ><fmt:formatNumber value="${list.order_total_price+list.member_sale}" pattern="#,###" /></td>
		</tr>			
	</c:forEach>
		<tr>
			<td colspan="6" align="center">합계 </td>
			<td style="color:blue;font-weight:700;"><fmt:formatNumber value="${sum1}" pattern="#,###" /></td>
			<td style="color:blue;font-weight:700;"><fmt:formatNumber value="${sum2}" pattern="#,###" /></td>
			<td style="color:blue;font-weight:700;"><fmt:formatNumber value="${sum3}" pattern="#,###" /></td>
			<td style="color:blue;font-weight:700;"><fmt:formatNumber value="${sum4}" pattern="#,###" /></td>
			<td style="color:blue;font-weight:700;"><fmt:formatNumber value="${sum5}" pattern="#,###" /></td>
			<td style="color:blue;font-weight:700;"><fmt:formatNumber value="${sum6}" pattern="#,###" /></td>
		</tr>
	
	
</table>

</body>
</html>