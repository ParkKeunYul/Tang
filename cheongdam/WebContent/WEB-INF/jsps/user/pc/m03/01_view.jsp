<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- container -->
<script>
var a_ajax_cart_flag = true;
	
	$(document).ready(function() {
		
		$("#saveOrderBtn").click(function() {
			var ea = parseInt($('#ea').val());
			
			if(ea <= 0){
				alert('최소 수량은 1개 이상이여야 합니다.');
				return false;
			}
			
			$('#box_option_seqno').val( $('#box_option option:selected').val() );
			$('#box_option_price').val( $('#box_option option:selected').attr('attr2') );
			$('#box_option_nm').val( $('#box_option option:selected').attr('attr1') );
			
			
			$.ajax({
				url : '/m03/01_remain_ea.do',
				type : 'POST',
				data : {
					 p_seq 			  : $('#p_seq').val()   
					,ea   			  : $('#ea').val()
					,box_option_price : $('#box_option option:selected').attr('attr2')
					,box_option_nm    : $('#box_option option:selected').attr('attr1')
					,box_option_seqno : $('#box_option option:selected').val()
					,pre_seq          : $('#pre_seq').val()
				},
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(data) {
					if(data.suc){
 						$('#frm').submit();
					}else{
						alert(data.msg);	
					}
				}
			});
			return false;
		});
		
		$("#saveCartBtn").click(function() {
			var ea = parseInt($('#ea').val());
			
			if(ea <= 0){
				alert('최소 수량은 1개 이상이여야 합니다.');
				return false;
			}
			
			if(!a_ajax_cart_flag){
				return false;
			}
			
			$.ajax({
				url : '/m03/01_add_cart.do',
				type : 'POST',
				data : {
					 p_seq 			  : $('#p_seq').val()   
					,ea   			  : $('#ea').val()
					,box_option_price : $('#box_option option:selected').attr('attr2')
					,box_option_nm    : $('#box_option option:selected').attr('attr1')
					,box_option_seqno : $('#box_option option:selected').val()
					,pre_seq          : $('#pre_seq').val()
				},
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(data) {
					if(data.suc){
						a_ajax_cart_flag = true;
 						if(confirm('약속처방 보관함에 저장되었습니다.\n약속처방 보관함으로 이동하겠습니까?')){
 							location.href='/m03/02.do';
 						}
					}else{
						alert(data.msg);	
					}
					
				}
			});
			return false;
		});
		
		$("#goods_img li").click(function() {
			$('#title_img').attr('src', $(this).children('a').children('img').attr('src'));
			return false;
		});
		
		
		$("#ea , #box_option").change(function() {
			var ea     = parseInt( $('#ea').val() );
			var price  = parseInt( $('#price').val());			
			var option = parseInt($('#box_option option:selected').attr('attr2') );
			
			$('.txt_num').text( comma( (ea * price) + option ));
			
		});
		
		init_img();
	});
	
	
	function init_img(){
		var fir_img = $('#goods_img li:first a img').attr('src');
		$('#title_img').attr('src', fir_img);
	}
</script>
<div id="container">

	<!-- contents -->
	<div id="contents">
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>약속처방</span><span>약속처방</span></p>
		</div>

		<ul class="sub_Menu w33">
			<li class="sel"><a href="01.do">약속처방</a></li>
			<li><a href="02.do">약속처방 보관함</a></li>
			<li><a href="03.do">사전조제지시서 관리</a></li>
		</ul>

		<!-- 본문내용 -->
		<div class="product_view">
			<form action="/m03/01_add_order.do" name="frm" id="frm" method="post" >
				<input type="hidden"  id="price" name="price" value="${view.p_price}"/>
				<input type="hidden"  id="p_seq" name="p_seq" value="${view.p_seq}"/>
				
				<input type="hidden"  id="box_option_price" name="box_option_price" value=""/>
				<input type="hidden"  id="box_option_nm"    name="box_option_nm" value=""/>
				<input type="hidden"  id="box_option_seqno" name="box_option_seqno" value=""/>
				
				<input type="hidden"  id="pre_seq" name="pre_seq" value="${view.pre_seq}"/>
				
				<!-- 상단 상품정보 -->
				<div class="infoArea">
					<div class="imgArea">
						<p><img src="#" id="title_img" width="400" height="300" alt="" /></p>
						<ul id="goods_img">
							<c:if test="${not empty view.image }">
								<li><a href="#"><img src="/upload/goods/${view.image }" width="120" height="90" alt="" /></a></li>
							</c:if>
							<c:if test="${not empty view.image2 }">
								<li><a href="#"><img src="/upload/goods/${view.image2 }" width="120" height="90" alt="" /></a></li>
							</c:if>
							<c:if test="${not empty view.image3 }">
								<li><a href="#"><img src="/upload/goods/${view.image3 }" width="120" height="90" alt="" /></a></li>
							</c:if>
						</ul>
					</div>
					
					<c:set var="yak_design1" value="${fn:split(view.yak_design1,'|')}" />
					<c:set var="yak_design2" value="${fn:split(view.yak_design2,'|')}" />
					<c:set var="yak_design3" value="${fn:split(view.yak_design3,'|')}" />
					<c:set var="yak_design4" value="${fn:split(view.yak_design4,'|')}" />
					<c:set var="yak_design5" value="${fn:split(view.yak_design5,'|')}" />
					<c:set var="yak_design6" value="${fn:split(view.yak_design6,'|')}" />
					<c:set var="yak_design7" value="${fn:split(view.yak_design7,'|')}" />
					<c:set var="yak_design8" value="${fn:split(view.yak_design8,'|')}" />
					<c:set var="yak_design9" value="${fn:split(view.yak_design9,'|')}" />
					<c:set var="yak_design10" value="${fn:split(view.yak_design10,'|')}" />
					<c:set var="yak_design11" value="${fn:split(view.yak_design11,'|')}" />
					<c:set var="yak_design12" value="${fn:split(view.yak_design12,'|')}" />
					<c:set var="yak_design13" value="${fn:split(view.yak_design13,'|')}" />
					<c:set var="yak_design14" value="${fn:split(view.yak_design14,'|')}" />
					<c:set var="yak_design15" value="${fn:split(view.yak_design15,'|')}" />
					
					<div class="product_info">
						<dl class="">
							<dt>처방명</dt>
							<dd class="name">${view.p_name}</dd>
							<dt>출전</dt>
							<dd>${view.jo_from}</dd>
							<dt>용량</dt>
							<dd>${view.p_size}</dd>
							<dt>처방비용</dt>
							<dd class="price"><fmt:formatNumber value="${view.p_price}" pattern="#,###원" /></dd>
							<dt>처방구성</dt>
							<dd>
								${yak_design1[0]}  ${yak_design1[2]}<c:if test="${!empty yak_design1[2]}">g, </c:if> 
								${yak_design2[0]}  ${yak_design2[2]}<c:if test="${!empty yak_design2[2]}">g, </c:if> 
								${yak_design3[0]}  ${yak_design3[2]}<c:if test="${!empty yak_design3[2]}">g, </c:if> 
								${yak_design4[0]}  ${yak_design4[2]}<c:if test="${!empty yak_design4[2]}">g, </c:if> 
								${yak_design5[0]}  ${yak_design5[2]}<c:if test="${!empty yak_design5[2]}">g, </c:if> 
								${yak_design6[0]}  ${yak_design6[2]}<c:if test="${!empty yak_design6[2]}">g, </c:if> 
								${yak_design7[0]}  ${yak_design7[2]}<c:if test="${!empty yak_design7[2]}">g, </c:if> 
								${yak_design8[0]}  ${yak_design8[2]}<c:if test="${!empty yak_design8[2]}">g, </c:if> 
								${yak_design9[0]}  ${yak_design9[2]}<c:if test="${!empty yak_design9[2]}">g, </c:if> 
								${yak_design10[0]} ${yak_design10[2]}<c:if test="${!empty yak_design10[2]}">g, </c:if> 
								${yak_design11[0]} ${yak_design11[2]}<c:if test="${!empty yak_design11[2]}">g, </c:if> 
								${yak_design12[0]} ${yak_design12[2]}<c:if test="${!empty yak_design12[2]}">g, </c:if> 
								${yak_design13[0]} ${yak_design13[2]}<c:if test="${!empty yak_design13[2]}">g, </c:if> 
								${yak_design14[0]} ${yak_design14[2]}<c:if test="${!empty yak_design14[2]}">g, </c:if> 
								${yak_design15[0]} ${yak_design15[2]}<c:if test="${!empty yak_design15[2]}">g</c:if>
							</dd>
						</dl>
		
						<dl class="brnone" style="margin-bottom: 0px;">
							<c:if test="${view.pre_req eq 'Y' }">
								<dt>처방현황</dt>
								<c:choose>
									<c:when test="${empty pre_order || pre_order.ea <= 0}">
										<dd class="fc02">사전조제지시서 필요</dd>	
									</c:when>
									<c:otherwise>
										<dd class="fc02">${pre_order.ea}개 처방가능</dd>
									</c:otherwise>
								</c:choose>
							</c:if>
							
							
							<dt>수량</dt>
							<dd>
								<c:if test="${view.pre_req eq 'Y' }">
									<select name="ea" id="ea" class="opt" style="width:80px;">
										<option value="0">0</option>	
										<c:if test="${not empty pre_order}">
											<c:forEach var="i" begin="1" end="${pre_order.ea}">
												<option value="${i}">${i}</option>
											</c:forEach>
										</c:if>													
									</select>
								</c:if>
								<c:if test="${view.pre_req ne 'Y' }">
									<select name="ea" id="ea" class="opt" style="width:80px;">
										<c:forEach var="i" begin="0" end="100">
											<option value="${i}">${i}</option>
										</c:forEach>
									</select>
								</c:if>
							</dd>
							
							<dt style="<c:if test="${empty  option_list}">display: none;</c:if>">포장</dt>
							<dd  style="<c:if test="${empty  option_list}">display: none;</c:if>">
								<select name="box_option" id="box_option" class="opt" style="width:300px;">
									<option value="0" attr1="선택안함" attr2="0">선택안함</option>
									<c:forEach var="list" items="${option_list}">
										<option value="${list.seqno}" attr1="${list.box_nm}"  attr2="${list.box_price}">${list.box_nm} (<fmt:formatNumber value="${list.box_price}" pattern="#,###" />)</option>
									</c:forEach>																
								</select>
							</dd>
						</dl>
							
						<c:choose>
							<c:when test="${pre_order.ea > 0 || view.pre_req ne 'Y'}">
								<div class="sum_total" style="clear: both;border-top:1px solid #acacac;padding-top: 15px;">
									<span class="num"></span>
									<span></span>
									<em>총 상품금액</em>
									<strong class="total_price"><span class="txt_num" style="font-weight:bold;">0</span><span class="won">원</span>
									</strong>
								</div>
								
								<div class="btn_area"  style="clear: both;margin-top: 0px;border: none;">
									<%-- <a href="#" class="mr5" onclick="window.open('01_preorder.do?p_seq=${view.p_seq}','window팝업','width=700, height=570, menubar=no, status=no, toolbar=no');"><span class="cr h352">사전조제지시서 작성</span></a> --%>
									<c:if test="${userInfo.member_level ne 0 && userInfo.member_level ne 1 }">
										<a href="#" class="mr5" id="saveCartBtn"><span class="cO h352">보관함 담기</span></a>						
										<a href="#" id="saveOrderBtn"><span class="cg h352">즉시발송</span></a>
									</c:if>
								</div>
							</c:when>
							<c:otherwise>
								<div class="btn_area"  style="clear: both;margin-top: 0px;border: none;">
									<a href="#" class="mr5" onclick="window.open('01_preorder.do?p_seq=${view.p_seq}','사전조제팝업','width=700, height=570, menubar=no, status=no, toolbar=no');"><span class="cr h352">사전조제지시서 작성</span></a>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<!-- //상단 상품정보 -->
				<!-- 상품 상세정보 -->
				<div class="detailArea">
					<p class="tit"><img src="/assets/user/pc/images/sub/tit01.png" alt="상품정보" /></p>
					<div class="conB">
						<strong>처방구성 및 제법</strong><br/>
						
						* 출전 : ${view.jo_from}<br/>
						* 처방구성 : 
						${yak_design1[0]}  ${yak_design1[2]}<c:if test="${!empty yak_design1[2]}">g</c:if> 
						${yak_design2[0]}  ${yak_design2[2]}<c:if test="${!empty yak_design2[2]}">g</c:if> 
						${yak_design3[0]}  ${yak_design3[2]}<c:if test="${!empty yak_design3[2]}">g</c:if> 
						${yak_design4[0]}  ${yak_design4[2]}<c:if test="${!empty yak_design4[2]}">g</c:if> 
						${yak_design5[0]}  ${yak_design5[2]}<c:if test="${!empty yak_design5[2]}">g</c:if> 
						${yak_design6[0]}  ${yak_design6[2]}<c:if test="${!empty yak_design6[2]}">g</c:if> 
						${yak_design7[0]}  ${yak_design7[2]}<c:if test="${!empty yak_design7[2]}">g</c:if> 
						${yak_design8[0]}  ${yak_design8[2]}<c:if test="${!empty yak_design8[2]}">g</c:if> 
						${yak_design9[0]}  ${yak_design9[2]}<c:if test="${!empty yak_design9[2]}">g</c:if> 
						${yak_design10[0]} ${yak_design10[2]}<c:if test="${!empty yak_design10[2]}">g</c:if> 
						${yak_design11[0]} ${yak_design11[2]}<c:if test="${!empty yak_design11[2]}">g</c:if> 
						${yak_design12[0]} ${yak_design12[2]}<c:if test="${!empty yak_design12[2]}">g</c:if> 
						${yak_design13[0]} ${yak_design13[2]}<c:if test="${!empty yak_design13[2]}">g</c:if> 
						${yak_design14[0]} ${yak_design14[2]}<c:if test="${!empty yak_design14[2]}">g</c:if> 
						${yak_design15[0]} ${yak_design15[2]}<c:if test="${!empty yak_design15[2]}">g</c:if><br/><br/>
	
						<strong>상품설명</strong><br/>
						${view.p_contents}
					</div>
				</div>
				<!-- //상품 상세정보 -->
			</form>
		</div>
		<!-- btnarea -->
		<div class="btn_area02">
			<a href="01.do?p_seq=${list.p_seq}&page=${bean.page}&group_code=${bean.group_code}&sub_code=${bean.sub_code}&search_value=${bean.encodeSV}"><span class="cglay h40">목록보기</span></a>
		</div>
		<!-- //btnarea -->
		<!-- //본문내용 -->
	
	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		