<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!-- container -->

<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "고객센터";
		String sec_nm = "고객센터";
		String thr_nm = "공지사항";
		int fir_n = 4;
		int sub_n = 1;
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
			<p class="Ltit">공지사항</p>
			<p>공지사항게시판입니다.<br/>북경한의원 원외탕전실 관련 다양한 정보를 확인하세요.</p>
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
					<col width="*" />
					<col width="150px" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
						<c:set var="q" value="${q+1}"></c:set>
						<tr>
							<td>${pageCount -q +1}</td>
							<td class="L top">
								<a href="01_view.do?seq=${list.seq}&board_name=${bean.board_name}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
									<c:if test="${list.notice_yn eq 'y'}">공지]</c:if>${list.title}
								</a>
								<c:if test="${list.ori_name1 ne null || list.ori_name2 ne null || list.ori_name3 ne null}">
									<img src="/assets/user/images/common/icon_file.png" alt="" class="ifile" />
								</c:if>
							</td>
							<td>${list.reg_date_user}</td>
						</tr>	
					</c:forEach>
					<c:if test="${empty list}">
						<tr><td colspan="3">검색된 결과가 없습니다.</td></tr>
					</c:if>
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