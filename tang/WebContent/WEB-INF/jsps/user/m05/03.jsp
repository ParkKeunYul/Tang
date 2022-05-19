<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- container -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "마이페이지";
		String sec_nm = "마이페이지";
		String thr_nm = "주문내역";
		int fir_n = 5;
		int sub_n = 3;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	<style>
		.order_list a{
			text-decoration: none;
		}
		.order_list a:hover{
			text-decoration: underline;
		}
	</style>
	
	
	
	<!-- contents -->
	<div id="contents">
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit">주문내역</p>
			<p><font class="point">결제가 완료되지 않으면 탕전실에 처방전이 접수되지 않아 조제가 시작되지 않습니다.</font><br/>탕전실에 접수된 처방전은 약재 및 배송정보를 수정할 수 없습니다.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">
			<script>
			$(document).ready(function() {
				$.datepicker.setDefaults({
					changeMonth: true,
					changeYear: true,
					dateFormat: 'yy-mm-dd'
					//inline: true
				});
				
				$(".date").datepicker({
					dateFormat: "yy-mm-dd",
					closeText:'닫기',
					prevText:'이전달',
					nextText:'다음달',
					showButtonPanel: true,
					currentText:'오늘',
					closeText: '닫기',
					monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					dayNames:['일','월','화','수','목','금','토'],
					dayNamesShort:['일','월','화','수','목','금','토'],
					dayNamesMin:['일','월','화','수','목','금','토'],
					/* beforeShow: function(input, inst) {
						var firstInput = $(this).attr('name')+"_st";
						var secondInput = $(this).attr('name')+"_ed";
						if($(this).attr('id') == firstInput){
							return {
								maxDate: $("#"+secondInput).datepicker("getDate")
							};
						}
						if($(this).attr('id') == secondInput){
							return {
								minDate: $("#"+firstInput).datepicker("getDate")
							};
						};
						var i_offset= $(input).offset();
						setTimeout(function(){
					       $('#ui-datepicker-div').css({'top':i_offset.top, 'bottom':'', 'left':'10px'});
						});
					} */
				});
				
				$('#sdateBtn').click(function() {
					$('#s_order_date').focus();
					return false;
				});
				
				$('#edateBtn').click(function() {
					$('#e_order_date').focus();
					return false;
				});
				
				$('#searchBtn').click(function() {
					searchOrder();
					return false;
				});
				
				
				$('div.btnA a').click(function() {
					return false;
				});
				
				$('div.btnA a span').click(function() {
					$('div.btnA a span').removeClass('sel');
					$(this).addClass('sel');
					
					var type = $(this).attr('attr');
					
					$('#search_date_type').val(type);
					
					if(type == 1){
						$('#s_order_date').val( getMinusDay(7) );
					}
					else if(type == 2){
						$('#s_order_date').val( getMinusDay(15) );
					}
					else if(type == 3){
						$('#s_order_date').val( prevMonth(1) );
					}
					else if(type == 4){
						$('#s_order_date').val( prevMonth(3) );
					}	
					else if(type == 5){
						$('#s_order_date').val( getMinusDay(365) );
					}
					$('#e_order_date').val( getNowDate('-'));
					return false;
				});
				
				$("#search_value").keydown(function(key) {
					if (key.keyCode == 13) {
						searchOrder();
					}
				}); 
				
				
				$('.cancelOrderBtn').click(function() {
					
					if(!confirm('선택한 주문건을 취소처리 하겠습니까?')){
						return false;
					}
					
					var e = $(this);
					var url = e.attr('href');
					$.ajax({
						url   : url,
						type  : 'POST',
						error : function() {
							alert('에러가 발생했습니다.\n관리자에 문의하세요.');
						},
						success : function(data) {
							alert(data.msg);
							if (data.suc){
								e.hide();
								console.log(e.parents("td").html('<font style="color:red;">취소처리중</font>'));								
							}
						}
					});
					return false;
				});
				
				
				$('.deleberyBtn').click(function() {
					deliveryInfo( $(this).attr('href'));
					return false;
				});
				
				
			});
			
			function searchOrder(){
				
				var s_order_date = objToStr($('#s_order_date').val(),'');
				var e_order_date = objToStr($('#e_order_date').val(),'');
				
				if(s_order_date == '' && e_order_date != ''){
					alert('검색 시작날짜를 입력하세요.');
					$('#s_order_date').focus();
					return false;
				}
				
				if(s_order_date != '' && e_order_date == ''){
					alert('검색 종료날짜를 입력하세요.');
					$('#s_order_date').focus();
					return false;
				}
				
				
				if(s_order_date !='' && e_order_date != ''){
					console.log(s_order_date.replace(/-/gi, ""));
					console.log(e_order_date.replace(/-/gi, ""));
					
					if(new Number(s_order_date.replace(/-/gi, "")) > new Number(e_order_date.replace(/-/gi, ""))){
						alert('조회시작일이 조회 종료일보다 큽니다.');
		        		$('#s_order_date').focus();
		        		return false;
		        	}	
				}
				
				$('#frm').submit();
			}
			
			function prevMonth(month) {
			   var d = new Date();
			   var monthOfYear = d.getMonth();
			   d.setMonth(monthOfYear - month);
			   return getDateStr(d);
			}
			function getDateStr(myDate){
				   var year = myDate.getFullYear();
				   var month = ("0"+(myDate.getMonth()+1)).slice(-2);
				   var day = ("0"+myDate.getDate()).slice(-2);
				   return ( year + '-' + month + '-' + day );
			}

			
			function addZero(i){
				var rtn = i + 100;
				return rtn.toString().substring(1,3);
			}
			
			function getMinusDay(day){
				 var d = new Date();
				 d.setDate(d.getDate()- day);
				 /*console.log('getMinusDay = ', d);*/
				 
				 return d.getFullYear() + "-"+addZero((d.getMonth()+1)) + "-" + addZero(d.getDate())
			}

			function getPlusDay(day){
				 var d = new Date();
				 
				 if(day > 0){
					 d.setDate(d.getDate() + day); 
				 }				 
				 return d.getFullYear() + "-"+addZero((d.getMonth()+1)) + "-" + addZero(d.getDate())
			}
			
			function getNowDate(seperate){        
			    var nowDate = new Date();
			    var nowYear = nowDate.getFullYear();
			    var nowMonth = nowDate.getMonth();
			    nowMonth++;
			    var nowDay = nowDate.getDate();
			    if(nowYear < 2000)
			        nowYear += 1900;

			    var tempDay = '';
			    var tempMonth = '';
			    if(nowDay < 10)
			        tempDay = '0';
			    if(nowMonth < 10)
			        tempMonth = '0';
			    if(seperate == null || seperate == undefined)
			        seperate = '';			
			    return nowYear + seperate + tempMonth + nowMonth + seperate + tempDay + nowDay;
			}
			
			</script>
			<!-- searchArea -->
			<div class="searchArea">
				<form action="/m05/03.do" name="frm" id="frm" method="get">
					<input type="hidden" name="search_date_type" id="search_date_type" value="${bean.search_date_type}" />
					<input type="hidden" name="page" value="1" />
					<table>
						<colgroup>
							<col width="230px" />
							<col width="220px" />
							<col width="*" />
						</colgroup>
						<tr style="<c:if test="${userInfo.mem_sub_seqno ne 0 }">display: none;</c:if>">
							<td colspan="3">
								계정 선택 : ${userInfo.part}
								<select name="search_sub_seqno" id="search_sub_seqno">
									<option value="0"  <c:if test="${bean.search_sub_seqno eq 0 }">selected="selected"</c:if> >마스터계정  : ${userInfo.id} [ ${userInfo.name} ]</option>
									<c:forEach var="list" items="${sub_id}">
										<c:set var="sub_grade" value="부원장" />
										<c:if test="${list.grade eq 2 }"><c:set var="sub_grade" value="직원" /></c:if>
									
										<option value="${list.seqno}"  <c:if test="${bean.search_sub_seqno eq list.seqno }">selected="selected"</c:if>>${sub_grade} :  ${list.id} [ ${list.name} ]</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						
						<tr>
							<td colspan="3">
								조회기간 <input type="text" name="s_order_date" id="s_order_date"  value="${bean.s_order_date }" readonly="readonly"  style="width:115px; margin-left:10px;" class="date" /><a href="#" id="sdateBtn"><span class="cal"></span></a> 
								<span class="ml10">~</span>
								<input type="text" name="e_order_date" id="e_order_date" value="${bean.e_order_date }"  readonly="readonly"  style="width:115px; margin-left:10px;"  class="date"/><a href="#" id="edateBtn"><span class="cal"></span></a>
	
								<div class="btnA">
									<a href="#"><span <c:if test="${bean.search_date_type eq 1 }">class="sel"</c:if>  attr="1">1주일</span></a>
									<a href="#"><span <c:if test="${bean.search_date_type eq 2 }">class="sel"</c:if>  attr="2">15일</span></a>
									<a href="#"><span <c:if test="${bean.search_date_type eq 3 }">class="sel"</c:if>  attr="3">1개월</span></a>
									<a href="#"><span <c:if test="${bean.search_date_type eq 4 }">class="sel"</c:if>  attr="4">3개월</span></a>
									<a href="#"><span <c:if test="${bean.search_date_type eq 5 }">class="sel"</c:if>  attr="5">1년</span></a>
								</div>
							</td>
						</tr>
						<tr>
							<td>처방구분
								<select name="search_order_type" id="search_order_type"  style="width:120px;">
									<option value="">전체처방</option>
									<option value="1" <c:if test="${bean.search_order_type eq 1 }">selected="selected"</c:if>>탕전</option>
									<option value="2" <c:if test="${bean.search_order_type eq 2 }">selected="selected"</c:if>>약속</option>
								</select>
							</td>
							<td>결제구분
								<select name="search_payment" id="search_payment"  style="width:120px;">
									<option value="">전체상태</option>
									<option value="1" <c:if test="${bean.search_payment eq 1 }">selected="selected"</c:if>>결제</option>
									<option value="2" <c:if test="${bean.search_payment eq 2 }">selected="selected"</c:if>>미결제</option>
								</select>
							</td>
							<td>
								<input type="text" name="search_value" id="search_value"  value="${bean.search_value }" placeholder="처방명 또는 상품명을 입력해주세요." style="width:230px;" />
								<a href="#" id="searchBtn"><span class="cB h34">검색</span></a>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<!-- // searchArea -->

			<!-- orderlist -->
			<table class="order_list">
				<colgroup>
					<col width="110px" />
					<col width="80px" />
					<col width="*" />
					<col width="120px" />
					<col width="80px" />
					<col width="90px" />
					<col width="90px" />
					<col width="80px" />
					<col width="80px" />
					<col width="80px" />
				</colgroup>
				<thead>
					<tr>
						<th>주문일</th>
						<th>주문유형</th>
						<th>처방명/상품명</th>
						<th>결제금액</th>
						<th>결제유형</th>
						<th>결제상태</th>
						<th>진행상태</th>
						<th>배송조회</th>
						<th>카드영수증</th>
						<th>취소</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="duple" value="1"></c:set>
					<c:forEach var="list" items="${list}">
					<c:set var="q" value="${q+1}"></c:set>
						<tr>
							<c:choose>
								<c:when test="${list.bunch ne 'n' && list.bunch_num eq 2  }">
									<td rowspan="2">${list.order_date2}</td>
									<c:set var="duple" value="2"></c:set>
								</c:when>
								<c:when test="${list.bunch ne 'n' && list.bunch_num eq 1  }">									
									<c:if test="${duple eq 1 }">
										<td>${list.order_date2}</td>
									</c:if>
									<c:set var="duple" value="1"></c:set>
								</c:when>
								<c:otherwise>
									<td>${list.order_date2}</td>
								</c:otherwise>
							</c:choose>
							<td>${list.order_type_nm}</td>
							<td class="L">
								<c:if test="${list.order_type eq 1 }">
									<c:set var="view_url" value="/m05/03_tview.do" ></c:set>
								</c:if>
								
								<c:if test="${list.order_type eq 2 }">
									<c:set var="view_url" value="/m05/03_yview.do" ></c:set>
								</c:if>
							
								<a href="${view_url}?search_sub_seqno=${bean.search_sub_seqno}&seqno=${list.seqno}&search_date_type=${bean.search_date_type}&s_order_date=${bean.s_order_date}&e_order_date=${bean.e_order_date}&search_order_type=${bean.search_order_type}&search_payment&${bean.search_payment}&search_value=${bean.encodeSV}&page=${bean.page}">
									<c:if test="${list.bunch ne 'n' }">[묶음]</c:if>${list.goods_name}
									<c:if test="${list.tot_cnt > 1 }">외 ${list.tot_cnt -1}건</c:if>
								</a>
							</td>
							<td class="R">
								<c:choose>
									<c:when test="${userInfo.mem_sub_grade eq 2}">
										***,***
									</c:when>
									<c:otherwise>										
										<fmt:formatNumber value="${list.all_price}" pattern="#,###원" />	
									</c:otherwise>
								</c:choose>								
							</td>
							<td>${list.payment_kind_nm}</td>
							<td>
								<span class="fc01">
									<c:choose>
										<c:when test="${list.order_type eq 1 }">
											<c:if test="${list.payment eq 1}">입금</c:if>
											<c:if test="${list.payment eq 2}">미입금</c:if>
											<c:if test="${list.payment eq 3}">후불</c:if>
										</c:when>
										<c:when test="${list.order_type eq 2 }">
											<c:if test="${list.payment eq 1}">입금</c:if>
											<c:if test="${list.payment eq 2}">미입금</c:if>
											<c:if test="${list.payment eq 3}">방문결제</c:if>
											<c:if test="${list.payment eq 4}">증정</c:if>
										</c:when>
									</c:choose>
								</span>
							</td>
							<td>
								<c:choose>
									<c:when test="${list.order_type eq 1 }">
										<c:if test="${list.order_ing eq 1}">접수대기</c:if>
										<c:if test="${list.order_ing eq 2}">입금대기</c:if>
										<c:if test="${list.order_ing eq 3}">조제중</c:if>
										<c:if test="${list.order_ing eq 4}">탕전중</c:if>
										<c:if test="${list.order_ing eq 5}">발송</c:if>
										<c:if test="${list.order_ing eq 6}">완료</c:if>
										<c:if test="${list.order_ing eq 7}">환불취소</c:if>
										<c:if test="${list.order_ing eq 8}">예약발송</c:if>
									</c:when>
									<c:when test="${list.order_type eq 2 }">
										<c:if test="${list.order_ing eq 1}">주문처리중</c:if>
										<c:if test="${list.order_ing eq 2}">배송준비</c:if>
										<c:if test="${list.order_ing eq 3}">배송중</c:if>
										<c:if test="${list.order_ing eq 4}">배송완료</c:if>
										<c:if test="${list.order_ing eq 5}">환불/취소</c:if>
										<c:if test="${list.order_ing eq 6}">예약발송</c:if>
										<c:if test="${list.order_ing eq 7}">입금대기</c:if>
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:if test="${not empty list.delivery_no  }">
									<a href="https://tracker.delivery/#/${list.tak_sel_id}/${list.delivery_no}" class="deleberyBtn"><span class="cO h25">조회</span></a>
								</c:if>
							</td>
							<td>
								<c:if test="${list.payment_kind eq 'Cart' }"><a href="#"><span class="cblue h25">영수증</span></a></c:if>
							</td>
							<td>
								<c:choose>
									<c:when test="${list.cancel_ing eq 'i'}">
										<c:choose>
											<c:when test="${list.order_type eq 1 &&  list.order_ing eq 7}">
												<font color="blue">취소완료</font>									
											</c:when>
											<c:when test="${list.order_type eq 2 &&  list.order_ing eq 5}">
												<font color="blue">취소완료</font>
											</c:when>
											<c:otherwise>
												<font color="red">취소처리중</font>	
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${list.order_type eq 1 }">
												<c:if test="${list.order_ing eq 1 || list.order_ing eq 2}"><a href="/m05/03_cancel_order.do?seqno=${list.seqno}&table_nm=p_order" class="cancelOrderBtn"><span class="cB h25">취소</span></a></c:if>											
											</c:when>
											<c:when test="${list.order_type eq 2 }">
												<c:if test="${list.order_ing eq 1}"><a href="/m05/03_cancel_order.do?seqno=${list.seqno}&table_nm=pp_order" class="cancelOrderBtn"><span class="cB h25">취소</span></a></c:if>
											</c:when>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- // orderlist -->
			<!-- paging -->
			${navi}
			<!-- // paging -->

		</div>
		<!-- //내용 -->
		<!-- //내용 -->
	</div>
	<!-- //contents -->
	
</div>
<!-- //container -->
<!-- https://apis.tracker.delivery/carriers/kr.cjlogistics/tracks/625437785146 -->	