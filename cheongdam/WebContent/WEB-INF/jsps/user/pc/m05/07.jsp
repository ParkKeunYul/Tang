<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!-- container -->
<script>
	$(document).ready(function() {
		
		$("#searchDicBtn").click(function() {
			$('#frm').submit();
		});
		
		$("#search_value").keydown(function(key) {
			if (key.keyCode == 13) {
				$('#frm').submit();
			}
		});
		
		$('#all_check').click(function () {
			var cksubarr = $('.part_check'); 
			if($(this).is(":checked")){
				 $(cksubarr).each(function(i){cksubarr[i].checked = true;});
			} else {
				$(cksubarr).each(function(i){cksubarr[i].checked = false;});
			}
		});
		
		$('.part_check').click(function () {
			if($(".part_check:checkbox:checked").length == 5){
				$('#all_check').prop("checked", true);
			}else{
				$('#all_check').prop("checked", false);
			}
		});
		
		$('#delBtn').click(function () {
			if($(".part_check:checkbox:checked").length == 0){
				alert('1개 이상 선택하세요.');
				return false;
			}
			
			var all_seqno = '';
			var i = 0;
			$(".part_check:checked").each(function() {
				var seqno = $(this).val();
				if(i == 0){
  					all_seqno  = seqno
  				}else{
  					all_seqno += ','+seqno
  				}
				i++;
			});
			console.log('all_seqno = ', all_seqno);
			
			if(!confirm('삭제 하겠습니까?')){
				return false;
			}
			
			$.ajax({
				url : '/m05/07_del.do',
				type : 'POST',
				data : {
					seqno : all_seqno
				},
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(data) {
					alert(data.msg);
					if (data.suc) {
						location.href=window.location.href;
					}
				}
			});
			return false;
		});
		
		
		
	});
</script>

<div id="container">
	<!-- contents -->
	<div id="contents">
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>마이페이지</span><span>장바구니</span></p>
		</div>

		<ul class="sub_Menu w16">
			<li><a href="01.do">내 정보수정</a></li>
			<li><a href="02.do">장바구니</a></li>
			<li><a href="03.do">주문내역</a></li>
			<li  class="sel"><a href="07.do">나의 처방관리</a></li>
			<li><a href="05.do">환자관리</a></li>
			<li><a href="04.do">탕전공동사용계약서</a></li>
		</ul>
	
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit" style="width: 250px;">나의 처방 관리</p>
			<p>자주 사용하는 처방은 매번 새로 처방할 필요없이 <strong>나의 처방 관리에 등록해두면 처방할 때 ‘나의 처방’으로 불러 오기 기능</strong>을 통해 간편하게 이용할 수 있습니다. </p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">
			<div class="searchBox01"  style="padding-top: 50px;">
				<form action="" method="get" name="frm" id="frm">
					<select name="search_title" id="search_title" style="width:150px;">
						<option value="T1.s_name"    <c:if test="${bean.search_title eq 'T1.s_name' }">selected="selected"</c:if>>처방명</option>
						<option value="T1.b_name"    <c:if test="${bean.search_title eq 'T1.b_name' }">selected="selected"</c:if>>출전</option>
						<option value="T1.s_jomun"   <c:if test="${bean.search_title eq 'T1.s_jomun' }">selected="selected"</c:if>>관련조문</option>
						<option value="T1.s_jukeung" <c:if test="${bean.search_title eq 'T1.s_jukeung' }">selected="selected"</c:if>>적응중</option>
						<option value="T1.s_chamgo"  <c:if test="${bean.search_title eq 'T1.s_chamgo' }">selected="selected"</c:if>>참고사항</option>
					</select>
					<div class="winput">
						<input type="text" style="width:200px;" name="search_value" id="search_value" value="${bean.search_value}" />
						<a href="#" id="searchDicBtn"><img src="/assets/user/pc/images/common/bg_search.png" alt="검색" class="mt8" /></a>
					</div>
				</form>
			</div>
			<!-- myorder -->
			<table class="myorder">
				<colgroup>
					<col width="80px" />
					<col width="150px" />
					<col width="*" />
					<col width="140px" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>출전</th>
						<th>처방명</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
						<tr>
							<td><input type="checkbox" class="part_check" value="${list.seqno}" attr="${list.s_name }" /></td>
							<td>${list.b_name}</td>
							<td>
								<a href="07_view.do?seqno=${list.seqno}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">${list.s_name}</a><br/>
								<span>${list.item_list }</span>
							</td>
							<td>${list.wdate2}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- //myorder -->
			<div>
				<a href="#" id="delBtn"><span class="cBB h30" style="font-weight: 700;">선택항목 삭제</span></a>
				<a href="07_add.do?page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}" class="fr"><span class="cg h30"  style="font-weight: 700;">+ 나의처방 추가</span></a>
			</div>

			<!-- paging -->
			${navi}
			<!-- //paging -->

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	