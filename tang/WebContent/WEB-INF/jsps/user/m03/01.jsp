<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- container -->
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "약속처방";
		String sec_nm = "약속처방";
		String thr_nm = "처방하기";
		int fir_n = 3;
		int sub_n = 1;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	<script>
		$(document).ready(function() {
			$(".not_join").click(function() {
				alert('처방 가능한 상태가 아닙니다.');
				return false;
			});
		});
	</script>
	
	<!-- contents -->
	<div id="contents">
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit">전체처방</p>
			<p><strong>신규로 처방하실 때에는 '보관함 처방'을 선택하시면 조제 후 보관함에 보관됩니다.</strong><br/>원장님들의 처방전에 근거하여 조제가 이루어 지며 <strong>'보관함 처방'</strong> 후 일정시간이 지나면 발송이 가능합니다.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">
			<!-- 카테고리 tab -->
			<div class="product_tab">
				<ul>
					<li><a href="?" <c:if test="${empty bean.group_code}">class="sel"</c:if>>전체처방</a></li>
					<c:forEach var="list" items="${shop_code}">						
						<li><a href="?group_code=${list.group_code }" <c:if test="${bean.group_code eq list.group_code }">class="sel"</c:if> >${list.group_name }</a></li>
					</c:forEach>
				</ul>
			</div>

			<!-- product_list -->
			<div class="product_list">
				<ul>
					<c:forEach var="list" items="${list}">
						<c:choose>
							<c:when test="${list.p_ea eq '처방가능' }">
								<li>
									<a href="01_view.do?p_seq=${list.p_seq}&page=${bean.page}">
										<p class="imgA" style="width: 340px;height: 340px;">
											<span class="btok">처방가능</span>
											<img src="/upload/goods/${list.image}" alt="${list.p_name }" style="width: 340px;height: 340px;" />
										</p>
									</a>
									<p class="price">
										${list.p_name }
										<c:choose>
											<c:when test="${userInfo.mem_sub_grade eq 2}">
												<span>***,***원</span>
											</c:when>
											<c:otherwise>										
												<span><fmt:formatNumber value="${list.p_price}" pattern="#,###원" /></span>
											</c:otherwise>
										</c:choose>
									</p>
								</li>	
							</c:when>
							<c:otherwise>
								<li>
									<a href="#" class="not_join">
										<p class="imgA" style="width: 340px;height: 340px;">
											<span class="btno">처방불가</span>
											<img src="/upload/goods/${list.image}" alt="${list.p_name }"  style="width: 340px;height: 340px;" />
										</p>
									</a>
									<p class="price">
										${list.p_name }										
										<c:choose>
											<c:when test="${userInfo.mem_sub_grade eq 2}">
												<span>***,***원</span>
											</c:when>
											<c:otherwise>										
												<span><fmt:formatNumber value="${list.p_price}" pattern="#,###원" /></span>
											</c:otherwise>
										</c:choose>
									</p>
								</li>
							</c:otherwise>
						</c:choose>
						
					</c:forEach>				
				</ul>
			</div>
			<!-- //product_list -->
			<!-- paging -->
			${navi}
			<!-- //paging -->

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	