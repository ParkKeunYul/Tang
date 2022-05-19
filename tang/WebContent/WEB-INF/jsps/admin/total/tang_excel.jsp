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

response.setHeader("Content-Disposition", "attachment; filename=tang_excel_"+sdf.format(now)+".xls");
response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>탕전집계</title>
</head>
<body>

<table border="1">
	<tr>
		<th colspan="2">한의원명</th>
		<th>주문횟수</th>
		<th>총 주문금액</th>
		<th style="color:blue;">결제금액</th>
		<th style="color:red;">할인금액</th>
		<th>탕전금액</th>
		<th>주수상반</th>
		<th>포장금액</th>
		<th>배달금액</th>
		<th>약재금액</th>
		<th style="color:red;">약재할인금액</th>
		<th style="color:blue;">약재결제금액</th>
	</tr>
	
	
	<c:set var="all_tot" value="0"></c:set>
	<c:set var="order_tot" value="0"></c:set>
	<c:set var="sale_tot" value="0"></c:set>
	<c:set var="tang_tot" value="0"></c:set>
	<c:set var="jusu_tot" value="0"></c:set>
	<c:set var="pojang_tot" value="0"></c:set>
	<c:set var="delivery_tot" value="0"></c:set>
	<c:set var="yakjae_tot" value="0"></c:set>
	<c:set var="yakjae_sale_tot" value="0"></c:set>
	<c:set var="yakjae_price_tot" value="0"></c:set>
	
	<c:forEach var="list" items="${list}">
		<tr>
			<c:set var="all_tot" value="${all_tot +  list.all_tot}"></c:set>
			<c:set var="order_tot" value="${order_tot +  list.order_tot}"></c:set>
			<c:set var="sale_tot" value="${sale_tot +  list.sale_tot}"></c:set>
			<c:set var="tang_tot" value="${tang_tot +  list.tang_tot}"></c:set>
			<c:set var="jusu_tot" value="${jusu_tot +  list.jusu_tot}"></c:set>
			
			<c:set var="pojang_tot" value="${pojang_tot +  list.pojang_tot}"></c:set>
			<c:set var="delivery_tot" value="${delivery_tot +  list.delivery_tot}"></c:set>
			<c:set var="yakjae_tot" value="${yakjae_tot +  list.yakjae_tot}"></c:set>
			<c:set var="yakjae_sale_tot" value="${yakjae_sale_tot +  list.yakjae_sale_tot}"></c:set>
			<c:set var="yakjae_price_tot" value="${yakjae_price_tot +  list.yakjae_price_tot}"></c:set>	
		
			<td width="300px" colspan="2">${list.han_name}</td>
			<td width="150px"><fmt:formatNumber value="${list.cnt}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.all_tot}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.order_tot}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.sale_tot}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.tang_tot}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.jusu_tot}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.pojang_tot}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.delivery_tot}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.yakjae_tot}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.yakjae_sale_tot}" pattern="#,###" /></td>
			<td width="150px"><fmt:formatNumber value="${list.yakjae_price_tot}" pattern="#,###" /></td>
		</tr>			
	</c:forEach>
	
	<tr>
		<td colspan="13"></td>
	</tr>
	<tr>
		<td colspan="13"></td>
	</tr>
	<tr>
		<td colspan="13"></td>
	</tr>
	
	<tr>
		<td colspan="3"></td>
		<td>총 주문금액</td>
		<td><fmt:formatNumber value="${all_tot}" pattern="#,###" /></td>
		<td style="color:blue;">총 결제금액</td>
		<td style="color:blue;"><fmt:formatNumber value="${order_tot}" pattern="#,###" /></td>
		<td style="color:red;">총 할인금액</td>
		<td style="color:red;"><fmt:formatNumber value="${sale_tot}" pattern="#,###" /></td>
		<td>총 탕전금액</td>
		<td><fmt:formatNumber value="${tang_tot}" pattern="#,###" /></td>
		<td>총 주수상반금액</td>
		<td><fmt:formatNumber value="${jusu_tot}" pattern="#,###" /></td>
	</tr>
	
	
	<tr>
		<td colspan="3"></td>
		<td>총 약재금액</td>
		<td><fmt:formatNumber value="${pojang_tot}" pattern="#,###" /></td>
		<td style="color:blue;">총 약재결제금액</td>
		<td style="color:blue;"><fmt:formatNumber value="${delivery_tot}" pattern="#,###" /></td>
		<td style="color:red;">총 약재할인금액</td>
		<td style="color:red;"><fmt:formatNumber value="${yakjae_tot}" pattern="#,###" /></td>
		<td>총 포장금액</td>
		<td><fmt:formatNumber value="${yakjae_sale_tot}" pattern="#,###" /></td>
		<td>총 배달금액</td>
		<td><fmt:formatNumber value="${yakjae_price_tot}" pattern="#,###" /></td>
	</tr>
</table>

</body>
</html>