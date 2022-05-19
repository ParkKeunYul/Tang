<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta http-equiv="Expires" content="-1" /> 
	<meta http-equiv="Pragma" content="no-cache" /> 
	<meta http-equiv="Cache-Control" content="No-Cache" />
	<meta name="title" content="청담원외탕전" />
	<title>청담원외탕전</title>
	<link rel="stylesheet" type="text/css" href="/assets/user/m/css/public.css?" />
	<script type="text/javascript" src="/assets/user/m/js/lib/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="/assets/user/m/js/common_ui.js?222"></script>
	<script type="text/javascript" src="/assets/user/m/js/common.js"></script>
	<script type="text/javascript" src="/assets/admin/js/validation.js"></script>
</head>
<body>
<div class="wrapper">
	<!-- header -->
	<div class="headerWrapper" id="header">
		<h1 class="logo"><a href="#"><img src="/assets/user/m/images/logo_top.png" alt="청담원외탕전"></a></h1>
	</div>
	<!-- //header -->

	<!-- container -->
	<div class="container sub" id="contents">
		<!-- LNB -->
		<div class="localMenu">
			<p class="tit">최근 배송정보 검색</p>
		</div>
		<!-- LNB -->

		<script>
			$(document).ready(function() {
				
				$("#search_value").keydown(function(key) {
					if (key.keyCode == 13) {
						search();
					}
				});
				
				$("#searchBtn").click(function() {
					search();
					return false;
				});
				
				$("#searchBtnAll").click(function() {
					$('#search_value').val('');
					search();
					return false;
				});
				
				
				$(".btnOR").click(function() {
					console.log('111');
					var idx = $(this).attr('attr');
					
					
					var r_address01  = objToStr( $('#r_address01_'+idx).val() );
					var r_zipcode    = objToStr( $('#r_zipcode_'+idx).val() );
					var r_handphone  = objToStr( $('#r_handphone_'+idx).val() );
					var r_name       = objToStr( $('#r_name_'+idx).val() );
					var r_tel        = objToStr( $('#r_tel_'+idx).val() );
					var r_address02  = objToStr( $('#r_address02_'+idx).val() );
					
					
					console.log(r_zipcode);
					console.log(r_name);
					console.log(r_address01);
					$('#r_address01', opener.document).val( r_address01 );
					$('#r_zipcode' , opener.document).val( r_zipcode);
					$('#r_name', opener.document).val( r_name );
					
					if(r_handphone != ''){
						 var jbSplit = r_handphone.split('-');
						 $('#r_handphone01', opener.document).val( jbSplit[0] );
						 $('#r_handphone02', opener.document).val( jbSplit[1] );
						 $('#r_handphone03', opener.document).val( jbSplit[2] );
						console.log(111);
					}else{
						$('#r_handphone01', opener.document).val( '' );
						$('#r_handphone02', opener.document).val( '' );
						$('#r_handphone03', opener.document).val( '' );	
					}	
					
					if(r_tel != ''){
						 var jbSplit = r_tel.split('-');
						 $('#r_tel01', opener.document).val( jbSplit[0] );
						 $('#r_tel02', opener.document).val( jbSplit[1] );
						 $('#r_tel03', opener.document).val( jbSplit[2] );
							
					}else{
						$('#r_tel01', opener.document).val( '' );
						$('#r_tel02', opener.document).val( '' );
						$('#r_tel03', opener.document).val( '' );	
					}
					console.log(222);
					$('#r_address02', opener.document).val('');
					$("#r_address02", opener.document).focus();
					console.log(333);
					window.close();
					
					//return false;
				});
			});
				
			function search(){
				$('#frm').submit();
			}
		</script>

		<!-- 본문 -->
		<div class="contents" id="contents">
			<div class="delsearch">
				<form action="" method="get" name="frm" id="frm">
					<input type="hidden" name="search_title" value="r_name" />
					<span><input type="text" id="search_value" name="search_value" value="${bean.search_value}" placeholder="수취인명을 입력해주세요." title=" " style="width:70%;"></span>
					<div>
						<button type="button" id="searchBtn" class="btnTypeBasic colorBlack"><span>검색</span></button>
						<button type="button" id="searchBtnAll" class="btnTypeBasic colorDGreen"><span>전체보기</span></button>
					</div>
				</form>
			</div>
			<div class="delList">
				<c:forEach var="list" items="${list}">
					<c:set var="q" value="${q+1}"></c:set>
					<input type="hidden" id="r_address01_${q}" value="${list.r_address}" />
					<input type="hidden" id="r_zipcode_${q}" value="${list.r_zipcode}" />
					<input type="hidden" id="r_handphone_${q}" value="${list.r_handphone}" />
					<input type="hidden" id="r_name_${q}" value="${list.r_name}" />
					<input type="hidden" id="r_tel_${q}" value="${list.r_tel}" />
					<input type="hidden" id="r_address02_${q}" value="${list.r_address02}" />
					
					
					<div class="Listbox" >
						<p class="tit">${list.r_name} <a href="#"><span attr="${q}" class="btnOR">적용</span></a></p>
						<ul>
							<li>우:${list.r_zipcode})${list.r_address}</li>
							<c:if test="${not empty list.r_handphone}">
								<li>휴대폰 : ${list.r_handphone}</li>
							</c:if>
							<li>처방일 : ${list.order_date3}</li>
						</ul>
					</div>
				</c:forEach>
			</div>
			${navi}
		</div>
		<!-- //본문 -->

	</div>
	<!-- //container -->

	<!-- footer -->
	<div class="footerWrapper" id="footer">
		<footer>
			<h3>청담원외탕전</h3>
			<div class="innerBox">
				<p>사업자등록번호 : 000-00-0000 / 대표자 : 홍길동</p>
				<p>대표전화 : 054-123-4567 / 팩스번호 : 054-123-4567</p>
				<p>통신판매업신고번호 : 제 0000-0000-0000호</p>
				<p>결제은행: 농협은행 000-000000-00 홍길동(청담원외탕전) </p>
				<p>사업장 주소 : 경상북도 포항시 북구 장성동 1417-10</p>
				<p class="copyright">Copyright ⓒ 청담원외탕전 All rights reserved.</p>
			</div>
		</footer>
	</div>
	<!-- //footer -->
</div>
</body>
</html>