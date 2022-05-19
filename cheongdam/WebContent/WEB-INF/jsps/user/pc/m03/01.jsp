<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	$(document).ready(function() {
		$(".not_join").click(function() {
			alert('처방 가능한 상태가 아닙니다.');
			return false;
		});
		
		$("#searchBoardBtn").click(function() {
			$('#frm').submit();
		});
		
		$("#search_value").keydown(function(key) {
			if (key.keyCode == 13) {
				$('#frm').submit();
			}
		});
	});
</script>

<style>
.product_list ul .imgA img{
	/* height: auto; */
}

</style>
<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="contents">

		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>약속처방</span><span>약속처방</span></p>
		</div>

		<ul class="sub_Menu w33">
			<li class="sel"><a href="01.do">약속처방</a></li>
			<li><a href="02.do">약속처방 보관함</a></li>
			<li><a href="03.do">사전조제지시서 관리</a></li>
		</ul>


		<div class="bannerArea">
			<p class="ba02">
				<strong>신규로 처방하실 때에는 <font class="fc01">'보관함 처방'</font>을 선택하시면 조제 후 보관함에 보관됩니다.</strong><br/>원장님들의 처방전에 근거하여 조제가 이루어 지며 '보관함 처방' 후 일정시간이 지나면 발송이 가능합니다.
			</p>
		</div>
		<!-- tabArea -->
		<div class="product_tab">
			<form action="" method="get" name="frm" id="frm">
				<ul class="tab01">
					<li><a href="?" <c:if test="${empty bean.group_code}">class="sel"</c:if>>전체</a></li>
					<c:forEach var="list" items="${shop_code}">						
						<li><a href="?group_code=${list.group_code }" <c:if test="${bean.group_code eq list.group_code }">class="sel"</c:if> >${list.group_name }</a></li>
					</c:forEach>
					<li><a href="amount.do" class="special">포인트구매</a></li>
					<li><a href="personal.do" class="special">개인결제</a></li>
				</ul>
				<ul class="tab02">
					<li><a href="?sub_code=" <c:if test="${empty bean.sub_code  }">class="sel"</c:if>>전체</a></li>
					<c:forEach var="list" items="${sub_code}">						
						<li><a href="?sub_code=${list.seqno }" <c:if test="${bean.sub_code eq list.seqno }">class="sel"</c:if> >${list.group_name }</a></li>
					</c:forEach>	
				</ul>
				<p class="fr">
					<input type="text" name="search_value" id="search_value" value="${bean.search_value}" placeholder="검색어를 입력하세요." style="width:200px;" /><a href="#" id="searchBoardBtn"><span class="h35 cB">검색</span></a>
				</p>
			</form>
		</div>
		<!-- //tabArea -->
		<!-- 본문내용 -->
		<div class="product_list">
			<ul>
				<c:forEach var="list" items="${list}">
					<li>
						<a href="01_view.do?p_seq=${list.p_seq}&page=${bean.page}&group_code=${bean.group_code}&sub_code=${bean.sub_code}&search_value=${bean.encodeSV}">
							<div class="imgA" style="width: 280px;height: 264px;">
								<span>${list.p_name }</span>
								<div style="display: table;">
									<div style="height: 210px;width: 280px;display: table-cell;vertical-align: middle;">
										<c:if test="${! empty list.image }">
											<img src="/upload/goods/${list.image}" alt="${list.p_name }" style="width:100%;height: auto;" />
										</c:if>
									</div>
								</div>								
							</div>
							<div class="txtA">
								<em><fmt:formatNumber value="${list.p_price}" pattern="#,###원" /></em>
								<div>
									<c:set var="yak_design1" value="${fn:split(list.yak_design1,'|')}" />
									<c:set var="yak_design2" value="${fn:split(list.yak_design2,'|')}" />
									<c:set var="yak_design3" value="${fn:split(list.yak_design3,'|')}" />
									<c:set var="yak_design4" value="${fn:split(list.yak_design4,'|')}" />
									<c:set var="yak_design5" value="${fn:split(list.yak_design5,'|')}" />
									<c:set var="yak_design6" value="${fn:split(list.yak_design6,'|')}" />
									<c:set var="yak_design7" value="${fn:split(list.yak_design7,'|')}" />
									<c:set var="yak_design8" value="${fn:split(list.yak_design8,'|')}" />
									<c:set var="yak_design9" value="${fn:split(list.yak_design9,'|')}" />
									<c:set var="yak_design10" value="${fn:split(list.yak_design10,'|')}" />
									<c:set var="yak_design11" value="${fn:split(list.yak_design11,'|')}" />
									<c:set var="yak_design12" value="${fn:split(list.yak_design12,'|')}" />
									<c:set var="yak_design13" value="${fn:split(list.yak_design13,'|')}" />
									<c:set var="yak_design14" value="${fn:split(list.yak_design14,'|')}" />
									<c:set var="yak_design15" value="${fn:split(list.yak_design15,'|')}" />
									<p><strong>처방구성</strong>
										<!-- 자초 1g, 당귀 2g, 지실 3g, 황금 4g -->
										${yak_design1[0]}  ${yak_design1[2]}<c:if test="${!empty yak_design1[2]}">g, </c:if> 
										${yak_design2[0]}  ${yak_design2[2]}<c:if test="${!empty yak_design2[2]}">g, </c:if> 
										${yak_design3[0]}  ${yak_design3[2]}<c:if test="${!empty yak_design3[2]}">g, </c:if> 
										${yak_design4[0]}  ${yak_design4[2]}<c:if test="${!empty yak_design4[2]}">g, </c:if> 
										${yak_design5[0]}  ${yak_design5[2]}<c:if test="${!empty yak_design5[2]}">g, </c:if> 
										${yak_design6[0]}  ${yak_design6[2]}<c:if test="${!empty yak_design6[2]}">g, </c:if> 
										${yak_design7[0]}  ${yak_design7[2]}<c:if test="${!empty yak_design7[2]}">g, </c:if> 
										${yak_design8[0]}  ${yak_design8[2]}<c:if test="${!empty yak_design8[2]}">g, </c:if> 
										${yak_design9[0]}  ${yak_design9[2]}<c:if test="${!empty yak_design9[2]}">g, </c:if> 
										${yak_design10[0]} ${yak_design10[2]}<c:if test="${!empty yak_design10[2]}">g, </c:if> 
										${yak_design11[0]} ${yak_design11[2]}<c:if test="${!empty yak_design11[2]}">g, </c:if> 
										${yak_design12[0]} ${yak_design12[2]}<c:if test="${!empty yak_design12[2]}">g, </c:if> 
										${yak_design13[0]} ${yak_design13[2]}<c:if test="${!empty yak_design13[2]}">g, </c:if> 
										${yak_design14[0]} ${yak_design14[2]}<c:if test="${!empty yak_design14[2]}">g, </c:if> 
										${yak_design15[0]} ${yak_design15[2]}<c:if test="${!empty yak_design15[2]}">g</c:if> 
									</p>
									<p>${list.p_bigo}</p>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>	
			</ul>
		</div>
		
		<!-- paging -->
		${navi}
		<!-- //paging -->
		<!-- //본문내용 -->
	
	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		