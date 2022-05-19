<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">공지사항</p>
		<div class="lnbDepth">
			<ul>
				<li class="sel"><a href="01.do">공지사항</a></li>
				<li><a href="02.do">이용안내</a></li>
				<li><a href="03.do">1:1문의</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<div class="contents" id="contents">
		<div class="commView">
			<h4>${view.title}</h4>
			<div class="dateInfo">
				<span><b>작성일 : </b><em>${view.reg_date_user}</em> <i>/</i> <b>조회수 : </b><em>${view.hit}</em></span>
			</div>
			<c:if test="${not empty view.ori_name }">
				<div class="fileInfo">
					<b>첨부파일</b>
					<ul>
						<c:if test="${not empty view.ori_name1 }">
							<li><a onclick="downloadBoard('${view.ori_name1}', '${view.re_name1}', '${view.board_name}')"  href="#">${view.ori_name1}</a></li>
						</c:if>
						<c:if test="${not empty view.ori_name2 }">
							<li><a onclick="downloadBoard('${view.ori_name2}', '${view.re_name2}', '${view.board_name}')"  href="#">${view.ori_name2}</a></li>
						</c:if>
						<c:if test="${not empty view.ori_name3 }">
							<li><a onclick="downloadBoard('${view.ori_name3}', '${view.re_name3}', '${view.board_name}')"  href="#">${view.ori_name3}</a>
						</c:if>
					</ul>
				</div>
			</c:if>
			<div class="textInfo">
				${view.content}
			</div>
			
			<div class="btnArea">
				<a href="01.do?page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}" class="btnTypeBasic colorGray"><span>목록보기</span></a>
			</div>
			<div class="prevNext">
				<p class="next">
					<b>다음글  </b>
					<c:choose>
						<c:when test="${not empty view.NEXT_SEQ}">
							<a href="?board_name=${bean.board_name}&seq=${view.NEXT_SEQ}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
								${view.NEXT_TITLE}
							</a>
						</c:when>
						<c:otherwise>
							<a href="#">다음글이 없습니다.</a>
						</c:otherwise>
					</c:choose>
				</p>
				<p class="prev">
					<b>이전글  </b>
					<c:choose>
						<c:when test="${not empty view.PRE_SEQ}">
							<a href="?board_name=${bean.board_name}&seq=${view.PRE_SEQ}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">
								${view.PRE_TITLE}
							</a>
						</c:when>
						<c:otherwise>
							<a href="#">이전글이 없습니다.</a>
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
	</div>
	<!-- //본문 -->

</div>
<!-- //container -->
