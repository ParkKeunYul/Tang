<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(document).ready(function() {
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
<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="contents">

		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>약속처방</span><span>약속처방 보관함</span></p>
		</div>

		<ul class="sub_Menu w33">
			<li class="sel"><a href="01.do">약속처방</a></li>
			<li ><a href="02.do">약속처방 보관함</a></li>
			<li><a href="03.do">사전조제지시서 관리</a></li>
		</ul>
		
		<!-- 본문내용 -->
		<div class="order_end">
			<p>"감사합니다. 결제 완료되었습니다."</p>
			<!-- 주문완료 카드 -->
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
						<th>총 포인트</th>
						<td><span class="tf02"><fmt:formatNumber value="${bean.tot_point}" pattern="#,###원" /></span></td>
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
		</div>
		
		
		<!-- btnarea -->
		<div class="btn_area01">
			<a href="/main.do"><span class="cw h60">홈으로 이동</span></a>
			<a href="/m05/99.do"><span class="cg h60">포인트 충전내역 보기</span></a>
		</div>
		<!-- //btnarea -->
		<!-- //본문내용 -->
	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		