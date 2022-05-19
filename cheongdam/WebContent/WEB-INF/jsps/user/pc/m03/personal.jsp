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
<!-- container -->
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


		<div class="bannerArea">
			<p class="ba02">
				<strong>신규로 처방하실 때에는 <font class="fc01">'보관함 처방'</font>을 선택하시면 조제 후 보관함에 보관됩니다.</strong><br/>원장님들의 처방전에 근거하여 조제가 이루어 지며 '보관함 처방' 후 일정시간이 지나면 발송이 가능합니다.
			</p>
		</div>
		<!-- tabArea -->
		<div class="product_tab">
			<form action="/m03/01.do" method="get" name="frm" id="frm">
				<ul class="tab01">
					<li><a href="/m03/01.do" >전체</a></li>
					<c:forEach var="list" items="${shop_code}">						
						<li><a href="/m03/01.do?group_code=${list.group_code }" <c:if test="${bean.group_code eq list.group_code }">class="sel"</c:if> >${list.group_name }</a></li>
					</c:forEach>
					<li><a href="amount.do" class="special">포인트구매</a></li>
					<li><a href="personal.do" class="sel">개인결제</a></li>
				</ul>
				<ul class="tab02">
					<li><a href="/m03/01.do?sub_code=" <c:if test="${empty bean.sub_code  }">class="sel"</c:if>>전체</a></li>
					<c:forEach var="list" items="${sub_code}">						
						<li><a href="/m03/01.do?sub_code=${list.seqno }" <c:if test="${bean.sub_code eq list.seqno }">class="sel"</c:if> >${list.group_name }</a></li>
					</c:forEach>	
				</ul>
				<p class="fr">
					<input type="text" name="search_value" id="search_value" value="${bean.search_value}" placeholder="검색어를 입력하세요." style="width:200px;" /><a href="#" id="searchBoardBtn"><span class="h35 cB">검색</span></a>
				</p>
			</form>
		</div>
		<!-- //tabArea -->
		
		<div style="clear: both;"></div>
		<!-- 본문내용 -->
		<div class="product_list" style="clear: both;">
			<ul>
				<c:forEach var="list" items="${list}">
					<li>
						<a href="personal_view.do?seqno=${list.seqno}&page=${bean.page}">
							<div class="imgA">
								<c:if test="${list.pay_yn eq 'n' }">
									<span>${list.title}</span>
								</c:if>
								<c:if test="${list.pay_yn eq 'y' }">
									<span style="font-weight: 700;text-decoration: line-through;">${list.title}[결제완료]</span>
								</c:if>
								<img src="/assets/user/pc/images/sub/thum_none.png" alt="" />
							</div>
							<div class="txtA">
								<em <c:if test="${list.pay_yn eq 'y' }">style="text-decoration: line-through;color:red;"</c:if>>
									<fmt:formatNumber value="${list.price}" pattern="#,###원" />
								</em>
								<div>${list.CONTENT}</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<!-- paging -->
		${navi }
		<!-- //paging -->
		<!-- //본문내용 -->
		
	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		