<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link type="text/css" rel='stylesheet' href="/assets/user/js/_fancybox2.0/jquery.fancybox.css?v=2.1.4"  media="screen"/>
<link rel="stylesheet" type="text/css" href="/assets/user/js/_fancybox2.0/helpers/jquery.fancybox-buttons.css?v=1.0.5" />
<link rel="stylesheet" type="text/css" href="/assets/user/js/_fancybox2.0/helpers/jquery.fancybox-thumbs.css?v=1.0.7" />
<script type="text/javascript" src="/assets/user/js/_fancybox2.0/jquery.mousewheel-3.0.6.pack.js"></script>
<script type="text/javascript" src="/assets/user/js/_fancybox2.0/jquery.fancybox.js?v=2.1.4"></script>
<style>
.fancybox-close{
	top: 0px;
	right: 0px;
}


</style>
<script>
var a_ajax_cart_flag = true;
	
	$(document).ready(function() {
		
		$("#saveOrderBtn").click(function() {
			var ea = parseInt($('#ea').val());
			
			
			$('.headerWrapper').hide();
			
			$.fancybox({
				'width'         : $( window ).width()+'px',
				'height'        : $( window ).height()+'px',
				'href'			: "amount_view_iframe.do?"+$('#frm').serialize(),
				'padding'		: '0',
				'margin'	    : 0,
				'transitionIn'	:	'elastic',
				'transitionOut'	:	'elastic',
				'type' 			: 	'iframe',
				'scrolling'     : 'no',
				closeClick      : true ,
				afterClose: function() {
					$('.headerWrapper').show();
				}
			});
			
			
			
			return false;
		});
		
		
		init_img();
		
		$('.infoinner img').each(function () {
			var img=$(this);
			
			 var width  = img.width(); 
	         var height = img.height(); 
			 var div_width = $('.infoinner').width();
			 
			 if(width> div_width){
				 img.css('width', '99%');
			 }
			 
			 console.log(width , div_width);
	         
		});
	});
	
	
	function init_img(){
		var fir_img = $('#goods_img li:first a img').attr('src');
		$('#title_img').attr('src', fir_img);
	}
</script>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">약속처방</p>
		<div class="lnbDepth">
			<ul>
				<li class="sel"><a href="01.do">약속처방</a></li>
				<li><a href="02.do">약속처방 보관함</a></li>
				<li><a href="03.do">사전조제지시서</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->
	<form action="/m03/amount_order" name="frm" id="frm" method="post" >
		<input type="hidden"  id="price" name="price" value="${view.price}"/>
		<input type="hidden"  id="seqno" name="seqno" value="${view.seqno}"/>
		<input type="hidden"  id="pre_seq" name="pre_seq" value="${view.pre_seq}"/>
		<input type="hidden" name="id"   value="${userInfo.id}" /><br/>
		
		<!-- 본문 -->	
		<div class="contents" id="contents">
			<div style="min-height: 50px;">
				<div id="mainBanner" class="owl-carousel owl-theme">
					<c:if test="${not empty view.image }">
						<span class="topBannerWrapper"><img src="/upload/amount/${view.image}" alt="" /></span>
					</c:if>
				</div>
			</div>
			<!-- productView -->
			<div class="productView">
				<!-- inner -->
				<div class="inner">
					<!-- 상품정보 -->
					<ul class="infobox">
						<li>
							<label class="title">상품명</label>
							<p class="name">${view.title}</p>
						</li>
						<li>
							<label class="title">가격</label>
							<p><span class="won"><fmt:formatNumber value="${view.price}" pattern="#,###" /></span> 원</p>
						</li>
						<li>
							<label class="title">부여포인트</label>
							<p><span class="won" style="color: blue;"><fmt:formatNumber value="${view.point}" pattern="#,###" /></span> 포인트</p>
						</li>
						<li>
							<label class="title">수량</label>
							<select name="ea" id="ea" class="opt" style="width:80px;">
								<c:forEach var="i" begin="1" end="100">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>
						</li>
					</ul>
					<!-- //상품정보 -->
	
				
				</div>
				<!-- //inner -->
				<div class="btnArea view">
					<button type="button" id="saveOrderBtn" class="btnTypeBasic colorOrange" style="width: 99%;"><span>즉시구매</span></button>
				</div>
			</div>			
			<!-- productView -->
	
			
			<!-- productInfo -->
			<div class="productInfo">
				<p class="tit">상품정보</p>
				<div class="infoinner">
					${view.detail}
				</div>
			</div>
			<!-- //productInfo -->
			<div class="btnArea">
				<a href="amount.do?p_seq=${list.p_seq}&page=${bean.page}&group_code=${bean.group_code}&sub_code=${bean.sub_code}&search_value=${bean.encodeSV}" class="btnTypeBasic colorGray"><span>목록보기</span></a>
			</div>
		</div>
		<!-- //본문 -->
	</form>

</div>
<!-- //container -->