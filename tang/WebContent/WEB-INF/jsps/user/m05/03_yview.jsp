<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- container -->
<% 
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>

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
		<!-- 내용 -->
		<div class="conArea">

			<div class="topinfo">
				<div>
					<p>결제정보</p>
					<ul>
						<li>
							<span class="tit">결제유형</span>
							${info.payment_kind_nm}
							<c:if test="${info.payment eq 'Card' }">
								<a href="https://npg.nicepay.co.kr/issue/IssueLoader.do?TID=${info.card_gu_no}&type=0" id="receiptBtn"  class="ml10"><span class="cO h20">영수증</span></a>
							</c:if>
						</li>
						<li>
							<span class="tit">결제상태</span>
							<c:if test="${info.pay_ing eq 1 }">입금</c:if>
							<c:if test="${info.pay_ing eq 2 }">미입금</c:if>
							<c:if test="${info.pay_ing eq 3 }">방문결제</c:if>
							<c:if test="${info.pay_ing eq 4 }">증정</c:if>
						</li>
						<li>
							<span class="tit">진행상태</span>
							<c:if test="${info.order_ing eq 1 }">주문처리중</c:if>
							<c:if test="${info.order_ing eq 2 }">배송준비</c:if>
							<c:if test="${info.order_ing eq 3 }">배송중</c:if>
							<c:if test="${info.order_ing eq 4 }">배송완료</c:if>
							<c:if test="${info.order_ing eq 5 }">환불/취소</c:if>
							<c:if test="${info.order_ing eq 6 }">예약발송</c:if>
							<c:if test="${info.order_ing eq 7 }">입금대기</c:if>
						</li>
					</ul>
				</div>
			</div>
			
			<div class="topinfo">
				<div>
					<p>
						보내는 사람
						<span class="fc01 b">
							<c:if test="${info.ship_type_from eq 1 }">(탕전실)</c:if>
							<c:if test="${info.ship_type_from eq 2 }">(한의원)</c:if>
							<c:if test="${info.ship_type_from eq 3}">(새로입력)</c:if>
						</span>
					</p>
					<ul>
						<li><span class="tit">발신인</span>${info.o_name}</li>
						<li><span class="tit">연락처</span>${info.o_tel}</li>
						<li><span class="tit">휴대전화</span>${info.o_handphone}</li>
						<li><span class="tit">주소</span>
							${info.o_zipcode}<br/>${info.o_address}
						</li>
					</ul>
				</div>
				<div class="ml60">
					<p>
						받는 사람
						<span class="fc01 b">
							<c:if test="${info.ship_type_to eq 1 }">(탕전실)</c:if>
							<c:if test="${info.ship_type_to eq 2 }">(한의원)</c:if>
							<c:if test="${info.ship_type_to eq 3}">(새로입력)</c:if>
						</span>
					</p>
					<ul>
						<li><span class="tit">수신인</span>${info.r_name}</li>
						<li><span class="tit">연락처</span>${info.r_tel}</li>
						<li><span class="tit">휴대전화</span>${info.r_handphone}</li>
						<li><span class="tit">주소</span>${info.r_zipcode}<br/>${info.r_address}</li>
						<li><span class="tit">배송메모</span>${fn:replace(info.o_memo, crcn, br)}</li>
						<li><span class="tit">택배정보</span>
							<c:if test="${not empty info.deliveryno  }">
								발송일 : ${info.delivery_date }<br/>
								<strong>
									송장번호 : ${info.deliveryno} 
									(${info.tak_sel_nm})
								</strong>
								<a href="https://tracker.delivery/#/${info.tak_sel_id}/${info.deliveryno}" class="deleberyBtn ml10"><span class="cO h20">배송조회</span></a>
							</c:if>
							
						</li>
					</ul>
				</div>
			</div>
			<!-- orderview -->
			<table class="order_view">
				<colgroup>
					<col width="*" />
					<col width="160px" />
					<col width="130px" />
					<col width="130px" />
				</colgroup>
				<thead>
					<tr>
						<th>상품정보</th>
						<th>상품금액</th>
						<th>수량</th>
						<th>총금액</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${p_list}">
						<tr>
							<td class="L"><img src="/upload/goods/${list.good_image}" style="width: 60px;height: 60px;"  class="am" alt="${list.goods_name }" />${list.goods_name}</td>
							
							<c:choose>
								<c:when test="${userInfo.mem_sub_grade eq 2}">
									<td class="R"><strong>***,***</strong></td>
									<td class="R"><strong><fmt:formatNumber value="${list.ea}" pattern="#,###" /></strong></td>
									<td class="R"><strong>***,***</strong></td>
								</c:when>
								<c:otherwise>										
									<td class="R"><strong><fmt:formatNumber value="${list.goods_price}" pattern="#,###" /></strong>원</td>
									<td class="R"><strong><fmt:formatNumber value="${list.ea}" pattern="#,###" /></strong></td>
									<td class="R"><strong><fmt:formatNumber value="${list.price}" pattern="#,###" /></strong>원</td>	
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- // orderview -->
			<div class="totalBox" style="margin-top:-1px;">
				<ul>
					<li class="tit">결제안내<span class="fc01">(${info.payment_kind_nm}입금)</span></li>
					<c:choose>
						<c:when test="${userInfo.mem_sub_grade eq 2}">
							<li class="Bt01">처방금액<span class="won">***,***</span></li>
							<li class="Bt02">배송비<span class="won">***,***</span></li>
							<li class="total">합계<span class="won">***,***</span></li>
						</c:when>
						<c:otherwise>										
							<li class="Bt01">처방금액<span class="won"><fmt:formatNumber value="${info.tot_price}" pattern="#,###" />원</span></li>
							<li class="Bt02">배송비<span class="won"><fmt:formatNumber value="${info.delivery_price}" pattern="#,###" />원</span></li>
							<li class="total">합계<span class="won"><fmt:formatNumber value="${info.all_price}" pattern="#,###" /></span>원</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
			<!-- btnarea -->
			<div class="btn_area02">
				<a href="/m05/03.do?search_date_type=${bean.search_date_type}&s_order_date=${bean.s_order_date}&search_sub_seqno=${bean.search_sub_seqno}&e_order_date=${bean.e_order_date}&search_order_type=${bean.search_order_type}&search_payment&${bean.search_payment}&search_value=${bean.encodeSV}&page=${bean.page}"><span class="cglay h40">목록보기</span></a>
			</div>
			<!-- //btnarea -->

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	