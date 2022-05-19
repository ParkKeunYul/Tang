<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!-- container -->

<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "마이페이지";
		String sec_nm = "마이페이지";
		String thr_nm = "주문내역";
		int fir_n = 5;
		int sub_n = 3;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	
	
	<!-- contents -->
	<div id="contents">
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit">주문내역</p>
			<p>주문하신 상품과 배송, 결제 정보를 확인하실 수 있습니다.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">

			<div class="topinfo">
				<div>
					<p>처방정보</p>
					<ul>
						<li><span class="tit">환자명</span>${info.w_name}</li>
						<li><span class="tit">성별/나이</span>${info.w_sex_nm} / ${info.w_age}</li>
						<li><span class="tit">처방명</span>${info.s_name}</li>
						<li><span class="tit">출전</span>${info.b_name}</li>
					</ul>
				</div>
				<div class="ml60">
					<p>결제정보</p>
					<ul>
						<li><span class="tit">결제유형</span>
							${info.payment_kind_nm}
							<c:if test="${info.payment_kind eq 'Card' }">
								<a href="https://npg.nicepay.co.kr/issue/IssueLoader.do?TID=${info.card_gu_no}&type=0" id="receiptBtn"  class="ml10"><span class="cO h20">영수증</span></a>
							</c:if>
						</li>
						<li>
							<span class="tit">결제상태</span>
							<c:if test="${info.payment eq 1 }">입금</c:if>
							<c:if test="${info.payment eq 2 }">미입금</c:if>
							<c:if test="${info.payment eq 3 }">후불</c:if>
						</li>
						<li>
							<span class="tit">진행상태</span>
							<c:if test="${info.order_ing eq 1 }">접수대기</c:if>
							<c:if test="${info.order_ing eq 2 }">입금대기</c:if>
							<c:if test="${info.order_ing eq 3 }">조제중</c:if>
							<c:if test="${info.order_ing eq 4 }">탕전중</c:if>
							<c:if test="${info.order_ing eq 5 }">발송</c:if>
							<c:if test="${info.order_ing eq 6 }">완료</c:if>
							<c:if test="${info.order_ing eq 7 }">환불취소</c:if>
							<c:if test="${info.order_ing eq 8 }">예약발송</c:if>
						</li>
					</ul>
				</div>
			</div>
			
			<div class="topinfo">
				<div>
					<p>
						보내는 사람
						<span class="fc01 b">
							<c:choose>
						       <c:when test="${info.d_type == '1'}">(탕전실)</c:when>
						       <c:when test="${info.d_type == '4'}">(탕전실)</c:when>
						       <c:when test="${info.d_type == '3'}">(한의원)</c:when>
						       <c:when test="${info.d_type == '6'}">방문수령</c:when>
						   </c:choose>
						</span>
					</p>
					<ul>
						<li><span class="tit">발신인</span>${info.d_from_name}</li>
						<li><span class="tit">연락처</span>${info.d_from_tel }</li>
						<li><span class="tit">휴대전화</span>${info.d_from_handphone }</li>
						<li><span class="tit">주소</span>
							${info.d_from_zipcode}<br/>${info.d_from_address01}&nbsp; ${info.d_from_address02}
						</li>
					</ul>
				</div>
				<div class="ml60">
					<p>
						받는 사람
						<span class="fc01 b">
							<c:choose>
						       <c:when test="${info.d_type == '1'}">(한의원)</c:when>
						       <c:when test="${info.d_type == '4'}">(환자)</c:when>
						       <c:when test="${info.d_type == '3'}">(환자)</c:when>
						       <c:when test="${info.d_type == '6'}">방문수령</c:when>
						   </c:choose>
						</span>
					</p>
					<ul>
						<li><span class="tit">수신인</span>${info.d_to_name }</li>
						<li><span class="tit">연락처</span>${info.d_to_tel}</li>
						<li><span class="tit">휴대전화</span>${info.d_to_handphone}</li>
						<li><span class="tit">주소</span>${info.d_to_zipcode}<br/>${info.d_to_address01}&nbsp; ${info.d_to_address02}</li>
						<li><span class="tit">배송메모</span>${fn:replace(info.d_to_contents, newLineChar, "<br/>")}</li>
						<li><span class="tit">택배정보</span>
							<c:if test="${not empty info.delivery_no  }">
							발송일 : ${info.delivery_date }<br/><strong>송장번호 : ${info.deliveryno}  (${info.tak_sel_nm})</strong>
							<a href="https://tracker.delivery/#/${info.tak_sel_id}/${info.delivery_no}" class="deleberyBtn ml10"><span class="cO h20">배송조회</span></a>														
							</c:if>
						</li>
					</ul>
				</div>
			</div>
			<!-- orderview -->
		<%-- 	<table class="order_view">
				<colgroup>
					<col width="*" />
					<col width="160px" />
					<col width="130px" />
				</colgroup>
				<thead>
					<tr>
						<th>상품정보</th>
						<th>상품금액</th>
						<th>배송비</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="L">격하축어탕 + 계지복령 + 용안육교이<a href="#" onclick="window.open('order_detail_popup.html','window팝업','width=1000, height=700, menubar=no, status=no, toolbar=no');"><span class="cblue h25 ml10">처방상세내역 보기</span></a></td>
						<td class="R"><strong>14,400</strong>원</td>
						<td class="R"><strong>3,000</strong>원</td>
					</tr>
				</tbody>
			</table> --%>
			<!-- // orderview -->
			<div class="totalBox" style="margin-top:-1px;">
				<ul>
					<li class="tit">결제안내<span class="fc01">(${info.payment_kind_nm})</span></li>
					<c:choose>
						<c:when test="${userInfo.mem_sub_grade eq 2}">
							<li class="Bt01">처방금액<span class="won">***,***</span></li>
							<li class="Bt02">배송비<span class="won">***,***</span></li>
							<li class="total">합계<span class="won">***,***</span></li>
						</c:when>
						<c:otherwise>																	
							<li class="Bt01">처방금액<span class="won"><fmt:formatNumber value="${info.order_total_price - info.order_delivery_price}" pattern="#,###원" /></span></li>
							<li class="Bt02">배송비<span class="won"><fmt:formatNumber value="${info.order_delivery_price}" pattern="#,###원" /></span></li>
							<li class="total">합계<span class="won"><fmt:formatNumber value="${info.order_total_price}" pattern="#,###원" /></span></li>
						</c:otherwise>
					</c:choose>
				
					
				</ul>
			</div>
			
			<div class="dictionary_popup" style="width: 100%;margin-top: 20px;display: none;">
				<div class="tit">
					<h4>세부내역</h4>
				</div>
				<!-- 처방전 세부내역 -->
				<table class="view01">
					<colgroup>
						<col width="150px" />
						<col width="*" />
						<col width="150px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>주문일자</th>
							<td>${info.order_date}</td>
							<th>주문번호</th>
							<td>${info.order_no}</td>
						</tr>
						<tr>
							<th>고객/환자명</th>
							<td>${info.w_name}</td>
							<th>성별/나이</th>
							<td>${info.w_sex_nm}/${info.w_age}</td>
						</tr>
						<tr>
							<th  style="display: none;">진단</th>
							<td  style="display: none;">${info.w_jindan}</td>
							<th>체격/체형</th>
							<td colspan="3">${info.w_size}</td>
						</tr>
						<tr style="display: none;">
							<th>기타1</th>
							<td>${info.w_etc01}</td>
							<th>기타2</th>
							<td>${info.w_etc02}</td>
						</tr>
						<tr>
							<th>증상</th>
							<td colspan="3">${info.w_contents}</td>
						</tr>
						<tr>
							<th>처방명/출전</th>
							<td colspan="3">${info.s_name}/${info.b_name}</td>
						</tr>
						<tr>
							<th>첩수/탕전</th>
							<td colspan="3">
								${info.c_chup_ea}첩/
								<c:if test="${info.c_tang_type eq 1}">첩약</c:if>
								<c:if test="${info.c_tang_type eq 2}">무압력탕전</c:if>
								<c:if test="${info.c_tang_type eq 3}">압력탕전</c:if>
								<c:if test="${info.c_tang_check13 eq 'y' }">(주수상반)</c:if>
								<c:if test="${info.c_tang_check14 eq 'y' }">(증류)</c:if>
								<c:if test="${info.c_tang_check15 eq 'y' }">(발효)</c:if>
								<c:if test="${info.c_tang_check16 eq 'y' }">(재탕)</c:if>
							</td>
						</tr>
						<tr <c:if test="${info.c_tang_type eq 1}">style="display: none;"</c:if> >
							<th>포장/팩수</th>
							<td colspan="3">${info.c_pack_ml}ml / 초탕:${info.c_pack_ea} </td>
						</tr>
						<tr <c:if test="${info.c_tang_type eq 1}">style="display: none;"</c:if> >
							<th>박스/수량</th>
							<td colspan="3">
								${info.c_box_nm} /
								<c:set var="c_box_ea" value = "${info.c_pack_ea / 60}" />
		    					<fmt:parseNumber integerOnly= "true" value= "${c_box_ea+(1-(c_box_ea%1))%1}" /> 
							</td>
						</tr>
					</tbody>
				</table>
			
				<table class="view02">
					<colgroup>
						<col width="*" />
						<col width="160px" />
						<col width="100px" />
						<col width="130px" />
						<col width="160px" />
					</colgroup>
					<thead>
						<tr>
							<th>약재명</th>
							<th>원산지</th>
							<th>조제량(g)</th>
							<th>단가(g)</th>
							<th>가격</th>
						</tr>
					</thead>
					<tbody>
						
					
						<c:forEach var="list" items="${p_list}">
							<c:set var="sum1" value="${sum1 + (list.p_joje * list.c_chup_ea) }"></c:set>
							<c:set var="sum2" value="${sum2 + list.yak_price}"></c:set>
							<c:set var="sum3" value="${sum3 + (list.p_danga * list.c_chup_ea)}"></c:set>
						
							<tr>
								<td class="L">${list.yak_name}</td>
								<td>${list.p_from}</td>
								<td><fmt:formatNumber value="${list.p_joje * list.c_chup_ea}" pattern="#,###.00" /></td>
								
								<c:choose>
									<c:when test="${userInfo.mem_sub_grade eq 2}">
										<td class="R">***,***</td>
										<td class="R">***,***</td>
									</c:when>
									<c:otherwise>										
										<td class="R"><fmt:formatNumber value="${list.yak_price}" pattern="#,###.00원" /></td>
										<td class="R"><fmt:formatNumber value="${list.p_danga * list.c_chup_ea}" pattern="#,###원" /></td>
									</c:otherwise>
								</c:choose>
								
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2" class="Rtit">합계</td>
							<td><span><fmt:formatNumber value="${sum1}" pattern="#,###.00" /></span>g</td>
							
							<c:choose>
								<c:when test="${userInfo.mem_sub_grade eq 2}">
									<td class="R">***,***</td>
									<td class="R">***,***</td>
								</c:when>
								<c:otherwise>										
									<td class="R"><span><fmt:formatNumber value="${sum2}" pattern="#,###.00" /></span>원</td>
									<td class="R"><span><fmt:formatNumber value="${sum3}" pattern="#,###" /></span>원</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</tfoot>
				</table>
			
				<table class="view01">
					<colgroup>
						<col width="150px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>조제지시사항</th>
							<td>${fn:replace(info.c_joje_contents, newLineChar, "<br/>")}</td>
						</tr>
						<tr>
							<th>조제첩부파일</th>
							<td>
								<c:if test="${!empty info.c_joje_file}">
									<p class=""><a href="/download.do?path=tang/${info.c_joje_folder}&filename=${info.c_joje_file}&refilename=${info.c_joje_file}">${info.c_joje_file}</a></p>
								</c:if>
							</td>
						<tr>
							<th>복용법</th>
							<td>${fn:replace(info.c_bokyong_contents, newLineChar, "<br/>")}</td>
						<tr>
							<th>복용첨부파일</th>
							<td>
								<c:if test="${!empty info.c_bokyong_file}">
									<p class=""><a href="/download.do?path=tang/${info.c_bokyong_folder}&filename=${info.c_bokyong_file}&refilename=${info.c_bokyong_file}">${info.c_bokyong_file}</a></p>
								</c:if>
							</td>
					</tbody>
				</table>
				
				<!-- btnarea -->
				<!-- <div class="fr mt10 mb20">
					<a href="#"><span class="cg h35">닫기</span></a>
				</div> -->
				<!-- //btnarea -->
			</div>
			
			<script>
				$(document).ready(function() {
					$('#detailBtn').click(function() {
						$('.dictionary_popup').slideDown();
						
						$('#detailBtn').hide();
						$('#detailCloseBtn').show();
						return false;
					});
					
					$('#detailCloseBtn').click(function() {
						$('.dictionary_popup').slideUp();
						$('#detailBtn').show();
						$('#detailCloseBtn').hide();
						return false;
					});
					
					$("#receiptBtn").click(function() {
					 	var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes, resizable=yes,width=420,height=540";     
					 	var url = $(this).attr('href');     
					 	window.open(url,"popupIssue",status); 
						return false;
					});
					
					$('.deleberyBtn').click(function() {
						deliveryInfo( $(this).attr('href'));
						return false;
					});
				});	
			</script>
			
			<!-- btnarea -->
			<div class="btn_area02">
				<a href="#" id="detailCloseBtn" style="display: none;"><span class="cbg h40">처방내역 닫기</span></a>
				<a href="#" id="detailBtn"><span class="cblue h40">처방내역 상세보기</span></a>
				<a href="/m05/03.do?search_date_type=${bean.search_date_type}&s_order_date=${bean.s_order_date}&search_sub_seqno=${bean.search_sub_seqno}&e_order_date=${bean.e_order_date}&search_order_type=${bean.search_order_type}&search_payment&${bean.search_payment}&search_value=${bean.encodeSV}&page=${bean.page}"><span class="cglay h40">목록보기</span></a>
			</div>
			<!-- //btnarea -->

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	