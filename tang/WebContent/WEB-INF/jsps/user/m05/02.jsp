<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!-- container -->
<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<style>
	.cart_list {width:100%; font-size:14px;}				
	.cart_list tbody tr td {				 	
		line-height:45px; 
		text-align:center;					
	}
	.cart_list .L {
		text-align:left; padding-left:10px;
	}
	.cart_list tbody tr:nth-child(even) {
		background:#f9f9f9;
	}
	
					
	.ui-jqgrid tr.ui-row-ltr td{
		border-right-width : 0px !important;
		border-bottom:1px solid #dddddd;
	}
	
	
	/* #gview_jqGrid .ui-jqgrid-labels, */
	.ui-jqgrid-labels{
		background:#e8e8e8; 
		border-bottom:1px solid #dddddd; 
		padding:10px 0 10px 0; 
		font-weight:700; 
		text-align:center;
	}
	
	.ui-jqgrid .ui-jqgrid-htable th{
		padding: 12px 0;
	}
	
	.ui-jqgrid .ui-jqgrid-htable th div{
		height: auto;
		font-size: 14px;
		font-weight: 700;
		font-family: 'Nanum Gothic';
	}
	
	.ui-jqgrid .ui-jqgrid-sortable{
		cursor: default;
	}
	
	.ui-jqgrid .ui-jqgrid-pager{
		height: 38px;
	}
	.ui-state-default, .ui-widget-content .ui-state-default{
		border:  none;
	}
	
	.ui-widget-content{
		border: none; 
	}
	.ui-state-highlight, .ui-widget-content .ui-state-highlight{
		border : none;
	}
	
	
	.ui-jqgrid .ui-pg-table td{
		font-size: 13px;
	}
	
	.ui-th-ltr, .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr{
		background: #e8e8e8;
	}
	
	.ui-corner-all, .ui-corner-bottom, .ui-corner-right, .ui-corner-br{
		border-bottom-right-radius : 0px;
	}
	
	.ui-corner-all, .ui-corner-bottom, .ui-corner-left, .ui-corner-bl{
		border-bottom-left-radius : 0px;
	}
	.ui-corner-all, .ui-corner-top, .ui-corner-right, .ui-corner-tr{
		border-top-right-radius : 0px;
	}
	.ui-corner-all, .ui-corner-top, .ui-corner-left, .ui-corner-tl{
		border-top-left-radius : 0px;
	}
	
	.cart_list{
		border-top: none;
	}
	
	.ui-widget.ui-widget-content{
		border: none;
	}
	
	.ui-jqgrid tr.jqgfirstrow td{
		border-right-width : 0px;
	}
	
	#gview_cartGrid,
	#gview_bundleGrid{
		border-top : 2px solid #26995d;
	}
	
</style>
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "마이페이지";
		String sec_nm = "마이페이지";
		String thr_nm = "장바구니";
		int fir_n = 5;
		int sub_n = 2;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	<%-- <script type="text/javascript" src="/assets/user/js/m05_02.js?${now}"> </script> --%>
	<script type="text/javascript" src="/assets/user/js/z_js/z_m05_02.js?${now}"> </script>
	
	<input type="hidden" name="mem_sub_seqno"   id="mem_sub_seqno" 	   value="${userInfo.mem_sub_seqno}"   />
	<input type="hidden" name="mem_sub_grade"   id="mem_sub_grade" 	   value="${userInfo.mem_sub_grade}"   />
	
	<!-- contents -->
		<div id="contents">
			<!-- 서브타이틀 -->
			<div class="titArea">
				<p class="Ltit">장바구니</p>
				<p>					
					주문하고자 하는 처방을 선택후  주문할 수 있습니다.<br/><strong>복수 선택을 하여 한번에 주문</strong> 할 수도 있습니다.<font class="point">(장바구니 보관기간은 1일입니다.)</font><br/>
					<strong>한 주문당 60팩 이하</strong>는 묶음 배송이 가능합니다.<font class="point">(묶음 배송은 최대 2건만 가능합니다.)</font>
				</p>
			</div>
			<!-- // 서브타이틀 -->
			<!-- 내용 -->
			<div class="conArea">
				
				<div class="searchArea"  style="padding-bottom: 10px;<c:if test="${userInfo.mem_sub_seqno ne 0}">display: none;</c:if>">
					<table>
						<colgroup>
							<col width="230px" />
							<col width="220px" />
							<col width="*" />
						</colgroup>
						<tr>
							<td colspan="3">
								계정 선택 : 
								<select name="search_sub_seqno" id="search_sub_seqno">
									<option value="0"  <c:if test="${userInfo.mem_sub_seqno eq 0 }">selected="selected"</c:if> >마스터계정  : ${userInfo.id} [ ${userInfo.name} ]</option>
									<c:forEach var="list" items="${sub_id}">
										<c:set var="sub_grade" value="부원장" />
										<c:if test="${list.grade eq 2 }"><c:set var="sub_grade" value="직원" /></c:if>
										<option value="${list.seqno}"  <c:if test="${userInfo.mem_sub_seqno eq list.seqno }">selected="selected"</c:if>>${sub_grade} :  ${list.id} [ ${list.name} ]</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
				</div>
				
				<!-- cartlist -->
				<table id="cartGrid" class="cart_list"></table>				
				<!-- //cartlist -->
				<div style="padding-top: 10px;">
					<a href="#" id="cartDelBtn"><span class="cBB h30">선택 삭제</span></a>
				</div>

				<div class="totalBox">
					<ul>
						<li class="tit">&nbsp;</li>
						<li class="Bt01">&nbsp;<span class="won">&nbsp;</span></li>
						<li class="Bt02">&nbsp;<span class="won">&nbsp;</span></li>
						<c:choose>
							<c:when test="${userInfo.mem_sub_grade eq 2}">
								<li class="total">합계<span class="won" >***,***</span>원</li>
								<li class="total" style="display: none;">합계<span class="won" id="cart_tot_price" >0</span>원</li>
							</c:when>
							<c:otherwise>										
								<li class="total">합계<span class="won" id="cart_tot_price">0</span>원</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				
				<form action="02_cart_order.do" method="post" id="frm" name="frm">
					<input type="hidden" name="all_seqno" id="all_seqno" value=""/>					
					<!-- btnarea -->
					<div class="btn_area03" >
						<a href="02_cart_order.do" id="orderType1Btn" <c:if test="${userInfo.mem_sub_grade eq 2}">style="display: none;"</c:if> ><span class="cg h40">주문하기</span></a>
					</div>
					<!-- //btnarea -->
				</form>
				
				<!-- 묶음배송 -->
				<p class="subTitle">* 묶음배송</p>				
				<!-- cartlist -->
				<table id="bundleGrid" class="cart_list"></table>
				<!-- //cartlist -->
				<div style="padding-top: 10px;">
					<a href="#" id="cancelBtn" ><span class="cBB h30">선택 일반배송으로 이동</span></a>
				</div>

				<div class="totalBox">
					<ul>
						<li class="tit">결제예정금액</li>
						<li class="Bt01">&nbsp;<span class="won">&nbsp;</span></li>
						<li class="Bt02">&nbsp;<span class="won">&nbsp;</span></li>
						
						<c:choose>
							<c:when test="${userInfo.mem_sub_grade eq 2}">
								<li class="total"><span class="won" >***,***</span>원</li>
								<li class="total" style="display: none;"><span class="won" id="bunch_cart_tot_price"></span>원</li>
							</c:when>
							<c:otherwise>										
								<li class="total">&nbsp;<span class="won" id="bunch_cart_tot_price"></span>원</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<form action="/m05/02_cart_plus_order.do" method="post" id="pfrm" name="pfrm">
					<input type="hidden" id="all_plus_seqno" name="all_seqno" />
					
					
					<!-- btnarea -->
					<div class="btn_area03" >
						<a href="02_cart_plus_order.do" id="orderPlusBtn" <c:if test="${userInfo.mem_sub_grade eq 2}">style="display: none;"</c:if>><span class="cg h40">묶음 배송 주문</span></a>
					</div>
					<!-- //btnarea -->
					<!-- //묶음배송 -->
				</form>
			</div>
			<!-- //내용 -->
		</div>
		<!-- //contents -->
</div>
<!-- //container -->	