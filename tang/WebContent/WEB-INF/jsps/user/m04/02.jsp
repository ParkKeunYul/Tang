<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!-- container -->

<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "고객센터";
		String sec_nm = "고객센터";
		String thr_nm = "이용안내";
		int fir_n = 4;
		int sub_n = 2;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
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
	<!-- contents -->
	<div id="contents">
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit">이용안내</p>
			<p>사이트 이용안내 게시판입니다. <br/>북경한의원 원외탕전실 관련 다양한 정보를 확인하세요.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">
			<div class="searchBox01">
				<form action="" method="get" name="frm" id="frm">
					<select name="search_title" id="search_title" style="width:150px;">
						<option value="title"    <c:if test="${bean.search_title eq 'title' }">selected="selected"</c:if>>제목</option>
						<option value="content"  <c:if test="${bean.search_title eq 'content' }">selected="selected"</c:if>>내용</option>
					</select>
					<div class="winput">
						<input type="text" name="search_value" id="search_value" value="${bean.search_value}" style="width:200px;" />
						<a href="#" id="searchBoardBtn"><img src="/assets/user/images/common/bg_search.png" alt="검색" class="mt8" /></a>
					</div>
				</form>
			</div>
			<!-- table -->
			<table class="basic_list">
				<colgroup>
					<col width="80px" />
					<col width="140px" />
					<col width="*" />
					<col width="150px" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>등록일</th>
					</tr>
					
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
						<c:set var="q" value="${q+1}"></c:set>
						<tr>
							<td>${pageCount -q +1}</td>
							<td>${list.cate_nm}</td>
							<td class="L">
								<a href="02_view.do?seq=${list.seq}&board_name=${bean.board_name}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
									${list.title}
								</a>
							</td>
							<td>${list.reg_date_user}</td>
						</tr>	
					</c:forEach>
					<c:if test="${empty list}">
						<tr><td colspan="4">검색된 결과가 없습니다.</td></tr>
					</c:if>
					<!-- 계약 및 신고 안내계약 및 신고 -->
				</tbody>
			</table>
			<!-- //table -->				
			
			<!-- paging -->
			${navi}
			<!-- //paging -->

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	