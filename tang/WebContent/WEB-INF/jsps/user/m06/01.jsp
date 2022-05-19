<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!-- container -->

<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "회원가입";
		String sec_nm = "회원가입";
		String thr_nm = "회원구분";
		int fir_n = 6;
		int sub_n = 1;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	<!-- contents -->
	<div id="contents">
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit">회원구분</p>
			<p>정성탕전 회원가입을 진심으로 환영합니다.<br/><span>이 사이트는 한의사 및 한방의료기관을 위해 전문서비스를 제공하고 있습니다. 따라서 일반인은 이용하실 수 없습니다.</span><br/>
			정성탕전 회원으로 <strong>가입하실 유형을 아래에서 선택</strong>하여 주세요.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">

			<div class="join01">
				<ul>
					<a href="01_step1_1.do">
						<li class="bg01">
							<span>의료기관</span>한의원(개원의)<br/>병원(요양병원, 한방병원), 보건소
						</li>
					</a>
					<a href="01_step1_2.do">
						<li class="bg02">
							<span>한의사</span>미개원의<br/>한의대(한의전) 졸업생
						</li>
					</a>
				</ul>
			</div>

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	