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

		<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>치험례 · 논문</span></p>
		<ul class="submenu w50">
			<li><a href="/m04/11.do" >비움환 자료실</a></li>
			<li><a href="/m04/12.do" class="sel">치험례 · 논문</a></li>
		</ul>


		<!-- 본문내용 -->
		<div class="searchBox01">
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
		<!-- table -->
		<table class="basic_list">
			<colgroup>
				<col width="70px" />
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
				<c:forEach var="list" items="${nlist}">
					<tr>
						<td>공지</td>
						<td class="L top">
							<a href="12_view.do?seq=${list.seq}&board_name=${bean.board_name}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
								${list.title}
							</a>
							<c:if test="${not empty list.ori_name1}">
								<img src="/assets/user/pc/images/icon_file.png" alt="" class="ifile" />
							</c:if>
						</td>
						<td>${list.reg_date_user}</td>
					</tr>	
				</c:forEach>
			
				<c:forEach var="list" items="${list}">
					<c:set var="q" value="${q+1}"></c:set>
					<tr>
						<td>${pageCount -q +1}</td>
						<td class="L">
							<a href="12_view.do?seq=${list.seq}&board_name=${bean.board_name}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
								${list.title}
							</a>
							<c:if test="${not empty list.ori_name1}">
								<img src="/assets/user/pc/images/icon_file.png" alt="" class="ifile" />
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
		<!-- //본문내용 -->

	</div>
	<!-- // contents -->