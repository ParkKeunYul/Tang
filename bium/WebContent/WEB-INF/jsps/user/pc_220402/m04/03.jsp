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
	<div class="contents">

		<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>1:1문의</span></p>
		<ul class="submenu w33">
			<li><a href="/m04/01.do" class="">공지사항</a></li>
			<li><a href="/m04/02.do" class="">이용안내</a></li>
			<li><a href="/m04/03.do" class="sel">1:1문의</a></li>
		</ul>


		<!-- 본문내용 -->
		<span class="t01">* 1:1문의는 타인에게 내용이 공개되지 않습니다.</span>
		<div class="searchBox01">
			<div style="display: none;">
				<form action="" method="get" name="frm" id="frm">
					<select name="search_title" id="search_title" style="width:100px;">
						<option value="all_type"    <c:if test="${bean.search_title eq 'all_type' }">selected="selected"</c:if>>전체</option>
						<option value="title"    <c:if test="${bean.search_title eq 'title' }">selected="selected"</c:if>>제목</option>
						<option value="content"  <c:if test="${bean.search_title eq 'content' }">selected="selected"</c:if>>내용</option>
					</select>
					<input type="text" name="search_value" id="search_value" value="${bean.search_value}" style="width:200px;" />
					<a href="#" id="searchBoardBtn"><span class="h35 cB">검색</span></a>
				</form>
			</div>
		</div>
		<!-- table -->
		<table class="basic_list">
			<colgroup>
				<col width="70px" />
				<col width="*" />
				<col width="80px" />
				<col width="170px" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>답변</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
					<c:set var="q" value="${q+1}"></c:set>
					<tr>
						<td>${pageCount -q +1}</td>
						<td class="L">
							<a href="03_view.do?seq=${list.seq}&board_name=${bean.board_name}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
								${list.title}
							</a>
						</td>
						<td>
							<c:if test="${list.re_com eq 'y' }"><span class="fc04">답변완료</span></c:if>
							<c:if test="${list.re_com ne 'y' }"><span class="fc02">답변중</span></c:if>
							
						</td>
						<td>${list.reg_date_user}</td>
					</tr>	
				</c:forEach>
				<c:if test="${empty list}">
					<tr><td colspan="4">등록된 문의가 없습니다.</td></tr>
				</c:if>
							
			</tbody>
		</table>
		<!-- //table -->
		
		<!-- btnarea -->
		<div class="btn_area03">
			<a href="03_write.do"><span class="cB h35">작성하기</span></a>
		</div>
		<!-- //btnarea -->
		
		<!-- paging -->
		${navi}
		<!-- //paging -->
		<!-- //본문내용 -->

	</div>
	<!-- // contents -->