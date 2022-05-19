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
			return false;
		});
		
		$('#onPrint').click(function() {
			window.print();
			return false;
		});
		
		$('#bunchBtn').click(function() {
			
			var width  = 820;
	 	    var height = 700;
			var left2  = window.pageXOffset + parseInt( ( $(window).width()/2 )  - (width/2)  );
	 	    var top2   = window.pageYOffset + parseInt( ( $(window).height()/2 ) - (height/2) );
	  		
	  		window.open ($(this).attr('href'),"over_view_2","toolbar=no, location=no, directories=no,resizable=no,left="+left2+",top="+top2+", width="+width+", height="+height+",scrollbars=yes")
			return false;
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
		
		.basic01 tbody tr td,
		.basic01 tbody tr th{
			padding: 3px 0;
		}
		
		.basic01 .tdL{
			padding: 3px 5px;
		}
		
		.add_th{
			background: #f9f9f9;
			font-size: 13px;
			font-weight: 400;
		}
		
		.basic01 tbody tr td{
			min-height: 30px;
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
			
			body{
				height: auto;
				min-height: 800px;
			}
  		}
	</style>
</head>
<body style="background-color: #fff;">
	<div id="idPrint">
		<p style="text-align: right;padding-top: 5px;" class="btn_area">
			<a href="detail_view.excel.do?seqno=${param.seqno}" class="btn01" id="onExcel">엑셀저장</a>
			<a href="#" class="btn02" id="onPrint">인쇄</a>
			<a href="#" class="btn03" id="onClose">닫기</a>
		</p>
		<form name="form" method=post>
			<table class="basic01" >
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
				</colgroup>
			  <tr> 
			    <td  align="center" class="add_th"><font>한의원명<br></font></td>
			    <td  width="170" class="tdL"><font>${info.han_name }</font></td>
			    <td  align="center"  class="add_th"><font>작성자</font></td>
			    <td  width="170"  class="tdL" ><font>${info.name}</font></td>
			  </tr>
			  
			  <tr> 
			    <td align="center"  class="add_th"><font>고객이름</font></td>
			    <td width="170"  class="tdL"><font>${info.w_name}</font></td>
			
			    <td align="center"  class="add_th"><font>처방제목</font></td>
			    <td  width="170"  class="tdL" ><font>[${info.s_name} ]</font></td>
		
			  </tr>
			  
			  <tr> 
			    <td align="center" class="add_th" ><font>주문번호</font></td>
			    <td class="tdL"><font>${info.order_no}</font><br></td>
			    <td align="center"  class="add_th"><font>주문날짜</font></td>
			    <td class="tdL"><font>${info.order_date}</font></td>
			  </tr>
			  
			  <tr> 
			    <td  align="center"  class="add_th"><font>배송구분</font></td>
			    <td  colspan="3"   class="tdL"><font><c:choose>
			   <c:when test="${info.d_type == '1'}">원외탕전 → 한의원주소</c:when>
			   <c:when test="${info.d_type == '4'}">원외탕전 → 고객주소</c:when>
			   <c:when test="${info.d_type == '3'}">한의원 → 고객주소</c:when>
			   <c:when test="${info.d_type == '6'}">방문수령</c:when>
			   <c:otherwise>기타</c:otherwise>
		   </c:choose></font></td>
			  </tr>
			  
			  <tr> 
			    <td  align="center"  class="add_th">고객주소</td>
			    <td  colspan="3"   class="tdL">
			    
			    	<!-- <p style="padding-bottom: 15px;">
			    		${info.d_from_name} ( ${info.d_from_handphone}&nbsp;&nbsp;  Tel : ${info.d_from_tel})<br>
						${info.d_from_zipcode} &nbsp;&nbsp;${info.d_from_address01}&nbsp;&nbsp; ${info.d_from_address02}
			    	</p>
					-->
			    	
			    	<p>
			    		${info.d_to_zipcode} &nbsp;&nbsp;${info.d_to_address01}&nbsp;&nbsp;${info.d_to_address02}
						( ${info.d_to_handphone}&nbsp;&nbsp;  Tel : ${info.d_to_tel})
			    	</p>
			    </td>
			  </tr>
			  
			  <tr> 
			     <td align="center"  class="add_th"><font>첩수</font></td>
			    <td class="tdL">
			    	<font>
			    		${info.c_chup_ea}첩 / <span id="txt_c2"></span>g x ${info.c_chup_ea_1} = <span id="txt_c4"></span>g <br/>
			    		<!-- 
			    		<input  type="text" value="${info.c_chup_ea}" name="c1" class="input" size="1" style="text-align=right;width: 25px;" >첩 /
			    		<input type="text"  name="c2" id="c2" class="input" size="3" style="text-align=right;color:#333333;width: 35px;">g x 
			    		<input type="text"  name="c3" value="${info.c_chup_ea_1}" class="input" size="1" style="text-align=right;width: 25px;">=
			    		<input type="text" name="c4" id="c4" class="input" size="4" style="color:#333333;width: 45px;">g
			    		 -->
			    	</font>
			    </td>
			    <td align="center"  class="add_th">용량/팩수<br></td>
			    <td class="tdL">
			    	<font>${info.c_pack_ml}ml</font> / <font>${info.c_pack_ea}</font>
			    </td>
			  </tr>
			  
			  <tr> 
			    <td align="center"  class="add_th"><font>탕전방식<br></font></td>
			    <td class="tdL"><font>${info.c_tang_type_nm}</font></td>
			    <td align="center"  class="add_th"><font>묶음배송<br></font></td>
			    <td class="tdL">
			    	<font>
			    		<c:if test="${info.bunch != 'n' }">
			    			<a href="detail_view.do?seqno=${info.bun_seqno}" id="bunchBtn">${info.bun_s_name}</a>
			    		</c:if>
			    	</font>
			    </td>
			  </tr>
			  <%-- 
			  <tr> 
			    <th align="center" ><font>주수상반<br></font></th>
			    <td class="tdL"><font>${info.jusu}</font></td>
			    <th align="center"  ><font>스티로폼포장</font></th>
			    <td class="tdL"><font><font color=blue>${info.c_stpom_type_nm}</font></font></td>
			  </tr>
			   --%>
			  <tr> 
			    <td align="center" class="add_th" ><font>박스포장/수량</font></td>
			    <td class="tdL">
			    	<font>
			    		${info.c_box_type_nm} / 
			    		<c:set var="c_box_ea" value = "${info.c_pack_ea / 60}" />
		    			<fmt:parseNumber integerOnly= "true" value= "${c_box_ea+(1-(c_box_ea%1))%1}" />
			    	</font>
			    </td>
			    <td align="center"  class="add_th"><font>파우치포장</font></td>
			    <td class="tdL"><font>${info.c_pouch_type_nm }</font></td>
			  </tr>
			  
			  <tr> 
			    <td  align="center" class="add_th" ><font>조제지시사항</font></td>
			    <td  colspan="3" class="tdL"  >
			    	<font>${fn:replace(info.c_joje_contents, newLineChar, "<br/>")}</font>
			    </td>
			  </tr>
			  
			  <tr> 
			     <td colspan="4"  valign=top  style="padding : 0 0 ;">
				 <table class="tbl">
			       <tr> 
	                <td width="100" height="28" align="center"  class="add_th" ><font color="#333333">약재명</font></td>
	                <td width="50" align="center"   class="add_th"><font color="#333333">원산지</font></td>
	                <td width="50" align="center"   class="add_th"><font color="#333333">투여량</font></td>
	                <td width="100" align="center"  class="add_th" ><font color="#333333">약재명</font></td>
	                <td width="50" align="center"   class="add_th"><font color="#333333">원산지</font></td>
	                <td width="50" align="center"   class="add_th"><font color="#333333">투여량</font></td>
	              </tr>
			       
			   <%--    <tr>
			        <c:set var = "sum1" value = "0" />
			        <c:set var = "sum2" value = "0" />
			        <c:set var = "sum3" value = "0" />
			        <c:set var = "sum4" value = "0" />
	
			        
					<c:forEach var="list" items="${yaklist}">
						<c:set var="sum1" value="${sum1 + list.p_joje }"></c:set>
						<c:set var="sum2" value="${sum2 + (list.p_joje * list.c_chup_ea) }"></c:set>
						<c:set var="sum3" value="${sum3 + list.p_danga}"></c:set>
						<c:set var="sum4" value="${sum4 + (list.p_danga * list.c_chup_ea)}"></c:set>
						
						<td align="center" ><font color="#333333">${list.yak_name}</font></td>
				          <td style="text-align:center;" ><font color="#333333">${list.p_from}</font></td>
				          <td style="text-align:center;" ><font color="#333333">${list.yak_place}</font></td>
				          <td style="text-align:right;" ><font color="#333333"><fmt:formatNumber value="${list.p_joje * info.c_chup_ea}" pattern=".00g" /></font></td>
				          <c:if test="${row_now%2 == 0 }">
				          	</tr><tr>
				          </c:if>
				          
				          
			        </c:forEach>
			      </tr> --%>
			      <tr>
	              	  <c:set var = "row_now" value = "0" />
	              	  <c:set var = "sum1" value = "0" />
			       	  <c:set var = "sum2" value = "0" />
			          <c:set var = "sum3" value = "0" />
			          <c:set var = "sum4" value = "0" />
	              	  
	              	  <c:set var = "total_joje_danga" value = "0" />
	              	  
	              	  
		              <c:forEach var="list" items="${yaklist}" varStatus="i">
		              	  <c:set var="row_now" value = "${row_now + 1}" />
		              	  <c:set var="sum1" value="${sum1 + list.p_joje }"></c:set>
						  <c:set var="sum2" value="${sum2 + (list.p_joje * list.c_chup_ea) }"></c:set>
						  <c:set var="sum3" value="${sum3 + list.p_danga}"></c:set>
						  <c:set var="sum4" value="${sum4 + (list.p_danga * list.c_chup_ea)}"></c:set>
		              	  <c:set var ="total_joje_danga" value = "${total_joje_danga + list.p_joje }" />
		              	 
		              	  <td align="center" class="tdL"><font color="#333333">${list.yak_name}</font></td>
				          <td style="text-align:center;" class="tdR"><font color="#333333">${list.p_from}</font></td>
				          <td style="text-align:right;" class="tdR" ><font color="#333333"><fmt:formatNumber value="${list.p_joje * info.c_chup_ea}" pattern=".00g" /></font></td>
				         
				          <c:if test="${row_now%2 == 0 }">
				          	</tr><tr>
				          </c:if>
				          <c:if test="${i.last}">
				          		<c:if test="${row_now%2 == 1 }">
				          			<td></td><td></td><td></td>
				          		</c:if>
				          </c:if>
		              </c:forEach>
	              </tr>
	              
			     <%-- 
			        <tr bgcolor="#F1F0EB"> 
			          <td align="center" colspan="2" ><font>소계</font></td>
			          <td class="tdR"><fmt:formatNumber value="${sum1}" pattern="#,###.00g" /></td>			          			         
			          <td class="tdR"><fmt:formatNumber value="${sum3}" pattern="#,###.00원" /></td>
			          <td class="tdR"><fmt:formatNumber value="${sum4}" pattern="#,### 원" /></td>
			          <td class="tdR"><fmt:formatNumber value="${sum2}" pattern="#,###.00g" /></td>			          
			        </tr>
			         --%>
			      </table>
			      	<input type="hidden" id="tot_g" value="${sum1}" />
			      	<input type="hidden" id="tot_tu" value="${sum2}" />
			      </td>
			  </tr>
			  
			  <tr> 
			    <td align="center"  class="add_th"><font>첩당<br></font></td>
			    <td class="tdL"><fmt:formatNumber value="${sum1}" pattern="#,###.00g" /></td>
			    <td align="center"  class="add_th"><font>소계<br></font></td>
			    <td class="tdL"><fmt:formatNumber value="${sum2}" pattern="#,###.00g" /></td>
			  </tr>
			  
			  <%-- 
			  <tr> 
			    <th  align="center" ><font>총비용</font></th>
			    <td  colspan="3" style="padding: 0px;" >
				    <table class="" style="width:100%;" >
				        <tr> 
				          <th width="90" height="28" align="center" ><font>약재비</font></th>
				          <th width="90" align="center" ><font>탕전비</font></th>
						  <th width="90" align="center" ><font>주수상반</font></th>
						  <th width="90" align="center" ><font>증류탕전</font></th>
				          <th width="90" align="center" ><font>배송비</font></th>
				          <th width="90" align="center" ><font>할인금액</font></th>
				          <th width="90" align="center" ><font>총결제</font></th>
				        </tr>
						<tr > 
				          <td width="90" height="28" align="center" ><font><fmt:formatNumber value="${info.order_yakjae_price}" pattern="#,### 원" /></font></td>
				          <td width="90" align="center"><font><fmt:formatNumber value="${info.order_tang_price}" pattern="#,### 원" /></font></td>
						  <td width="90" align="center"><font><fmt:formatNumber value="${info.order_suju_price}" pattern="#,### 원" /></font></td>
						  <td width="90" align="center"><font><fmt:formatNumber value="${info.order_jeunglyu_price}" pattern="#,### 원" /></font></td>
						  <td width="90" align="center"><font><fmt:formatNumber value="${info.order_delivery_price}" pattern="#,### 원" /></font></td>
				          <td width="90" align="center"><font><fmt:formatNumber value="${info.member_sale}" pattern="#,### 원" />&nbsp;</font></td>
				          <td width="90" align="center"><font><fmt:formatNumber value="${info.order_total_price}" pattern="#,### 원" /></font></td>
				        </tr>
					</table>	
				</td>
			  </tr>
			   --%>
			  <!-- 
			  <tr> 
			    <th  align="center" ><font>조제지시사항</font></th>
			    <td  colspan="3" class="tdL"  >
			    	<font>${fn:replace(info.c_joje_contents, newLineChar, "<br/>")}</font>
			    </td>
			  </tr>
			  
			   <tr> 
			    <th  align="center" ><font>조제첨부파일</font></th>
			    <td colspan="3" class="tdL"  >
			    	<c:if test="${!empty info.c_joje_file}">
						<p class=""><a href="/download.do?path=tang/${info.c_joje_folder}&filename=${info.c_joje_file}&refilename=${info.c_joje_file}">${info.c_joje_file}</a></p>
					</c:if>
			    </td>
			  </tr>
			  
			  <tr> 
			    <th  align="center" ><font>복용법<br></font></th>
			    <td  colspan="3"  class="tdL" >
			    	${fn:replace(info.c_bokyong_contents, newLineChar, "<br/>")}
			    	<font><br><a href="tang_bokyoung_print.do?seqno=${info.seqno}" target="_blank">[프린트]</a></font>
			    </td>
			  </tr>
			  
			  <tr> 
			    <th  align="center" ><font>복용첨부파일<br></font></th>
			    <td  colspan="3"  class="tdL" >
			    	<c:if test="${!empty info.c_bokyong_file}">
						<p class=""><a href="/download.do?path=tang/${info.c_bokyong_folder}&filename=${info.c_bokyong_file}&refilename=${info.c_bokyong_file}">${info.c_bokyong_file}</a></p>
					</c:if>
			    </td>
			  </tr>
			  
			  <tr> 
			    <th  align="center" ><font>발송정보<br></font></th>
			    <td  colspan="3"  class="tdL" >
			    	<font>
						${info.d_from_name} ( ${info.d_from_handphone}&nbsp;&nbsp;  Tel : ${info.d_from_tel})<br>
						${info.d_from_zipcode} &nbsp;&nbsp;${info.d_from_address01}&nbsp;&nbsp; ${info.d_from_address02}
					</font>
				</td>
			  </tr>
			  
			  <tr> 
			    <th  align="center" ><font>배송정보<br></font></th>
			    <td  colspan="3" class="tdL"  >
			    	<font>
			    		${info.d_to_name} ( ${info.d_to_handphone}&nbsp;&nbsp;  Tel : ${info.d_to_tel})<br>
		 				${info.d_to_zipcode} &nbsp;&nbsp;${info.d_to_address01}&nbsp;&nbsp;${info.d_to_address02}
				 	</font>
			 	 </td>
			  </tr>
			  
			  <tr> 
			    <th align="center" ><font>배송시메모<br></font></th>
			    <td colspan="3"  ><font>${info.d_to_contents}</font></td>
			  </tr>
			  
			  <tr> 
			    <th align="center" ><font>주문시요청사항<br></font></th>
			    <td colspan="3"  ><font>${info.d_to_contents2}</font></td>
			  </tr>
			  
			  <tr> 
			    <th align="center" ><font>관리자메모 </font></th>
			    <td colspan="3" ><font>${info.realprice_memo}</font></td>
			  </tr>
			   -->
			</table>
			
		</form>
	</div>
</body>
</html>