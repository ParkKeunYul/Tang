<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="application/vnd.ms-excel; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<title>탕전내용보기</title>
<%	
	pageContext.setAttribute("crlf", "\n");
	Date now  = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
    response.setHeader("Content-Disposition", "attachment; filename=tangDetail_"+sdf.format(now)+".xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");
 %>
 </head>
<body>
	<table width="570" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td height="5"></td>
	  </tr>
	  <tr> 
	    <td><strong><font color="#333333">▶ 주문내역서</font></strong></td>
	  </tr>
	  <tr> 
	    <td height="7"></td>
	  </tr>
	</table>
	
	<table width="570" border="1" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
	  <tr> 
	    <td width="100" height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">회원명(처방자)<br>
	      </font></strong></td>
	    <td width="170" height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.name}<strong><br>
	      </strong></td>
	    <td height="25" width="100" colspan="2" align="center" bgcolor="e8e7e2"><strong><font color="#333333">한의원명</font></strong></td>
	    <td height="25" width="170" bgcolor="f8f8f8" style="padding : 0 0 0 10;">${info.han_name }</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">주문번호</font></strong></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10;mso-number-format:'\@'" align="left">${info.order_no}<br></td>
	    <td height="25" colspan="2" align="center" bgcolor="e8e7e2"><strong><font color="#333333">주문날짜</font></strong></td>
	    <td width="170" height="25" align="left" bgcolor="f8f8f8" style="padding : 0 0 0 10;mso-number-format:\@;">${info.order_date2}</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">주문상품</font></strong></td>
	    <td height="25" colspan="4" bgcolor="f8f8f8" style="padding : 0 0 0 10">[${info.s_name} ]</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">첩수</font></strong></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.c_chup_ea}첩 / ${info.c_chup_ea_g}gx${info.c_chup_ea_1}=${info.c_chup_g}g<br></td>
	    <td height="25" colspan="2" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>파우치 용량<br>
	      </strong></font></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.c_pack_ml}ml</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">팩수(초탕)<br>
	      </font></strong></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_pack_ea}</td>
	    <td height="25" colspan="2" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>팩수(재탕)<br>
	      </strong></font></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_more_tang}</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>탕전방식<br>
	      </strong></font></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.c_tang_type_nm}</td>
	    
		<td height="25" colspan="2" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>묶음배송<br>
	      </strong></font></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">
	    	<c:if test="${info.bunch != 'n' }">
    			<a href="javascript:order_detail(${info.seqno});">${info.s_name}</a>
    		</c:if>
	    </td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>주수상반<br>
	      </strong></font></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.jusu}<br></td>
		<td height="25" colspan="2" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>스티로폼포장<br>
	      </strong></font></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_stpom_type_nm}</td>  
	  </tr>
	  
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">박스포장</font></strong></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10;text-align:left;">${info.c_box_type_nm}</td>
	    <td height="25" colspan="2" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>파우치포장</strong></font></td>
	    <td height="25" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.c_pouch_type_nm }</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">조제지시사항</font></strong></td>
	    <td height="25" colspan="4" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_joje_contents}</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">복용법<br>
	      </font></strong></td>
	    <td height="25" colspan="4" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_bokyong_contents }</td>
	  </tr>
	  <tr> 
	    <td height="200" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>처방내용</strong></font></td>
	    <td colspan="4" bgcolor="f8f8f8" valign=top><table width="100%" border="1" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
	        <tr bgcolor="gray"> 
	          <td width="70" height="25" align="center" class="gesi-list">약재명</td>
	          <td width="70" align="center" class="gesi-list">원산지</td>
	          <td width="70" align="center" class="gesi-list">조제량(g)</td>
	          <td width="80" align="center" class="gesi-list">g당 단가</td>
	          <td width="80" align="center" class="gesi-list">단가</td>
	          <td width="70" align="center" class="gesi-list">상태</td>
	        </tr>
	       
			<c:set var = "sum1" value = "0" />
		    <c:set var = "sum2" value = "0" />
		    <c:set var = "sum3" value = "0" />
		    <c:set var = "sum4" value = "0" />

		        
			<c:forEach var="list" items="${yaklist}">
				<c:set var="sum1" value="${sum1 + list.p_joje }"></c:set>
				<c:set var="sum2" value="${sum2 + (list.p_joje * list.c_chup_ea) }"></c:set>
				<c:set var="sum3" value="${sum3 + list.p_danga}"></c:set>
				<c:set var="sum4" value="${sum4 + (list.p_danga * list.c_chup_ea)}"></c:set>
			
				<tr bgcolor="#F9F9F9"> 
		          <td align="center" class="gesi-list">${list.yak_name}</td>
		          <td align="center" class="gesi-list">${list.p_from}</td>
		          <td align="center" class="nem01">${list.p_joje}<font>g</font></td>
		          <td align="left" class="nem01"><fmt:formatNumber value="${list.yak_price}" pattern="#,###.00원" /></td>
		          <td align="left" class="gesi-list"><fmt:formatNumber value="${list.p_danga * list.c_chup_ea}" pattern="#,###원" /></td>
		          <td align="center" class="gesi-list">
		          	<c:choose>
		          		<c:when test="${list.yak_status eq 'y'}">재고충분</c:when>
		          		<c:otherwise>재고부족</c:otherwise>
		          	</c:choose>
		          </td>
		        </tr>
		       
		   </c:forEach>
	
	
	        <tr bgcolor="#F1F0EB"> 
	          <td colspan="2" align="center" class="gesi-list">소계</td>
	          <td align="center" class="nem01"><fmt:formatNumber value="${sum1}" pattern=".00" /> g</td>
	          <td align="right" class="nem01"><fmt:formatNumber value="${sum3}" pattern="#,###.00원" /></td>
	          <td align="right" class="nem01" colspan="2"><fmt:formatNumber value="${sum4}" pattern="#,###원" /></td>
	        </tr>
	      </table></td>
	  </tr>
	</table>
</body>
</html>
