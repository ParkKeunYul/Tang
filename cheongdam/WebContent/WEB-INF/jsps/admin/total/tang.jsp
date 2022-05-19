<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">


<script type="text/javascript" src="/assets/admin/js/zjsp/total/z_tang.js?${adminInfo.pp}"> </script>
<!-- <script type="text/javascript" src="/assets/admin/js/jsp/total/tang.js"> </script> -->

<style>
	.txt_li li{
		float: left;
		width: 20%;
		padding-bottom: 5px;
	}
	
	.txt_li li label{
		display: inline-block;
		width: 95px;
		font-weight: 700;
	}
	
	.txt_li li input{
		background-color: #f3f3f3;
		text-align: right;
	}
</style>
	<div class="con_tit">통계 &gt; 탕전집계</div>
	
	<div class="conBox">
		<div class="inputArea disB">
			<span style="font-weight: 700;">기간 : </span><input type="text" class="date" style="width: 80px;" id="search_sday" readonly="readonly"   /> 
			~ <input type="text" class="date"  style="width: 80px;" id="search_eday" readonly="readonly" />
			
			<span style="font-weight: 700;">한의원명 : </span><input type="text" id="search_name" />
			
			<a href="#" id="search_btn" class="btn01">검색</a>
			
		</div>
		
		<ul>
			<li style="overflow-x:hidden;margin-bottom: 10px;">
				<div style="padding: 25px;">
					<table id="jqGrid"></table>
				</div>
			</li>
			<li>
				<ul class="txt_li">			
					<li><label for="" >총 주문금액 : </label><input type="text" id="all_tot"  readonly="readonly"/></li>
					<li><label for="" style="color: blue;">총 결제금액 : </label><input type="text" id="order_tot" readonly="readonly"/></li>
					<li><label for="" style="color: red;">총 할인금액 : </label><input type="text" id="sale_tot" readonly="readonly"/></li>
					<li><label for="">총 탕전금액 : </label><input type="text" id="tang_tot" readonly="readonly"/></li>
					<li><label for="">총 주수상반금액 : </label><input type="text" id="jusu_tot" readonly="readonly"/></li>
					
					
					<li><label for="" >총 약재금액 : </label><input type="text" id="yakjae_tot" readonly="readonly"/></li>
					<li><label for="" style="color: blue;">총 약재결제금액: </label><input type="text" id="yakjae_price_tot" readonly="readonly"/></li>
					<li><label for="" style="color: red;">총 약재할인금액 : </label><input type="text" id="yakjae_sale_tot" readonly="readonly"/></li>
					<li><label for="">총 포장금액 : </label><input type="text" id="pojang_tot" readonly="readonly"/> </li>
					<li><label for="">총 배달금액 : </label><input type="text" id="delivery_tot" readonly="readonly"/></li>
					
					<li style="clear: both;"></li>
				</ul>
			</li>
					
		</ul>
		
	</div>


</html>