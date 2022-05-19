<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">


<script type="text/javascript" src="/assets/admin/js/jsp/total/stock.js"> </script>
	
	<div class="con_tit">통계 &gt; 약재재고현황</div>
	
	<div class="conBox">
		<div class="inputArea disB">
			약재명 : <input type="text" name="search_yaknm" id="search_yaknm" style="width: 80px;" />
			그룹명 : <input type="text" name="search_groupnm" id="search_groupnm" style="width: 80px;" />
			원산지 : <input type="text" name="search_from" id="search_from" style="width: 80px;" />
			
			<a href="#" id="search_btn" class="btn01">검색</a>
			<input type="hidden" id="search_rowid" value="" />
		</div>
		
		
		<ul>
			<li style="overflow-x:hidden; height:350px;margin-bottom: 10px;">
				<div style="padding: 25px;">
					<table id="jqGrid"></table>
				</div>
			</li>
			<li style="width: 50%; float: left;overflow-x:hidden; height:350px;">
				
				<div style="padding-left: 25px;">
					<select id="search_use_year">
						<option value="1">1년전</option>
						<option value="2">2년전</option>
						<option value="3">3년전</option>
						<option value="4">4년전</option>
						<option value="5">5년전</option>
					</select>
					<a href="#" id="search_btn_use" class="btn01">검색</a>
				</div>
				
				<div style="padding: 0 25px;">
					<table id="useGrid" style="marign : 15px;"></table>
				</div>
			</li>
			<li style="width: 50%; float: left;overflow-x:hidden; height:350px;">
				<div style="padding-left: 25px;">
					<select id="search_add_year">
						<option value="1">1년전</option>
						<option value="2">2년전</option>
						<option value="3">3년전</option>
						<option value="4">4년전</option>
						<option value="5">5년전</option>
					</select>
					<a href="#" id="search_btn_add" class="btn01">검색</a>
				</div>
				<div style="padding:  0 25px;">
					<table id="addGrid" style="marign : 15px;"></table>
				</div>
			</li>
		</ul>
		
		
	</div>


</html>