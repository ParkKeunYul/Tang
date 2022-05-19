<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#findAddrBtn2").click(function() {
		find_addr('han_zipcode','han_address01', 'han_address02');
		return false;
	});
	
	$("#handphone01,#handphone02,#handphone03,#han_tel_1,#han_tel_2,#han_tel_3,#han_fax_1,#han_fax_2,#han_fax_3").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	}).on("focusout", function() {
	    var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        $(this).val(x);
	    }
	}).on("focus", function() {
		var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        $(this).val(x);
	    }
	});
	
	$("#popBtn").click(function() {
		var url = '04_pop.do?';
	        url+= $('#frm').serialize();
	        
	        console.log(url);
		
		var popupX = (window.screen.width / 2) - (1050 / 2);
		var popupY= (window.screen.height / 2) - (760 / 2);
		
		window.open(url, '‘계약서', 'toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=1050px, height=760px, top='+popupX+', left='+popupY)
		return false;
	});
	
	
	$("#hpop_Btn").click(function() {
		var url = '05_pop.do?';
			url+= $('#frm').serialize();
        
        console.log(url);
		
		var popupX = (window.screen.width / 2) - (1050 / 2);
		var popupY= (window.screen.height / 2) - (760 / 2);
		
		window.open(url, '‘계약서', 'toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=1050px, height=760px, top='+popupX+', left='+popupY)
		return false;
	});

	$("#pdf_Btn").click(function() {
		var url = '06_pop.do?';
			url+= $('#frm').serialize();
        
        console.log(url);
		
		var popupX = (window.screen.width / 2) - (850 / 2);
		var popupY= (window.screen.height / 2) - (900 / 2);
		
		window.open(url, '‘pdf 저장방법', 'toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=850px, height=900px, top='+popupX+', left='+popupY)
		return false;
	});
	
	
});
</script>
<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="contents">

		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>마이페이지</span><span>탕전공동사용계약서</span></p>
		</div>

		<ul class="sub_Menu w20">
			<li><a href="01.do">내 정보수정</a></li>
			<!-- <li><a href="02.do">장바구니</a></li> -->
			<li><a href="03.do">주문내역</a></li>
			<!-- <li><a href="07.do">나의 처방관리</a></li> -->
			<li><a href="05.do">환자관리</a></li>
			<li class="sel"><a href="04.do">탕전공동사용계약서</a></li>
			<li><a href="99.do">포인트 사용내역</a></li>
		</ul>
	<%-- ${info} --%>
		
		<!-- 본문내용 -->
		<div class="contract">
			<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
			<div class="grayB">계약서에 기재될 상세정보를 확인해 주세요</div>
			<div class="inner">
				<form action="#" name="frm" id='frm'>
					<table>
						<colgroup>
							<col width="15%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>의료기관명</th>
								<td><input type="text" name="han_name" id="han_name" style="width:222px;" value="${info.han_name}"></td>
							</tr>
							<tr>
								<th>사업자번호</th>
								<td>
									<c:set var="biz_no" value="${fn:split(info.biz_no,'-')}" />
									<input type="text" id="biz_no_1" name="biz_no_1" style="width:65px;" maxlength="3" value="${biz_no[0]}"> -
									<input type="text" id="biz_no_2" name="biz_no_2" style="width:65px;" maxlength="2" value="${biz_no[1]}"> -
									<input type="text" id="biz_no_3" name="biz_no_3" style="width:65px;" maxlength="5" value="${biz_no[2]}">
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<span class="dI H40">
										<input type="text" value="${info.han_zipcode }" name="han_zipcode" id="han_zipcode" style="width:50px;" readonly><a href="#" id="findAddrBtn2"><span id="addrBtn1" class="h35 cB">주소찾기</span></a>
									</span>
									<span class="dI">
										<input type="text" value="${info.han_address01 }" name="han_address01" style="width:400px;" readonly id="han_address01">
										<input type="text" value="${info.han_address02 }" name="han_address02" style="width:250px;" id="han_address02"> 
									</span>
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td>
									<c:set var="han_tel" value="${fn:split(info.han_tel,'-')}" />
									<input type="text" id="han_tel_1" name="han_tel_1" style="width:65px;" maxlength="4" value="${han_tel[0]}"> -
									<input type="text" id="han_tel_2" name="han_tel_2" style="width:65px;" maxlength="4" value="${han_tel[1]}"> -
									<input type="text" id="han_tel_3" name="han_tel_3" style="width:65px;" maxlength="4" value="${han_tel[2]}">
								</td>
							</tr>
							<tr>
								<th>팩스번호</th>
								<td>
									<c:set var="han_fax" value="${fn:split(info.han_fax,'-')}" />
									<input type="text" id="han_tel_1" name="han_fax_1" style="width:65px;" maxlength="4" value="${han_fax[0]}"> -
									<input type="text" id="han_tel_2" name="han_fax_2" style="width:65px;" maxlength="4" value="${han_fax[1]}"> -
									<input type="text" id="han_tel_3" name="han_fax_3" style="width:65px;" maxlength="4" value="${han_fax[2]}">
								</td>
							</tr>
							<tr>
								<th>대표자</th>
								<td><input type="text" id="ceo" name="ceo" value="${info.name}" style="width:220px;"></td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" name="sign_img" id="sign_img" value="${info.sign_img}" />
				</form>
			</div>
			<!-- btnarea -->
			<div class="ac">
				<a href="#" id="popBtn" ><span class="cg h60">계약서 출력하기</span></a> <a href="#" id="hpop_Btn" ><span class="cg h60">보건소 신고서류 출력하기</span></a>
			</div>
			<!-- //btnarea -->
			
			<div class="ac" style="font-size:13px; margin-top:30px; height:35px; padding-top:10px; background:#f1f1f1;">
				온라인 개설신고를 위한 “보건소 신고서류” 파일 저장 안내 <a href="#" id="pdf_Btn" style="margin-left:20px;"><span class="h25 cB">자세히 보기</span></a>
			</div>
		
		</div>
		<!-- //본문내용 -->

	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		