<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% 
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<!-- contents -->
<div class="contents">

	<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>주문내역</span></p>
	<ul class="submenu w50">
		<li><a href="/m05/01.do" class="">회원 정보수정</a></li>
		<li><a href="/m05/03.do" class="sel">주문내역</a></li>
	</ul>

	<!-- 본문내용 -->
	<!-- 결제정보 -->
	<script>
		$(document).ready(function() {
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
	<div class="order_detail_top">
		<p class="titG02 fl">결제정보</p>
		<ul>
			<li>
				결제유형 : ${info.payment_kind_nm} 
				<c:if test="${info.payment eq 'Card' }"><a href="https://npg.nicepay.co.kr/issue/IssueLoader.do?TID=${info.card_gu_no}&type=0" id="receiptBtn"><span class="cBlue h23">영수증</span></a></c:if></li>
			<li>
				결제상태 : 
				<c:if test="${info.pay_ing eq 1 }"><span style="color: blue;font-weight:700;">입금</span></c:if>
				<c:if test="${info.pay_ing eq 2 }">미입금</c:if>
				<c:if test="${info.pay_ing eq 3 }">방문결제</c:if>
				<c:if test="${info.pay_ing eq 4 }">증정</c:if></li>
			<li>
				진행상태 : 
				<c:choose>
					<c:when test="${(info.cancel_ing == 'i' ||  info.cancel_ing == 'y' )&& info.order_ing eq 5}">
					
						<span style="color: red;font-weight: 700;">취소 완료</span>
					</c:when>
					<c:when test="${info.cancel_ing == 'i' ||  info.cancel_ing == 'y'}">
						<span style="color: red;font-weight: 700;">주문취소 요청중</span>
					</c:when>
					<c:otherwise>
						<c:if test="${info.order_ing eq 1 }">주문처리중</c:if>
						<c:if test="${info.order_ing eq 2 }">배송준비</c:if>
						<c:if test="${info.order_ing eq 3 }">배송중</c:if>
						<c:if test="${info.order_ing eq 4 }">배송완료</c:if>
						<c:if test="${info.order_ing eq 5 }">환불/취소</c:if>
						<c:if test="${info.order_ing eq 6 }">예약발송</c:if>
						<c:if test="${info.order_ing eq 7 }">입금대기</c:if> 
						<c:if test="${not empty info.deliveryno  }">
							<c:if test="${info.tak_sel_id eq 'kr.cjlogistics'}">
								<a href="http://nplus.doortodoor.co.kr/web/detail.jsp?slipno=${info.deliveryno}" class="deleberyBtn"><span class="cO h23">조회</span></a>
							</c:if>
							<c:if test="${info.tak_sel_id eq 'kr.lotte'}">
								<a href="http://www.deliverytracking.kr/?dummy=dummy&deliverytype=lotteglogis&keyword=${info.deliveryno}" class="deleberyBtn"><span class="cO h23">조회</span></a>
							</c:if>
						
							<%-- <a href="https://tracker.delivery/#/${info.tak_sel_id}/${info.deliveryno}" class="deleberyBtn"><span class="cO h23">조회</span></a> --%>
						</c:if>
					</c:otherwise>
				</c:choose>
			</li>
			
		</ul>
	</div>
	<!-- 배송정보 -->
	<div class="order_detail02">
		<p class="titG02">배송정보</p>
		<table class="detailVT" style="width:880px;">
			<colgroup>
				<col width="120px" />
				<col width="120px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th rowspan="5" class="th01">보내는 사람<br/>
					<font class="fc07">
						(
						<c:if test="${info.ship_type_from eq 1 }">한의원</c:if>
						<c:if test="${info.ship_type_from eq 2 }">비움환원외탕전</c:if>
						<c:if test="${info.ship_type_from eq 3 }">비움환원외탕전 </c:if>
						<c:if test="${info.ship_type_from eq 4 }">기타</c:if>
						<c:if test="${info.ship_type_from eq 5 }">방문수령</c:if>
						)						
					</font>
					<th>발신인</th>
					<td>${info.o_name}</td>
				</tr>
				<tr>
					<th>연락처1</th>
					<td>${info.o_tel}</td>
				</tr>
				<tr>
					<th>연락처2</th>
					<td>${info.o_handphone}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>(우:${info.o_zipcode}) ${info.o_address}</td>
				</tr>
				<tr>
					<th>주문시 요청사항 </th>
					<td>${info.o_memo2}</td>
				</tr>
			</tbody>
		</table>
		<table class="detailVT" style="margin:20px 0 0 0; width:880px;">
			<colgroup>
				<col width="120px" />
				<col width="120px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th rowspan="6" class="th02">받는 사람<br/>
					<font class="fc07">(
						<c:if test="${info.ship_type_from eq 1 }">고객</c:if>
						<c:if test="${info.ship_type_from eq 2 }">
							${info.r_name}<!-- 한의원 -->
						</c:if>
						<c:if test="${info.ship_type_from eq 3 }">고객 </c:if>
						<c:if test="${info.ship_type_from eq 4 }">기타</c:if>
						<c:if test="${info.ship_type_from eq 5 }">방문수령</c:if>
					)</font>
					<th>수신인</th>
					<td>${info.r_name}</td>
				</tr>
				<tr>
					<th>연락처1</th>
					<td>${info.r_tel}</td>
				</tr>
				<tr>
					<th>연락처2</th>
					<td>${info.r_handphone}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>(우:${info.r_zipcode}) ${info.r_address}</td>
				</tr>
				<tr>
					<th>배송메모</th>
					<td>${fn:replace(info.o_memo, crcn, br)}</td>
				</tr>
				<tr>
					<th>택배정보</th>
					<td>
						<c:if test="${not empty info.deliveryno  }">
							발송일 : ${info.delivery_date } / 
							<font class="b">송장번호 : ${info.deliveryno} (${info.tak_sel_nm}) </font>
							<c:if test="${info.tak_sel_id eq 'kr.cjlogistics'}">
								<a href="http://nplus.doortodoor.co.kr/web/detail.jsp?slipno=${info.deliveryno}" class="deleberyBtn"><span class="cO h23">조회</span></a>
							</c:if>
							<c:if test="${info.tak_sel_id eq 'kr.lotte'}">
								<a href="http://www.deliverytracking.kr/?dummy=dummy&deliverytype=lotteglogis&keyword=${info.deliveryno}" class="deleberyBtn"><span class="cO h23">조회</span></a>
							</c:if>
							
							<%-- <a href="https://tracker.delivery/#/${info.tak_sel_id}/${info.deliveryno}" class="deleberyBtn"><span class="cO h23">조회</span></a> --%>
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
		
	</div>
	<!-- //배송정보 -->
	<!-- orderview -->
	<table class="order_view">
		<colgroup>
			<col width="*" />
			<col width="130px" />
			<col width="90px" />
			<col width="150px" />
		</colgroup>
		<thead>
			<tr>
				<th>상품정보</th>
				<th>상품단가</th>
				<th>수량</th>
				<th>합계</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${p_list}">
				<tr>
					<td class="L">
						<p class="img"><img src="/upload/goods/${list.good_image}" style="width: 60px;height: 60px;"  class="am" alt="${list.goods_name }" /></p>
						<div class="name">
							${list.goods_name}
							<c:if test="${list.sale_type eq 2 }"> <span style="color:#fb665f;">(가맹점)</span></c:if>
							<c:if test="${list.box_option_seqno ne 0 && list.box_option_seqno ne null }">
								<p class="opttxt">
									- 옵션 : ${list.box_option_nm }(+<fmt:formatNumber value="${list.box_option_price}" pattern="#,###" />)
								</p>
							</c:if>
						</div>
					</td>
					<td class="R"><strong><fmt:formatNumber value="${list.goods_price}" pattern="#,###" /></strong>원</td>
					<td><fmt:formatNumber value="${list.ea}" pattern="#,###" /></td>
					<td class="R"><strong><fmt:formatNumber value="${list.price}" pattern="#,###" /></strong>원</td>
				</tr>
			</c:forEach>
			
		</tbody>
	</table>
	<!-- // orderview -->
	<!-- total -->			
	<div class="totalArea">
		<table class="totalT">
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>처방비용 합계</th>
					<td>
						<span class="price"><fmt:formatNumber value="${info.tot_price}" pattern="#,###" /></span>원
					</td>
				</tr>
				<tr>
					<th>배송료(+)</th>
					<td>
						<span class="price"><fmt:formatNumber value="${info.delivery_price}" pattern="#,###" /></span>원
					</td>
				</tr>
				<tr>
					<th>할인금액(-)</th>
					<td>
						<span class="price"><fmt:formatNumber value="${info.tot_sale_price}" pattern="#,###" /></span>원
					</td>
				</tr>
				<tr>
					<th>총 결제금액</th>
					<td>
						<span class="price fc04"><fmt:formatNumber value="${info.all_price - info.tot_sale_price}" pattern="#,###" /></span>원
					</td>
				</tr>
			</tbody>
		</table>
	</div>
			
	<!-- //total -->
	<!-- btnarea -->
	<div class="btn_area02">
		<a href="/m05/03.do?search_date_type=${bean.search_date_type}&s_order_date=${bean.s_order_date}&e_order_date=${bean.e_order_date}&search_order_type=${bean.search_order_type}&search_payment&${bean.search_payment}&search_value=${bean.encodeSV}&page=${bean.page}"><span class="cB h40">목록보기</span></a>
	</div>
	<!-- //btnarea -->
	<!-- //본문내용 -->

</div>
<!-- // contents -->

		