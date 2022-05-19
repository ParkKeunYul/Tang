<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% 
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="contents">

		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>마이페이지</span><span>주문내역</span></p>
		</div>

		<ul class="sub_Menu w20">
			<li ><a href="01.do">내 정보수정</a></li>
			<!-- <li><a href="02.do">장바구니</a></li> -->
			<li class="sel"><a href="03.do">주문내역</a></li>
			<!-- <li><a href="07.do">나의 처방관리</a></li> -->
			<li><a href="05.do">환자관리</a></li>
			<li><a href="04.do">탕전공동사용계약서</a></li>
			<li><a href="99.do">포인트 사용내역</a></li>
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
			<p class="tit"><img src="/assets/user/pc/images/sub/tit03.png" alt="배송정보" /></p>
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
							</c:if>
						</c:otherwise>
					</c:choose>
				</li>
					
			</ul>
		</div>
		<!-- 배송정보 -->
		<div class="order_detail mb30">
			<p class="tit"><img src="/assets/user/pc/images/sub/tit02.png" alt="배송정보" /></p>
			<div class="bline">
				<em class="bgy mt40">
					보내는 사람<br/>
					<font class="fc07">
						(
						<c:if test="${info.ship_type_from eq 1 }">한의원</c:if>
						<c:if test="${info.ship_type_from eq 2 }">청담원외탕전</c:if>
						<c:if test="${info.ship_type_from eq 3 }">청담원외탕전 </c:if>
						<c:if test="${info.ship_type_from eq 4 }">기타</c:if>
						<c:if test="${info.ship_type_from eq 5 }">방문수령</c:if>
						)						
					</font>
				</em>
				<table class="detailVT" style="width:730px;">
					<colgroup>
						<col width="80px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>발신인</th>
							<td>${info.o_name}</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>${info.o_tel}</td>
						</tr>
						<tr>
							<th>휴대전화</th>
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
			</div>
			<div class="clfix pt20 pl10">
				<em class="bgb mt70">
					받는 사람<br/>
					<font class="fc07">(
						<c:if test="${info.ship_type_from eq 1 }">고객</c:if>
						<c:if test="${info.ship_type_from eq 2 }">한의원</c:if>
						<c:if test="${info.ship_type_from eq 3 }">고객 </c:if>
						<c:if test="${info.ship_type_from eq 4 }">기타</c:if>
						<c:if test="${info.ship_type_from eq 5 }">방문수령</c:if>
					)</font>
				</em>
				<table class="detailVT" style="width:730px;">
					<colgroup>
						<col width="80px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>수신인</th>
							<td>${info.r_name}</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>${info.r_tel}</td>
						</tr>
						<tr>
							<th>휴대전화</th>
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
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
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
							<div class="name">${list.goods_name}
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
						<th>포인트결제</th>
						<td>
							<span class="price"><fmt:formatNumber value="${info.use_point}" pattern="#,###" /></span>원
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
			<a href="/m05/03.do?search_date_type=${bean.search_date_type}&s_order_date=${bean.s_order_date}&e_order_date=${bean.e_order_date}&search_order_type=${bean.search_order_type}&search_payment&${bean.search_payment}&search_value=${bean.encodeSV}&page=${bean.page}"><span class="cglay h40">목록보기</span></a>
		</div>
		<!-- //btnarea -->
		<!-- //본문내용 -->

	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		