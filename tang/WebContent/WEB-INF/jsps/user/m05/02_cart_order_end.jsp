<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- container -->

<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "마이페이지";
		String sec_nm = "마이페이지";
		String thr_nm = "장바구니";
		int fir_n = 5;
		int sub_n = 2;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	<script>
	$(document).ready(function() {
		$("#copyAccountBtn").click(function() {
			try{
				$('#accountNum').show();
				$('#accountNum').select();	
				document.execCommand("copy"); 
				$('#accountNum').hide();
				
				alert('계좌번호가 복사되었습니다.');
			}catch (e) {
				alert('지원하지 않는 브라우저입니다.');
			}
			return false;
		});
		
		$("#receiptBtn").click(function() {
		 	var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes, resizable=yes,width=420,height=540";     
		 	var url = $(this).attr('href');     
		 	window.open(url,"popupIssue",status); 
			return false;
		});
	});
	</script>
	
	<!-- contents -->
	<div id="contents">
		<!-- 내용 -->
		<div class="conArea">
			
			<div class="cart_endArea">
				<p class="tit">"감사합니다. 주문이 완료되었습니다."</p>

				<!-- 주문완료 카드 -->
				<c:if test="${bean.payment_kind eq 'Card' }">
					<table class="cart_end">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>총 결제금액</th>
								<td><span class="tf02"><fmt:formatNumber value="${bean.result_price}" pattern="#,###원" /></span></td>
							</tr>
							<tr>
								<th>결제카드</th>
								<td>${bean.card_nm} /
									<c:choose>
										<c:when test="${bean.card_quota ne '00' }">할부 ${bean.card_quota}개월</c:when>
										<c:otherwise>일시불</c:otherwise>
									</c:choose> 
									<a href="https://npg.nicepay.co.kr/issue/IssueLoader.do?TID=${bean.tid}&type=0" id="receiptBtn" ><span class="cO h25">영수증 인쇄</span></a>
								</td>
							</tr>
							<tr>
								<th>결제일</th>
								<td>${bean.today}</td>
							</tr>
						</tbody>
					</table>
					<!-- //주문완료 카드 -->
				</c:if>
				
				
				<!-- 주문완료 무통장 -->
				<c:if test="${bean.payment_kind eq 'Bank' }">
					<table class="cart_end">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>총 결제금액</th>
								<td><span class="fc01 b"><fmt:formatNumber value="${bean.result_price}" pattern="#,###원" /></span></td>
							</tr>
							<tr>
								<th>입금계좌</th>
								<td><span >농협은행 302-1184-7609-61</span> (예금주 : 추래흥)<a href="#" id="copyAccountBtn"><span class="cO h25">계좌번호 복사</span></a></td>
							</tr>
							<!--
							<tr>
								<th>입금자명</th>
								<td>박원장</td>
							</tr>
                            -->
						</tbody>
					</table>
					<input type="text" value="농협은행 302-1184-7609-61" id="accountNum" style="display:none; " />
				</c:if>
				<!-- // 주문완료 무통장 -->
			</div>
			<!-- //cartend -->
			<!-- cartview -->
			<table class="cart_list">
				<colgroup>
					<col width="120px" />
					<col width="120px" />
					<col width="140px" />
					<col width="*" />
					<col width="130px" />
					<col width="180px" />
				</colgroup>
				<thead>
					<tr>
						<th>처방일자</th>
						<th>담당한의사</th>
						<th>환자명</th>
						<th>처방명</th>
						<th>합계금액</th>
						<th>배송지</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
					<tr>
						<td>${list.wdate2}</td>
						<td>${list.han_name }</td>
						<td>${list.w_name }</td>
						<td class="L">${list.s_name}</td>
						<td class="R fc01"><fmt:formatNumber value="${list.order_total_price}" pattern="#,###원" /></td>
						<td>
							<c:choose>
								<c:when test="${list.d_type eq 1 }">원외탕전 → 한의원</c:when>
								<c:when test="${list.d_type eq 4 }">원외탕전 → 환자</c:when>
								<c:when test="${list.d_type eq 3 }">한의원 → 환자</c:when>
								<c:when test="${list.d_type eq 6 }">방문수령</c:when>
							</c:choose>
							
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- //cartlist -->
			<!-- btnarea -->
			<div class="btn_area01">
				<a href="/main.do"><span class="cw h60">홈으로 이동</span></a>
				<a href="/m05/03.do"><span class="cg h60">주문내역보기</span></a>
			</div>
			<!-- //btnarea -->

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
	
</div>
<!-- //container -->	