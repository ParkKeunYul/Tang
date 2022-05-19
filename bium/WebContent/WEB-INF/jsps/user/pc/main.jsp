<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>	
	<title>비움환원외탕전</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta http-equiv="Expires" content="-1" /> 
	<meta http-equiv="Pragma" content="no-cache" /> 
	<meta http-equiv="Cache-Control" content="No-Cache" />
	<meta name="title" content="비움환원외탕전" />
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/style.css" />
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/swiper.min.css" />
	
	
	<script  src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script type="text/javascript" src="/assets/user/pc/js/common.js?24" ></script>
	<script type="text/javascript" src="/assets/common/js/validation.js?3" ></script>
	<script src="/assets/user/pc/js/swiper.min.js?4"></script>
	<script type="text/javascript">
    	$(document).ready(function() {
    		$(".draggable").draggable({ containment: "window" });
    		
    		var swiper = new Swiper('.swiper-container', {
    			autoplay: {
    				delay: 5000,
    			},
    			slidesPerView: 1,
    			spaceBetween: 30,
    			loop: true,
    			pagination: {
    			el: '.swiper-pagination',
    			clickable: true,
    			},	
    			spaceBetween: 3000,
    			effect: 'fade',
    			speed: 3000,
    		});
    	});
    	
    	function popClose(seq,mode){
    		if($("#popChk"+seq).is(":checked") == true){
    			if($("#popChk"+seq+":checked").val() == 'TODAY'){
    				CookieManager.put('tangPop'+seq, seq, 60*60*24);
    			}else{
    				CookieManager.put('tangPop'+seq, seq, 60*60*24*365);
    			}
    		}
    		$("#tangPop_"+seq).css("display","none");
    	}
	</script>
</head>
<body>
	<div id="wrap">
		<!-- 팝업 -->
		<c:forEach var="list" items="${all_list}">
			<c:set var="pop_show" value=""></c:set>
			<c:forEach var="clist" items="${cookie}">
				<c:if test="${clist.value.name eq list.pop_id}">
					<c:set var="pop_show" value="display:none;"></c:set>
				</c:if>		
			</c:forEach>
			
			<div class="draggable" id="tangPop_${list.seqno}" style="p;clear:both;z-index:10000131;position:absolute;top:${list.top_size}px;left:${list.left_size}px;width:${list.w_size}px;height:${list.h_size}px;background:#fff;${pop_show}">
		        <div style="cursor:pointer;width:${list.w_size}px;height:${list.h_size}px;overflow: hidden;">
		        	<c:choose>
		        		<c:when test="${!empty list.yn_link}">
		        			<a href="${list.yn_link}" <c:if test="${list.yn_win eq 'y' }">target="_blank"</c:if>>
				        		<img src="/upload/popup/all/${list.upfile}" alt="${list.title}" width="${list.w_size}" height="${list.h_size}" />
				        	</a>
		        		</c:when>
		        		<c:otherwise>
		        			<img src="/upload/popup/all/${list.upfile}" alt="${list.title}" width="${list.w_size}" height="${list.h_size}" />
		        		</c:otherwise>
		        	</c:choose>		        		        		        		        
		        </div>
		       	<div style="margin:0 auto;text-align: center;line-height:27px;width:<?=$list[width]?>;background-color:#f4f4f4;">
		               <input type="checkbox" name="popChk${list.seqno}" id="popChk${list.seqno}" /> <label for="popChk${list.seqno}">오늘하루 보지 않기</label>  
		               <a href="#" onclick="popClose('${list.seqno}','TODAY');"> <img alt="팝업닫기" src="/assets/user/pc/images/poup_close.png" style="width:13px;height:13px;position:relative;top:7px"/></a>
		        </div>
		   	</div> 
		</c:forEach>
	
		<!-- header 시작 -->
		<%@include file="./layout/header.jsp" %>
		<!-- //header -->
		
		<!-- Mcontainer -->
		<div id="Mcontainer">
			<!-- Mcontents -->
			<div class="Mcontents">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="/assets/user/pc/images/visual03.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="/assets/user/pc/images/visual01.jpg" alt="" /></div>
					</div>
					<!-- Add Pagination -->
					<div class="swiper-pagination"></div>
				</div>
				<div class="bannerArea">
					<!-- 공지사항 -->
					<div class="notice">
						<p class="tit">공지사항 <a href="/m04/01.do" class="req_login">+</a></p>
						<ul class="">
							<c:forEach var="list" items="${nlist}">
								<li><a href="/m04/01_view.do?seq=${list.seq}&board_name=notice&page=1&search_title=&search_value=" class="req_login">${list.title}</a><span>${list.reg_date_user }</span></li>
							</c:forEach>
						</ul>
					</div>
					<!-- 공지사항 -->
					<!-- 약속처방 -->
					<div class="banner ic01">
						<p class="tit">약속처방</p>
						<p class="txt"><span>주문 마감 : 평일 15시</span>* 마감시간 이후 주문건은 <br/>&nbsp;&nbsp; 익일 발송됩니다.</p>
						<a href="/m03/01.do" class="req_login">바로가기 &gt;</a>
					</div>
					<!-- //약속처방 -->
					<!-- 이용안내 -->
					<div class="banner ic02">
						<p class="tit">이용안내</p>
						<p class="txt">원외탕전 협약서<br/>보건소 신고 안내</p>
						<a href="/m04/02.do" class="req_login">바로가기 &gt;</a>
					</div>
					<!-- //이용안내 -->
				</div>
				<div class="mproduct">
					<p class="tit">몸은 비우고 건강을 채우는!<span>비움환 원외탕전의 제품</span></p>
					<ul>
						<c:forEach var="list" items="${goodslist}">
							<li><a href="/m03/01_view.do?p_seq=${list.p_seq}&page=1"  class="req_login"><img src="/upload/goods/${list.image}" alt="${list.p_name }" />${list.p_name }</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- //Mcontents -->
		</div>
		<!-- // Mcontainer -->
		<!-- footer -->
		<%@include file="./layout/footer.jsp" %>
		<!-- //footer -->
		
	</div>
</body>
</html>