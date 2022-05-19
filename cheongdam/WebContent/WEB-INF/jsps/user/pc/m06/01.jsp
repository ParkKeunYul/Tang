<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

	<%@include file="../layout_mem/top.jsp" %>
		<div class="banner">
			<h3>로그인</h3>
			<p class="txtarea"><strong>청담원외탕전에 방문해주셔서 감사합니다.</strong><br/>회원가입을 거쳐 로그인을 하시면 청담원외탕전의 모든 메뉴를 사용하실 수 있습니다.</p>
		</div>

		<!-- 본문내용 -->
		<div class="join01 pt60">
			<ul>
				<a href="01_step1_1.do">
					<li class="bg01">
						<span>의료기관</span>
						<span class="bline"></span>
						한의원(개원의)<br/>병원(요양병원, 한방병원), 보건소
					</li>
				</a>
				<a href="01_step1_2.do">
					<li class="bg02">
						<span>한의사</span>
						<span class="bline"></span>
						미개원의
					</li>
				</a>
			</ul>
		</div>
		<!-- //본문내용 -->

	</div>
	<!-- // joinArea -->
	<!-- footer -->
	<%@include file="../layout_mem/footer.jsp" %>
	<!-- //footer -->
</div>
</body>
</html>
		