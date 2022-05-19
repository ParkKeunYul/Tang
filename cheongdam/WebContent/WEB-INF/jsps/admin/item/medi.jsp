<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<style>
	.item_manage{
		width: 100%;
	}
	
	.item_manage li {
		float: left;
		width: 40%;
		list-style-type: none;
	}
</style>

 <!-- <script type="text/javascript" src="/assets/admin/js/jsp/item/medi.js"> </script> --> 
 <script type="text/javascript" src="/assets/admin/js/zjsp/item/z_medi.js"> </script>    
<div class="con_tit">아이템관리 &gt; 약재관리</div>
<div class="conBox">
	<ul class="item_manage">
		<li>
			<div class="inputArea disB">
				그룹명 : <input type="text" id="search_group_value" />
				<a href="#" id="group_searchBtn" class="btn01">검색</a>
				<a href="#" id="group_addBtn" class="btn02">신규등록</a>
				<div id="group_addForm" style="display: none;">
					그룹명 <input type="text" name="a_group_name" id="a_group_name" />
				</div>
			</div>
			<table id="groupGrid"></table>
			<div id="groupGridControl"></div>
			
		</li>
		<li style="width:5%;float: left;text-align: center;line-height: 300px;"> &gt;&gt;</li>
		<li>			
			<div class="inputArea disB">
				<a href="#" id="name_addBtn" class="btn02">신규등록</a>
			</div>
			
			<div id="name_Form" class=""></div>
			<div id="name_mod_Form" class=""></div>
			<table id="nameGrid"></table>
			<div id="nameGridControl"></div>
			
		</li>
	</ul>
	<div style="clear: both;padding-top: 15px;">
		<div class="inputArea disB">
			<select id="search_all_title">
				<option value="yak_name">약재명</option>
			</select>
			<input type="text" id="search_all_value" />
			<a href="#" id="all_searchBtn" class="btn01">검색</a>
			<div style="display:inline-block;">
				[(최초 약재 세팅시 20개 -> 1000개 변경후 세팅하시면 좀더 편하게 하실수 있습니다.(번호 약재명 클릭시 정렬됩니다.)] <br/>
				원산지,기본값, g/당단가,위치 정보는 목록의  셀 클릭시 변경 할 수 있습니다
			</div>			
			 
		</div>
		<div id="allGridControl"></div>
		<table id="allGrid"></table>
		
		<div id="dic_update_form"></div>
	</div>
</div>



