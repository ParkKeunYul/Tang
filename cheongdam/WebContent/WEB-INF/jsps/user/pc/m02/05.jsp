<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- container -->
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<div id="container">
	
	
	<!-- contents -->
	<div id="contents">
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>탕전처방</span><span>방제사전</span></p>
		</div>

		<ul class="sub_Menu w16">
			<li><a href="01.do">처방하기</a></li>
			<li><a href="06.do">실속처방</a></li>
			<li><a href="02.do">방제사전</a></li>
			<li><a href="03.do">포장보기</a></li>
			<li><a href="04.do">환경설정</a></li>
			<li  class="sel"><a href="05.do">사용 설명서</a></li>
		</ul>
		
		<!-- 내용 -->
		<div class="conArea">
			
			<!-- 처방하기-환자정보입력 -->
			<div class="div_tit">처방하기 - 환자정보입력</div>
			<div class="ac">
				<img src="/assets/user/pc/images/sub/instruction01.jpg" alt="" />
				<img src="/assets/user/pc/images/sub/instruction02.jpg" alt="" class="mt40" />
			</div>
			<!-- // 처방하기-환자정보입력 -->

			<!-- 처방하기-처방내용 -->
			<div class="div_tit mt70">처방하기 - 처방내용</div>
			<div class="ac">
				<img src="/assets/user/pc/images/sub/instruction03.jpg" alt="" />
				<img src="/assets/user/pc/images/sub/instruction04.jpg" alt="" class="mt40" />
				<img src="/assets/user/pc/images/sub/instruction05.jpg" alt="" class="mt40" />
				<img src="/assets/user/pc/images/sub/instruction06.jpg" alt="" class="mt40" />
			</div>
			<!-- // 처방하기-처방내용 -->
			
			<!-- 처방하기-처방내용 -->
			<div class="div_tit mt70">처방하기 - 옵션</div>
			<div class="ac">
				<img src="/assets/user/pc/images/sub/instruction07.jpg" alt="" />
			</div>

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	