<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<script type="text/javascript" src="/assets/admin/js/jsp/base/login_his.js"> </script>
	
	
	<div class="con_tit">기본관리 &gt; 최근로그인정보</div>
	
	<div class="conBox">
		<div class="inputArea disB">
			<select name="search_title" id="search_title">
				<option value="id">아이디</option>
				<option value="name">이름</option>
				<option value="han_name">한의원명</option>		
			</select>
			<input type="text" id="search_value" value="">
			<a href="#" id="search_btn" class="btn01">검색1</a>
		</div>
		
		
		
		<table id="jqGrid"></table>
		<div id="jqGridControl"></div>
	</div>


</html>