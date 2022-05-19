<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- container -->
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<div id="container">

	<script>
		$(document).ready(function() {
			$('#saveMyDic').click(function () {
				
				var check_seqno = $('#check_seqno').val();
				var check_sname = $('#check_sname').val();
				
				$.ajax({
				    url: $(this).attr('href'),		    
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
				    }   
				});	
				return false;
			});
			
			$('#dicOrderBtn').click(function () {
				if(confirm($('#s_name').val()+' 처방하겠습니까?')){
					return true;
				}
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
			<p class="Ltit">방제사전</p>
			<p>대표 처방집의 다양한 처방정보를 제공합니다.<br/>나의 처방으로 등록 하시면 <font class="fc01_t b">"마이페이지 > 나의처방 관리"</font> 에서 등록 하신 처방전을 수정 하실 수 있습니다.</p>
		</div>
		<!-- // 서브타이틀 -->
		
		<!-- 내용 -->
		<div class="conArea">
			<input type="hidden"  id="s_name" value="${view.s_name}" />
			<!-- dictionary_view -->
			<table class="view01">
				<colgroup>
					<col width="200px" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>처방명</th>
						<td>${view.b_name}  /  ${view.s_name}</td>
					</tr>
					<tr>
						<th>관련조문</th>
						<td>${fn:replace(view.s_jomun, newLineChar, "<br/>")}</td>
					</tr>
					<tr>
						<th>적응증</th>
						<td>${fn:replace(view.s_jukeung, newLineChar, "<br/>")}</td>
					</tr>
					<tr>
						<th>참고사항</th>
						<td>${fn:replace(view.s_chamgo, newLineChar, "<br/>")}</td>
					</tr>
					<%-- <tr>
						<th>약재정보</th>
						<td>
							<c:forEach var="list" items="${subList}">
								${list.yak_name}[${list.dy_standard }],
							</c:forEach>
						</td>
					</tr> --%>
				</tbody>
			</table>
			<table class="view02">
				<colgroup>
					<col width="*" />
					<col width="200px" />
					<col width="150px" />
					<col width="150px" />
					<col width="160px" />
				</colgroup>
				<thead>
					<tr>
						<th>약재명</th>
						<th>원산지</th>
						<th>표준량(g)</th>
						<th>단가(g)</th>
						<th>가격</th>
					</tr>
				</thead>
				<tbody>
					<c:set var = "sum0" value = "0" />
					<c:set var = "sum1" value = "0" />
		        	<c:set var = "sum2" value = "0" />
				
					<c:forEach var="list" items="${subList}">
						<c:set var="sum0" value = "${sum0 + list.dy_standard}" />
						<c:set var="sum1" value = "${sum1 + list.yak_danga}" />
						
						<c:set var="pages" value="${list.yak_danga * list.dy_standard}" />
						<c:set var="sum2" value = "${sum2 + (pages+(1-(pages%1))%1)}" />
						<tr>
							<td class="L">${list.yak_name}</td>
							<td>${list.yak_from}</td>
							<td>${list.dy_standard }</td>
							<td class="R">
								<fmt:formatNumber value="${list.yak_danga}" pattern=".00 원" type = "number" />
							</td>
							<td class="R">
								<fmt:formatNumber value="${pages+(1-(pages%1))%1}" pattern="#,### 원" type = "number" />
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" class="Rtit">합계</td>
						<td><span><fmt:formatNumber value="${sum0}" type = "number"  /></span>g</td>
						<td class="R"><span><fmt:formatNumber value="${sum1}" type = "number"  /></span>원</td>
						<td class="R"><span><fmt:formatNumber value="${sum2}" type = "number"  /></span>원</td>
					</tr>
				</tfoot>
			</table>
			<!-- //dictionary_view -->
			<div class="btn_area03">
				<input type="hidden" id="check_seqno" value="${view.seqno}" />
				<input type="hidden" id="check_sname" value="'${view.s_name}'" />
				<a href="/m02/02_add_mydic.do" id="saveMyDic"><span class="cg h34">나의 처방 관리에 등록</span></a>
				<a href="/m02/01.do?dic_seqno=${view.seqno}" id="dicOrderBtn"><span class="cblue h34">처방하기</span></a>
				<a href="02.do?search_ch=${bean.search_ch}&page=${bean.page}&search_title=${bean.search_title}&search_value=${bean.encodeSV}"><span class="cglay h34">목록</span></a>
			</div>
		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	