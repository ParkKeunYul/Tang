<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/assets/user/js/jquery-ui-1.12.1/jquery-ui.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
.ui-datepicker{ font-size: 12px; width: 250px}
.ui-datepicker select.ui-datepicker-month{ width:40%; font-size: 11px; }
.ui-datepicker select.ui-datepicker-year{ width:40%; font-size: 11px; }
</style>
<script>

</script>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">주문내역</p>
		<div class="lnbDepth lnbDepth4">
			<ul>
				<li><a href="01.do">내 정보수정</a></li>
				<li><a href="03.do">주문내역</a></li>
				<li><a href="04.do" style="letter-spacing: -3px;">탕전공동사용계약서</a></li>
				<li class="sel"><a href="99.do" style="letter-spacing: -3px;">포인트사용내역</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->
	
	<style>
		.point_box{
			margin: 20px 0 25px;
		}
		
		.useable_point{
			border: 1px solid #adc1dd;
			background: #00b49c;
			padding: 12px 18px 26px;
		}
		
		.useable_point_title{
			font-size : 1.3em;
			line-height: 35px;
			font-weight: 700;
			color: white;
			text-align: center;
		}
		
		.useable_point_amount{
			position: relative;
		    display: table-cell;
		    width: 940px;
		    height: 62px;
		    padding-bottom: 1px;
		    border: 1px solid #cbdaef;
		    text-align: center;
		    font-size: 1.6em;
		    font-family: Dotum,"돋움";
		    line-height: 100%;
		    font-weight: 700;
		    color: #006bff;
		    background: #fff;
		    vertical-align: middle;
		}
		
		.useable_point_amount .amount{
			margin-top: 0;
		    font-size: 1.4em;
		    line-height: 30px;
		    vertical-align: middle;
		    width: 100%;
		
		}
	
	</style>
	<!-- 본문 -->
	<div class="contents" id="contents" style="padding-top: 0.5em;">
		<div class="point_box">
			<dl class="useable_point">
				<dt class="useable_point_title">
					사용가능한 포인트
				</dt>
				<dd class="useable_point_amount">
					<strong class="amount"><fmt:formatNumber value="${point_all.tot}" pattern="#,###" /></strong>
				</dd>
			</dl>
		</div>
				
		<!-- list -->
		<div class="board_list">
			<ul>
				<c:forEach var="list" items="${list}">
					<li>
						<span style="margin-top: 0rem;">
							내역 : <c:if test="${list.pp_seqno ne 0 }">${list.use_reason} 상품 결제</c:if>
							<c:if test="${list.pp_seqno eq 0 }">${list.reason}</c:if>
						</span>
						
						<c:choose>
							<c:when test="${list.point_type eq 'p' }">
								<span style="color: blue;display: inline-block;float: left;">+ <fmt:formatNumber value="${list.point}" pattern="#,###" /></span>
							</c:when>
							<c:otherwise>
								<span style="color: red;display: inline-block;float: left;">- <fmt:formatNumber value="${list.point}" pattern="#,###" /></span>
							</c:otherwise>
						</c:choose>
						<span style="display: inline-block;float: right;">사용일 : ${list.reg_date}</span>
						<span style="height: 1px;clear: both;"></span>
					</li>
				</c:forEach>
			</ul>
		</div>			
		<!-- //list -->
		${navi}

	</div>
	<!-- //본문 -->

</div>
<!-- //container -->
		