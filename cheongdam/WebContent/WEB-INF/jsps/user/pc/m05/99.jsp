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
			<p class="sg"><span>마이페이지</span><span>포인트 사용내역</span></p>
		</div>

		<ul class="sub_Menu w20">
			<li><a href="01.do">내 정보수정</a></li>
			<!-- <li><a href="02.do">장바구니</a></li> -->
			<li><a href="03.do">주문내역</a></li>
			<!-- <li><a href="07.do">나의 처방관리</a></li> -->
			<li ><a href="05.do">환자관리</a></li>
			<li><a href="04.do">탕전공동사용계약서</a></li>
			<li class="sel"><a href="99.do">포인트 사용내역</a></li>
		</ul>
	
		<!-- 본문내용 -->
		<div class="contract">
			<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
			<div class="grayB">포인트 사용 및 적립 내용입니다.</div>
			
			<style>
				.point_box{
					margin: 20px 0 25px;
				}
				
				.useable_point{
					border: 1px solid #adc1dd;
					background: #00b49c;
					padding: 12px 18px 26px;
				}
				
				.useable_point_title{
					font-size : 16px;
					line-height: 35px;
					font-weight: 700;
					color: white;
					text-align: center;
				}
				
				.useable_point_amount{
					position: relative;
				    display: table-cell;
				    width: 940px;
				    height: 62px;
				    padding-bottom: 1px;
				    border: 1px solid #cbdaef;
				    text-align: center;
				    font-size: 16px;
				    font-family: Dotum,"돋움";
				    line-height: 100%;
				    font-weight: 700;
				    color: #006bff;
				    background: #fff;
				    vertical-align: middle;
				}
				
				.useable_point_amount .amount{
					margin-top: 0;
				    font-size: 26px;
				    line-height: 30px;
				    vertical-align: middle;
				    width: 100%;
				
				}
			
			</style>
			<div class="point_box">
				<dl class="useable_point">
					<dt class="useable_point_title">
						사용가능한 포인트
					</dt>
					<dd class="useable_point_amount">
						<strong class="amount">
						<c:choose>
							<c:when test="${empty point_all}">0</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${point_all.tot}" pattern="#,###" />	
							</c:otherwise>
						</c:choose>
						
						</strong>
					</dd>
				</dl>
			</div>
			
			<table class="basic_list">
				<colgroup>
					
					<%-- <col width="130px" /> --%>
					<col width="*" />
					<col width="150px" />
					<col width="250px" />					
				</colgroup>
				<thead>
					<tr>
						<th>내역</th>
						<th>포인트</th>
						<th>변동일</th>						
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty  list}">
						<tr>
							<td colspan="3">포인트 적립 사용 기록이 없습니다.</td>
						</tr>
					</c:if>
				
					<c:forEach var="list" items="${list}">
						<tr>
							<td style="text-align:left;padding-left:15px;">								
								<c:if test="${list.pp_seqno ne 0 }">${list.use_reason} 상품 결제</c:if>
								<c:if test="${list.pp_seqno eq 0 }">${list.reason}</c:if>								
							</td>
							<td style="text-align:right;">
								<c:choose>
									<c:when test="${list.point_type eq 'p' }">
										<span style="color: blue;">+ <fmt:formatNumber value="${list.point}" pattern="#,###" /></span>
									</c:when>
									<c:otherwise>
										<span style="color: red;">- <fmt:formatNumber value="${list.point}" pattern="#,###" /></span>
									</c:otherwise>
								</c:choose>
							</td>
							<td>${list.reg_date}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			${navi}
			
		</div>
		<!-- //본문내용 -->
		<!-- //내용 -->
	</div>
	<!-- //contents -->
	
</div>
<!-- //container -->	

