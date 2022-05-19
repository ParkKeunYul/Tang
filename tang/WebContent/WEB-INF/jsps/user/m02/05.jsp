<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- container -->
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "탕전처방";
		String sec_nm = "탕전처방";
		String thr_nm = "사용설명서";
		int fir_n = 2;
		int sub_n = 5;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	
	<!-- contents -->
	<div id="contents">
		
		<!-- 내용 -->
		<div class="conArea">
			
			<!-- 처방하기-환자정보입력 -->
			<div class="div_tit">처방하기 - 환자정보입력</div>
			<div class="ac">
				<img src="/assets/user/images/sub/instruction01.jpg" alt="" />
				<img src="/assets/user/images/sub/instruction02.jpg" alt="" class="mt40" />
			</div>
			<!-- // 처방하기-환자정보입력 -->

			<!-- 처방하기-처방내용 -->
			<div class="div_tit mt70">처방하기 - 처방내용</div>
			<div class="ac">
				<img src="/assets/user/images/sub/instruction03.jpg" alt="" />
				<img src="/assets/user/images/sub/instruction04.jpg" alt="" class="mt40" />
				<img src="/assets/user/images/sub/instruction05.jpg" alt="" class="mt40" />
				<img src="/assets/user/images/sub/instruction06.jpg" alt="" class="mt40" />
			</div>
			<!-- // 처방하기-처방내용 -->
			
			<!-- 처방하기-처방내용 -->
			<div class="div_tit mt70">처방하기 - 옵션</div>
			<div class="ac">
				<img src="/assets/user/images/sub/instruction07.jpg" alt="" />
			</div>

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	