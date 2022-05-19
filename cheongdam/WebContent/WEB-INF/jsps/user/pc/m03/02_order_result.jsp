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
			<li><a href="03.do">사전조제지시서 관리</a></li>
		</ul>
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
							<th>결제금액</th>
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
						<c:if test="${bean.result_point > 0}">
							<tr>
								<th>포인트사용</th>
								<td class="b fc03" style="color:blue;"><fmt:formatNumber value="${bean.result_point}" pattern="#,###원" /></td>
							</tr>
						</c:if>
						<tr>
							<th>총 결제금액</th>
							<td><span class="tf02"><fmt:formatNumber value="${bean.result_price + bean.result_point}" pattern="#,###원" /></span></td>
						</tr>
						<tr>
							<th>결제일</th>
							<td>${bean.today}</td>
						</tr>
					</tbody>
				</table>
				<!-- //주문완료 카드 -->
			</c:if>
			
			<c:if test="${bean.payment_kind eq 'Point' }">
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
						<c:if test="${bean.result_point > 0}">
							<tr>
								<th>포인트사용</th>
								<td class="b fc03" style="color:blue;"><fmt:formatNumber value="${bean.result_point}" pattern="#,###원" /></td>
							</tr>
						</c:if>
					</tbody>
				</table>
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
						<c:if test="${bean.result_point > 0}">
							<tr>
								<th>포인트사용</th>
								<td class="b fc03" style="color:blue;"><fmt:formatNumber value="${bean.result_point}" pattern="#,###원" /></td>
							</tr>
							<tr>
								<th>입금금액 </th>
								<td class="b fc04"><fmt:formatNumber value="${bean.result_price - bean.result_point}" pattern="#,###원" /></td>
							</tr>
						</c:if>
						<tr>
							<th>입금계좌</th>
							<td>농협은행 301-0260-0285-71 (예금주 : 이용세) <a href="#" id="copyAccountBtn"><span class="cO h25">계좌번호 복사</span></a></td>
						</tr>
						
						<!--
						<tr>
							<th>입금자명</th>
							<td>박원장</td>
						</tr>
						-->
					</tbody>
				</table>
				<input type="text" value="농협은행 301-0260-0285-71" id="accountNum" style="display:none; " />
			</c:if>
		</div>
		<!-- orderview -->
		<%--<p class="pb10"><strong>처방일자 :</strong> ${sub.order_date2}  /  <strong>담당한의사 :</strong> ${userInfo.han_name}</p> 
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
				<c:forEach var="list" items="${list}">
					<tr>
						<td class="L">
							<p class="img"><img src="/upload/goods/${list.image}" style="width: 60px;height: 60px;" class="am" alt="" /></p>
							<div class="name">${list.goods_name }
								<c:if test="${list.box_option_seqno ne 0  && list.box_option_seqno ne null}">
									<p class="opttxt">
										- 옵션 :  ${list.box_option_nm }(+<fmt:formatNumber value="${list.box_option_price}" pattern="#,###" />)
									</p>
								</c:if>
								
							</div>
						</td>
						<td class="R fc04"><strong><fmt:formatNumber value="${list.goods_tot}" pattern="#,###" /></strong>원</td>
					</tr>
				</c:forEach>
				<c:if test="${bean.delivery_price > 0 }">
					<tr>
						<td class="L">
							<p class="img"></p>
							<div class="name">배송비</div>
						</td>
						<td class="R fc04"><strong><fmt:formatNumber value="${bean.delivery_price}" pattern="#,###" /></strong>원</td>
					</tr>
				</c:if>
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
			</tbody>
		</table> --%>
		<!-- // orderview -->
		
		<!-- btnarea -->
		<div class="btn_area01">
			<a href="/main.do"><span class="cw h60">홈으로 이동</span></a>
			<a href="/m05/03.do"><span class="cg h60">주문내역 보기</span></a>
		</div>
		<!-- //btnarea -->
		<!-- //본문내용 -->
	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		