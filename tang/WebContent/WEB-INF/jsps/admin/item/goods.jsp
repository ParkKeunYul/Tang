<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<script type="text/javascript" src="/assets/admin/js/jsp/item/goods.js"> </script>
<div class="con_tit">아이템관리 &gt; 약속처방 상품관리</div>
<div class="conBox">
	<div class="inputArea disB">
		<select name="search_title" id="search_title">
			<option value="p_name">상품명</option>
		</select>
		<input type="text" id="search_value" value="">
		<a href="#" id="search_btn" class="btn01">검색</a>
		<a href="#" id="addGoodsBtn" class="btn02">상품 추가</a>
	</div>
	
	<table id="jqGrid"></table>
	<div id="jqGridControl"></div> 


	<div id="addForm"></div>
	<div id="modForm"></div>
</div>
</html>