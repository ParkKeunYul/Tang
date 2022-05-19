<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>	
	<title>청담원외탕전</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta http-equiv="Expires" content="-1" /> 
	<meta http-equiv="Pragma" content="no-cache" /> 
	<meta http-equiv="Cache-Control" content="No-Cache" />
	<meta name="title" content="청담원외탕전" />
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/style.css?${menu.pp}" />
	<link rel="stylesheet" type="text/css" href="/assets/user/js/jquery-ui-1.12.1/jquery-ui.css" />
	
	<script  src="https://code.jquery.com/jquery-1.12.4.js" ></script>
		
	
	<script type="text/javascript" src="/assets/user/pc/js/common.js?${menu.pp}11" ></script>
	<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>
	<script type="text/javascript" src="/assets/admin/js/validation.js"></script>
	<script  src="/assets/user/js/jquery.bpopup.min.js"></script>
	<!--[if lte IE 9]>
	<style type=text/css>
	       html{
	           overflow: hidden;
	           height: 100%;    
	       }
	       body{
	           overflow: auto;
	           height: 100%;
	       }
	    </style>
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/swiper.min.css?${menu.pp }" />
	<script src="/assets/user/pc/js/swiper.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		new Swiper('.swiper1', {
			autoplay: {
				delay: 5000,
				disableOnInteraction: false,
			},
			slidesPerView: 1,
			loop: true,
			pagination: {
				el: '.swiper-pagination',
				clickable: true,
			},
			navigation: {
				nextEl: '.swiper-button-next',
				prevEl: '.swiper-button-prev',
			}
		});
	});
	</script>
	<style>
		.swiper-container-horizontal>.swiper-pagination-bullets, .swiper-pagination-custom, .swiper-pagination-fraction{
			bottom : 3px;
		}
	
	</style>
</head>
<body>
<div id="wrap">
	<t:insertAttribute name="header" />
	
	<t:insertAttribute name="body" />
	
	<t:insertAttribute name="footer" />		
</div>

<!-- 배너 추가 작업 200527 -->

<c:if test="${not empty bannerList }">
	<div class="swiper-container swiper1">
		<div class="swiper-wrapper">
			<c:forEach var="list" items="${bannerList}">
				<c:choose>
					<c:when test="${list.target ne 'Y' }">
						<div class="swiper-slide"><a href="http://${list.link}" target="_blank"><img src='/upload/banner/${list.re_name}' width='240px;' height='410px;' alt="${list.title}" /></a></div>
					</c:when>
					<c:otherwise>
						<div class="swiper-slide"><a href="http://${list.link}"><img src='/upload/banner/${list.re_name}' width='240px;' height='410px;' alt="${list.title}" /></a></div>	
					</c:otherwise>
				</c:choose>
			</c:forEach>			
		</div>
		<div class="swiper-pagination"></div>
	</div>
</c:if>


<!--// 배너 추가 작업 -->
</body>
</html>