<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!-- container -->
<link type="text/css" rel='stylesheet' href="/assets/user/js/_fancybox2.0/jquery.fancybox.css?v=2.1.4"  media="screen"/>
<link rel="stylesheet" type="text/css" href="/assets/user/js/_fancybox2.0/helpers/jquery.fancybox-buttons.css?v=1.0.5" />
<link rel="stylesheet" type="text/css" href="/assets/user/js/_fancybox2.0/helpers/jquery.fancybox-thumbs.css?v=1.0.7" />
<script type="text/javascript" src="/assets/user/js/_fancybox2.0/jquery.mousewheel-3.0.6.pack.js"></script>
<script type="text/javascript" src="/assets/user/js/_fancybox2.0/jquery.fancybox.js?v=2.1.4"></script>
<script>
var a_ajax_cart_flag = true;
	
	$(document).ready(function() {
		
		$("#saveOrderBtn").click(function() {
			var ea = parseInt($('#ea').val());
			
			if(ea <= 0){
				alert('최소 수량은 1개 이상이여야 합니다.');
				return false;
			}
			
			
			var url = $(this).attr('href');
			try{
				$.fancybox({
					'width'         : '789px',
					'height'        : '505px',
					/* 'width'         : '1400px',
					'height'        : '1200px', */
					'href'			: "/m03/amount_view_iframe.do?"+$('#frm').serialize(),
					'padding'		: '0',
					'margin'	    : 0,
					'transitionIn'	:	'elastic',
					'transitionOut'	:	'elastic',
					'type' 			: 	'iframe',
			//		'type' 			: 	'ajax',
					'scrolling'     : 'no',
					closeClick      : true
					/* ,afterClose  : function() { 
			            window.location.reload();
			        } */
				});
			}catch (e) {
				console.log(e);
				return false;
			}
			return false;
		});
		
		
		$("#ea").change(function() {
			var ea     = parseInt( $('#ea').val() );
			var price  = parseInt( $('#price').val());			
			
			$('.txt_num').text( comma( (ea * price)  ));
			
		});
	});
	function closeFancyBox(){
		console.log('closeFancyBox');
		$.fancybox.close();
	}
</script>
<div id="container">

	<!-- contents -->
	<div id="contents">
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>약속처방</span><span>약속처방</span></p>
		</div>

		<ul class="sub_Menu w33">
			<li class="sel"><a href="01.do">약속처방</a></li>
			<li><a href="02.do">약속처방 보관함</a></li>
			<li><a href="03.do">사전조제지시서 관리</a></li>
		</ul>

		<!-- 본문내용 -->
		<div class="product_view">
			<form action="/m03/amount_order" name="frm" id="frm" method="post" >
				<input type="hidden"  id="price" name="price" value="${view.price}"/>
				<input type="hidden"  id="seqno" name="seqno" value="${view.seqno}"/>
				<input type="hidden"  id="pre_seq" name="pre_seq" value="${view.pre_seq}"/>
				<input type="hidden" name="id"   value="${userInfo.id}" /><br/>
				
				<!-- 상단 상품정보 -->
				<div class="infoArea">
					<div class="imgArea" style="padding: 0;">
						<p><img src="/upload/amount/${view.image }" id="title_img" width="458" height="470" alt="" /></p>
					</div>
					
					<div class="product_info">
						<dl class="">
							<dt>상품명</dt>
							<dd class="name">${view.title}</dd>
							<dt>가격</dt>
							<dd class="name"><fmt:formatNumber value="${view.price}" pattern="#,### 원" /></dd>
							<dt>부여포인트</dt>
							<dd class="name"><fmt:formatNumber value="${view.point}" pattern="#,### 포인트" /></dd>
						</dl>
		
						<dl class="brnone" style="margin-bottom: 0px;">
							
							<dt>포인트 수량</dt>
							<dd>
								<select name="ea" id="ea" class="opt" style="width:80px;">
									<option value="0">0</option>	
									<c:forEach var="i" begin="1" end="100">
										<option value="${i}">${i}</option>
									</c:forEach>
								</select>
							</dd>
						</dl>
							
						
						<div class="sum_total" style="clear: both;border-top:1px solid #acacac;padding-top: 15px;">
							<span class="num"></span>
							<span></span>
							<em>총 상품금액</em>
							<strong class="total_price"><span class="txt_num" style="font-weight:bold;">0</span><span class="won">원</span>
							</strong>
						</div>
						
						<div class="btn_area"  style="clear: both;margin-top: 0px;border: none;">
							<a href="/m03/amount_view_iframe.do" id="saveOrderBtn"><span class="cg h352">즉시구매</span></a>
						</div>
							
					</div>
				</div>
				<!-- //상단 상품정보 -->
				<!-- 상품 상세정보 -->
				<div class="detailArea">
					<p class="tit"><img src="/assets/user/pc/images/sub/tit01.png" alt="상품정보" /></p>
					<div class="conB">
						${view.detail}
					</div>
				</div>
				<!-- //상품 상세정보 -->
			</form>
		</div>
		<!-- btnarea -->
		<div class="btn_area02">
			<a href="amount.do?seqno=${view.seqno}&page=${bean.page}&group_code=${bean.group_code}&sub_code=${bean.sub_code}&search_value=${bean.encodeSV}"><span class="cglay h40">목록보기</span></a>
		</div>
		<!-- //btnarea -->
		<!-- //본문내용 -->
	
	</div>
	<!-- // contents -->

</div>
<!-- // container -->

