<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
	$(document).ready(function() {
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
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">이용안내</p>
		<div class="lnbDepth">
			<ul>
				<li><a href="01.do">공지사항</a></li>
				<li class="sel"><a href="02.do">이용안내</a></li>
				<li><a href="03.do">1:1문의</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<div class="contents" id="contents">
		<div class="board_search">
			<form action="" method="get" name="frm" id="frm">
				<input type="hidden" name="search_title" id="search_title" value="title" />
				<span><input type="text" name="search_value" id="search_value"  placeholder="검색어를 입력해주세요." title=" "></span>
				<button type="button" id="searchBoardBtn" class="btnTypeBasic colorDGreen"><span>검색</span></button>
			</form>
		</div>
		<div class="board_list">
			<ul>
				<c:forEach var="list" items="${nlist}">
					<li class="sel">
						<a href="02_view.do?seq=${list.seq}&board_name=${bean.board_name}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">[${list.cate_nm}] ${list.title}</a>
						<span>${list.reg_date_user}</span>
					</li>
				</c:forEach>
				<c:forEach var="list" items="${list}">
					<li>
						<a href="02_view.do?seq=${list.seq}&board_name=${bean.board_name}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">[${list.cate_nm}] ${list.title}</a>
						<span>${list.reg_date_user}</span>
					</li>
				</c:forEach>			
			</ul>
		</div>
		
		${navi}
	</div>
	<!-- //본문 -->

</div>
<!-- //container -->