<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	
	history.pushState(null, null, location.href);
	    window.onpopstate = function () {
	        history.go(1);
	};
});
</script>
<!-- contents -->
<div class="contents">

	<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>약속처방 보관함</span></p>
	<c:choose>
		<c:when test="${userSession.member_level eq  4}">
			<ul class="submenu w25">
				<li><a href="/m03/01.do" class="${bean.jungm_menu}">약속처방</a></li>
				<li><a href="/m99/01.do" class="${bean.ga_menu}">약속처방(가맹점)</a></li>
				<li><a href="/m03/02.do" class="">약속처방 보관함</a></li>
				<li><a href="/m03/03.do" class="">사전조제지시서 관리</a></li>
			</ul>
		</c:when>
		<c:otherwise>
			<ul class="submenu w33">
				<li><a href="01.do" class="sel">약속처방</a></li>
				<li><a href="02.do" class="">약속처방 보관함</a></li>
				<li><a href="03.do" class="">사전조제지시서 관리</a></li>
			</ul>
		</c:otherwise>
	</c:choose>
	
	<!-- 본문내용 -->
	<div class="order_end">
		<p>"감사합니다. 주문이 완료되었습니다."</p>
		<!-- 주문완료 카드 -->
		<c:if test="${bean.payment_kind eq 'Card' }">
			<table class="order_view mb30">
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
		
		<c:if test="${bean.payment_kind eq 'Bank' }">
			<table class="order_view mb30">
				<colgroup>
					<col width="150px" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>총 결제금액</th>
						<td class="b fc04"><fmt:formatNumber value="${bean.result_price}" pattern="#,###원" /></td>
					</tr>
					<tr>
						<th>입금계좌</th>
						<td>기업은행  091-194297-04-015 강명상(비움환원외탕전) <a href="#" id="copyAccountBtn"><span class="cO h25">계좌번호 복사</span></a></td>
					</tr>
					<!--
					<tr>
						<th>입금자명</th>
						<td>박원장</td>
					</tr>
					-->
				</tbody>
			</table>
			<input type="text" value="기업은행  091-194297-04-015 강명상(비움환원외탕전)" id="accountNum" style="display:none; " />
		</c:if>
		
		<c:if test="${bean.payment_kind eq 'Cms' }">
			<table class="order_view mb30">
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
						<th>계좌 간편 결제정보</th>
						<td>${bean.easybank_name} / ${bean.easybanK_account}</td>
					</tr>
					<tr>
						<th>결제일</th>
						<td>${bean.today}</td>
					</tr>
				</tbody>
			</table>
			<input type="text" value="기업은행  091-194297-04-015 강명상(비움환원외탕전)" id="accountNum" style="display:none; " />
		</c:if>
	</div>
	
	<!-- orderview -->
	<%-- <p class="pb10"><strong>처방일자 :</strong> 2020-12-26  /  <strong>담당한의사 :</strong> 대박한의원</p>
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
					<p class="img"><img src="../../images/sub/sam01.png" class="am" alt="" /></p>
					<div class="name">비움환나이트</div>
				</td>
				<td class="R fc04"><strong>55,000</strong>원</td>
			</tr>
			<tr>
				<td class="L">
					<p class="img"><img src="../../images/sub/sam01.png" class="am" alt="" /></p>
					<div class="name">비움환나이트</div>
				</td>
				<td class="R fc04"><strong>1,480,000</strong>원</td>
			</tr>
			<tr>
				<td class="L">
					<p class="img"><img src="../../images/sub/sam01.png" class="am" alt="" /></p>
					<div class="name">비움환나이트</div>
				</td>
				<td class="R fc04"><strong>250,000</strong>원</td>
			</tr>
		</tbody>
	</table> --%>
	<!-- // orderview -->
	
	<!-- btnarea -->
	<div class="btn_area01">
		<a href="/main.do"><span class="cw h60">홈으로 이동</span></a>
		<a href="/m05/03.do"><span class="cp h60">주문내역 보기</span></a>
	</div>
	<!-- //btnarea -->
	<!-- //본문내용 -->
</div>
<!-- // contents -->

		