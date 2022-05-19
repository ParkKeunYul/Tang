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
		list-style-type: none;
	}
</style>


<script type="text/javascript" src="/assets/admin/js/jsp/item/dic.js"> </script>

<div class="con_tit">아이템관리 &gt; 방재사전</div>
<div class="conBox">
	<ul class="item_manage" >
		<li style="width: 33%;">
			<div class="inputArea disB">			
				출전그룹 : <input type="text" id="search_group_value" />
				<a href="#" id="group_searchBtn" class="btn01">검색</a>
				<a href="#" id="group_addBtn"  class="btn02">신규등록</a>
				<div id="group_addForm" style="display: none;">
					출전 그룹명 <input type="text" name="a_b_name" id="a_b_name" />
				</div>
			</div>
			
			<table id="groupGrid"></table>
			<div id="groupGridControl"></div>
			
		</li>
		<li style="width:2%;float: left;text-align: center;line-height: 300px;">&gt;&gt;</li>
		<li style="width:60%;">
			<div class="inputArea disB">
				처방명 : <input type="text" id="search_name_value" />
				<a href="#" id="name_searchBtn" class="btn01">검색</a>
				<a href="#" id="name_addBtn" class="btn02">신규등록</a>
			</div>
			<div id="name_Form" class=""></div>
			<div id="name_mod_Form" class=""></div>
			
			<div style="height: 277px;overflow:hidden;overflow:auto;">
				<table id="nameGrid"></table>
				<div id="nameGridControl"></div>
			</div>	
		</li>
	</ul>
	<div style="clear: both;padding-top: 15px;border-top: 1px solid blue;">
		
		<ul class="item_manage"  >
			<li style="width: 33%;">
				<div class="inputArea disB">
					<select id="search_all_title">
						<option value="s_name">처방명</option>
						<option value="b_name">출전명</option>
					</select>
					<input type="text" id="search_all_value" />
					<a href="#" id="all_searchBtn" class="btn01">검색</a>
				</div>
				<table id="allGrid"></table>
				<div id="allGridControl"></div>
			</li>
			<li style="width:2%;float: left;text-align: center;line-height: 300px;">&gt;&gt;</li>
			<li style="width:60%;">
				<div class="inputArea disB">
					<a href="#" id="priceItemDelBtn" class="btn03">선택삭제</a>
				</div>
				<table id="priceGrid"></table>
				<div id="price_update_form" class=""></div>
				
				<div class="inputArea disB"> 
					<select id="addPrice_search_title">
						<option value="yak_name">약재명</option>
					</select>
					<input type="text" id="addPrice_search_value" />
					<a href="#" id="addPriceSearchBtn" class="btn01">검색</a>
				</div>
				<table id="allGridYak"></table>
				<div id="allGridYakControl" class=""></div>				
				
			</li>
		</ul>	
		<div style="clear: both;"></div>	
	</div>
</div>

