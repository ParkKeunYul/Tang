<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="contents">

		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>청담원외탕전 소개</span><span>위치안내</span></p>
		</div>

		<ul class="sub_Menu w33">
			<li><a href="01.do">청담원외탕전 소개</a></li>
			<li ><a href="02.do">청담원외탕전의 약속</a></li>
			<li class="sel"><a href="03.do">위치안내</a></li>
		</ul>

		<!-- 본문내용 -->
		<!-- * 카카오맵 - 지도퍼가기 -->
		<!-- 1. 지도 노드 -->
		<div id="daumRoughmapContainer1578639411861" class="root_daum_roughmap root_daum_roughmap_landing"></div>

		<!--
			2. 설치 스크립트
			* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
		-->
		<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

		<!-- 3. 실행 스크립트 -->
		<script charset="UTF-8">
			new daum.roughmap.Lander({
				"timestamp" : "1578639411861",
				"key" : "wk2v",
				"mapWidth" : "920",
				"mapHeight" : "450"
			}).render();
		</script>
		<div class="map">
			<ul>
				<li><span>주소</span>(우 : 37588) 경상북도 포항시 북구 장량로 140번길 6 (장성동)</li>
				<li><span>전화</span>054-242-1079</li>
				<li><span>팩스</span>054-232-1079</li>
				<!--<li><span>입금계좌</span>농협은행 000-000000-00 홍길동(청담원외탕전)</li>-->
			</ul>
		</div>
		<!-- //본문내용 -->

	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		