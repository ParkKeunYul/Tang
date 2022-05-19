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
    response.setHeader("Content-Disposition", "attachment; filename=tangDetail2_"+sdf.format(now)+".xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");
 %>
 </head>
<body>
	
	<table width="570" border="1" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
	  <tr> 
	    <td width="100" height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">회원명(처방자)<br>
	      </font></strong></td>
	    <td width="170" height="25" colspan="3"  bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.name}<strong><br>
	      </strong></td>
	    <td height="25" width="100" align="center" bgcolor="e8e7e2"><strong><font color="#333333">한의원명</font></strong></td>
	    <td height="25" width="170" colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10;">${info.han_name }</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">주문번호</font></strong></td>
	    <td height="25" colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10;mso-number-format:'\@'" align="left">${info.order_no}<br></td>
	    <td height="25" " align="center" bgcolor="e8e7e2"><strong><font color="#333333">주문날짜</font></strong></td>
	    <td width="170" colspan="3" height="25" align="left" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.order_date}</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">주문상품</font></strong></td>
	    <td height="25" colspan="7" bgcolor="f8f8f8" style="padding : 0 0 0 10">[${info.s_name} ]</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">첩수</font></strong></td>
	    <td height="25" colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.c_chup_ea}첩 / ${info.c_chup_ea_g}gx${info.c_chup_ea_1}=${info.c_chup_g}g<br></td>
	    <td height="25" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>파우치 용량<br></strong></font></td>
	    <td height="25" colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.c_pack_ml}ml</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">팩수(초탕)<br></font></strong></td>
	    <td height="25" colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_pack_ea}</td>
	    <td height="25"  align="center" bgcolor="e8e7e2"><font color="#333333"><strong>팩수(재탕)<br></strong></font></td>
	    <td height="25" colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_more_tang}</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>탕전방식<br></strong></font></td>
	    <td height="25"  colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.c_tang_type_nm}</td>	    
		<td height="25"  align="center" bgcolor="e8e7e2"><font color="#333333"><strong>묶음배송<br></strong></font></td>
	    <td height="25"  colspan="3"  bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">
	    	<c:if test="${info.bunch != 'n' }">
    			<a href="javascript:order_detail(${info.seqno});">${info.s_name}</a>
    		</c:if>
	    </td>
	  </tr>
	  <tr> 
	    <td height="25"   align="center" bgcolor="e8e7e2"><font color="#333333"><strong>주수상반<br></strong></font></td>
	    <td height="25" colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.jusu}<br></td>
		<td height="25"   align="center" bgcolor="e8e7e2"><font color="#333333"><strong>스티로폼포장<br></strong></font></td>
	    <td height="25"  colspan="3"  bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_stpom_type_nm}</td>  
	  </tr>
	  
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">박스포장</font></strong></td>
	    <td height="25"  colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10;text-align:left;">${info.c_box_type_nm}</td>
	    <td height="25" align="center" bgcolor="e8e7e2"><font color="#333333"><strong>파우치포장</strong></font></td>
	    <td height="25"  colspan="3" bgcolor="f8f8f8" style="padding : 0 0 0 10">${info.c_pouch_type_nm }</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">조제지시사항</font></strong></td>
	    <td height="25" colspan="7" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_joje_contents}</td>
	  </tr>
	  <tr> 
	    <td height="25" align="center" bgcolor="e8e7e2"><strong><font color="#333333">복용법<br>
	      </font></strong></td>
	    <td height="25" colspan="7" bgcolor="f8f8f8" style="padding : 0 0 0 10" align="left">${info.c_bokyong_contents }</td>
	  </tr>
	  <tr> 
	    <td colspan="8" bgcolor="f8f8f8" valign=top>
		    <table width="100%" border="1" class="tb1">
              <tr> 
                <td width="100" height="28" align="center" bgcolor="#F4F4F0" class="gesi-list"><font color="#333333">약재명</font></td>
                <td width="50" align="center" bgcolor="#F4F4F0" class="gesi-list"><font color="#333333">원산지</font></td>
                <td width="60" align="center" bgcolor="#F4F4F0" class="gesi-list"><font color="#333333">위치</font></td>
                <td width="50" align="center" bgcolor="#F4F4F0" class="gesi-list"><font color="#333333">투여량(g)</font></td>
                <td width="100" align="center" bgcolor="#F4F4F0" class="gesi-list"><font color="#333333">약재명</font></td>
                <td width="50" align="center" bgcolor="#F4F4F0" class="gesi-list"><font color="#333333">원산지</font></td>
                <td width="60" align="center" bgcolor="#F4F4F0" class="gesi-list"><font color="#333333">위치</font></td>
                <td width="50" align="center" bgcolor="#F4F4F0" class="gesi-list"><font color="#333333">투여량(g)</font></td>
              </tr>
              
              <tr>
              	  <c:set var = "sum1" value = "0" />
              	  
              	  <c:set var = "total_joje_danga" value = "0" />
              	  
              	  
	              <c:forEach var="list" items="${yaklist}" varStatus="i">
	              	  <c:set var="sum1" value = "${sum1 + 1}" />
	              	  <c:set var ="total_joje_danga" value = "${total_joje_danga + list.p_joje }" />
	              	  <td align="center" class="gesi-list"><font color="#333333">${list.yak_name}</font></td>
			          <td align="center" class="gesi-list"><font color="#333333">${list.p_from}</font></td>
			          <td align="center" class="gesi-list"><font color="#333333">${list.yak_place}</font></td>
			          <td style="text-align:right;" class="gesi-list"><font color="#333333"><fmt:formatNumber value="${list.p_joje * info.c_chup_ea}" pattern=".00g" /></font></td>
			          <c:if test="${sum1%2 == 0 }">
			          	</tr><tr>
			          </c:if>
			          <c:if test="${i.last}">
			          		<c:if test="${sum1%2 == 1 }">
			          			<td></td><td></td><td></td><td></td>
			          		</c:if>
			          </c:if>
	              </c:forEach>
              </tr>
            </table>
	      </td>
	  </tr>
	  <tr> 
	    <td colspan="8" bgcolor="f8f8f8" valign=top>
	    	<c:set var = "c_chup_g" value = "${total_joje_danga * info.c_chup_ea_1}" />
		    
	    	<table width="100%" border="1" class="tb1">
              <tr> 
                <td width="140" height="50" align="center" bgcolor="#F4F4F0" colspan="2">
                	<span class="gesi-list"><font color="#333333">첩당 :</font></span> 
                	<span class="nem01"><font color="#333333"><fmt:formatNumber value="${total_joje_danga}" pattern=".00" /></font></span> 
                  	<span class="gesi-list"><font color="#333333">g</font></span> <br>
                  	<span class="gesi-list"><font color="#333333">소개 :</font></span> 
                  	<span class="nem01"><font color="#333333"><fmt:formatNumber value="${c_chup_g}" pattern=".00" /></font></span>
                  	<span class="gesi-list">g</span> <br>
                </td>
                <td colspan="4" align="center" bgcolor="#F4F4F0">
               		<%-- ${info.c_tang_type} --%> 
                	<%-- <c:if test="${info.c_tang_type eq 1 }"> --%>
                		<c:set var = "e1" 		   value = "${c_chup_g *1.7 }" />
                		<c:set var = "e2_1" 	   value = "${info.c_pack_ea +2 }" />
                		<c:set var = "e2_2" 	   value = "${info.c_pack_ml}" />
                		<c:set var = "e2" 		   value = "${e2_1 * e2_2 }" />
                		<c:set var = "total_water" value = "${e1 + 1000 + e2}" />
                	<%-- </c:if> --%>
                	<font color="#333333">
                		물량 =
                		<fmt:formatNumber value="${e1}" pattern=".0" />
                		+ 1000 + 
                		<fmt:formatNumber value="${e2}" pattern=".0" /> 
                		=
                		<fmt:formatNumber value="${total_water}" pattern=".0" />
                		ml
                	</font>
                </td>
                <td width="30" align="center" bgcolor="#F4F4F0" class="gesi-list">
                	<font color="#333333">확인</font>
                </td>
                <td align="center" bgcolor="#FFFFFF" class="gesi-list">&nbsp;</td>
              </tr>
           </table>
	    </td>
	  </tr>	   
	</table>
</body>
</html>
