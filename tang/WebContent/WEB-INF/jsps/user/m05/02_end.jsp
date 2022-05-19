<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
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
	
	<!-- contents -->
	<div id="contents">
		<!-- 내용 -->
		<div class="conArea">
			
			<div class="cart_endArea">
				<p class="tit">"감사합니다. 주문이 완료되었습니다."</p>

				<!-- 주문완료 카드 -->
				<table class="cart_end">
					<colgroup>
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>총 결제금액</th>
							<td><span class="tf02">353,882원</span></td>
						</tr>
						<tr>
							<th>결제카드</th>
							<td>국민 / 일시불
								<a href="#"><span class="cO h25">영수증 인쇄</span></a>
							</td>
						</tr>
						<tr>
							<th>결제일</th>
							<td>2019-06-21</td>
						</tr>
					</tbody>
				</table>
				<!-- //주문완료 카드 -->

				<!-- 주문완료 무통장 -->
				<table class="cart_end">
					<colgroup>
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>총 결제금액</th>
							<td><span class="fc01 b">353,882원</span></td>
						</tr>
						<tr>
							<th>입금계좌</th>
							<td>기업은행 122345698446 (예금주 : 북경한의원 원외탕전실)<a href="#"><span class="cO h25">계좌번호 복사</span></a></td>
						</tr>
						<tr>
							<th>입금자명</th>
							<td>박원장</td>
						</tr>
						<tr>
							<th>입금기한</th>
							<td>2019-06-21</td>
						</tr>
					</tbody>
				</table>
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
					<tr>
						<td>2019-10-31</td>
						<td>홍길동</td>
						<td>대박한의원</td>
						<td>자운고 20gx2</td>
						<td class="R fc01">50,400원</td>
						<td>탕전실 → 한의원</td>
					</tr>
					<tr>
						<td>2019-10-31</td>
						<td>홍길동</td>
						<td>대박한의원</td>
						<td>경옥고스틱, 6박스</td>
						<td class="R fc01">810,400원</td>
						<td>한의원 → 환자</td>
					</tr>
					<tr>
						<td>2019-10-31</td>
						<td>홍길동</td>
						<td>대박한의원</td>
						<td>가감보심탕</td>
						<td class="R fc01">14,400원</td>
						<td>탕전실 → 한의원</td>
					</tr>
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