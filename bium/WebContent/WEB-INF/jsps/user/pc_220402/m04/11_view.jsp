<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

	<!-- contents -->
	<div class="contents">

		<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>비움환 자료실</span></p>
		<ul class="submenu w50">
			<li><a href="/m04/11.do" class="sel">비움환 자료실</a></li>
			<li><a href="/m04/12.do" class="">치험례 · 논문</a></li>
		</ul>

		<!-- 본문내용 -->
		<!-- table -->
		<table class="basic_view">
			<colgroup>
				<col width="120px" />
				<col width="*" />
				<col width="120px" />
			</colgroup>
			<thead>
				<tr>
					<th>제목</th>
					<th class="subject" colspan="2"><c:if test="${view.notice_yn eq 'y'}">[공지] </c:if>
						<c:choose>
							<c:when test="${view.cate_nm eq 1 }">[ 통계자료  ] </c:when>
							<c:when test="${view.cate_nm eq 2 }">[ 비만자료  ] </c:when>
							<c:when test="${view.cate_nm eq 3 }">[ 비움환처방  ] </c:when>
							<c:otherwise>[ 기타 ] </c:otherwise>
						</c:choose>
						${view.title}
					</th>
				</tr>
				
			</thead>
			<tbody>
				<c:if test="${not empty view.ori_name1 ||  not empty view.ori_name2 || not empty view.ori_name3}">
					<tr>
						<th>첨부파일</th>
						<td>
							<c:if test="${not empty view.ori_name1 }">
								<img src="/assets/user/pc/images/icon_file.png" alt="" class="ifile" /><a onclick="downloadBoard('${view.ori_name1}', '${view.re_name1}', '${view.board_name}')"  href="#">${view.ori_name1}</a><br/>
							</c:if>
							<c:if test="${not empty view.ori_name2 }">
								<img src="/assets/user/pc/images//icon_file.png" alt="" class="ifile" /><a onclick="downloadBoard('${view.ori_name2}', '${view.re_name2}', '${view.board_name}')"  href="#">${view.ori_name2}</a><br/>
							</c:if>
							<c:if test="${not empty view.ori_name3 }">
								<img src="/assets/user/pc/images//icon_file.png" alt="" class="ifile" /><a onclick="downloadBoard('${view.ori_name3}', '${view.re_name3}', '${view.board_name}')"  href="#">${view.ori_name3}</a>
							</c:if>
						</td>
						<td>${view.reg_date_user}</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<div class="table_con" style="min-height: 300px;">${view.content}</div>
		<!-- //table -->
		
		<!-- btnarea -->
		<div class="btn_area02">
			<a href="11.do?page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}&search_cate=${bean.search_cate}"><span class="cglay h40">목록보기</span></a>
		</div>
		<!-- //btnarea -->

		<!-- 이전글다음글 -->
		<table class="basic_pre">
			<colgroup>
				<col width="130px" />
				<col width="*" />
				<col width="120px" />
			</colgroup>
			<tbody>
				<tr>
					<th class="next">다음글</th>
					<c:choose>
						<c:when test="${not empty view.NEXT_SEQ}">
							<td>
								<a href="?board_name=${bean.board_name}&seq=${view.NEXT_SEQ}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}&search_cate=${bean.search_cate}">
									${view.NEXT_TITLE}
								</a>
							</td>
							<td>${view.NEXT_REG}</td>	
						</c:when>
						<c:otherwise>
							<td>다음글이 없습니다.</td>
							<td>-</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<th class="pre">이전글</th>
					<c:choose>
						<c:when test="${not empty view.PRE_SEQ}">
							<td>
								<a href="?board_name=${bean.board_name}&seq=${view.PRE_SEQ}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}&search_cate=${bean.search_cate}">
									${view.PRE_TITLE}
								</a>
							</td>
							<td>${view.PRE_REG}</td>	
						</c:when>
						<c:otherwise>
							<td>이전글이 없습니다.</td>
							<td>-</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</tbody>
		</table>
		<!-- //이전글다음글 -->
		<!-- //본문내용 -->

	</div>
	<!-- // contents -->
		