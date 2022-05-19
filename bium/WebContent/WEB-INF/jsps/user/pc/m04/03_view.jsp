<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

	<!-- contents -->
	<div class="contents">

		<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>1:1문의</span></p>
		<ul class="submenu w33">
			<li><a href="/m04/01.do" class="">공지사항</a></li>
			<li><a href="/m04/02.do" class="">이용안내</a></li>
			<li><a href="/m04/03.do" class="sel">1:1문의</a></li>
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
					<th class="subject" colspan="2"><c:if test="${view.notice_yn eq 'y'}">[공지] </c:if>${view.title}</th>
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
		<div class="table_con" style="min-height: 300px;">
			${view.content}
			
			<c:if test="${view.re_com eq 'y' }"><span class="fc04">답변완료</span>
				<div class="commentBox">
					<p class="tit">답변내용</p>
					${view.re_content}
				</div>
			</c:if>
		</div>
		<!-- //table -->
		
		<!-- btnarea -->
		<div class="btn_area02">
			<a href="03.do?page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}"><span class="cglay h40">목록보기</span></a>
		</div>
		<!-- //btnarea -->

		<!-- //본문내용 -->

	</div>
	<!-- // contents -->
		