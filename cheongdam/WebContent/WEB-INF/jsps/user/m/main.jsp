<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<title>청담원외탕전1</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta http-equiv="Expires" content="-1" /> 
	<meta http-equiv="Pragma" content="no-cache" /> 
	<meta http-equiv="Cache-Control" content="No-Cache" />
	<link rel="stylesheet" type="text/css" href="/assets/user/m/css/public.css?111">
	<script type="text/javascript" src="/assets/user/m/js/lib/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="/assets/user/m/js/lib/plugins_with_sly.js"></script><!-- LNB 플러그인 -->
	<script type="text/javascript" src="/assets/user/m/js/lib/sly.js"></script><!-- LNB 플러그인 -->
	<script type="text/javascript" src="/assets/user/m/js/lib/owl.carousel.js"></script>
	<script type="text/javascript" src="/assets/user/m/js/common_ui.js?11221333"></script>
	<script type="text/javascript" src="/assets/user/m/js/common.js?22222222"></script>
</head>


<body>
	<div class="wrapper">
		<!-- header 시작 -->
		<%@include file="./layout/header.jsp" %>
		<!-- //header -->
	
		<!-- container -->
		<div class="container main" id="contents"><!-- 메인 .main -->
			<span class="hidden">본문시작</span>
	
			<div id="mainBanner" class="owl-carousel owl-theme">
				<span class="topBannerWrapper"><a href="#"><img src="/assets/user/m/images/rollimg02.png" alt=""></a></span>
				<span class="topBannerWrapper"><a href="#"><img src="/assets/user/m/images/rollimg01.png" alt=""></a></span>
			</div>
	
			<div class="mainMenuLink">
				<span class="mLink">
					<a href="/m/m05/03.do" class="req_login"><img src="/assets/user/m/images/icon01.png" alt="연합회"><strong>주문내역</strong></a>
					<a href="/m/m03/02.do" class="req_login"><img src="/assets/user/m/images/icon02.png" alt="교통정보"><strong>약속처방 보관함</strong></a>
					<a href="/m/m01/03.do"><img src="/assets/user/m/images/icon03.png" alt="직업정보"><strong>위치안내</strong></a>
				</span>
			</div>
	
			<div class="bannerarea">
				<p><img src="/assets/user/m/images/banner01.png" alt="" /></p>
				<p><img src="/assets/user/m/images/banner02.png" alt="" /></p>
			</div>
	
			<div class="productM">
				<div class="tit">
					cheongdam herb<span>청담원외탕전의 제품</span>
				</div>
				<ul>
					<c:forEach var="list" items="${goodslist}">
						<li><a href="/m/m03/01_view.do?p_seq=${list.p_seq}&page=1"><img src="/upload/goods/${list.image}" alt="" /><span>${list.p_name }</span></a></li>
					</c:forEach>
				</ul>
			</div>
	
			<div class="bannerarea">
				<p><img src="/assets/user/m/images/banner03.png" alt="" /></p>
			</div>
	
		</div>
		<!-- //container -->
	
		<!-- footer -->
		<%@include file="./layout/footer.jsp" %>
		<!-- //footer -->
	</div>
</body>
</html>