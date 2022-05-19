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
		<!-- orderview -->
		<table class="order_view mb30">
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
		
		<!-- 배송정보 -->
		<div class="order_detail">
			<p class="tit"><img src="/assets/user/pc/images/sub/tit02.png" alt="배송정보" /></p>
			<div class="bline">
				<em>배송지 선택</em>
				<label><input type="radio" /> 한의원 - 고객</label>
				<label><input type="radio" /> 청담원외탕전 - 한의원</label>
				<label><input type="radio" /> 청담원외탕전 - 고객</label>
				<label><input type="radio" /> 기타</label>
				<label><input type="radio" /> 방문수령</label>
			</div>
			<div class="bline">
				<em class="bgy mt50">보내는 사람</em>
				<table class="detailT" style="width:730px;">
					<colgroup>
						<col width="80px" />
						<col width="*" />
						<col width="80px" />
						<col width="230px" />
					</colgroup>
					<tbody>
						<tr>
							<th>발신인</th>
							<td colspan="3"><input type="text" name="" id="" style="width:220px;"></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>
								<input type="text" id="" name="phone01" style="width:65px;" maxlength="4"> -
								<input type="text" id="" name="phone02" style="width:65px;" maxlength="4"> -
								<input type="text" id="" name="phone03" style="width:65px;" maxlength="4">
							</td>
							<th>휴대전화</th>
							<td>
								<input type="text" id="" name="handphone01" style="width:65px;" maxlength="4"> -
								<input type="text" id="" name="handphone02" style="width:65px;" maxlength="4"> -
								<input type="text" id="" name="handphone03" style="width:65px;" maxlength="4">
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">
								<input type="text" name="zipcode01" id="zip_cd" style="width:150px;" readonly>
								<a href="#"><span id="addrBtn1" class="h30 cB">주소찾기</span></a><br/>
								<input type="text" name="address01" style="width:350px;" readonly id="addr1">
								<input type="text" name="address02" placeholder="상세주소" style="width:270px; margin:0px 0 0 10px;" id="addr2"> 
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="clfix pt20 pl10">
				<em class="bgb mt110">받는 사람</em>
				<table class="detailT" style="width:730px;">
					<colgroup>
						<col width="80px" />
						<col width="*" />
						<col width="80px" />
						<col width="230px" />
					</colgroup>
					<tbody>
						<tr>
							<th>수신인</th>
							<td colspan="3"><input type="text" name="" id="" style="width:220px;"></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>
								<input type="text" id="" name="phone01" style="width:65px;" maxlength="4"> -
								<input type="text" id="" name="phone02" style="width:65px;" maxlength="4"> -
								<input type="text" id="" name="phone03" style="width:65px;" maxlength="4">
							</td>
							<th>휴대전화</th>
							<td>
								<input type="text" id="" name="handphone01" style="width:65px;" maxlength="4"> -
								<input type="text" id="" name="handphone02" style="width:65px;" maxlength="4"> -
								<input type="text" id="" name="handphone03" style="width:65px;" maxlength="4">
							</td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">
								<input type="text" name="zipcode01" id="zip_cd" style="width:150px;" readonly>
								<a href="#"><span id="addrBtn1" class="h30 cB">주소찾기</span></a>
								<a href="#" onclick="window.open('before_del.html','window팝업','width=850, height=520, menubar=no, status=no, toolbar=no');"><span id="addrBtn1" class="h30 cg">최근배송정보</span></a>
								<br/>
								<input type="text" name="address01" style="width:350px; margin-top:10px;" readonly id="addr1">
								<input type="text" name="address02" placeholder="상세주소" style="width:270px; margin:10px 0 0 10px;" id="addr2"> 
							</td>
						</tr>
						<tr>
							<th>배송메모</th>
							<td colspan="3" class="pt10">
								<textarea name="" id="" style="width:630px; height:40px;resize:none;"></textarea>
							</td>
						</tr>
						<tr>
							<th>주문시<br/>요청사항</th>
							<td colspan="3" class="pt10">
								<textarea name="" id="" style="width:630px; height:40px;resize:none;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- //배송정보 -->

		<!-- 결제정보 -->
		<div class="order_detail">
			<p class="tit"><img src="/assets/user/pc/images/sub/tit03.png" alt="결제정보" /></p>
			<div class="bline">
				<table class="detailT" style="width:100%;">
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
							<th>적립금(-)</th>
							<td>
								<span class="price">0</span>원
								(보유 : 2,000원) <a href="#" class="point_check"></a>
								<p class="pointArea">
									<input type="text" name="" id="" style="width:60px;"> 원
									<input type="checkbox" class="ml20"/> 전액사용
									<a href="#" class="point_ok"></a>
								</p>
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
			
			<div class="clfix pt20 pl10">
				<table class="detailT" style="width:100%;">
					<colgroup>
						<col width="120px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>결제수단</th>
							<td>
								<a href="#"><span class="cw h30">신용카드</span></a>
								<a href="#"><span class="cg h30 ml10">무통장 입금</span></a>
								<div class="boxA">
									<p class="fl">
										<label for=""><input type="radio" /> 세금계산서</label>
										<label for=""><input type="radio" /> 현금영수증</label>
										<label for=""><input type="radio" /> 미신청</label>
									</p>
									<p class="fl">
										<strong> 이메일 </strong> 
										<input type="text" name="" id="" style="width:250px;">
									</p>
									<!--
									<p class="fl">
										<select name="" id="" class="opt2" style="width:100px;">
											<option value="소득공제용" selected>소득공제용</option>
											<option value="지출증빙용">지출증빙용</option>
										</select>
										<strong> 휴대폰 번호 </strong> 
										<input type="text" id="" name="phone01" style="width:65px;" maxlength="4"> -
										<input type="text" id="" name="phone02" style="width:65px;" maxlength="4"> -
										<input type="text" id="" name="phone03" style="width:65px;" maxlength="4">
									</p>
									<p class="fl">
										<select name="" id="" class="opt2" style="width:100px;">
											<option value="소득공제용" selected>소득공제용</option>
											<option value="지출증빙용">지출증빙용</option>
										</select>
										<strong> 사업자등록번호 </strong> 
										<input type="text" id="" name="" style="width:65px;" maxlength="4"> -
										<input type="text" id="" name="" style="width:65px;" maxlength="4"> -
										<input type="text" id="" name="" style="width:65px;" maxlength="4">
									</p>
									-->
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- //결제정보 -->
		
		<!-- btnarea -->
		<div class="btn_area01">			
			<a href="02_com.do"><span class="cg h60">주문하기</span></a>
		</div>
		<!-- //btnarea -->
		<!-- //본문내용 -->
	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		