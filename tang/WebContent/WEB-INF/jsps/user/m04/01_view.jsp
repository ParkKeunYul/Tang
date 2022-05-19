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
						<th class="subject" colspan="2"><c:if test="${view.notice_yn eq 'y'}">공지]</c:if>${view.title}</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>첨부파일</th>
						<td>
							<c:if test="${not empty view.ori_name1 }">
								<img src="/assets/user/images/common/icon_file.png" alt="" class="ifile" />
								<a onclick="downloadBoard('${view.ori_name1}', '${view.re_name1}', '${view.board_name}')"  href="#">${view.ori_name1}</a>
							</c:if>
							<c:if test="${not empty view.ori_name2 }">
								<img src="/assets/user/images/common/icon_file.png" alt="" class="ifile" />
								<a onclick="downloadBoard('${view.ori_name2}', '${view.re_name2}', '${view.board_name}')"  href="#">${view.ori_name2}</a>
							</c:if>
							<c:if test="${not empty view.ori_name3 }">
								<img src="/assets/user/images/common/icon_file.png" alt="" class="ifile" />
								<a onclick="downloadBoard('${view.ori_name3}', '${view.re_name3}', '${view.board_name}')"  href="#">${view.ori_name3}</a>
							</c:if>
						</td>
							
						<td>${view.reg_date_user}</td>
					</tr>
				</tbody>
			</table>
			<div class="table_con">${view.content}</div>
			<!-- //table -->
			
			<!-- btnarea -->
			<div class="btn_area02">
				<a href="01.do?page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}"><span class="cglay h40">목록보기</span></a>
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
									<a href="?board_name=${bean.board_name}&seq=${view.NEXT_SEQ}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
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
									<a href="?board_name=${bean.board_name}&seq=${view.PRE_SEQ}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
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

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
	
</div>
<!-- //container -->	