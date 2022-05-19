<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<script type="text/javascript" src="/assets/admin/js/jsp/base/manage.js"> </script>


<!-- 
<span><a href="#" class="btn01">글쓰기</a></span>
	<span><a href="#" class="btn02">수정</a></span>
	<span><a href="#" class="btn03">삭제</a></span>
 -->
<div class="con_tit">기본관리 &gt; 관리자관리</div>
<div class="conBox">
	<div class="inputArea disB">
		<input type="text" id="search_a_id" value="">
		<a href="#" onclick="aaa();" class="btn01">검색</a>
		<a href="#" onclick="add();" class="btn02">추가</a>
		<a href="#" onclick="del();" class="btn03">삭제</a>
	</div>
	
	<table id="jqGrid"></table>
	<div id="jqGridControl"></div>
	
	<div id="add_form"></div>
	<div id="update_form"></div>
</div>



<style>

	.aa{
		cursor: pointer;
	}
</style>



</html>