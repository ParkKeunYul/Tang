<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>탕전주문내역서</title>
	<link rel="stylesheet" href="/assets/admin/css/admin.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
	<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
	
	
	<script  src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="/assets/admin/js/jquery/jquery.ui.datepicker-ko.js"></script>
	
 	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>		
	<script type="text/javascript" src="/assets/admin/js/setting.js"></script>
	<script type="text/javascript" src="/assets/admin/js/validation.js"></script>
	
	<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>
	
	<script>
		$(document).ready(function() {
			print();	
		})
	</script>
	<style>
		.tbv tbody td{
			padding: 2px 10px 2px;
		}
		input[type="text"]{
			height: 22px;
			line-height: 22px;
		}
		
		.check_table tr td{
			border: 1px solid black;
		}
		
		.basic01 tbody tr td,
		.basic01 tbody tr th{
			padding: 3px 0;
		}
		
		.basic01 .tdL{
			padding: 3px 5px;
		}
		
		@media print{
			.btn_area{
				display: none;
			}
			.tbv tbody td{
				padding: 1px 10px 1px;
			}
			
			input[type="text"]{
				padding-left: 1px;
			}
  		}
	</style>
</head>
<body style="background-color: #fff;">
	<%-- ${info} --%>
	<input type="hidden" name="order_no" id="order_no" value="${info.order_no}" />
		<table class="basic01">
			<colgroup>
				<col width="*" />
				<col width="80px" />
				<col width="120px" />
				<col width="120px" />
				<col width="120px" />
				<col width="120px" />
				<col width="140px" />
			</colgroup>
			<thead>
				<tr>
					<th>상품명</th>
					<th>수량</th>
					<th>판매가</th>
					<th>상품구매금액</th>
					<th>옵션금액</th>
					<th>할인금액</th>
					<th>최종 구매금액</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${p_list}">		   			
				<tr>
					<td class="tdL">
						<img src="/upload/goods/${list.good_image}" style="width: 60px;height: 60px;"  class="am" alt="${list.goods_name }" />${list.goods_name}
						<c:if test="${list.box_option_seqno ne 0 && list.box_option_seqno ne null }">
							[옵션 : ${list.box_option_nm }(+<fmt:formatNumber value="${list.box_option_price}" pattern="#,###" />)]
						</c:if>
					</td>
					<td>${list.ea}</td>
					<td class="tdR"><strong><fmt:formatNumber value="${list.goods_price}" pattern="#,###" /></strong>원</td>
					<td class="tdR"><strong><fmt:formatNumber value="${list.price - list.box_option_price}" pattern="#,###" /></strong>원</td>
					<td class="tdR"><strong><fmt:formatNumber value="${list.box_option_price}" pattern="#,###" /></strong>원</td>
					<td class="tdR"><strong><fmt:formatNumber value="${list.sale_price}" pattern="#,###" /></strong>원</td>
					<td class="tdR"><strong><fmt:formatNumber value="${list.price - list.sale_price}" pattern="#,###" /></strong>원</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	
		<div class="totalBox" style="margin-top:-1px;">
			<ul>
				<li class="tit">총금액</li>
				<li class="Bt01">최종 구매금액<span class="won"><fmt:formatNumber value="${info.tot_price - info.tot_sale_price}" pattern="#,###" />원</span></li>
				<li class="Bt02">배송비<span class="won"><fmt:formatNumber value="${info.delivery_price}" pattern="#,###" />원</span></li>
				<li class="total">합계<span class="won"><fmt:formatNumber value="${info.all_price}" pattern="#,###" /></span>원</li>
				<li class="Bt04">입금상태 
					<select name="pay_ing" id="pay_ing" class="upt_col" attr="pay_ing"  style="width:140px; margin-left:20px;">
						<option value="1"  <c:if test="${info.pay_ing eq 1 }">selected="selected"</c:if>>입금</option>
						<option value="2"  <c:if test="${info.pay_ing eq 2 }">selected="selected"</c:if>>미입금</option>
						<option value="3"  <c:if test="${info.pay_ing eq 3 }">selected="selected"</c:if>>방문결제</option>
						<option value="4"  <c:if test="${info.pay_ing eq 4 }">selected="selected"</c:if>>증정</option>
					</select>
				</li>
			</ul>
		</div>
		<!-- // 주문내역 -->
	
		<!-- 결제정보 -->
		<p><span class="viewtit">결제정보</span><span class="txt02">(${info.payment_kind_nm})</span><span class="txt03">상점관리자 조회시 참고하세요</span></p>
		<table class="basic01">
			<colgroup>
				<col width="15%" />
				<col width="35%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tbody>
				<tr>
					<th>회원명</th>
					<td class="tdL">
						<input type=text name="order_name" id="order_name"  value="${info.order_name}" style="border:1 solid BABBBA;width: 100px;" size=20> 
					</td>
					<th>한의원명</th>
					<td class="tdL">${info.han_name }</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td class="tdL">${info.han_tel } / ${info.handphone }</td>
					<th>이메일</th>
					<td class="tdL">${info.email}</td>
				</tr>
				<tr <c:if test="${info.payment ne 'Cms' }">style="display:none;"</c:if>>
					<th>거래번호</th>
					<td class="tdL">${info.cms_tid}</td>
					<th>결제은행 / 계좌번호</th>
					<td class="tdL">${info.easybank_name} / ${info.easybanK_account }</td>				
				</tr>
				<c:if test="${info.payment eq 'Cms' }">
					<tr>
						<th>취소요청</th>
						<td class="tdL" colspan="3">
							<c:if test="${info.cancel_ing eq 'y'}"><font style="color: red;">주문자에 의해 취소 요청된 주문건</font></c:if>
							<c:if test="${info.cancel_ing eq 'i'}">
								<select name="cancel_ing" id="cancel_ing"  class="upt_col" attr="cancel_ing">
									<option value=""  >정상주문으로 변경</option>
									<option value="i" <c:if test="${info.cancel_ing eq 'i'}">selected</c:if>>주문자에 의해 취소 요청된 주문건</option>
								</select>
								
								<c:if test="${info.payment eq 'Cms' && empty info.card_cancel_id }">
									<a href="#" id="cmsCancelBtn"    class="btn03" style="vertical-align: top;">계좌간편 결제 취소</a>
								</c:if>
								
								<div <c:if test="${empty info.card_cancel_id }">style="display: none;"</c:if>  id="cardCancelArea">
									간편결제 취소 정보 : <span id="card_cancel_info">${info.card_cancel_id}/${info.card_cancel_date}</span>
								</div>
								
								
								<div style="display: none;" >
									<input type="text" id="card_cancel_id" value="${info.card_cancel_id}" />
									<form name="cms_cancel_frm" method="post" id="cms_cancel_frm">
										
										<input type="text" name="c_seqno"  		id="cms_seqno" 	value="${info.seqno}" />
										<input type="text" name="c_order_no" 	id="cms_order_no" value="${info.order_no}" />
										<input type="text" name="CancelAmt" 	id="cms_CancelAmt" value="${info.all_price}">
										<input type="text" name="TID" 			id="cms_TID" value="${info.cms_tid}">
										<input type="text" name="MOID" 			id="cms_MOID" value="${info.cms_moid}">
										<input type="text" name="CancelMsg" 	value="고객취소">
										
										<select name="PartialCancelCode" 		id="c_PartialCancelCode">
						                   <option value="0" selected="selected">전체 취소</option>
						                   <!-- <option value="1" >부분 취소</option> -->
						                 </select>
					                 </form>
				                 </div>
								
							</c:if>
						</td>
					</tr>
				</c:if>
				<tr <c:if test="${info.payment ne 'Card' }">style="display:none;"</c:if>>
					<th>거래번호</th>
					<td class="tdL">${info.card_gu_no}</td>
					<th>주문번호</th>
					<td class="tdL">${info.card_ju_no }</td>				
				</tr>
				<c:if test="${info.payment eq 'Card'}">
					<tr>
						<th>취소요청</th>
						<td class="tdL">
							<c:if test="${info.cancel_ing eq 'y'}"><font style="color: red;">주문자에 의해 취소 요청된 주문건</font></c:if>
							<c:if test="${info.cancel_ing eq 'i'}">
								<select name="cancel_ing" id="cancel_ing"  class="upt_col" attr="cancel_ing">
									<option value=""  >정상주문으로 변경</option>
									<option value="i" <c:if test="${info.cancel_ing eq 'i'}">selected</c:if>>주문자에 의해 취소 요청된 주문건</option>
								</select>
								<c:if test="${info.payment eq 'Card' && empty info.card_cancel_id }">
									<a href="#" id="cardCancelBtn"    class="btn03" style="vertical-align: top;">카드 결제 취소</a>
								</c:if>
								
								<div <c:if test="${empty info.card_cancel_id }">style="display: none;"</c:if>  id="cardCancelArea">
									카드 취소 정보 : <span id="card_cancel_info">${info.card_cancel_id}/${info.card_cancel_date}</span>
								</div>
								
								<div style="display:none;" >
									<input type="text" id="card_cancel_id" value="${info.card_cancel_id}" />
									<form name="keyin_cancel_frm" method="post" id="keyin_cancel_frm">
										<input type="text" name="c_seqno"  		id="c_seqno" 	value="${info.seqno}" />
										<input type="text" name="c_order_no" 	id="c_order_no" value="${info.order_no}" />
										<input type="text" name="CancelMsg" 	value="고객취소">
										<input type="text" name="CancelAmt" 	id="c_CancelAmt" value="${info.all_price}">
										<input type="text" name="TID" 			id="c_TID" value="${info.card_gu_no}">
										<select name="PartialCancelCode" 		id="c_PartialCancelCode">
						                   <option value="0" selected="selected">전체 취소</option>
						                   <!-- <option value="1" >부분 취소</option> -->
						                 </select>
					                 </form>
				                 </div>
							</c:if>
						</td>
						<th>승인번호</th>
						<td class="tdL">${info.card_su_no}</td>
					</tr>
				</c:if>
				<tr <c:if test="${info.payment eq 'Card'}">style="display:none;"</c:if>>
					<th>영수증신청</th>
					<td class="tdL">
						<c:choose>
							<c:when test="${info.bill_part eq 1}">
								<font color="blue">세금계산서 신청</font> / ${info.bill_email }
							</c:when>
							<c:when test="${info.bill_part eq 2}">
								<font color="red">현금영수증 신청</font> / ${info.bill_name } / ${info.bill_handphone}
							</c:when>
							<c:otherwise>미신청</c:otherwise>
						</c:choose>
					</td>
					<th>계산서/영수증</th>
					<td class="tdL">
						<c:if test="${info.payment eq 'Bank' }">
							<select name="o_paypart" id="o_paypart" class="upt_col" attr='o_paypart' >
								<option value="1" <c:if test="${info.o_paypart eq 1 }">selected="selected"</c:if>>미발행</option>
								<option value="0" <c:if test="${info.o_paypart eq 0 }">selected="selected"</c:if>>발행</option>
							</select>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>관리자메모</th>
					<td class="tdL" colspan="3">
						<textarea rows=3 cols=120 name="realprice_memo" id="realprice_memo">${info.realprice_memo}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //결제정보 -->
	
		<!-- 배송정보 -->
		<p><span class="viewtit">배송정보</span>
			<span class="txt02">
				(
					<c:if test="${info.ship_type_from eq 1 }">한의원 -> 고객</c:if>
					<c:if test="${info.ship_type_from eq 2 }">비움원외탕전 -> 한의원</c:if>
					<c:if test="${info.ship_type_from eq 3 }">비움원외탕전 -> 고객</c:if>
					<c:if test="${info.ship_type_from eq 4 }">직접입력</c:if>
					<c:if test="${info.ship_type_from eq 5 }">방문수령</c:if>
				)
			</span>
		</p>
		<table class="basic02">
			<colgroup>
				<col width="120px" />
				<col width="130px" />
				<col width="340px" />
				<col width="130px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th class="bg01">진행상태</th>
					<td colspan="4" class="tdL bg01">
						<select name="order_ing" id="order_ing"  class="upt_col" attr="order_ing" style="width:100px;">
							 <option value="1" <c:if test="${info.order_ing eq 1 }">selected="selected"</c:if>>주문처리중</option>
							 <option value="7" <c:if test="${info.order_ing eq 7 }">selected="selected"</c:if>>입금대기</option>
							 <option value="2" <c:if test="${info.order_ing eq 2 }">selected="selected"</c:if>>배송준비</option>
							 <option value="3" <c:if test="${info.order_ing eq 3 }">selected="selected"</c:if>>배송중</option>
							 <option value="4" <c:if test="${info.order_ing eq 4 }">selected="selected"</c:if>>배송완료</option>
							 <option value="6" <c:if test="${info.order_ing eq 6 }">selected="selected"</c:if>>예약발송</option>
							 <option value="5" <c:if test="${info.order_ing eq 5 }">selected="selected"</c:if>>환불/취소</option>
						</select>
	
						<p class="txt01">송장번호</p>
						<select name="tak_sel" id="tak_sel"  class="upt_col" attr="tak_sel" style="width: 200px;">
							<option value="">선택</option>
							<c:forEach var="list" items="${deli_list}">
								<option value="${list.seqno}"  <c:if test="${info.tak_sel eq list.seqno }">selected="selected"</c:if> >${list.delivery_nm}</option>
							</c:forEach>
						</select>
						
						<input type=text name="deliveryno" id="deliveryno" placeholder="-없이 숫자만 등록" style="width:200px;" size=14 value="${info.deliveryno}" > 
						
						<%-- <p class="txt01">알림톡</p>
						<input type="checkbox" name="r_class" value="y" <c:if test="${info.r_class eq 'y' }">checked disabled</c:if>  onchange="r_class_change();">
						*송장번호 입력후에 체크해 주세요 --%>
					</td>
				</tr>
				<tr>
					<th class="bg02" rowspan="2">발송인 정보</th>
					<th class="bg02">발송인 이름</th>
					<td class="tdL">${info.o_name}</td>
					<th class="bg02">연락처</th>
					<td class="tdL">${info.o_tel} / ${info.o_handphone}</td>
				</tr>
				<tr>
					<th class="bg02">주소</th>
					<td colspan="3" class="tdL">${info.o_zipcode}<br>${info.o_address}</td>
				</tr>
				<tr>
					<th class="bg03" rowspan="4">수취인 정보</th>
					<th class="bg03">수취인 이름</th>
					<td class="tdL">
						<input type="text" name="r_name" id="r_name" value="${info.r_name}"  placeholder="이름" style="width:160px;">
					</td>
					<th class="bg03">연락처</th>
					<td class="tdL">
						<input type="text" name="r_tel" id="r_tel" value="${info.r_tel}"  placeholder="전화번호" style="width:160px;">
						/
						<input type="text" name="r_handphone" id="r_handphone" value="${info.r_handphone}"  placeholder="휴대전화" style="width:160px;">
					</td>
				</tr>
				<tr>
					<th class="bg03">주소</th>
					<td colspan="3" class="tdL">
						<%-- ${info.r_zipcode}  <br>${info.r_address} --%>
						<input type="text" name="r_zipcode" id="r_zipcode" value="${info.r_zipcode}"  style="width:80px;" readonly>
						<input type="text" name="r_address" id="r_address" value="${info.r_address}"  style="width:570px;"  ><br/>
					</td>
				</tr>
				<tr>
					<th class="bg03">배송시 메모</th>
					<td colspan="3" class="tdL">${info.o_memo}</td>
				</tr>
				<tr>
					<th class="bg03">주문시 요청사항</th>
					<td colspan="3" class="tdL">${info.o_memo2}</td>
				</tr>
			</tbody>
		</table>
		<!-- //배송정보 -->
	
	
</body>
</html>