<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
var a_ajax_cart_flag = true;

$(document).ready(function() {
	
	
	$("#saveCartBtn").click(function() {
		
		$('#frm').submit();
	});
});
</script>
<style>
	.lnbDepth ul li{
		width: 50%;
	}
	
	.productView .inner ul li label.title{
		width: 33%;
	}
	
	.productView .inner ul li label.title{
		width: 70px;
	}	
</style>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">탕전처방</p>
		<div class="lnbDepth">
			<ul>
				<li class="sel" style="width: 100%;"><a href="/m/m02/06.do">실속처방</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->
	<form action="/m/m02/06_add_order.do" name="frm" id="frm" method="post" >
		<input type="hidden"  id="price" name="price" value="${view.price}"/>
		<input type="hidden"  id="seqno" name="seqno" value="${view.seqno}"/>
		<input type="hidden"  id="page" name="page" value="${bean.page}"/>
		
		<!-- 본문 -->	
		<div class="contents" id="contents">
			<div style="min-height: 10px;">
				<div id="mainBanner" class="owl-carousel owl-theme">
					<c:if test="${not empty view.image1 }">
						<span class="topBannerWrapper"><img src="/upload/fast/${view.image1}" alt="" /></span>
					</c:if>
					<c:if test="${not empty view.image2 }">
						<span class="topBannerWrapper"><img src="/upload/fast/${view.image2}" alt="" /></span>
					</c:if>
					<c:if test="${not empty view.image3 }">
						<span class="topBannerWrapper"><img src="/upload/fast/${view.image3}" alt="" /></span>
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
							<label class="title">처방명</label>
							<p class="name">${view.tang_name}</p>
						</li>
						<!-- 
						<li style="">
							<label class="title">탕전방식</label>
							<p>
								<c:choose>
									<c:when test="${view.c_tang_type eq 2}">무압력탕전</c:when>
									<c:when test="${view.c_tang_type eq 3}">압력탕전</c:when>
									<c:otherwise>첩약</c:otherwise>
								</c:choose>
								<c:if test="${view.c_tang_type ne 1}">
									<span style="color: red;">
										<c:if test="${view.c_tang_check eq 13}">(주수상반)</c:if>
										<c:if test="${view.c_tang_check eq 14}">(증류)</c:if>
										<c:if test="${view.c_tang_check eq 15}">(발효)</c:if>
										<c:if test="${view.c_tang_check eq 16}">(재탕)</c:if>
									</span>
								</c:if>
							</p>
						</li>
						 -->
						<li style="width: 50%;float: left;">
							<label class="title">첩수</label>
							<p>${view.c_chup_ea}첩</p>
						</li>
						<li style="<c:if test="${view.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
							<label class="title">파우치</label>
							<p>${view.c_pouch_type_nm}</p>
						</li>
						<li style="<c:if test="${view.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
							<label class="title">박스</label>
							<p>${view.c_box_type_nm}</p>
						</li>
						<!-- 
						<li style="<c:if test="${view.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
							<label class="title">스티로폼</label>
							<p>${view.c_stpom_type_nm}</p>
						</li>
						 -->
						<li style="<c:if test="${view.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
							<label class="title">팩용량</label>
							<p>${view.c_pack_ml}ml</p>
						</li>
						<li style="<c:if test="${view.c_tang_type eq 1}">display: none;</c:if>width: 50%;float: left;">
							<label class="title">팩수</label>
							<p>${view.c_pack_ea}</p>
						</li>
						<li style="clear: both;height: 1px;margin-bottom: 0px;"></li>
						<li style="width: 50%;float: left;">
							<label class="title">처방비용</label>
							<p><span class="won"><fmt:formatNumber value="${view.price}" pattern="#,###" /></span><span style="font-size: 12px;">원</span></p>
						</li>
						<c:if test="${view.sale_per > 0}">
							<li style="width: 50%;float: left;">
								<label class="title">할인금액</label>
								<p><span class="won"><fmt:formatNumber value="${view.sale_price}" pattern="#,###" /></span><span style="font-size: 12px;">원</span></p>
							</li>
							<li style="clear: both;">
								<label class="title">총금액</label>
								<p><span class="won"><fmt:formatNumber value="${view.price - view.sale_price}" pattern="#,###" /></span><span style="font-size: 12px;">원</span></p>
							</li>
						</c:if>
						<li style="clear: both;height: 1px;margin-bottom: 0px;"></li>
					</ul>
					
					<!-- //상품정보 -->
	
					<!-- 처방정보 -->
					<ul class="countbox"></ul>
					<!-- //처방정보 -->
				</div>
				<!-- //inner -->
				<div class="btnArea view">
					<c:if test="${userInfo.member_level ne 0 && userInfo.member_level ne 1 }">
						<button type="button" id="saveCartBtn" class="btnTypeBasic colorGreen" style="width: 99%;"><span>즉시구매</span></button>
					</c:if>
				</div>
			</div>			
			<!-- productView -->
	<!-- 한해림 농협 241061-52-191288 -->
			
			<!-- productInfo -->
			<div class="productInfo">
				<p class="tit">처방 정보</p>
				<div class="infoinner">
					<ul style="margin-bottom: 5px;margin-left: 10px;">
						<c:if test="${! empty  ylist}">
							<li style="">
								<span style="display: inline-block;width: 45%;font-weight: 700;">약초명</span> 
								<span style="display: inline-block;width: 26%;font-weight: 700;">원산지</span>
								<span style="display: inline-block;width: 22%;font-weight: 700;text-align: right;">1첩조제량</span>							 
							</li>
						</c:if>
					</ul>
					<ol style="list-style: decimal;margin-left: 10px;">
						<c:forEach var="list" items="${ylist}">
							<li style="">
								<span style="display: inline-block;width: 45%;">${list.yak_name}</span> 
								<span style="display: inline-block;width: 26%;">${list.yak_from}</span>
								<span style="display: inline-block;width: 22%;text-align: right;">${list.my_joje}g</span>							 
							</li>
						</c:forEach>
					</ol>
					<div style="padding-bottom: 20px;"></div>
					${view.p_contents}
				</div>
			</div>
			<!-- //productInfo -->
			<div class="btnArea">
			
				<a href="06.do?p_seq=${list.p_seq}&page=${bean.page}&group_code=${bean.group_code}&sub_code=${bean.sub_code}&search_value=${bean.encodeSV}" class="btnTypeBasic colorGray"><span>목록보기</span></a>
			</div>
		</div>
		<!-- //본문 -->
	</form>

</div>
<!-- //container -->