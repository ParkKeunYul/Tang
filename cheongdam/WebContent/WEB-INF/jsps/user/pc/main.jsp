<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>	
	<title>청담원외탕전</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta http-equiv="Expires" content="-1" /> 
	<meta http-equiv="Pragma" content="no-cache" /> 
	<meta http-equiv="Cache-Control" content="No-Cache" />
	<meta name="title" content="청담원외탕전" />
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/style.css" />
	<script  src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="/assets/user/pc/js/jquery.bxslider.min.js" ></script>
	<script type="text/javascript" src="/assets/user/pc/js/common.js?${menu.pp}" ></script>
	<script type="text/javascript" src="/assets/common/js/validation.js" ></script>
	<script type="text/javascript">
    	$(document).ready(function() {
    		$(".draggable").draggable({ containment: "window" });
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
	<!--  IE 상단 떨림 추가 -->
	<style>
		/*Edge*/
		@supports ( -ms-accelerator:true ) 
		{
		    html{
		        overflow: hidden;
		        height: 100%;    
		    }
		    body{
		        overflow: auto;
		        height: 100%;
		    }
		}
		/*Ie 10/11*/
		@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) 
		{
		    html{
		        overflow: hidden;
		        height: 100%;    
		    }
		    body{
		        overflow: auto;
		        height: 100%;
		    }
		}
	</style>
	<!--[if lte IE 9]>
	<style type=text/css>
	       html{
	           overflow: hidden;
	           height: 100%;    
	       }
	       body{
	           overflow: auto;
	           height: 100%;
	       }
	    </style>
	<![endif]-->
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
	               <a href="#" onclick="popClose('${list.seqno}','TODAY');"> <img alt="팝업닫기" src="/assets/user/pc/images/main/poup_close.png" style="width:13px;height:13px;position:relative;top:7px"/></a>
	        </div>
	   	</div> 
	</c:forEach>
	<c:forEach var="list" items="${indi_list}">
		<c:set var="pop_show" value=""></c:set>
		<c:forEach var="clist" items="${cookie}">
			<c:if test="${clist.value.name eq list.pop_id}">
				<c:set var="pop_show" value="display:none;"></c:set>
			</c:if>		
		</c:forEach>
		
		<div class="draggable indi" id="tangPop_${list.seqno}" style="p;clear:both;z-index:10000131;position:absolute;top:${list.top_size}px;left:${list.left_size}px;width:${list.w_size}px;height:${list.h_size}px;background:#fff;${pop_show}">
	        <div style="cursor:pointer;width:${list.w_size}px;height:${list.h_size}px;overflow: hidden;">
	        	${fn:replace(list.CONTENT, newLineChar, "<br/>")}
	        </div>
	       	<div style="margin:0 auto;text-align: center;line-height:27px;width:<?=$list[width]?>;background-color:#f4f4f4;">
	            <input type="checkbox" name="popChk${list.seqno}" id="popChk${list.seqno}" /> <label for="popChk${list.seqno}">오늘하루 보지 않기</label>  
	            <a href="#none" onclick="popClose('${list.seqno}','TODAY');"> <img alt="팝업닫기" src="/assets/user/images/main/poup_close.png" style="width:13px;height:13px;position:relative;top:7px"/></a>
	        </div>
	   	</div>
	
	</c:forEach>
	<!-- 팝업// -->
		
		
		<!-- header 시작 -->
		<%@include file="./layout/header.jsp" %>
		<!-- //header -->
		
		<!-- Mcontainer -->
		<div id="Mcontainer">
			<div class="main_con">
				<div class="main_box1">
					<div class="main_banner">
						<ul class="main-slide">
							<li class="slide_1">
								<img src="/assets/user/pc/images/main/visual02.png" alt="" />
							</li>
							<li class="slide_2">
								<img src="/assets/user/pc/images/main/visual01.png" alt="" />
							</li>
						</ul>
					</div>
					<div class="main_box2">
						<div class="main_box2_1 pc">
							<a href="#"><img src="/assets/user/pc/images/main/bg_banner01_txt.png" alt="청담원외탕전 약속" /></a>
						</div>
						<div class="main_box2_1 pcw">
							<a href="#"><img src="/assets/user/pc/images/main/bg_banner01w_txt.png" alt="청담원외탕전 약속" /></a>
						</div>
						<div class="main_box2_2 pc">
							<a href="#"><img src="/assets/user/pc/images/main/bg_banner02_txt.png" alt="청담원외탕전 기술" /></a>
						</div>
						<div class="main_box2_2 pcw">
							<a href="#"><img src="/assets/user/pc/images/main/bg_banner02w_txt.png" alt="청담원외탕전 기술" /></a>
						</div>
					</div>
				</div>
				<div class="main_box3">
					<div class="main_box3_1">
						<p class="Mtit"><img src="/assets/user/pc/images/main/tit01.png" alt="청담원외탕전의 제품" /></p>
						<ul class="Mproduct">
							<c:forEach var="list" items="${goodslist}">
							<li><a href="/m03/01_view.do?p_seq=${list.p_seq}&page=1"  class="req_login"><p><img src="/upload/goods/${list.image}"  alt="${list.p_name }" /></p><span>${list.p_name }</span></a></li>
							</c:forEach>
						</ul>
					</div>
					<div class="main_box3_2 pc">
						<a href="#"><img src="/assets/user/pc/images/main/bg_banner03n.png" alt="" /></a>
					</div>
					<div class="main_box3_2 pcw">
						<a href="#"><img src="/assets/user/pc/images/main/bg_banner03wn.png" alt="" /></a>
					</div>
				</div>
			</div>
		</div>
		<!-- // Mcontainer -->
		<!-- footer -->
		<%@include file="./layout/footer.jsp" %>
		<!-- //footer -->
	</div>
</body>
</html>