<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script type="text/javascript">
function logout(){
	if(confirm('로그아웃하시겠습니까?')){
		location.href='/admin/logout';
	}
}
</script>

<div class="header">
	<h2><a href="/admin/main.do" style="color: #fff;">관리자</a></h2>
	<ul class="gnb">		
		<li><a href="/admin/base/manage/list.do">기본관리</a></li>
		<li><a href="/admin/delivery/base/list.do">택배관리</a></li>
		<li><a href="/admin/order/tang/list.do">주문관리</a></li>
		<li><a href="/admin/total/use/list.do">통계</a></li>
		<li><a href="/admin/item/medi/list.do">아이템관리</a></li>
		<li><a href="/admin/board/notice/list.do">게시판 관리</a></li>
	</ul>
</div>



