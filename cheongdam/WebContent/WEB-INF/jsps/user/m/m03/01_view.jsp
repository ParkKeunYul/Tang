<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
 							location.href='/m/m03/02.do';
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
		
		$('.infoinner img').each(function () {
			var img=$(this);
			
			 var width  = img.width(); 
	         var height = img.height(); 
			 var div_width = $('.infoinner').width();
			 
			 if(width> div_width){
				 img.css('width', '99%');
			 }
			 
			 console.log(width , div_width);
	         
		});
	});
	
	
	function init_img(){
		var fir_img = $('#goods_img li:first a img').attr('src');
		$('#title_img').attr('src', fir_img);
	}
</script>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">약속처방</p>
		<div class="lnbDepth">
			<ul>
				<li class="sel"><a href="01.do">약속처방</a></li>
				<li><a href="02.do">약속처방 보관함</a></li>
				<li><a href="03.do">사전조제지시서</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->
	<form action="/m/m03/01_add_order.do" name="frm" id="frm" method="post" >
		<input type="hidden"  id="price" name="price" value="${view.p_price}"/>
		<input type="hidden"  id="p_seq" name="p_seq" value="${view.p_seq}"/>
		
		<input type="hidden"  id="box_option_price" name="box_option_price" value=""/>
		<input type="hidden"  id="box_option_nm"    name="box_option_nm" value=""/>
		<input type="hidden"  id="box_option_seqno" name="box_option_seqno" value=""/>
		<input type="hidden"  id="pre_seq" name="pre_seq" value="${view.pre_req}"/>
	
		<!-- 본문 -->	
		<div class="contents" id="contents">
			<div style="min-height: 50px;">
				<div id="mainBanner" class="owl-carousel owl-theme">
					<c:if test="${not empty view.image }">
						<span class="topBannerWrapper"><img src="/upload/goods/${view.image}" alt="" /></span>
					</c:if>
					<c:if test="${not empty view.image1 }">
						<span class="topBannerWrapper"><img src="/upload/goods/${view.image1}" alt="" /></span>
					</c:if>
					<c:if test="${not empty view.image2 }">
						<span class="topBannerWrapper"><img src="/upload/goods/${view.image2}" alt="" /></span>
					</c:if>
				</div>
			</div>
			<!-- productView -->
			<div class="productView">
				<!-- inner -->
				<div class="inner">
					<!-- 상품정보 -->
					<ul class="infobox">
						<li>
							<label class="title">처방명</label>
							<p class="name">${view.p_name}</p>
						</li>
						<li>
							<label class="title">출전</label>
							<p>${view.jo_from}</p>
						</li>
						<li>
							<label class="title">용량</label>
							<p>${view.p_size}</p>
						</li>
						<li>
							<label class="title">처방비용</label>
							<p><span class="won"><fmt:formatNumber value="${view.p_price}" pattern="#,###" /></span>원</p>
						</li>
						<li>
							<label class="title">처방구성</label>
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
							<p>
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
							</p>
						</li>
					</ul>
					<!-- //상품정보 -->
	
					<!-- 처방정보 -->
					<ul class="countbox">
						<c:if test="${view.pre_req eq 'Y' }">
							<li>
								<label class="title">처방현황</label>
								<c:choose>
									<c:when test="${empty pre_order || pre_order.ea <= 0}">
										<dd class="fc02">사전조제지시서 필요</dd>	
									</c:when>
									<c:otherwise>
										<p class="count">${pre_order.ea}개 처방 가능</p>
									</c:otherwise>
								</c:choose>
								
							</li>
						</c:if>
						<li>
							<label class="title">수량</label>
							<c:if test="${view.pre_req eq 'Y' }">
								<select name="ea" id="ea"   style="width:50%;">
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
						</li>
						
						<li style="<c:if test="${empty  option_list}">display: none;</c:if>">
							<label class="title">포장</label>
							<select name="box_option" id="box_option"   style="width:50%;">
								<option value="0" attr1="선택안함" attr2="0">선택안함</option>	
								<c:forEach var="list" items="${option_list}">
									<option value="${list.seqno}" attr1="${list.box_nm}"  attr2="${list.box_price}">${list.box_nm} (<fmt:formatNumber value="${list.box_price}" pattern="#,###" />)</option>
								</c:forEach>
							</select>
						</li>
					</ul>
					<!-- //처방정보 -->
				</div>
				<!-- //inner -->
				<div class="btnArea view">
					<c:choose>
						<c:when test="${pre_order.ea > 0  || view.pre_req ne 'Y'}">
							<c:if test="${userInfo.member_level ne 0 && userInfo.member_level ne 1 }">
								<button type="button" id="saveCartBtn" class="btnTypeBasic colorOrange"><span>보관함 담기</span></button>
								<button type="button" id="saveOrderBtn" class="btnTypeBasic colorGreen"><span>즉시발송</span></button>
							</c:if>
						</c:when>
						<c:otherwise>
							<button class="btnTypeBasic colorORed" type="button" onclick="window.open('/m/m03/01_preorder.do?p_seq=${view.p_seq}','사전조제지시','width=700, height=570, menubar=no, status=no, toolbar=no');"><span>사전조제지시서 작성</span></button>
						</c:otherwise>
					</c:choose>
					
				</div>
			</div>			
			<!-- productView -->
	
			
			<!-- productInfo -->
			<div class="productInfo">
				<p class="tit">상품정보</p>
				<div class="infoinner">
					${view.p_contents}
				</div>
			</div>
			<!-- //productInfo -->
			<div class="btnArea">
				<a href="01.do?p_seq=${list.p_seq}&page=${bean.page}&group_code=${bean.group_code}&sub_code=${bean.sub_code}&search_value=${bean.encodeSV}" class="btnTypeBasic colorGray"><span>목록보기</span></a>
			</div>
		</div>
		<!-- //본문 -->
	</form>

</div>
<!-- //container -->