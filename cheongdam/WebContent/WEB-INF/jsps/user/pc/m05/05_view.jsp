<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- container -->
<% pageContext.setAttribute("newLineChar", "\n"); %>
<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.orderlistGrid {width:100%; font-size:14px;}				
	.orderlistGrid tbody tr td {				 	
		line-height:32px; 
		text-align:center;					
	}
	.orderlistGrid .L {
		text-align:left; padding-left:10px;
	}
	.orderlistGrid tbody tr:nth-child(even) {
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
	
	#jqGrid input[name=my_joje]{
		height: 27px;
		text-align: right;
		font-size: 15px;
		background:#f5f5f5 !important;
		width: 45px !important;
	}
	
	.ui-jqgrid .ui-jqgrid-sortable{
		cursor: default;
	}
	/*ui-widget-content jqgrow ui-row-ltr ui-state-highlight*/
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
	
	div.ui-pager-control .ui-pg-input[type="text"]{
		height: 15px !important;
		width : 22px;
		padding : 0 0;
		vertical-align: middle;
		font-size: 13px;
		text-align: right;
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
	
	.ui-widget.ui-widget-content{
		/* border-left : none; */
	}
	
	
	.LArea .oderlist_top{
		border-bottom:  none;
	}
	
	#patientGrid{
		font-size: 13px;
	}
</style>
<script type="text/javascript" src="/assets/user/js/m05_05_view.js"> </script>

<div id="container">
	
	<!-- contents -->
	<div id="contents">
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>마이페이지</span><span>환자관리</span></p>
		</div>

		<ul class="sub_Menu w20">
			<li><a href="01.do">내 정보수정</a></li>
			<!-- <li><a href="02.do">장바구니</a></li> -->
			<li><a href="03.do">주문내역</a></li>
			<!-- <li><a href="07.do">나의 처방관리</a></li> -->
			<li class="sel"><a href="05.do">환자관리</a></li>
			<li><a href="04.do">탕전공동사용계약서</a></li>
			<li><a href="99.do">포인트 사용내역</a></li>
		</ul>
	
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit">환자관리</p>
			<p>환자들을 체계적으로 등록 및 관리할 수 있는 환자관리 시스템을 제공하여<br/>환자의 개인정보 등록, 진단과 증상 메모기능 처방내역 확인을 하실 수 있습니다.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">

			<div class="topinfo" style="padding-top: 50px;">
				<div style="width: 100%;border-bottom:none;">					
					<p><span style="display: inline-block;padding-left: 20px;font-weight: 700;">환자 정보</span><span class="fc02 b"></span></p>
					<ul>
						<li><span class="tit">중복방지번호</span>${view.chart_num}</li>
						<li><span class="tit">환자명</span>${view.name}</li>
						<li><span class="tit">성별</span>${view.sex}</li>
						<li><span class="tit">생년월일</span><span class="txt_age">만30</span>/<span class="txt_birth">${view.birth_year }</span></li>
						<li><span class="tit">연락처</span>${view.tel}</li>
						<li><span class="tit">휴대전화</span>${view.handphone}</li>
						<li><span class="tit">주소</span>
							${view.zipcode}<br/>${view.address01} ${view.address02}
						</li>
						<li><span class="tit">체격/체형</span>${view.size}</li>
						<li><span class="tit">증상</span>${fn:replace(view.contents, newLineChar, "<br/>")}</li>
					</ul>
				</div>
				<div class="ml60" style="display: none;">
					<p>추가정보</p>
					<ul>
						<li><span class="tit">체격/체형</span>${view.size}</li>
						<li style="display: none;"><span class="tit">진단</span>${fn:replace(view.jindan, newLineChar, "<br/>")}</li>
						<li><span class="tit">증상</span>${fn:replace(view.contents, newLineChar, "<br/>")}</li>
						<li style="display: none;"><span class="tit">기타1</span>${fn:replace(view.etc1, newLineChar, "<br/>")}</li>
						<li style="display: none;"><span class="tit">기타2</span>${fn:replace(view.etc2, newLineChar, "<br/>")}</li>
					</ul>
				</div>
			</div>
			<div class="btn_area04">
				<%-- <a href="/m02/01.do?wp_seqno=${view.seqno}"><span class="cg h34">처방하기</span></a> --%>
				<a href="#" id="modBtn"><span class="cblue h34">수정하기</span></a>
				<a href="05.do?page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}"><span class="cglay h34">목록</span></a>
			</div>
			
			<input type="hidden" name="seqno" id="seqno" value="${view.seqno}" />
			<p class="ctit">과거 처방 내역</p>
			
			<!-- table -->
			<table id="preOrderGrid" class="orderlistGrid"></table>
			<div id="preOrderGridControl"></div>
			<!-- //table -->				

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 

<!-- layer_popup 환자 정보수정 -->
<div id="mod_pop" class="Pstyle2">
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
	<span class="b-close"><img src="/assets/user/pc/images/sub/btn_close02p.png" alt="닫기" /></span>
	<p class="ptit">환자정보 수정</p>
	<div class="content pformT">
	<form action="05.mod.do" name="frm" id="frm">
		<input type="hidden" name="seqno" value="${view.seqno}" />
		<table>			
			<colgroup>
				<col width="120px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>중복방지번호</th>
					<td>
						${view.chart_num}
						<input type="hidden" name="chart_num" id="chart_num" value="${view.chart_num}" placeholder="중복방지번호 입력" style="width:220px;">
					</td>
				</tr>
				<tr>
					<th>환자명 <span class="fc04">*</span></th>
					<td><input type="text" name="name" id="name"  value="${view.name}" placeholder="환자명 입력" style="width:220px;"></td>
				</tr>
				<tr>
					<th>성별 <span class="fc04">*</span></th>
					<td>
						<select name="sex" id="sex"  style="width:70px;">
							<option value="남자" <c:if test="${view.sex eq '남자' }">selected="selected"</c:if>>남자</option>
							<option value="여자" <c:if test="${view.sex eq '여자' }">selected="selected"</c:if>>여자</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>생년월일 <span class="fc04">*</span></th>
					<td>
						<c:set var="birth_year" value="${fn:split(view.birth_year,'-')}" />
						<select name="birth_year" id="birth_year"  style="width:70px;">
							<c:forEach var="i" begin="0" end="${sysYear-1900}">
							    <c:set var="yearOption" value="${sysYear-i}" />
							    <option value="${yearOption}"   <c:if test="${yearOption eq birth_year[0] }">selected="selected"</c:if> >${yearOption}</option>
							</c:forEach>
						</select>
						년
						<select name="birth_month" id="birth_month"  style="width:60px;">
							<c:forEach var="i" begin="1" end="12">
								<option value="<c:if test="${i < 10 }">0</c:if>${i}" <c:if test="${i eq birth_year[1] }">selected="selected"</c:if>  > <c:if test="${i < 10 }">0</c:if>${i}</option>
							</c:forEach>
						</select>
						월
						<select name="birth_day" id="birth_day"  style="width:60px;">
							<c:forEach var="i" begin="1" end="31">
								<option value="<c:if test="${i < 10 }">0</c:if>${i}" <c:if test="${i eq birth_year[2] }">selected="selected"</c:if> > <c:if test="${i < 10 }">0</c:if>${i}</option>
							</c:forEach>
						</select>
						일
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<c:set var="tel" value="${fn:split(view.tel,'-')}" />
						<input type="text" id="tel01" name="tel01" style="width:65px;" maxlength="4" value="${tel[0]}"> -
						<input type="text" id="tel02" name="tel02" style="width:65px;" maxlength="4" value="${tel[1]}"> -
						<input type="text" id="tel03" name="tel03" style="width:65px;" maxlength="4" value="${tel[2]}">
					</td>
				</tr>
				<tr>
					<th>휴대전화 <span class="fc04">*</span></th>
					<td>
						<c:set var="handphone" value="${fn:split(view.handphone,'-')}" />
						<input type="text" id="handphone01" name="handphone01" style="width:65px;" maxlength="4" value="${handphone[0]}"> -
						<input type="text" id="handphone02" name="handphone02" style="width:65px;" maxlength="4" value="${handphone[1]}"> -
						<input type="text" id="handphone03" name="handphone03" style="width:65px;" maxlength="4" value="${handphone[2]}">
					</td>
				</tr>
				<tr>
					<th>주소 <span class="fc04">*</span></th>
					<td>
						<span class="dI H40">
							<input type="text" value="${view.zipcode }"  name="zipcode" id="zipcode" style="width:180px;" readonly><a href="#" id="findAddrBtn"><span id="addrBtn1" class="h34 cB">주소찾기</span></a>
						</span>
						<span class="dI">
							<input type="text" value="${view.address01 }" name="address01" style="width:350px;" readonly id="address01">
							<input type="text" value="${view.address02 }" name="address02" placeholder="상세주소" style="width:350px;" id="address02"> 
						</span>
					</td>
				</tr>
				<tr>
					<th>체격/체형</th>
					<td>
						<textarea name="size" id="size" style="width:350px; height:20px;resize:none;">${view.size}</textarea>
					</td>
				</tr>
				<tr style="display:none;">
					<th>진단</th>
					<td>
						<textarea name="jindan" id="jindan" style="width:350px; height:40px;resize:none;">${view.jindan}</textarea>
					</td>
				</tr>
				<tr>
					<th>증상</th>
					<td>
						<textarea name="contents" id="contents" style="width:350px; height:30px;resize:none;">${view.contents}</textarea>
					</td>
				</tr>
				<tr style="display:none;">
					<th>기타1</th>
					<td>
						<textarea name="etc1" id="etc1" style="width:350px; height:30px;resize:none;">${view.etc1}</textarea>
					</td>
				</tr>
				<tr style="display:none;">
					<th>기타2</th>
					<td>
						<textarea name="etc2" id="etc2" style="width:350px; height:30px;resize:none;">${view.etc1}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	
		<!-- btnarea -->
		<div class="btn_area02 pt0 mb0">
			<a href="#" id="popupButton1"><span class="cg h35">수정하기</span></a>
		</div>
		<!-- //btnarea -->
			
		</form>
	</div>
</div>
<!-- //layer_popup 환자 정보수정 -->