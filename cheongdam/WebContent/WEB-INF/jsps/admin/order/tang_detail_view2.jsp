<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>탕전주문내역서</title>
	<link rel="stylesheet" href="/assets/admin/css/admin.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
	<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
	
	
	<script  src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="/assets/admin/js/jquery/jquery.ui.datepicker-ko.js"></script>
	
 	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>		
	<script type="text/javascript" src="/assets/admin/js/setting.js"></script>
	<script type="text/javascript" src="/assets/admin/js/validation.js"></script>
	
	<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>
	
	<script>
	$(document).ready(function() {
		
		var g = $('#tot_g').val();
		var tu = $('#tot_tu').val();
		
		
		$('#c2').val(parseInt(g));
		$('#txt_c2').text(g);
		
		
		$('#c4').val(parseInt(tu));
		$('#txt_c4').text(tu);
		
		
		$('#onClose').click(function() {
			self.close();
		});
		
		$('#onPrint').click(function() {
			print();
		});
		
		
		
	});
	</script>
	<style>
		.tbv tbody td{
			padding: 2px 10px 2px;
		}
		input[type="text"]{
			height: 22px;
			line-height: 22px;
		}
		
		.check_table tr td{
			border: 1px solid black;
		}
		
		.basic01 tbody tr td,
		.basic01 tbody tr th{
			padding: 3px 0;
		}
		
		.basic01 .tdL{
			padding: 3px 5px;
		}
		
		@media print{
			.btn_area{
				display: none;
			}
			.tbv tbody td{
				padding: 1px 10px 1px;
			}
			
			input[type="text"]{
				padding-left: 1px;
			}
  		}
	</style>
</head>
<body style="background-color: #fff;">
<div id="idPrint">
	<p style="text-align: right;padding-top: 5px;" class="btn_area">
		<a href="detail_view.excel2.do?seqno=${param.seqno}" class="btn01" id="onExcel">엑셀저장</a>
		<a href="#" class="btn02" id="onPrint">인쇄</a>
		<a href="#" class="btn03" id="onClose">닫기</a>
	</p>
	<table class="basic01">
        <tr> 
          <td width="270"><strong><font color="#333333">▶ 탕전주문내역서</font></strong></td>
          <td style="text-align:right;padding: 0 0 ;">
          	<table width="528" border="1" cellpadding="0" cellspacing="1"  class="">
              <tr> 
                <td width="40" rowspan="2" align="center" ><strong><font color="#333333">결 재</font></strong><br> </td>
                <td width="63" height="25" align="center" ><strong><font color="#333333">접수</font></strong></td>
                <td width="63" align="center" ><strong><font color="#333333">조제</font></strong></td>
				<td width="63" align="center" ><strong><font color="#333333">확인</font></strong></td>
                <td width="63" align="center" ><strong><font color="#333333">탕전</font></strong></td>
				<td width="63" align="center" ><strong><font color="#333333">이송</font></strong></td>
				<td width="63" align="center" ><strong><font color="#333333">포장</font></strong></td>
                <td width="63" align="center" ><strong><font color="#333333">발송</font></strong></td>
              </tr>
              <tr> 
                <td height="50" >&nbsp;</td>
                <td >&nbsp;</td>
                <td >&nbsp;</td>
                <td >&nbsp;</td>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table>
	<form name="form" method=post>
		<table class="basic01" style="border-top:none;margin-top:0px;">
			<colgroup>
				<col width="15%">
				<col width="35%">
				<col width="15%">
				<col width="35%">
			</colgroup>
		  <tr> 
		    <th align="center" ><strong><font color="#333333">회원명(처방자)<br></font></strong></th>
		    <td width="170"  class="tdL"><font color="#333333">${info.name}</font></td>
		    <th align="center" ><strong><font color="#333333">한의원명</font></strong></th>
		    <td width="170" class="tdL"><font color="#333333">${info.han_name }</font></td>
		  </tr>
		  
		  <tr> 
		    <th align="center" ><strong><font color="#333333">복용자</font></strong></th>
		    <td width="170"  class="tdL" ><font color="#333333">${info.w_name}</font></td>
		    <th align="center" ><strong><font color="#333333">성별/나이</font></strong></th>
		    <td  width="170"class="tdL"  ><font color="#333333">${info.w_sex_nm} / ${info.w_age}</font></td>
		  </tr>
		  
		  <tr> 
		    <th align="center" ><strong><font color="#333333">주문번호</font></strong></th>
		    <td class="tdL"><font color="#333333">${info.order_no}</font><br></td>
		    <th align="center" ><strong><font color="#333333">주문날짜</font></strong></th>
		    <td class="tdL"><font color="#333333">${info.order_date2}</font></td>
		  </tr>
		  
		  <tr> 
		    <th align="center" ><strong><font color="#333333">주문상품</font></strong></th>
		    <td colspan="3"  class="tdL"><font color="#333333">[${info.s_name} ]</font></td>
		  </tr>
		  
		  <tr> 
		    <th align="center" ><strong><font color="#333333">첩수</font></strong></th>
		    <td class="tdL">
		    	<font color="#333333">
		    		${info.c_chup_ea}첩 / <span id="txt_c2"></span>g x ${info.c_chup_ea_1} = <span id="txt_c4"></span>g <br/>
		    		<%-- <input  type="text" value="${info.c_chup_ea}" name="c1" class="input" size="1" style="text-align=right;width: 25px;" >첩 /
		    		<input type="text"  name="c2" id="c2" class="input" size="3" style="text-align=right;color:#333333;width: 35px;">gx
		    		<input type="text"  name="c3" value="${info.c_chup_ea_1}" class="input" size="1" style="text-align=right;width: 25px;">=
		    		<input type="text" name="c4" id="c4" class="input" size="4" style="color:#333333;width: 45px;">g<br> --%>
		    	</font>
		    </td>
		    <th align="center" ><font color="#333333"><strong>파우치 용량<br></strong></font></th>
		    <td class="tdL"><font color="#333333">${info.c_pack_ml}ml</font></td>
		  </tr>
		  
		  <tr> 
		    <th align="center" ><strong><font color="#333333">팩수<br></font></strong></th>
		    <td class="tdL"><font color="#333333">${info.c_pack_ea}</font></td>
		    <th align="center" ><font color="#333333"><strong>묶음배송<br></strong></font></th>
		    <td class="tdL"  >
		    	<font color="#333333">
		    		<c:if test="${info.bunch != 'n' }">
		    			<a href="javascript:order_detail(${info.seqno});">${info.s_name}</a>
		    		</c:if>
		    	</font>
		    </td>
		  </tr>
		  
		  <tr> 
		    <th align="center" ><font color="#333333"><strong>탕전방식<br></strong></font></th>
		    <td class="tdL"><font color="#333333">${info.c_tang_type_nm}</font></td>
		    <th align="center" ><font color="#333333"><strong>배송비</strong></font></th>
		    <td class="tdL">
		    	<c:if test="${info.order_delivery_price_check eq 'y' }"><font color="#333333">후불</font></c:if>
		    	<c:if test="${info.order_delivery_price_check != 'y' }"><font color="#333333">선불</font></c:if>
		    </td>
		  </tr>
		  
		  <tr> 
		    <th><font color="#333333"><strong>주수상반<br></strong></font></th>
		    <td class="tdL"><font color="#333333">${info.jusu}</font></td>
		    <th align="center"  ><font color="#333333"><strong>스티로폼포장</strong></font></th>
		    <td class="tdL" ><font color="#333333"><font color=blue>${info.c_stpom_type_nm}</font></font></td>
		  </tr>
		  
		  <tr> 
		    <th align="center" ><strong><font color="#333333">박스포장</font></strong></th>
		    <td class="tdL"><font color="#333333">${info.c_box_type_nm}</font></td>
		    <th align="center" ><font color="#333333"><strong>파우치포장</strong></font></th>
		    <td class="tdL"><font color="#333333">${info.c_pouch_type_nm }</font></td>
		  </tr>
		    <tr> 
		    <td colspan="4"  valign=top  style="padding:0 0 ;">
		    	<table width="100%" border="1" class="tb1">
	              <tr> 
	                <th width="100" height="28" align="center"  ><font color="#333333">약재명</font></th>
	                <th width="50" align="center"  ><font color="#333333">원산지</font></th>
	                <th width="60" align="center"  ><font color="#333333">위치</font></th>
	                <th width="50" align="center"  ><font color="#333333">투여량(g)</font></th>
	                <th width="100" align="center"  ><font color="#333333">약재명</font></th>
	                <th width="50" align="center"  ><font color="#333333">원산지</font></th>
	                <th width="60" align="center"  ><font color="#333333">위치</font></th>
	                <th width="50" align="center"  ><font color="#333333">투여량(g)</font></th>
	              </tr>
	              
	              <tr>
	              	  <c:set var = "row_now" value = "0" />
	              	  <c:set var = "sum1" value = "0" />
	              	  <c:set var = "sum2" value = "0" />
	              	  
	              	  <c:set var = "total_joje_danga" value = "0" />
	              	  
	              	  
		              <c:forEach var="list" items="${yaklist}" varStatus="i">
		              	  <c:set var="row_now" value = "${row_now + 1}" />
		              	  <c:set var="sum1" value = "${sum1 + list.p_joje}" />
		              	  <c:set var="sum2" value = "${sum2 + (list.p_joje * info.c_chup_ea)}" />
		              	  <c:set var ="total_joje_danga" value = "${total_joje_danga + list.p_joje }" />
		              	  <td align="center" ><font color="#333333">${list.yak_name}</font></td>
				          <td style="text-align:center;" ><font color="#333333">${list.p_from}</font></td>
				          <td style="text-align:center;" ><font color="#333333">${list.yak_place}</font></td>
				          <td style="text-align:right;" ><font color="#333333"><fmt:formatNumber value="${list.p_joje * info.c_chup_ea}" pattern=".00g" /></font></td>
				          <c:if test="${row_now%2 == 0 }">
				          	</tr><tr>
				          </c:if>
				          <c:if test="${i.last}">
				          		<c:if test="${row_now%2 == 1 }">
				          			<td></td><td></td><td></td><td></td>
				          		</c:if>
				          </c:if>
		              </c:forEach>
	              </tr>
	            </table>
	            <input type="hidden" id="tot_g" value="${sum1 }" />
	            <input type="hidden" id="tot_tu" value="${sum2 }" />
			</td>
		  </tr>
		  <tr> 
		    <td  colspan="4"  style="padding : 0 0 0 0">
		    	<c:set var = "c_chup_g" value = "${total_joje_danga * info.c_chup_ea_1}" />
		    
		    	<table width="100%" border="1" class="tb1">
	              <tr> 
	                <td width="110" height="50" class="tdL" >
	                	<span ><font color="#333333">첩당 :</font></span> 
	                	<span ><font color="#333333"><fmt:formatNumber value="${total_joje_danga}" pattern=".00g" /></font></span><br>
	                  	<span ><font color="#333333">소개 :</font></span> 
	                  	<span ><font color="#333333"><fmt:formatNumber value="${c_chup_g}" pattern=".00g" /></font></span>	                  	
	                </td>
	                <td width="320" align="center" >
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
	                <td width="30" align="center"  >
	                	<font color="#333333">확인</font>
	                </td>
	                <td align="center" bgcolor="#FFFFFF" >&nbsp;</td>
	              </tr>
	           </table>
			</td>
		  </tr>
		  
		  <tr> 
		    <th  align="center" ><strong><font color="#333333">조제지시사항</font></strong></th>
		    <td  colspan="3"  class="tdL" >
		    	<font>${fn:replace(info.c_joje_contents, newLineChar, "<br/>")}</font>
		    </td>
		  </tr>
		  
		  <tr> 
		    <th  align="center" ><strong><font color="#333333">조제첨부파일</font></strong></th>
		    <td  colspan="3"  class="tdL" >
		    	<c:if test="${!empty info.c_joje_file}">
					<p class=""><a href="/download.do?path=tang/${info.c_joje_folder}&filename=${info.c_joje_file}&refilename=${info.c_joje_file}">${info.c_joje_file}</a></p>
				</c:if>
		    </td>
		  </tr>
		  
		  <tr> 
		    <th  align="center" ><strong><font color="#333333">복용법<br></font></strong></th>
		    <td  colspan="3" class="tdL"  >
		    	${fn:replace(info.c_bokyong_contents, newLineChar, "<br/>")}
		    	<font><br><a href="tang_bokyoung_print.do?seqno=${info.seqno}" target="_blank">[프린트]</a></font>
		    </td>
		  </tr>
		  
		  <tr> 
		    <th  align="center" ><strong><font color="#333333">복용첨부파일<br></font></strong></th>
		    <td  colspan="3" class="tdL" >
		    	<c:if test="${!empty info.c_bokyong_file}">
					<p class=""><a href="/download.do?path=tang/${info.c_bokyong_folder}&filename=${info.c_bokyong_file}&refilename=${info.c_bokyong_file}">${info.c_bokyong_file}</a></p>
				</c:if>
		    </td>
		  </tr>
		  
		  <tr> 
		    <th  align="center" ><strong><font color="#333333">발송정보<br></font></strong></th>
		    <td  colspan="3"  class="tdL">
		    	<font color="#333333">
					${info.d_from_name} ( ${info.d_from_handphone}&nbsp;&nbsp;  Tel : ${info.d_from_tel})<br>
					${info.d_from_zipcode} &nbsp;&nbsp;${info.d_from_address01}&nbsp;&nbsp; ${info.d_from_address02}
				</font>
			</td>
		  </tr>
		  <tr> 
		    <th  align="center" ><strong><font color="#333333">배송정보<br></font></strong></th>
		    <td  colspan="3" class="tdL" >
		    	<font color="#333333">
		    		${info.d_to_name} ( ${info.d_to_handphone}&nbsp;&nbsp;  Tel : ${info.d_to_tel})<br>
	 				${info.d_to_zipcode} &nbsp;&nbsp;${info.d_to_address01}&nbsp;&nbsp;${info.d_to_address02}
			 	</font>
		 	 </td>
		  </tr>
		  
		  <tr> 
		    <th align="center" ><strong><font color="#333333">배송시메모<br></font></strong></th>
		    <td colspan="3"class="tdL"  ><font color="#333333">${info.d_to_contents}</font></td>
		  </tr>
		  
		  <tr> 
		    <th  align="center" ><strong><font color="#333333">주문시요청사항<br></font></strong></th>
		    <td  colspan="3" class="tdL" ><font color="#333333">${info.d_to_contents2}</font></td>
		  </tr>
		  
		  <tr> 
		    <th align="center" ><strong><font color="#333333">관리자메모 </font></strong></th>
		    <td colspan="3" class="tdL"><font color="#333333">${info.realprice_memo}</font></td>
		  </tr>
		</table>
	</form>
</div>
	
	
</body>
</html>