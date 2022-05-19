<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!-- container -->

<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "원외탕전실 소개";
		String sec_nm = "원외탕전실 소개";
		String thr_nm = "원장님 인사말";
		int fir_n = 1;
		int sub_n = 1;
	%>
	<%@include file="../layout/submenu.jsp"%>
	
	<%-- <jsp:include page="../layout/submenu.jsp" flush="false">
		<jsp:param name="serverTime" value="111112222"></jsp:param>
	</jsp:include> --%>
	
	<!-- //submenuArea -->
	
	<!-- contents -->
	<div id="contents" class="p01">
		<!-- 내용 -->
		<div class="info01">
			<div class="txtare">
				<p class="tit01">“약은 <strong>정성</strong>입니다”</p>
				<p class="tit02">"동의보감"에서는 도라지 한뿌리도<br/>산삼을 다루듯 해야 악효가 빛을 발한다고 했습니다.</p>
				<p>첨단 기술력을 바탕으로 믿을 수 있는 약재 선별은 물론, 정성스런 마음까지 잊지 않겠습니다.</p>
			</div>
		</div>
		<div class="subtxt">
			<p>안녕하십니까.<br/>
			본 탕전실은 <strong>'깐깐한 약재선별', '믿음을 주는 한약 탕제'</strong>라는 슬로건 아래 좋은 품질의 GMP 약재 사용과 청결한 약재 관리를 원칙으로 좀 더 깨끗한 약재, 안심 할 수 있는 약재를 기본으로 사용하고 있습니다. <br/><br/>
			또한 공인된 시험기관으로부터 중금속과 이산화황 및 잔류농약성분 등을 정기적으로 검사하여 꾸준한 탕전 관리를 하고 있습니다. <br/><br/>
			저희 탕전실은 앞으로도 기본에 충실하며, 한방의 세계화와 우리 한방의 우수성이 널리 보급될 수 있도록 최선을 다해 약재관리와 탕전관리에 임하겠습니다. <br/><br/>
			감사합니다.</p>
			<p class="name">
				<img src="/assets/user/images/sub/name03.png" class="am pr40" alt="김보형" />
			</p>
		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	