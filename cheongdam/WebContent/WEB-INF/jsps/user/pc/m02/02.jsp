<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- container -->
<div id="container">
	
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
			
			
			$('#saveMyDic').click(function () {
				if($(".part_check:checkbox:checked").length == 0){
					alert('한개이상 선택하세요.');
					return false;
				}
				
				
				var check_seqno = '';
				var check_sname = '';
				
				var cnt = 0;
				$(".part_check:checkbox:checked").each(function(){
					if(cnt == 0){
						check_seqno = $(this).val();
						check_sname = "'"+$(this).attr('attr')+"'";
					}else{
						check_seqno += ","+$(this).val();
						check_sname += "||'"+ $(this).attr('attr')+"'";
					}
					cnt++;
				});
				console.log('check_seqno = ', check_seqno);
				
				$.ajax({
				    url: "/m02/02_add_mydic.do",		    
				    type : 'POST',
				    data : {
				    	 check_seqno : check_seqno
				    	,check_sname : check_sname
					},
			        error: function(){
				    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				    },
				    success: function(data){
				       console.log('data = ', data);
				       alert(data.msg);
				       
				       if(data.suc){
				    	   var cksubarr = $('.part_check'); 
						   $(cksubarr).each(function(i){cksubarr[i].checked = false;});
						   $('#all_check').prop("checked", false);
				       }
				    }   
				});	
				
				return false;
			});
			
		});
	</script>
	<!-- contents -->
	<div id="contents">
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>탕전처방</span><span>방제사전</span></p>
		</div>

		<ul class="sub_Menu w16">
			<li><a href="01.do">처방하기</a></li>
			<li><a href="06.do">실속처방</a></li>
			<li class="sel"><a href="02.do">방제사전</a></li>
			<li><a href="03.do">포장보기</a></li>
			<li><a href="04.do">환경설정</a></li>
			<li><a href="05.do">사용 설명서</a></li>
		</ul>
	
	
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit" style="width: 160px;">방제사전</p>
			<p>대표 처방집의 다양한 처방정보를 제공합니다.<br/>나의 처방으로 등록 하시면 <font class="fc01_t b">"마이페이지 > 나의처방 관리"</font> 에서 등록 하신 처방전을 수정 하실 수 있습니다.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">
			<%-- ${bean} --%>
			<!-- searchArea -->
			<div class="searchArea">
				<form action="" method="get" name="frm" id="frm">
					<select name="search_title" id="search_title"  style="width:130px;float:left;height: 37px;">
						<option value="T2.s_name"    <c:if test="${bean.search_title eq 'T2.s_name' }">selected="selected"</c:if>>처방명</option>
						<option value="T1.b_name"    <c:if test="${bean.search_title eq 'T1.b_name' }">selected="selected"</c:if>>출전</option>
						<option value="T2.s_jomun"   <c:if test="${bean.search_title eq 'T2.s_jomun' }">selected="selected"</c:if>>관련조문</option>
						<option value="T2.s_jukeung" <c:if test="${bean.search_title eq 'T2.s_jukeung' }">selected="selected"</c:if>>적응중</option>
						<option value="T2.s_chamgo"  <c:if test="${bean.search_title eq 'T2.s_chamgo' }">selected="selected"</c:if>>참고사항</option>
					</select>
					<div class="inputL" style="width: 200px;">
						<input type="text" placeholder="통합검색" style="width:165px;" name="search_value" id="search_value" value="${bean.search_value}" />
						<a href="#"><img src="/assets/user/pc/images/common/bg_search.png" alt="검색" class="mt8" id="searchDicBtn" /></a>
					</div>
					<ul class="search_han1">
						<li class="sel"><a href="?page=1&search_ch="  <c:if test="${bean.search_ch eq '' || bean.search_ch eq null}">class="sel"</c:if> >전체</a></li>
						<li><a href="?page=1&search_ch=ㄱ" <c:if test="${bean.search_ch eq 'ㄱ' }">class="sel"</c:if>>ㄱ</a></li>
						<li><a href="?page=1&search_ch=ㄴ" <c:if test="${bean.search_ch eq 'ㄴ' }">class="sel"</c:if>>ㄴ</a></li>
						<li><a href="?page=1&search_ch=ㄷ" <c:if test="${bean.search_ch eq 'ㄷ' }">class="sel"</c:if>>ㄷ</a></li>
						<li><a href="?page=1&search_ch=ㄹ" <c:if test="${bean.search_ch eq 'ㄹ' }">class="sel"</c:if>>ㄹ</a></li>
						<li><a href="?page=1&search_ch=ㅁ" <c:if test="${bean.search_ch eq 'ㅁ' }">class="sel"</c:if>>ㅁ</a></li>
						<li><a href="?page=1&search_ch=ㅇ" <c:if test="${bean.search_ch eq 'ㅇ' }">class="sel"</c:if>>ㅇ</a></li>
						<li><a href="?page=1&search_ch=ㅂ" <c:if test="${bean.search_ch eq 'ㅂ' }">class="sel"</c:if>>ㅂ</a></li>
						<li><a href="?page=1&search_ch=ㅅ" <c:if test="${bean.search_ch eq 'ㅅ' }">class="sel"</c:if>>ㅅ</a></li>
						<li><a href="?page=1&search_ch=ㅈ" <c:if test="${bean.search_ch eq 'ㅈ' }">class="sel"</c:if>>ㅈ</a></li>
						<li><a href="?page=1&search_ch=ㅊ" <c:if test="${bean.search_ch eq 'ㅊ' }">class="sel"</c:if>>ㅊ</a></li>
						<li><a href="?page=1&search_ch=ㅋ" <c:if test="${bean.search_ch eq 'ㅋ' }">class="sel"</c:if>>ㅋ</a></li>
						<li><a href="?page=1&search_ch=ㅍ" <c:if test="${bean.search_ch eq 'ㅍ' }">class="sel"</c:if>>ㅍ</a></li>
						<li><a href="?page=1&search_ch=ㅎ" <c:if test="${bean.search_ch eq 'ㅎ' }">class="sel"</c:if>>ㅎ</a></li>
					</ul>
				</form>
			</div>
			<!-- // searchArea -->
			<!-- myorder -->
			<table class="myorder">
				<colgroup>
					<col width="80px" />
					<col width="150px" />
					<col width="*" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_check" /></th>
						<th>출전</th>
						<th>처방명</th>
					</tr>	
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}">
						<c:set var="q" value="${q+1}"></c:set>
						<tr style="height:97px; ">
							<td><input type="checkbox" class="part_check" value="${list.seqno}" attr="${list.s_name }" /></td>
							<td>${list.b_name}</td>
							<td>
								<a href="02_view.do?seqno=${list.seqno}&search_ch=${bean.search_ch}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}">${list.s_name}</a><br/>
								<span>${list.item_list }</span>
							</td>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
			<!-- //myorder -->
			<div style="text-align: right;">
				<a href="#" id="saveMyDic"><span class="cg h30" >+ 선택항목을 나의 처방으로 등록</span></a>
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