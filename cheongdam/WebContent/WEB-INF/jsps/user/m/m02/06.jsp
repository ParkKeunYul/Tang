<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	$(document).ready(function() {
		$("#searchBoardBtn").click(function() {
			$('#frm').submit();
		});
		
		$("#search_value").keydown(function(key) {
			if (key.keyCode == 13) {
				$('#frm').submit();
			}
		});
	});
</script>
<style>
	.lnbDepth ul li{
		width: 50%;
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
				<!-- <li><a href="/m/m05/02.do">장바구니</a></li> -->				
			</ul>
		</div>
	</div>
	<!-- LNB -->
	<!-- productsearch -->
	<div class="productsearch">
		<form action="" method="get" name="frm" id="frm">
			<div class="sel02">
				<select name="sub_code" id="sub_code"  style="width:100%;">
					<option value="" <c:if test="${empty bean.sub_code  }">selected="selected"</c:if>  >전체</option>
					<c:forEach var="list" items="${sub_code}">
						<option value="${list.seqno }" <c:if test="${bean.sub_code eq list.seqno }">selected="selected"</c:if> >${list.group_name }</option>
					</c:forEach>
				</select>
				<div>
					<span><input type="text" name="search_value" id="search_value" placeholder="검색어를 입력해주세요." title=" "  value="${bean.search_value}" style="width:90%;"></span>
					<button type="button" id="searchBoardBtn" class="btnTypeBasic colorDGreen"><span>검색</span></button>
				</div>
			</div>
		</form>
	</div>
	<!-- //productsearch -->

	<!-- 본문 -->
	<div class="contents" id="contents">
		<div class="productList">
			<ul>
				<c:forEach var="list" items="${list}">
					<li>
						<div class="productBox">
							<a href="06_view.do?seqno=${list.seqno}&page=${bean.page}&search_value=${bean.encodeSV}">
								<div class="imgA" style="height: 200px;">
										<img src="/upload/fast/${list.image1}" alt="" style="height: 150px;" onerror="this.src='/assets/user/m/images/no_image.png';" />
									<span>${list.tang_name }</span>
								</div>
								<div class="txtA">
									<em><fmt:formatNumber value="${list.price}" pattern="#,###원" /></em>
									<div>
										<p>
											<strong style="display: inline-block;">
												<c:choose>
													<c:when test="${list.c_tang_type eq 2}">무압력탕전</c:when>
													<c:when test="${list.c_tang_type eq 3}">압력탕전</c:when>
													<c:otherwise>첩약</c:otherwise>
												</c:choose>
											</strong>
											<c:if test="${list.c_tang_type ne 1}">
												<span style="color: red;">
													<c:if test="${list.c_tang_check eq 13}">(주수상반)</c:if>
													<c:if test="${list.c_tang_check eq 14}">(증류)</c:if>
													<c:if test="${list.c_tang_check eq 15}">(발효)</c:if>
													<c:if test="${list.c_tang_check eq 16}">(재탕)</c:if>
												</span>
											</c:if>
										</p>
										<p>${list.yakjae_u}</p>
									</div>
								</div>
							</a>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<!--  -->
		${navi}
		<!--  -->
	</div>
	<!-- //본문 -->

</div>
<!-- //container -->