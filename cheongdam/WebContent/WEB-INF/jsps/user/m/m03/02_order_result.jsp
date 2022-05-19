<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">약속처방</p>
		<div class="lnbDepth">
			<ul>
				<li><a href="01.do">약속처방</a></li>
				<li  class="sel"><a href="02.do">약속처방 보관함</a></li>
				<li><a href="03.do">사전조제지시서</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->
	
	<!-- 본문 -->
	<div class="contents" id="contents">
		<div class="cartEnd">
			<div class="tit">"감사합니다. 주문이 완료되었습니다."</div>
			<c:if test="${bean.payment_kind eq 'Point' }">
				<table class="askList">
					<colgroup>
						<col width="30%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>총 결제금액</th>
							<td class="L"><span class="fc03"><fmt:formatNumber value="${bean.result_price}" pattern="#,###원" /></span></td>
						</tr>
						<c:if test="${bean.result_point > 0}">
							<tr>
								<th>포인트사용</th>
								<td class="L"><span class="fc03" style="color:blue;"><fmt:formatNumber value="${bean.result_point}" pattern="#,###원" /></span></td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</c:if>
			
			<c:if test="${bean.payment_kind eq 'Bank' }">
				<table class="askList">
					<colgroup>
						<col width="30%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>총 결제금액</th>
							<td class="L"><span class="fc03"><fmt:formatNumber value="${bean.result_price}" pattern="#,###원" /></span></td>
						</tr>
						<c:if test="${bean.result_point > 0}">
							<tr>
								<th>포인트사용</th>
								<td class="L"><span class="fc03" style="color:blue;"><fmt:formatNumber value="${bean.result_point}" pattern="#,###원" /></span></td>
							</tr>
							<tr>
								<th>총 입금금액</th>
								<td class="L"><span class="fc03"><fmt:formatNumber value="${bean.result_price - bean.result_point}" pattern="#,###원" /></span></td>
							</tr>
						</c:if>
						<tr>
							<th>입금계좌</th>
							<td class="L">
								농협은행 301-0260-0285-71 <br/>(예금주 : 이용세)
								<a href="#" id="copyAccountBtn"><span class="btnOR">계좌번호 복사</span></a>
							</td>
						</tr>
						<!--
						<tr>
							<th>입금자명</th>
							<td class="L">박원장</td>
						</tr>
						-->
					</tbody>
				</table>
				<input type="text" value="농협은행 301-0260-0285-71" id="accountNum" style="display:none; " />
			</c:if>
			
			<c:if test="${bean.payment_kind eq 'Card' }">
				<table class="askList">
					<colgroup>
						<col width="30%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>결제금액</th>
							<td class="L"><span class="fc03"><fmt:formatNumber value="${bean.result_price}" pattern="#,###원" /></span></td>
						</tr>
						<tr>
							<th>결제카드</th>
							<td class="L">
								${bean.card_nm} /
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
								<td class="L"><span class="fc03" style="color:blue;"><fmt:formatNumber value="${bean.result_point}" pattern="#,###원" /></span></td>
							</tr>
						</c:if>
						<tr>
							<th>총 결제금액</th>
							<td class="L"><span class="fc03"><fmt:formatNumber value="${bean.result_price + bean.result_point}" pattern="#,###원" /></span></td>
						</tr>
						<tr>
							<th>결제일</th>
							<td class="L">${bean.today}</td>
						</tr>			
					</tbody>
				</table>
			</c:if>
		</div>
		<!-- view -->
	<%--
		<div class="orderview">
			
			<div class="graybox">
				<span>처방일자 : </span> ${sub.order_date2}  / 
				<span>담당한의사 : </span> ${userInfo.han_name}
			</div>

			-->
			
			<!-- 결제 제품정보 -->
			<div class="orderDetail">
				<c:forEach var="list" items="${list}">
					<div class="detailList">
						<div class="Dtit">
							<img src="/upload/goods/${list.image}"  style="width: 50px;height: 50px;" alt="" /> <p>${list.goods_name }</p>
						</div>
						<c:if test="${list.box_option_seqno ne 0  && list.box_option_seqno ne null}">
							<ul class="op">							
								<li>- 옵션 : ${list.box_option_nm }(+<fmt:formatNumber value="${list.box_option_price}" pattern="#,###" />)</li>								
							</ul>
						</c:if>
						
						<ul class="info">
							<li>
								<label class="title">주문금액</label>
								<p><strong><fmt:formatNumber value="${list.goods_tot}" pattern="#,###" /></strong>원</p>
							</li>
						</ul>
					</div>
				</c:forEach>
			</div>
		</div>	--%>		
		<!-- //view -->
		 
		<div class="btnArea view">
			<button type="button" onclick="location.href='/main.do'" class="btnTypeBasic colorWhite"><span>홈으로 이동</span></button>
			<button type="button" onclick="location.href='/m/m05/03.do'" class="btnTypeBasic colorGreen"><span>주문내역 보기</span></button>
		</div>
	</div>
	<!-- //본문 -->
</div>
<!-- //container -->