<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">


<script type="text/javascript" src="/assets/admin/js/jsp/board/data.js"> </script>


<div class="con_tit">게시판관리 &gt; 공지사항</div>
<div class="conBox">
	<div class="inputArea disB">
		<a href="#" id="delBtn" class="btn03">[ 선택삭제 ]</a>
		<a href="#" id="addBtn" class="btn02">[ 글쓰기 ]</a>
	</div>
	
	<table id="jqGrid"></table>
	<div id="jqGridControl"></div>
	
	<div id="addForm"></div>
	<div id="modForm"></div>
</div>




</html>