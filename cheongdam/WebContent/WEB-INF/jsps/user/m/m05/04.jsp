<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
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
	
	$("#findAddrBtn2").click(function() {
		find_addr('han_zipcode','han_address01', 'han_address02');
		return false;
	});
	
	$("#popBtn").click(function() {
		var url = '04_pop.do?';
	        url+= $('#frm').serialize();
	        
		
		
		window.open(url, '‘계약서', 'toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no,')
		return false;
	});
});
</script>
<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">탕전공동사용계약서</p>
		<div class="lnbDepth lnbDepth4">
			<ul>
				<li><a href="01.do">내 정보수정</a></li>
				<li><a href="03.do">주문내역</a></li>				
				<li class="sel"><a href="04.do" style="letter-spacing: -3px;">탕전공동사용계약서</a></li>
				<li ><a href="99.do" style="letter-spacing: -3px;">포인트사용내역</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<div class="contents member" id="contents">
		<form action="#" name="frm" id='frm'>
			<p class="contsTit fc01">계약서에 기재될 상세정보를 확인해 주세요</p>
			<div class="innerBoxMem">
				<ul class="memberForm">
					<li class="type02">
						<span class="title">의료기관명</span>
						<div><input type="text" name="han_name" id="han_name" value="${info.han_name}" style="width:100%;"></div>
					</li>
					<li class="type02">
						<span class="title">사업자번호</span>
						<div>
							<c:set var="biz_no" value="${fn:split(info.biz_no,'-')}" />
							<input type="text" id="biz_no_1" name="biz_no_1" style="width:65px;" maxlength="4" value="${biz_no[0]}"> -
							<input type="text" id="biz_no_2" name="biz_no_2" style="width:65px;" maxlength="4" value="${biz_no[1]}"> -
							<input type="text" id="biz_no_3" name="biz_no_3" style="width:65px;" maxlength="4" value="${biz_no[2]}">
						</div>
					</li>					
					<li class="type02 address">
						<label class="title">주소</label>
						<div>
							<span><input type="text" value="${info.han_zipcode }" name="han_zipcode" id="han_zipcode" style="width:130px;" readonly></span><button type="button" class="btnTypeBasic" id="findAddrBtn2"><span>주소찾기</span></button>
							<input type="text"  value="${info.han_address01 }" name="han_address01"  style="width:100%;" id="han_address01">
							<input type="text"  value="${info.han_address02 }" name="han_address02"  style="width:100%;" id="han_address02"> 
						</div>
					</li>
					<li class="type02">
						<label class="title" for="phone">연락처</label>
						<div>
							<c:set var="han_tel" value="${fn:split(info.han_tel,'-')}" />
								<input type="text" id="han_tel_1" name="han_tel_1" style="width:65px;" maxlength="4" value="${han_tel[0]}"> -
								<input type="text" id="han_tel_2" name="han_tel_2" style="width:65px;" maxlength="4" value="${han_tel[1]}"> -
								<input type="text" id="han_tel_3" name="han_tel_3" style="width:65px;" maxlength="4" value="${han_tel[2]}">
						</div>
					</li>
					<li class="type02">
						<span class="title">대표자</span>
						<div><input type="text" id="ceo" name="ceo" value="${info.name}" style="width:100%;"></div>
					</li>
				</ul>
			</div>
	
			<div class="btnArea write">
				<button type="button" id="popBtn" class="btnTypeBasic colorGreen"><span>계약서 출력하기</span></button>
			</div>
		</form>
	</div>
	<!-- //본문 -->

</div>
<!-- //container -->
		