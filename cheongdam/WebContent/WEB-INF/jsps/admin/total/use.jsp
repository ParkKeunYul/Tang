<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">

<script type="text/javascript" src="/assets/admin/js/jsp/total/use.js"> </script>
	<div class="con_tit">통계 &gt; 약재사용통계</div>
	
	<div class="conBox">
		<div class="inputArea disB">
			기간 : <input type="text" class="date" style="width: 80px;" id="search_sday" readonly="readonly"   /> 
			~ <input type="text" class="date"  style="width: 80px;" id="search_eday" readonly="readonly" />
			
			약재명 : <input type="text" name="search_yaknm" id="search_yaknm" style="width: 80px;" />
			그룹명 : <input type="text" name="search_groupnm" id="search_groupnm" style="width: 80px;" />
			원산지 : <input type="text" name="search_from" id="search_from" style="width: 80px;" />
			
			<a href="#" id="search_btn" class="btn01">검색</a>
			
		</div>
		
		<ul>
			<li style="overflow-x:hidden; height:350px;margin-bottom: 10px;">
				<div style="padding: 25px;">
					<table id="jqGrid"></table>
				</div>
			</li>
			<li style="width: 50%; float: left;overflow-x:hidden; height:250px;">
				<div style="padding: 25px;">
					<table id="useGrid" style="marign : 15px;"></table>
				</div>
			</li>
			<li style="width: 50%; float: left;overflow-x:hidden; height:250px;">
				<div style="padding: 25px;">
					<table id="addGrid" style="marign : 15px;"></table>
				</div>
			</li>
		</ul>
		
	</div>


</html>