<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- container -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<div id="container">	
	
	<!-- contents -->
	<div id="contents">
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>탕전처방</span><span>포장보기</span></p>
		</div>

		<ul class="sub_Menu w16">
			<li><a href="01.do">처방하기</a></li>
			<li><a href="06.do">실속처방</a></li>
			<li><a href="02.do">방제사전</a></li>
			<li class="sel"><a href="03.do">포장보기</a></li>
			<li><a href="04.do">환경설정</a></li>
			<li><a href="05.do">사용 설명서</a></li>
		</ul>
	
		
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