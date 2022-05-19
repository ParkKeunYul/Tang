<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
<!--
	2. 설치 스크립트
	* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
-->
<script charset="UTF-8">
$(document).ready(function() {
	new daum.roughmap.Lander({
		"timestamp" : "1612760250588",
		"key" : "24c66",
		"mapWidth" : "990",
		"mapHeight" : "450"
	}).render();
});
	
</script>
<!-- contents -->
<div class="contents">
	<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>비움환원외탕전 위치안내</span></p>
	<ul class="submenu w33">
		<li><a href="01.do">비움환 원외탕전소개</a></li>
		<li><a href="03.do">시설안내</a></li>
		<li><a href="02.do" class="sel">위치안내</a></li>
	</ul>
	<!-- * 카카오맵 - 지도퍼가기 -->
	<!-- 1. 지도 노드 -->
	<div id="daumRoughmapContainer1612760250588" class="root_daum_roughmap root_daum_roughmap_landing"></div>

	<div class="mapinfo">
		<p class="tit">비움환원외탕전</p>
		<ul>
			<li><span class="w80"><strong>주소</strong></span>부산광역시 강서구 대저중앙로 172번길 20, 비움환원외탕전<br/></li>
			<li><span class="w80"><strong>전화</strong></span>051-941-5104 <span class="w80 ac">/</span> <span class="w80"><strong>팩스</strong></span>051-941-5103</li>
		</ul>
	</div>
</div>
<!-- //contents -->
	