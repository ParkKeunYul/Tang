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
<div id="container">
	<!-- contents -->
	<div id="contents">

		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>고객센터</span><span>공지사항</span></p>
		</div>

		<ul class="sub_Menu w33">
			<li class="sel"><a href="01.do">공지사항</a></li>
			<li><a href="02.do">이용안내</a></li>
			<li><a href="03.do">1:1문의</a></li>
		</ul>

		<div class="bannerArea mb20">
			<p class="ba03">
				<strong>공지사항게시판</strong>입니다. <br/>청담원외탕전실 관련 다양한 정보를 확인하세요.
			</p>
		</div>

		<!-- 본문내용 -->
		<div class="searchBox01">
			<form action="" method="get" name="frm" id="frm">
				<select name="search_title" id="search_title" style="width:100px;">
					<option value="title"    <c:if test="${bean.search_title eq 'title' }">selected="selected"</c:if>>제목</option>
					<option value="content"  <c:if test="${bean.search_title eq 'content' }">selected="selected"</c:if>>내용</option>
				</select>
				<input type="text" name="search_value" id="search_value" value="${bean.search_value}" style="width:200px;" />
				<a href="#" id="searchBoardBtn"><span class="h35 cgb">검색</span></a>
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
							<a href="01_view.do?seq=${list.seq}&board_name=${bean.board_name}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
								${list.title}
							</a>
							<c:if test="${not empty list.ori_name}">
								<img src="/assets/user/pc/images/common/icon_file.png" alt="" class="ifile" />
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
							<a href="01_view.do?seq=${list.seq}&board_name=${bean.board_name}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
								${list.title}
							</a>
							<c:if test="${not empty list.ori_name}">
								<img src="/assets/user/pc/images/common/icon_file.png" alt="" class="ifile" />
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

</div>
<!-- // container -->
		