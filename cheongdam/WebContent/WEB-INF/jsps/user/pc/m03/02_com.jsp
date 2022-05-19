<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="contents">

		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>약속처방</span><span>약속처방 보관함</span></p>
		</div>

		<ul class="sub_Menu w33">
			<li ><a href="01.do">약속처방</a></li>
			<li class="sel"><a href="02.do">약속처방 보관함</a></li>
			<li><a href="03.do">사전조제지시서 현황</a></li>
		</ul>
		
		<!-- 본문내용 -->
		<div class="order_end">
			<p>"감사합니다. 주문이 완료되었습니다."</p>
			<table class="order_view mb30">
				<colgroup>
					<col width="150px" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>총 결제금액</th>
						<td class="b fc04">1,776,000원</td>
					</tr>
					<tr>
						<th>입금계좌</th>
						<td>기업은행 122345698446 (예금주 : 청담원외탕전) <a href="#"><span class="cO h25">계좌번호 복사</span></a></td>
					</tr>
					<tr>
						<th>입금자명</th>
						<td>박원장</td>
					</tr>
					<tr>
						<th>입금기한</th>
						<td>2019-06-21</td>
					</tr>
					<tr>
						<th>적립금</th>
						<td>우수회원<span class="ptxt">(구매금액의 3%, 150원 적립예정 - 배송완료 7일 후 적립됩니다.)</span></td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- orderview -->
		<p class="pb10"><strong>처방일자 :</strong> 2019-12-26  /  <strong>담당한의사 :</strong> 대박한의원</p>
		<table class="order_view mb30">
			<colgroup>
				<col width="*" />
				<col width="150px" />
			</colgroup>
			<thead>
				<tr>
					<th>상품정보</th>
					<th>합계</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="L">
						<p class="img"><img src="/assets/user/pc/images/sub/sam01.png" class="am" alt="" /></p>
						<div class="name">(특가)경옥고스틱, 6박스</div>
					</td>
					<td class="R fc04"><strong>55,000</strong>원</td>
				</tr>
				<tr>
					<td class="L">
						<p class="img"><img src="/assets/user/pc/images/sub/sam01.png" class="am" alt="" /></p>
						<div class="name">(특가)경옥고스틱, 6박스
							<p class="opttxt">
								- 옵션 : 경옥고 150g 1개<br/>- 추가주문 : 소포장 50g 2개(+50,000)
							</p>
						</div>
					</td>
					<td class="R fc04"><strong>1,480,000</strong>원</td>
				</tr>
				<tr>
					<td class="L">
						<p class="img"><img src="/assets/user/pc/images/sub/sam01.png" class="am" alt="" /></p>
						<div class="name">(특가)경옥고스틱, 6박스</div>
					</td>
					<td class="R fc04"><strong>250,000</strong>원</td>
				</tr>
			</tbody>
		</table>
		<!-- // orderview -->
		
		<!-- btnarea -->
		<div class="btn_area01">
			<a href="#.html"><span class="cw h60">홈으로 이동</span></a>
			<a href="/04/02.do"><span class="cg h60">주문내역 보기</span></a>
		</div>
		<!-- //btnarea -->
		<!-- //본문내용 -->
	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		