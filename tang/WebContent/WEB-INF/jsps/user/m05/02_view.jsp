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
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit">장바구니</p>
			<p>주문하고자 하는 처방명을 클릭 후 <strong>배송정보 및 미기입 사항을 입력하셔야만 선택버튼이 활성화 되어 주문</strong> 할 수 있습니다.<br/><strong>복수 선택을 하여 한번에 주문</strong> 할 수도 있습니다.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">

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
				<tfoot>
					<tr>
						<td colspan="6" class="totalBoxfoot">
							<ul class="fr">
								<li class="Bt01">처방금액<span class="won">150,000원</span></li>
								<li class="Bt02">배송비<span class="won">50,000원</span></li>
								<li class="total">합계<span class="won">150,000</span>원</li>
							</ul>
						</td>
					</tr>
				</tfoot>
			</table>
			<!-- //cartlist -->

			<div class="totalend">
				<ul>
					<li class="tit">결제수단</li>
					<li>
						<a href="#"><span class="cBB h30">신용카드</span></a>
						<a href="#"><span class="cBB h30">무통장 입금</span></a>
					</li>
					<li>
						<label for=""><input type="radio" />세금계산서</label>
						<label for=""><input type="radio" />현금영수증</label>
						<label for=""><input type="radio" />미신청</label>
					</li>
				</ul>
			</div>
			<!-- btnarea -->
			<div class="btn_area01">
				<a href="#"><span class="cw h60">취소</span></a>
				<a href="02_end.do"><span class="cg h60">주문하기</span></a>
			</div>
			<!-- //btnarea -->

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
	
</div>
<!-- //container -->	