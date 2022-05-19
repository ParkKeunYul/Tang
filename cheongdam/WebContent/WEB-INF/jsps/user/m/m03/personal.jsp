<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script>
	$(document).ready(function() {
		$(".not_join").click(function() {
			alert('처방 가능한 상태가 아닙니다.');
			return false;
		});
		
		$("#searchBoardBtn").click(function() {
			$('#frm').submit();
		});
		
		$("#search_value").keydown(function(key) {
			if (key.keyCode == 13) {
				$('#frm').submit();
			}
		});
		
		$("#sub_code").change(function() {
			location.href='/m/m03/01.do?sub_code='+$(this).val();
		});
	});
</script>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">약속처방</p>
		<div class="lnbDepth">
			<ul>
				<li class="sel"><a href="/m/m03/01.do">약속처방</a></li>
				<li><a href="/m/m03/02.do">약속처방 보관함</a></li>
				<li><a href="/m/m03/03.do">사전조제지시서</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->
	<!-- productsearch -->
	<div class="productsearch">
		<form action="" method="get" name="frm" id="frm">
			<div class="sel01">
				<ul>
					<li><a href="/m/m03/01.do"><span >전체</span></a></li>
					<c:forEach var="list" items="${shop_code}">						
						<li><a href="/m/m03/01.do?group_code=${list.group_code }"  ><span <c:if test="${bean.group_code eq list.group_code }">class="sel"</c:if>>${list.group_name }</span></a></li>
					</c:forEach>
					<li><a href="amount.do"><span class="pri">포인트구매</span></a></li>
					<li><a href="personal.do"><span class="sel">개인결제</span></a></li>
				</ul>
			</div>
			
			<div class="sel02">
				<select name="sub_code" id="sub_code"  style="width:100%;">
					<option value="" <c:if test="${empty bean.sub_code  }">selected="selected"</c:if>  >전체</option>
					<c:forEach var="list" items="${sub_code}">
						<option value="${list.seqno }" <c:if test="${bean.sub_code eq list.seqno }">selected="selected"</c:if> >${list.group_name }</option>
					</c:forEach>
				</select>
				<div>
					<span><input type="text" name="search_value" id="search_value" placeholder="검색어를 입력해주세요." title=" " style="width:90%;"></span>
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
						<a href="personal_view.do?seqno=${list.seqno}&page=${bean.page}">
							<div class="imgA">
								<c:if test="${list.pay_yn eq 'n' }">
									<span>${list.title}</span>
								</c:if>
								<c:if test="${list.pay_yn eq 'y' }">
									<span <c:if test="${list.pay_yn eq 'y' }">style="font-weight: 700;text-decoration: line-through;"</c:if>>${list.title}[결제완료]</span>
								</c:if>
								<img src="/assets/user/m/images/thum_none.png" width="162" height="150" alt="" />
							</div>
							<div class="txtA">
								<em <c:if test="${list.pay_yn eq 'y' }">style="text-decoration: line-through;color:red;"</c:if> ><fmt:formatNumber value="${list.price}" pattern="#,###원" /></em>
								<div <c:if test="${list.pay_yn eq 'y' }">style="font-weight: 700;text-decoration: line-through;"</c:if> >${list.CONTENT}</div>
							</div>
						</a>
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