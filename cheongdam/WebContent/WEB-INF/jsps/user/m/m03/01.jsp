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
			location.href='?sub_code='+$(this).val();
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
				<li class="sel"><a href="01.do">약속처방</a></li>
				<li><a href="02.do">약속처방 보관함</a></li>
				<li><a href="03.do">사전조제지시서</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->
	<!-- productsearch -->
	<div class="productsearch">
		<form action="" method="get" name="frm" id="frm">
			<div class="sel01">
				<ul>
					<li><a href="?"><span <c:if test="${empty bean.group_code}">class="sel"</c:if> >전체</span></a></li>
					<c:forEach var="list" items="${shop_code}">						
						<li><a href="?group_code=${list.group_code }"  ><span <c:if test="${bean.group_code eq list.group_code }">class="sel"</c:if>>${list.group_name }</span></a></li>
					</c:forEach>
					<li><a href="amount.do"><span class="pri">포인트구매</span></a></li>
					<li><a href="personal.do"><span class="pri">개인결제</span></a></li>
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
						<div class="productBox">
							<a href="01_view.do?p_seq=${list.p_seq}&page=${bean.page}&group_code=${bean.group_code}&sub_code=${bean.sub_code}&search_value=${bean.encodeSV}">
								<div class="imgA" style="height: 200px;">
										<img src="/upload/goods/${list.image}" alt="" style="height: 150px;" />
									<span>${list.p_name }</span>
								</div>
								<div class="txtA">
									<em><fmt:formatNumber value="${list.p_price}" pattern="#,###원" /></em>
									<div>
										<c:set var="yak_design1" value="${fn:split(list.yak_design1,'|')}" />
										<c:set var="yak_design2" value="${fn:split(list.yak_design2,'|')}" />
										<c:set var="yak_design3" value="${fn:split(list.yak_design3,'|')}" />
										<c:set var="yak_design4" value="${fn:split(list.yak_design4,'|')}" />
										<c:set var="yak_design5" value="${fn:split(list.yak_design5,'|')}" />
										<c:set var="yak_design6" value="${fn:split(list.yak_design6,'|')}" />
										<c:set var="yak_design7" value="${fn:split(list.yak_design7,'|')}" />
										<c:set var="yak_design8" value="${fn:split(list.yak_design8,'|')}" />
										<c:set var="yak_design9" value="${fn:split(list.yak_design9,'|')}" />
										<c:set var="yak_design10" value="${fn:split(list.yak_design10,'|')}" />
										<c:set var="yak_design11" value="${fn:split(list.yak_design11,'|')}" />
										<c:set var="yak_design12" value="${fn:split(list.yak_design12,'|')}" />
										<c:set var="yak_design13" value="${fn:split(list.yak_design13,'|')}" />
										<c:set var="yak_design14" value="${fn:split(list.yak_design14,'|')}" />
										<c:set var="yak_design15" value="${fn:split(list.yak_design15,'|')}" />
										<p><strong>처방구성</strong>
											${yak_design1[0]}  ${yak_design1[2]}<c:if test="${!empty yak_design1[2]}">g, </c:if> 
											${yak_design2[0]}  ${yak_design2[2]}<c:if test="${!empty yak_design2[2]}">g, </c:if> 
											${yak_design3[0]}  ${yak_design3[2]}<c:if test="${!empty yak_design3[2]}">g, </c:if> 
											${yak_design4[0]}  ${yak_design4[2]}<c:if test="${!empty yak_design4[2]}">g, </c:if> 
											${yak_design5[0]}  ${yak_design5[2]}<c:if test="${!empty yak_design5[2]}">g, </c:if> 
											${yak_design6[0]}  ${yak_design6[2]}<c:if test="${!empty yak_design6[2]}">g, </c:if> 
											${yak_design7[0]}  ${yak_design7[2]}<c:if test="${!empty yak_design7[2]}">g, </c:if> 
											${yak_design8[0]}  ${yak_design8[2]}<c:if test="${!empty yak_design8[2]}">g, </c:if> 
											${yak_design9[0]}  ${yak_design9[2]}<c:if test="${!empty yak_design9[2]}">g, </c:if> 
											${yak_design10[0]} ${yak_design10[2]}<c:if test="${!empty yak_design10[2]}">g, </c:if> 
											${yak_design11[0]} ${yak_design11[2]}<c:if test="${!empty yak_design11[2]}">g, </c:if> 
											${yak_design12[0]} ${yak_design12[2]}<c:if test="${!empty yak_design12[2]}">g, </c:if> 
											${yak_design13[0]} ${yak_design13[2]}<c:if test="${!empty yak_design13[2]}">g, </c:if> 
											${yak_design14[0]} ${yak_design14[2]}<c:if test="${!empty yak_design14[2]}">g, </c:if> 
											${yak_design15[0]} ${yak_design15[2]}<c:if test="${!empty yak_design15[2]}">g</c:if> 
										</p>
										<p>${list.p_bigo}</p>
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