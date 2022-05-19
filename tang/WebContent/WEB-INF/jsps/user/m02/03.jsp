<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- container -->
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "탕전처방";
		String sec_nm = "탕전처방";
		String thr_nm = "포장보기";
		int fir_n = 2;
		int sub_n = 3;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	
	<!-- contents -->
	<div id="contents">
		
		<!-- 내용 -->
		<div class="conArea">
			
			<!-- 포장박스 리스트 -->
			<div class="div_tit">포장박스 리스트</div>
			<div class="boxList">
				<c:forEach var="list" items="${box_list}">
					<div>
						<p class="img" style="width: 200px;height: 199px;"><img src="/upload/box/${list.box_image }" alt="" width="199px;" height="199px;" /></p>
						<ul>
							<li><span>제품명</span>${list.box_name}</li>
							<li><span>규격</span>${list.box_size}</li>
							<li><span>가격</span><fmt:formatNumber value="${list.box_price}" type = "number"  /></li>
							<li><span>재고량</span>${list.box_status_nm}</li>
							<li><span>설명</span><p class="am">${fn:replace(list.box_contents, newLineChar, "<br/>")}</p></li>
						</ul>
					</div>
				</c:forEach>
			</div>
			<!-- // 포장박스 리스트 -->

			<!-- 파우치 리스트 -->
			<div class="div_tit mt60">파우치 리스트</div>
			<div class="boxList">
				<c:forEach var="list" items="${pouch_list}">
					<div>
						<p class="img" style="width: 200px;height: 199px;"><img src="/upload/pouch/${list.pouch_image }" alt="" width="199px;" height="199px;" /></p>
						<ul>
							<li><span>제품명</span>${list.pouch_name}</li>
							<li><span>규격</span>${list.pouch_size}</li>
							<li><span>가격</span><fmt:formatNumber value="${list.pouch_price}" type = "number"  /></li>
							<li><span>재고량</span>${list.pouch_status_nm}</li>
							<li><span>설명</span><p class="am">${fn:replace(list.pouch_contents, newLineChar, "<br/>")}</p></li>
						</ul>
					</div>
				</c:forEach>
			</div>
			<!-- // 파우치 리스트 -->

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	