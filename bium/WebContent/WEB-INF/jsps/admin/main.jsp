<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<meta http-equiv="Expires" content="-1"> 
	<meta http-equiv="Pragma" content="no-cache"> 
	<meta http-equiv="Cache-Control" content="No-Cache">
	<title>원외탕전 관리자 메인</title>
	<link rel="stylesheet" href="/assets/admin/css/admin.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
	<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
	
	
	<script  src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="/assets/admin/js/jquery/jquery.ui.datepicker-ko.js"></script>
	
 	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>		
	<script type="text/javascript" src="/assets/admin/js/setting.js"></script>
	<script type="text/javascript" src="/assets/admin/js/validation.js"></script>
	
	<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<body>
<% 
 response.setHeader("Cache-Control","no-cache"); 
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0); 
%>
<jsp:useBean id="toDay" class="java.util.Date" />
<div style="display: none;">
	<fmt:formatDate value="${toDay}" pattern="yyyyMMddHHmmss" />
</div>
<script type="text/javascript" src="/assets/admin/js/z_main.js?${toDay}"> </script>
<style>
	h2.menuTab{
		position: relative;
	}
	
	h2.menuTab .title{
		display : inline-block;
		color: #fff;
		background: #3b579d;
		padding: 10px 15px;		
		/* text-align: center; */
		border-top-left-radius : 10px;
		border-top-right-radius : 10px;
	}
	
	h2.menuTab a{
		position: absolute;
		right: 0px;
		color: blue;
		top : 10px;	
	}
	
	h2.menuTab a:hover{
		text-decoration: none;
	}
</style>

<div id="warp">
	<div id="headerWr">
		<div class="header">
			<h2>
				<a href="/admin/main.do" style="color: #fff;">관리자</a>
				<a href="/admin/logout.do"  style="color: #fff;">[로그아웃]</a>
			</h2>
			<ul class="gnb">		
				<li><a href="/admin/base/manage/list.do">기본관리</a></li>
				<li><a href="/admin/delivery/base/list.do">택배관리</a></li>
				<li><a href="/admin/order/shop/list.do">주문관리</a></li>
				<li><a href="/admin/item/goods/list.do">아이템관리</a></li>
				<li><a href="/admin/board/notice/list.do">게시판 관리</a></li>
			</ul>
		</div>
	</div>
	
	<div id="container" style="">
		<div class="order_cnt">
			<c:set var="now" value="<%=new java.util.Date()%>" />
			<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일" /></c:set>
			<c:out value="${sysYear}" /> 주문현황
			<!-- 2019년 07월 21일 탕전 주문현황 -->
		</div>
	
		<div class="shop"  style="padding: 10px 15px 0 15px;">
			<h2 class="mtit"><span>&sdot; 약속처방 주문내역</span><a href="/admin/order/shop/list.do">더보기</a></h2>
			<table id="shopGrid"></table>					
			<div id="shop_form"></div>
		</div>
		
		<div class="resent"  style="padding: 10px 15px 0 15px;">
			<ul>
				<li style="float: left;width: 50%;">
					<div style="padding: 5px;">
						<h2 class="mtit"><span>&sdot; 최근 가입회원</span><a href="/admin/base/member/list.do">더보기</a></h2>
						<div id="memberForm"></div>
						<table id="memberGrid"></table>
					</div>
					
				</li>
				<li style="float: left;width: 50%;">
					<div style="padding: 5px 0 0 20px;">
						<h2 class="mtit"><span>&sdot; 최근 문의사항</span><a href="/admin/board/qna/list.do">더보기</a></h2>
						<div id="qnaForm"></div>
						<table id="qnaGrid"></table>
					</div>
				</li>
				<li style="clear: both;"></li>
			</ul>
		</div>
	</div>

	<div id="footerWr">
		<div id="footer">
			COPYRIGHT(C) 2019 관리자. ALL RIGHTS RESERVED.
		</div>
	</div>
</div>
</body>
</html>