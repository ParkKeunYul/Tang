<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- container -->
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "원외탕전실 소개";
		String sec_nm = "원외탕전실 소개";
		String thr_nm = "찾아오시는 길";
		int fir_n = 1;
		int sub_n = 3;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	
	<!-- contents -->
	<div id="contents" class="p01">
		<!-- 내용 -->
		<div class="info03">
			<div class="txtare">
				<p class="tit02">(우 : 29056) 충북 옥천군 옥천읍 송신길 28 북경한의원 원외탕전실 <br/>고객센터 : 043.731.5075  /  팩스 : 043.731.5076</p>
			</div>
		</div>
		<!-- * 카카오맵 - 지도퍼가기 -->
		<!-- 1. 지도 노드 -->
		<div id="daumRoughmapContainer1577668998383" class="root_daum_roughmap root_daum_roughmap_landing" style="margin-top:50px;"></div>

		<!--
			2. 설치 스크립트
			* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
		-->
		<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

		<!-- 3. 실행 스크립트 -->
		<script charset="UTF-8">
			new daum.roughmap.Lander({
				"timestamp" : "1577668998383",
				"key" : "wf6p",
				"mapWidth" : "1100",
				"mapHeight" : "450"
			}).render();
		</script>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	