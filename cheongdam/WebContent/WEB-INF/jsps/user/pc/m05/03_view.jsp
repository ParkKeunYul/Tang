<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

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
			<li><a href="02.do">장바구니</a></li>
			<li class="sel"><a href="02.do">주문내역</a></li>
			<li><a href="04.do">탕전공동사용계약서</a></li>
			<li><a href="99.do">포인트 사용내역</a></li>
		</ul>

		<!-- 본문내용 -->
		<!-- 결제정보 -->
		<div class="order_detail_top">
			<p class="tit"><img src="/assets/user/pc/images/sub/tit03.png" alt="배송정보" /></p>
			<ul>
				<li>결제유형 : 카드 <a href="#"><span class="cBlue h23">영수증</span></a></li>
				<li>결제상태 : 결제완료</li>
				<li>진행상태 : 배송중 <a href="#"><span class="cO h23">조회</span></a></li>
			</ul>
		</div>
		<!-- 배송정보 -->
		<div class="order_detail mb30">
			<p class="tit"><img src="/assets/user/pc/images/sub/tit02.png" alt="배송정보" /></p>
			<div class="bline">
				<em class="bgy mt40">보내는 사람<br/><font class="fc07">(청담원외탕전)</font></em>
				<table class="detailVT" style="width:730px;">
					<colgroup>
						<col width="80px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>발신인</th>
							<td>청담원외탕전</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>054-123-4567</td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td>010-1234-5678</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>(우:12345) 경상북도 포항시 북구 장성동 1417-10</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="clfix pt20 pl10">
				<em class="bgb mt70">받는 사람<br/><font class="fc07">(한의원)</font></em>
				<table class="detailVT" style="width:730px;">
					<colgroup>
						<col width="80px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>수신인</th>
							<td>청담원외탕전</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>054-123-4567</td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td>010-1234-5678</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>(우:12345) 경상북도 포항시 북구 장성동 1417-10</td>
						</tr>
						<tr>
							<th>배송메모</th>
							<td>경기실 보관</td>
						</tr>
						<tr>
							<th>택배정보</th>
							<td>발송일 : 2019-09-23 23:26:13 / 
								<font class="b">송장번호 : 387168738276(CJ대한통운) </font><a href="#"><span class="cO h23">조회</span></a>
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
				<tr>
					<td class="L">
						<p class="img"><img src="/assets/user/pc/images/sub/sam01.png" class="am" alt="" /></p>
						<div class="name">(특가)경옥고스틱, 6박스</div>
					</td>
					<td class="R"><strong>50,000</strong>원</td>
					<td>1</td>
					<td class="R"><strong>55,000</strong>원</td>
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
					<td class="R"><strong>130,000</strong>원</td>
					<td>11</td>
					<td class="R"><strong>1,480,000</strong>원</td>
				</tr>
				<tr>
					<td class="L">
						<p class="img"><img src="/assets/user/pc/images/sub/sam01.png" class="am" alt="" /></p>
						<div class="name">(특가)경옥고스틱, 6박스</div>
					</td>
					<td class="R"><strong>250,000</strong>원</td>
					<td>1</td>
					<td class="R"><strong>250,000</strong>원</td>
				</tr>
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
							<span class="price">1,780,000</span>원
						</td>
					</tr>
					<tr>
						<th>배송료(+)</th>
						<td>
							<span class="price">4,000</span>원
						</td>
					</tr>
					<tr>
						<th>할인금액(-)</th>
						<td>
							<span class="price">0</span>원
						</td>
					</tr>
					<tr>
						<th>총 결제금액</th>
						<td>
							<span class="price fc04">1,776,000</span>원
						</td>
					</tr>
				</tbody>
			</table>
		</div>
				
		<!-- //total -->
		<!-- btnarea -->
		<div class="btn_area02">
			<a href="order_list.html"><span class="cglay h40">목록보기</span></a>
		</div>
		<!-- //btnarea -->
		<!-- //본문내용 -->

	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		