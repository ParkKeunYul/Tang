<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% 
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>
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
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">주문내역</p>
		<div class="lnbDepth lnbDepth4">
			<ul>
				<li><a href="01.do">내 정보수정</a></li>
				<li class="sel"><a href="03.do">주문내역</a></li>
				<li ><a href="04.do" style="letter-spacing: -3px;">탕전공동사용계약서</a></li>
				<li ><a href="99.do" style="letter-spacing: -3px;">포인트사용내역</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<div class="contents" id="contents">			
		<!-- view -->
		<div class="orderview">
			<!-- 결제수단 -->
			<div class="Listbox">
				<p class="tit01">결제수단</p>
				<ul>
					<li>
						<label class="title">결제유형</label>
						<p>
							${info.payment_kind_nm} 
							<c:if test="${info.payment eq 'Card' }"><a class="btnTypeBasic sizeXS colorBlueGray" href="https://npg.nicepay.co.kr/issue/IssueLoader.do?TID=${info.card_gu_no}&type=0" id="receiptBtn"><span>영수증</span></a></c:if>
						</p>
					</li>
					<li>
						<label class="title">결제상태</label>
						<p>
							<c:if test="${info.pay_ing eq 1 }"><span style="color: blue;font-weight:700;">입금</span></c:if>
							<c:if test="${info.pay_ing eq 2 }">미입금</c:if>
							<c:if test="${info.pay_ing eq 3 }">방문결제</c:if>
							<c:if test="${info.pay_ing eq 4 }">증정</c:if>
						</p>
					</li>
					<li>
						<label class="title">진행상태</label>
						<p>
							<c:choose>
								<c:when test="${ (info.cancel_ing == 'i' ||  info.cancel_ing == 'y') && info.order_ing ne 5}">
									주문취소 요청중
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
									<%-- 
										<a href="https://tracker.delivery/#/${info.tak_sel_id}/${info.deliveryno}" class="" class=""><span >조회</span></a>
									 --%>
										<c:if test="${info.tak_sel_id eq 'kr.cjlogistics'}">
											<a href="http://nplus.doortodoor.co.kr/web/detail.jsp?slipno=${info.deliveryno}" class="btnTypeBasic sizeXS colorOrange deleberyBtn"><span class="">조회</span></a>
										</c:if>
										<c:if test="${info.tak_sel_id eq 'kr.lotte'}">
											<a href="http://www.deliverytracking.kr/?dummy=dummy&deliverytype=lotteglogis&keyword=${info.deliveryno}" class="btnTypeBasic sizeXS colorOrange deleberyBtn"><span class="">조회</span></a>
										</c:if>	
										
									</c:if>
								</c:otherwise>
							</c:choose>							
						</p>
					</li>
				</ul>
			</div>
			<!-- //결제수단 -->
			<!-- 보내는 사람 -->
			<div class="Listbox">
				<p class="tit02">보내는 사람</p>
				<ul>
					<li>
						<label class="title">발신인</label>
						<p>
							${info.o_name}
							(
							<c:if test="${info.ship_type_from eq 1 }">한의원</c:if>
							<c:if test="${info.ship_type_from eq 2 }">청담원외탕전</c:if>
							<c:if test="${info.ship_type_from eq 3 }">청담원외탕전 </c:if>
							<c:if test="${info.ship_type_from eq 4 }">기타</c:if>
							<c:if test="${info.ship_type_from eq 5 }">방문수령</c:if>
							)
						</p>
					</li>
					<li>
						<label class="title">연락처</label>
						<p>${info.o_tel}</p>
					</li>
					<li>
						<label class="title">휴대전화</label>
						<p>${info.o_handphone}</p>
					</li>
					<li>
						<label class="title">주소</label>
						<p>(우:${info.o_zipcode}) ${info.o_address}</p>
					</li>
				</ul>
			</div>
			<!-- //보내는 사람 -->
			<!-- 받는 사람 -->
			<div class="Listbox">
				<p class="tit03">받는 사람</p>
				<ul>
					<li>
						<label class="title">수신인</label>
						<p>
							${info.r_name}
							(
								<c:if test="${info.ship_type_from eq 1 }">고객</c:if>
								<c:if test="${info.ship_type_from eq 2 }">한의원</c:if>
								<c:if test="${info.ship_type_from eq 3 }">고객 </c:if>
								<c:if test="${info.ship_type_from eq 4 }">기타</c:if>
								<c:if test="${info.ship_type_from eq 5 }">방문수령</c:if>
							)
						</p>
					</li>
					<li>
						<label class="title">연락처</label>
						<p>${info.r_tel}</p>
					</li>
					<li>
						<label class="title">휴대전화</label>
						<p>${info.r_handphone}</p>
					</li>
					<li>
						<label class="title">주소</label>
						<p>(우:${info.r_zipcode}) ${info.r_address}</p>
					</li>
					<li>
						<label class="title">배송메모</label>
						<p>&nbsp; ${fn:replace(info.o_memo, crcn, br)}</p>
					</li>
					<c:if test="${not empty info.deliveryno  }">
					<li>
						<label class="title">택배정보</label>
						<p>
							발송일 : ${info.delivery_date }<br/>
							<strong>송장번호 : ${info.deliveryno}(${info.tak_sel_nm})</strong>
							<c:if test="${info.tak_sel_id eq 'kr.cjlogistics'}">
								<a href="http://nplus.doortodoor.co.kr/web/detail.jsp?slipno=${info.deliveryno}" class="btnTypeBasic sizeXS colorOrange deleberyBtn"><span class="">조회</span></a>
							</c:if>
							<c:if test="${info.tak_sel_id eq 'kr.lotte'}">
								<a href="http://www.deliverytracking.kr/?dummy=dummy&deliverytype=lotteglogis&keyword=${info.deliveryno}" class="btnTypeBasic sizeXS colorOrange deleberyBtn"><span class="">조회</span></a>
							</c:if>
						</p>
					</li>
					</c:if>
				</ul>
			</div>
			<!-- //받는 사람 -->
			
			<!-- 결제 제품정보 -->
			<div class="orderDetail mt30">
				<c:forEach var="list" items="${p_list}">				
					<!-- 02 -->
					<div class="detailList">
						<div class="Dtit">
							<img src="/upload/goods/${list.good_image}" alt="${list.goods_name }" width="50px" height="50px" /> <p>${list.goods_name }</p>
						</div>
						<c:if test="${list.box_option_seqno ne 0 && list.box_option_seqno ne null }">
							<ul class="op">
								<li>- 옵션 : ${list.box_option_nm }(+<fmt:formatNumber value="${list.box_option_price}" pattern="#,###" />)</li>
							</ul>
						</c:if>
						<ul class="info">
							<li>
								<label class="title">상품단가</label>
								<p><strong><fmt:formatNumber value="${list.goods_price}" pattern="#,###" /></strong>원</p>
							</li>
							<li>
								<label class="title">구매수량</label>
								<p><strong><fmt:formatNumber value="${list.ea}" pattern="#,###" /></strong></p>
							</li>
							<li>
								<label class="title">주문금액</label>
								<p><strong><strong><fmt:formatNumber value="${list.price}" pattern="#,###" /></strong></strong>원</p>
							</li>
						</ul>
					</div>
				</c:forEach>
			</div>
			<!-- //결제 제품정보 -->
			<!-- 결제 정보 -->
			<div class="orderTotal">
				<ul class="tlist">
					<li>
						<label class="title">처방비용 합계</label>
						<p><strong><fmt:formatNumber value="${info.tot_price}" pattern="#,###" /></strong>원</p>
					</li>
					<li>
						<label class="title">배송료(+)</label>
						<p><strong>+ <fmt:formatNumber value="${info.delivery_price}" pattern="#,###" /></strong>원</p>
					</li>
					<li>
						<label class="title">할인금액(-)</label>
						<p><strong>-<fmt:formatNumber value="${info.tot_sale_price}" pattern="#,###" /></strong>원</p>
					</li>
					<li>
						<label class="title">포인트결제</label>
						<p><strong><fmt:formatNumber value="${info.use_point}" pattern="#,###" /></strong>원</p>
					</li>
				</ul>
			</div>
			<ul class="totalarea">
				<li>
					<label class="title">총 결제금액</label>
					<p><strong><fmt:formatNumber value="${info.all_price - info.tot_sale_price}" pattern="#,###" /></strong>원</p>
				</li>
			</ul>
		</div>			
		<!-- //view -->
		<div class="btnArea">
			<a href="/m/m05/03.do?search_date_type=${bean.search_date_type}&s_order_date=${bean.s_order_date}&e_order_date=${bean.e_order_date}&search_order_type=${bean.search_order_type}&search_payment&${bean.search_payment}&search_value=${bean.encodeSV}&page=${bean.page}" class="btnTypeSearch colorGray mt20"><span>목록보기</span></a>
		</div>
	</div>
	<!-- //본문 -->

</div>
<!-- //container -->
		