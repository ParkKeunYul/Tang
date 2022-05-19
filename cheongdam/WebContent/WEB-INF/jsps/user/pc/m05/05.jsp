<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!-- container -->

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
$(document).ready(function() {
	$("#addBtn").click(function() {
		$('#add_pop').bPopup({
			onOpen: function() {
               closeDaumPostcode();
               frmReset();
               $('#chart_num').focus();
            },
			onClose: function() {
				frmReset();
				closeDaumPostcode();
            }
		});
		$('#popFormTxt').text('신규등록');
		$('#saveBtn').text('등록하기');
		return false;
	});
	
	$('#popFormTxt').text('신규등록');
	$('#saveBtn').text('등록하기');
	
	/* $("td .li").click(function() {
		$('#add_pop').bPopup();
		$('#popFormTxt').text('환자정보 수정');
		$('#saveBtn').text('수정');
		
		return false;
	}); */
	
	$("#findAddrBtn").click(function() {
		find_addr('zipcode','address01', 'address02');
		return false;
	});
	
	$("#popupButton1").click(function() {
		/* 
		if (!valCheck('chart_num', '중복방지번호를 입력하세요.')) return false;
		
		if( $('#check_chart').val == 0 ){
			alert('중복방지번호 중복확인이 필요합니다.');
			return;
		}
		 */
		if (!valCheck('name', '환자명을 입력하세요.')) return false;
		if (!valCheck('handphone01', '휴대폰번호를 입력하세요.')) return false;
		if (!valCheck('handphone03', '휴대폰번호를 입력하세요.')) return false;
		if (!valCheck('handphone02', '휴대폰번호를 입력하세요.')) return false;
		if (!valCheck('zipcode', '주소를 입력하세요.')) return false;
		
		$.ajax({
			url : '/m05/05_add.do',
			type: 'POST',
			data : $("#frm").serialize(),
			error : function() {
				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			},
			success : function(data) {
				alert(data.msg);
				if (data.suc){					
					$('#add_pop').bPopup().close();
					location.href='/m05/05.do';
				}
			}
		});
		return false;
	});
	
	$("#searchBtn").click(function() {
		$('#search_frm').submit();
		return false;
	});
	
	$("#chartBtn").click(function() {
		if (!valCheck('chart_num', '중복방지번호를 입력하세요.')) return false;
		
		$.ajax({
			url : 'duple_chart.do',
		    data : {
		    	chart_num : $('#chart_num').val()
		    },        
	        error: function(){
		    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		    },
		    success: function(data){
		    	alert(data.msg);
		    	$('#check_chart').val(data.check_chart);
		    }   
		});
		return false;
	});
	
	
	$(".pdelBtn").click(function() {
		var seqno = $(this).attr('attr1');
		
		if(confirm('삭제하겠습니까?')){
			$.ajax({
				url : '05_del.do',
			    data : {
			    	seqno : seqno
			    },        
		        error: function(){
			    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			    },
			    success: function(data){
			    	alert(data.msg);
			    	if(data.suc){
			    		var url = $(location).attr('href').replace('#', ''); 
			    		location.href=url.replace('#', '');
			    	}
			    }   
			});
		}else{
			return;	
		}
		
		
	});
	
});

function frmReset(){
	$('#frm').each(function(){this.reset();});
}
</script>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
<div id="container">	
	<!-- //submenuArea -->
	
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
			<div class="searchBox01" style="padding-top: 50px;">
				<form action="" name="search_frm" id="search_frm" method="get">
					<input type="hidden" name="page" value="1" />
					<label><input type="radio" name="search_type"  value="name" <c:if test="${bean.search_type eq 'name'}">checked</c:if>> 처방환자</label>
					<label><input type="radio" name="search_type"  value="all"  <c:if test="${bean.search_type eq 'all'}">checked</c:if>> 전체 </label>
					<div class="winput">
						<input type="text" name="search_value" id="search_value" value="${bean.search_value}" style="width:200px;" />
						<a href="#" id="searchBtn"><img src="/assets/user/pc/images/common/bg_search.png" alt="검색" class="mt8" /></a>
					</div>
					<a href="#" id="addBtn"><span class="cg h34">신규등록</span></a>
				</form>
			</div>
			<!-- table -->
			<table class="basic_list">
				<colgroup>
					<col width="110px" />
					<%-- <col width="130px" /> --%>
					<col width="*" />
					<col width="110px" />
					<col width="110px" />
					<col width="120px" />
					<col width="110px" />
					<col width="80px" />
				</colgroup>
				<thead>
					<tr>
						<th>등록일</th>
						<%-- <th>중복방지번호</th> --%>
						<th>환자명</th>
						<th>성별</th>
						<th>생년월일</th>
						<th>휴대전화</th>
						<th>최근처방일</th>	
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
						<tr>
							<td>${list.wdate2}</td>
							<%-- <td>${list.chart_num}</td> --%>
							<td><a href="05_view.do?seqno=${list.seqno}&page=${bean.page}&search_title=${bean.search_type}&search_value=${bean.encodeSV}" class="li">${list.name}</a></td>
							<td>${list.sex}</td>
							<td>${list.birth_year}</td>
							<td>${list.handphone}</td>
							<td>${list.last_order}</td>
							<td>
								<%-- <c:if test="${!empty list.last_order}"></c:if> --%>
								<c:if test="${empty list.last_order}">
									<!-- 삭제가능 -->
									<a href="#" class="pdelBtn" attr1='${list.seqno }'><span class="cBB h30" style="font-weight: 700;">삭제</span></a>
								</c:if>
								
							</td>
						</tr>
					</c:forEach>
					
					
				</tbody>
			</table>
			<!-- //table -->				
			
			<!-- paging -->
			${navi}
			<!-- //paging -->

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
	
</div>
<!-- //container -->	

<!-- layer_popup 환자 신규등록 -->
<div id="add_pop" class="Pstyle2">
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
	<span class="b-close"><img src="/assets/user/pc/images/sub/btn_close02p.png" alt="닫기" /></span>
	<p class="ptit" id="popFormTxt">신규등록</p>
	<div class="content pformT">
	<form action="05.add.do" name="frm" id="frm">
		<input type="hidden" name="check_chart" id="check_chart" value="0" />
		<table>			
			<colgroup>
				<col width="120px" />
				<col width="*" />
			</colgroup>
			<tbody>				
				<tr style="display:none;" >
					<th>중복방지번호 <span class="fc04">*</span></th>
					<td>
						<input type="text" name="chart_num" id="chart_num" placeholder="중복방지번호 입력" style="width:120px;">
						<a href="#" id="chartBtn"><span id="chartBtn1" class="h34 cB">중복체크</span></a>
					</td>
				</tr>
				<tr>
					<th>환자명 <span class="fc04">*</span></th>
					<td><input type="text" name="name" id="name" placeholder="환자명 입력" style="width:220px;"></td>
				</tr>
				<tr>
					<th>성별 <span class="fc04">*</span></th>
					<td>
						<select name="sex" id="sex"  style="width:70px;">
							<option value="남자">남자</option>
							<option value="여자">여자</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>생년월일 <span class="fc04">*</span></th>
					<td>
						<select name="birth_year" id="birth_year"  style="width:70px;">
							<c:forEach var="i" begin="0" end="${sysYear-1900}">
							    <c:set var="yearOption" value="${sysYear-i}" />
							    <option value="${yearOption}"   <c:if test="${yearOption eq 1980 }">selected="selected"</c:if> >${yearOption}</option>
							</c:forEach>
						</select>
						년
						<select name="birth_month" id="birth_month"  style="width:60px;">
							<c:forEach var="i" begin="1" end="12">
								<option value="<c:if test="${i < 10 }">0</c:if>${i}"> <c:if test="${i < 10 }">0</c:if>${i}</option>
							</c:forEach>
						</select>
						월
						<select name="birth_day" id="birth_day"  style="width:60px;">
							<c:forEach var="i" begin="1" end="31">
								<option value="<c:if test="${i < 10 }">0</c:if>${i}"> <c:if test="${i < 10 }">0</c:if>${i}</option>
							</c:forEach>
						</select>
						일
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<input type="text" id="tel01" name="tel01" style="width:65px;" maxlength="4"> -
						<input type="text" id="tel02" name="tel02" style="width:65px;" maxlength="4"> -
						<input type="text" id="tel03" name="tel03" style="width:65px;" maxlength="4">
					</td>
				</tr>
				<tr>
					<th>휴대전화 <span class="fc04">*</span></th>
					<td>
						<input type="text" id="handphone01" name="handphone01" style="width:65px;" maxlength="4"> -
						<input type="text" id="handphone02" name="handphone02" style="width:65px;" maxlength="4"> -
						<input type="text" id="handphone03" name="handphone03" style="width:65px;" maxlength="4">
					</td>
				</tr>
				<tr>
					<th>주소 <span class="fc04">*</span></th>
					<td>
						<span class="dI H40">
							<input type="text" name="zipcode" id="zipcode" style="width:180px;" readonly><a href="#" id="findAddrBtn"><span id="addrBtn1" class="h34 cB">주소찾기</span></a>
						</span>
						<span class="dI">
							<input type="text" name="address01" style="width:350px;" readonly id="address01">
							<input type="text" name="address02" placeholder="상세주소" style="width:350px;" id="address02"> 
						</span>
					</td>
				</tr>
				<tr>
					<th>체격/체형</th>
					<td>
						<textarea name="size" id="size" style="width:350px; height:20px;resize:none;"></textarea>
					</td>
				</tr>
				<tr style="display:none;">
					<th>진단</th>
					<td>
						<textarea name="jindan" id="jindan" style="width:350px; height:40px;resize:none;"></textarea>
					</td>
				</tr>
				<tr>
					<th>증상</th>
					<td>
						<textarea name="contents" id="contents" style="width:350px; height:30px;resize:none;"></textarea>
					</td>
				</tr>
				<tr style="display:none;">
					<th>기타1</th>
					<td>
						<textarea name="etc1" id="etc1" style="width:350px; height:30px;resize:none;"></textarea>
					</td>
				</tr>
				<tr style="display:none;">
					<th>기타2</th>
					<td>
						<textarea name="etc2" id="etc2" style="width:350px; height:30px;resize:none;"></textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<!-- btnarea -->
		<div class="btn_area02 pt0 mb0">
			<a href="#" id="popupButton1"><span class="cg h35">등록하기</span></a>
		</div>
		<!-- //btnarea -->
		
	</form>
	</div>
</div>
<!-- //layer_popup 환자 신규등록 -->