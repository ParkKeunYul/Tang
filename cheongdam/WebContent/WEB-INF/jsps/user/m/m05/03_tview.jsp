<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% 
pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<script>
	$(document).ready(function() {
		$("#receiptBtn").click(function() {
		 	var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes, resizable=yes,width=420,height=540";     
		 	var url = $(this).attr('href');     
		 	window.open(url,"popupIssue",status); 
			return false;
		});
		
		$('.deleberyBtn').click(function() {
			deliveryInfo( $(this).attr('href'));
			return false;
		});
		
	});	
</script>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">주문내역</p>
		<div class="lnbDepth">
			<ul>
				<li><a href="01.do">내 정보수정</a></li>
				<li class="sel"><a href="03.do">주문내역</a></li>
				<li ><a href="04.do" style="letter-spacing: -3px;">탕전공동사용계약서</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<div class="contents" id="contents">			
		<!-- view -->
		<div class="orderview">
			<!-- 결제수단 -->
			<div class="Listbox">
				<p class="tit01">결제수단</p>
				<ul>
					<li>
						<label class="title">결제유형</label>
						<p>
							${info.payment_kind_nm} 
							<c:if test="${info.payment_kind eq 'Card' }"><a class="btnTypeBasic sizeXS colorBlueGray" href="https://npg.nicepay.co.kr/issue/IssueLoader.do?TID=${info.card_gu_no}&type=0" id="receiptBtn"><span>영수증</span></a></c:if>
						</p>
					</li>
					<li>
						<label class="title">결제상태</label>
						<p>
							<c:if test="${info.payment eq 1 }">입금</c:if>
							<c:if test="${info.payment eq 2 }">미입금</c:if>
							<c:if test="${info.payment eq 3 }">후불</c:if>
						</p>
					</li>
					<li>
						<label class="title">진행상태</label>
						<p>
							<c:choose>
								<c:when test="${ (info.cancel_ing == 'i' ||  info.cancel_ing == 'y') && info.order_ing ne 5}">
									주문취소 요청중
								</c:when>
								<c:otherwise>
									<c:if test="${info.order_ing eq 1 }">접수대기</c:if>
									<c:if test="${info.order_ing eq 2 }">입금대기</c:if>
									<c:if test="${info.order_ing eq 3 }">조제중</c:if>
									<c:if test="${info.order_ing eq 4 }">탕전중</c:if>
									<c:if test="${info.order_ing eq 5 }">발송</c:if>
									<c:if test="${info.order_ing eq 6 }">완료</c:if>
									<c:if test="${info.order_ing eq 7 }">환불취소</c:if>
									<c:if test="${info.order_ing eq 7 }">예약발송</c:if>  
									<c:if test="${not empty info.deliveryno  }">
										<a href="https://tracker.delivery/#/${info.tak_sel_id}/${info.deliveryno}" class="deleberyBtn" class="btnTypeBasic sizeXS colorOrange"><span >조회</span></a>
									</c:if>
								</c:otherwise>
							</c:choose>							
						</p>
					</li>
				</ul>
			</div>
			<!-- //결제수단 -->
			<!-- 보내는 사람 -->
			<div class="Listbox">
				<p class="tit02">보내는 사람</p>
				<ul>
					<li>
						<label class="title">발신인</label>
						<p>
							${info.d_from_name}
							(
							<c:if test="${info.d_type eq 1 }">청담원외탕전</c:if>
							<c:if test="${info.d_type eq 3 }">한의원</c:if>
							<c:if test="${info.d_type eq 4 }">청담원외탕전 </c:if>
							<c:if test="${info.d_type eq 6 }">직접입력 </c:if>
							<c:if test="${info.d_type eq 7 }">방문수령 </c:if>
							)
						</p>
					</li>
					<li>
						<label class="title">연락처</label>
						<p>${info.d_from_handphone}</p>
					</li>
					<li>
						<label class="title">주소</label>
						<p>(우:${info.d_from_zipcode}) ${info.d_from_address01}&nbsp; ${info.d_from_address02}</p>
					</li>
				</ul>
			</div>
			<!-- //보내는 사람 -->
			<!-- 받는 사람 -->
			<div class="Listbox">
				<p class="tit03">받는 사람</p>
				<ul>
					<li>
						<label class="title">수신인</label>
						<p>
							${info.d_to_name}
							(
								<c:if test="${info.d_type eq 1 }">한의원</c:if>
								<c:if test="${info.d_type eq 3 }">고객</c:if>
								<c:if test="${info.d_type eq 4 }">고객 </c:if>
								<c:if test="${info.d_type eq 6 }">직접입력 </c:if>
								<c:if test="${info.d_type eq 7 }">방문수령 </c:if>
							)
						</p>
					</li>
					<li>
						<label class="title">연락처</label>
						<p>${info.d_from_handphone}</p>
					</li>
					<li>
						<label class="title">주소</label>
						<p>(우:${info.d_from_zipcode}) ${info.d_from_address01}&nbsp; ${info.d_from_address02}</p>
					</li>
					<li>
						<label class="title">배송메모</label>
						<p>&nbsp; ${fn:replace(info.o_memo, crcn, br)}</p>
					</li>
					<c:if test="${not empty info.deliveryno  }">
					<li>
						<label class="title">택배정보</label>
						<p>
							발송일 : ${info.delivery_date }<br/>
							<strong>송장번호 : ${info.deliveryno}(${info.tak_sel_nm})</strong>
							<a href="https://tracker.delivery/#/${info.tak_sel_id}/${info.deliveryno}" class="deleberyBtn btnTypeBasic sizeXS colorOrange"><span>배송조회</span></a>
						</p>
					</li>
					</c:if>
				</ul>
			</div>
			<!-- //받는 사람 -->
			<style>
				.orderview .orderDetail{
					padding: 0.5em;
				}
				
				.orderview .orderDetail .detailList{
					padding: 0.5em;
				}
			
				.orderview .orderDetail {width:100%; background:#f8f8f8; border:1px solid #eeeeee; padding:2rem 1.5rem 1.0rem 1.5rem; box-sizing:border-box;}
				.orderview .orderDetail ul {}
				.orderview .orderDetail ul:last-child {border-bottom:none;}
				.orderview .orderDetail ul li {margin-bottom:.9rem; line-height:2rem;}
				.orderview .orderDetail ul li label.title {width:25%; font-weight:700; float:left; display:table;}
				.orderview .orderDetail ul li p {width:75%; display:table-cell; vertical-align:middle;}
				.orderview .orderDetail ul li a {line-height:2.0rem; }
				.orderview .orderDetail ul li strong {font-weight:700;}
				
				.orderview .orderDetail ul li label.title{
					width: 33%;
				}
				
				.orderview .orderDetail ul li label.title{
					width: 70px;
				}
				
				.orderDetail .tit03{
					display:block; width:100%; padding:1rem; font-size:1.6rem; font-weight:700; background:#e5f2f6; border-bottom:1px solid #c9c9c9; box-sizing: border-box;
				}
			</style>
			<!-- 결제 제품정보 -->
			<div class="orderDetail mt30">
				<ul class="infobox">
					<li>
						<label class="title">처방명</label>
						<p class="name">${info.s_name}</p>
					</li>
					<li style="">
						<label class="title">탕전방식</label>
						<p>
							<c:choose>
								<c:when test="${info.c_tang_type eq 2}">무압력탕전</c:when>
								<c:when test="${info.c_tang_type eq 3}">압력탕전</c:when>
								<c:otherwise>첩약</c:otherwise>
							</c:choose>
							<c:if test="${view.c_tang_type ne 1}">
								<span style="color: red;">
									<c:if test="${info.c_tang_check13 eq 'y'}">(주수상반)</c:if>
									<c:if test="${info.c_tang_check14 eq 'y'}">(증류)</c:if>
									<c:if test="${info.c_tang_check15 eq 'y'}">(발효)</c:if>
									<c:if test="${info.c_tang_check16 eq 'y'}">(재탕)</c:if>
								</span>
							</c:if>
						</p>
					</li>
					<li style="width: 50%;float: left;">
						<label class="title">첩수</label>
						<p>${info.c_chup_ea}첩</p>
					</li>
					<li style="<c:if test="${info.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
						<label class="title">파우치</label>
						<p>${info.c_pouch_nm}</p>
					</li>
					<li style="<c:if test="${view.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
						<label class="title">박스</label>
						<p>${info.c_box_nm}</p>
					</li>
					<li style="<c:if test="${view.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
						<label class="title">스티로폼</label>
						<p>${info.c_stpom_nm}</p>
					</li>
					<li style="<c:if test="${info.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
						<label class="title">팩용량</label>
						<p>${info.c_pack_ml}ml</p>
					</li>
					<li style="<c:if test="${info.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
						<label class="title">팩수</label>
						<p>${info.c_pack_ea}</p>
					</li>
					<li style="clear: both;height: 1px;margin-bottom: 0px;"></li>					
				</ul>				
			</div>
			<div class="orderDetail" style="line-height: 22px;">
				<ul style="margin-bottom: 5px;margin-left: 10px;">
						<li style="">
							<span style="display: inline-block;width: 45%;font-weight: 700;">약초명</span> 
							<span style="display: inline-block;width: 26%;font-weight: 700;">원산지</span>
							<span style="display: inline-block;width: 22%;font-weight: 700;text-align: right;">1첩조제량</span>							 
						</li>
				</ul>
				<ol style="list-style: decimal;margin-left: 10px;">
					<c:forEach var="list" items="${p_list}">
						<li style="">
							<span style="display: inline-block;width: 45%;">${list.yak_name}</span> 
							<span style="display: inline-block;width: 26%;">${list.p_from}</span>
							<span style="display: inline-block;width: 22%;text-align: right;">${list.p_joje}g</span>							 
						</li>
					</c:forEach>
				</ol>
			</div>
			<!-- //결제 제품정보 -->
			<!-- 결제 정보 -->
			<div class="orderTotal">
				<ul class="tlist">
					<li>
						<label class="title">처방비용 합계</label>
						<p><strong><fmt:formatNumber value="${info.order_total_price + info.member_sale}" pattern="#,###" /></strong>원</p>
					</li>
					<li>
						<label class="title">할인금액(-)</label>
						<p><strong>-<fmt:formatNumber value="${info.member_sale}" pattern="#,###" /></strong>원</p>
					</li>
				</ul>
			</div>
			<ul class="totalarea">
				<li>
					<label class="title">총 결제금액</label>
					<p><strong><fmt:formatNumber value="${info.order_total_price}" pattern="#,###" /></strong>원</p>
				</li>
			</ul>
		</div>			
		<!-- //view -->
		<div class="btnArea">
			<a href="/m/m05/03.do?search_date_type=${bean.search_date_type}&s_order_date=${bean.s_order_date}&e_order_date=${bean.e_order_date}&search_order_type=${bean.search_order_type}&search_payment&${bean.search_payment}&search_value=${bean.encodeSV}&page=${bean.page}" class="btnTypeSearch colorGray mt20"><span>목록보기</span></a>
		</div>
	</div>
	<!-- //본문 -->

</div>
<!-- //container -->
		