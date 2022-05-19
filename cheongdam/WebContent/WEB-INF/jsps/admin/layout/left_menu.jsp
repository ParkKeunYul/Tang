<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<p>${adminInfo.a_name}님 방문을 환영합니다.<br/><a href="/admin/logout.do">로그아웃</a></p>
<%-- ${adminInfo} --%>
<ul class="leftMenu">
	<!-- <li class="act"><a href="#">소중한 추억</a></li> -->
	<c:if test="${menu.fmenu eq 1}">
		<li><a href="/admin/base/manage/list.do">관리자 관리</a></li>
		<li><a href="/admin/base/popup/all/list.do">팝업 관리</a></li>
		<li><a href="/admin/base/popup/indi/list.do">개인 팝업 관리</a></li>
		<!-- <li><a href="/admin/base/popup/not/list.do">미개원의 팝업 관리</a></li> -->
		<li><a href="/admin/base/login/list.do">최근 로그인정보</a></li>
		<li><a href="/admin/base/member/list.do">회원관리</a></li>
		<li><a href="/admin/base/member/outlist.do">탈퇴회원관리</a></li>
		<li><a href="/admin/base/memGrade/list.do">회원등급별 설정</a></li>
		<li><a href="/admin/base/memGroup/list.do">회원그룹 관리</a></li>
	</c:if>
	
	<c:if test="${menu.fmenu eq 2}">
		<li><a href="/admin/delivery/base/list.do">택배사 설정</a></li>
		<li><a href="/admin/delivery/free/list.do">배송비관리</a></li>
	</c:if>
	
	<c:if test="${menu.fmenu eq 3}">		
		<li><a href="/admin/order/shop/list.do">약속처방</a></li>
		<li><a href="/admin/order/tang/list.do">탕전주문</a></li>
		<li><a href="/admin/order/personal/list.do">개인결제</a></li>		
		<li><a href="/admin/order/point/list.do">포인트 결제</a></li>
	</c:if>
	
	<c:if test="${menu.fmenu eq 4}">
		<li><a href="/admin/total/use/list.do">약재사용통계</a></li>
		<li><a href="/admin/total/stock/list.do">약재재고현황</a></li>
		<li><a href="/admin/total/inven/list.do">약재입고장</a></li>
		<li><a href="/admin/total/tang/list.do">탕전집계</a></li>
	</c:if>
	
	<c:if test="${menu.fmenu eq 5}">
		<li><a href="/admin/item/goods/list.do">약속처방 상품관리</a></li>
		<li><a href="/admin/item/goodsGroup/list.do">약속처방 그룹관리</a></li>
		<li><a href="/admin/item/goodsGroup/sublist.do">약속처방 하위그룹관리</a></li>
		<li><a href="/admin/item/prejoje/list.do">사전조제지시서 출력</a></li>
		<li><a href="/admin/item/medi/list.do">약재관리</a></li>
		<li><a href="/admin/item/dic/list.do">방제사전</a></li>
		<li><a href="/admin/item/box/list.do">박스관리</a></li>
		<li><a href="/admin/item/pouch/list.do">파우치관리</a></li>
		<li><a href="/admin/item/sty/list.do">스티로폼관리</a></li> 
		<li><a href="/admin/item/fast/list.do">실속처방 상품관리</a></li>
		<li><a href="/admin/item/amount/list.do">포인트 상품관리</a></li>
		<li><a href="/admin/item/amountHis/list.do">포인트 충전-사용 관리</a></li>
	</c:if>
	
	<c:if test="${menu.fmenu eq 6}">
		<li><a href="/admin/board/notice/list.do">공지사항</a></li>
		<li><a href="/admin/board/data/list.do">이용안내</a></li>
		<!-- <li><a href="/admin/board/faq/list.do">자주하는질문</a></li> -->
		<li><a href="/admin/board/qna/list.do">문의하기</a></li>
		<li><a href="/admin/board/banner/list.do">배너관리</a></li>
	</c:if>
	<%-- ${menu} --%>
</ul>