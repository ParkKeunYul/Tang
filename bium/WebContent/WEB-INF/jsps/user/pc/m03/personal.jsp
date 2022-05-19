<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="contents">

	<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>약속처방</span></p>
	
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

	<div class="bannerinfo">
		<form action="/m03/01.do" method="get" name="frm" id="frm">
			<div class="topA">
				<p class="txt">
					<strong>신규로 처방하실 때에는 <font class="fc01">'보관함 처방'</font>을 선택하시면 조제 후 보관함에 보관됩니다.</strong><br/>원장님들의 처방전에 근거하여 조제가 이루어 지며 '보관함 처방' 후 일정시간이 지나면 발송이 가능합니다.
				</p>
				<p class="search">
					<input type="text" name="search_value" id="search_value" value="${bean.search_value}" placeholder="상품명을 입력하세요" style="width:180px;" /><a href="#" id="searchBoardBtn"><span class="h35 cB">검색</span></a>
				</p>
			</div>
			<!-- tabArea -->
			<ul class="product_tab">
				<li><a href="?" <c:if test="${empty bean.group_code}">class=""</c:if>>전체</a></li>
				<c:forEach var="list" items="${shop_code}">						
					<li><a href="?group_code=${list.group_code }" <c:if test="${bean.group_code eq list.group_code }">class="sel"</c:if> >${list.group_name }</a></li>
				</c:forEach>
				<li><a href="/m03/personal.do" class="sel">개인결제</a></li>
			</ul>
			<!-- //tabArea -->
		</form>
	</div>	
	<!-- 본문내용 -->
	
	<div class="product_list">
		<ul>
			<c:forEach var="list" items="${list}">
				<li>
					<a href="personal_view.do?seqno=${list.seqno}&page=${bean.page}">
						<div class="imgA">
							<c:if test="${list.pay_yn eq 'n' }">
								<span>${list.title}</span>
							</c:if>
							<c:if test="${list.pay_yn eq 'y' }">
								<span style="font-weight: 700;text-decoration: line-through;">${list.title}[결제완료]</span>
							</c:if>
							<img src="/assets/user/pc/images/sub/thum_none.png" alt="" />
						</div>
						<div class="txtA">
							<em <c:if test="${list.pay_yn eq 'y' }">style="text-decoration: line-through;color:red;"</c:if>>
								<fmt:formatNumber value="${list.price}" pattern="#,###원" />
							</em>
							<div>${list.CONTENT}</div>
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