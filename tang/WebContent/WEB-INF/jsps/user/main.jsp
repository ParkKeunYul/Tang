<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>	
	<title>북경한의원 원외탕전실</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<meta http-equiv="Expires" content="-1" /> 
	<meta http-equiv="Pragma" content="no-cache" /> 
	<meta http-equiv="Cache-Control" content="No-Cache" />
	<meta name="title" content="북경한의원 원외탕전실" />
	<link rel="stylesheet" type="text/css" href="/assets/user/css/style.css" />
	<script  src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script  src="/assets/user/js/jquery.bpopup.min.js"></script>
	<script  src="/assets/user/js/common.js?111"></script>
	
	<script type="text/javascript" src="/assets/admin/js/validation.js"></script>
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
</head>
<body>

<div id="wrap">
	<!-- header 시작 -->
	<%@include file="./layout/header.jsp" %>
	<!-- //header -->
	
	
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
	        	<a href="${list.yn_link}" <c:if test="${list.yn_win eq 'y' }">target="_blank"</c:if>>
	        		<img src="/upload/popup/all/${list.upfile}" alt="${list.title}" width="${list.w_size}" height="${list.h_size}" />
	        	</a>	        		        	
	        </div>
	       	<div style="margin:0 auto;text-align: center;line-height:27px;width:<?=$list[width]?>;background-color:#f4f4f4;">
	               <input type="checkbox" name="popChk${list.seqno}" id="popChk${list.seqno}" /> <label for="popChk${list.seqno}">오늘하루 보지 않기</label>  
	               <a href="#" onclick="popClose('${list.seqno}','TODAY');"> <img alt="팝업닫기" src="/assets/user/images/main/poup_close.png" style="width:13px;height:13px;position:relative;top:7px"/></a>
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
	
	<!-- Mcontainer -->
	<div id="Mcontainer">
		<!-- Mcontents -->
		<div id="Mcontents">
			<p class="tit"><img src="/assets/user/images/main/main_txt.png" alt="약은 “정성”입니다" /></p>
			<ul>
				<li class="icon01"><a href="/m01/02.do"><img src="/assets/user/images/main/icon01.png" alt="탕전실의 약속" /></a></li>
				<li class="icon02"><a href="/m02/01.do" class="req_login"><img src="/assets/user/images/main/icon02.png" alt="탕전처방" /></a></li>
				<li class="icon03"><a href="/m03/01.do" class="req_login"><img src="/assets/user/images/main/icon03.png" alt="약속처방" /></a></li>
			</ul>
		</div>
		<!-- //Mcontents -->
	</div>
	<!-- //Mcontainer -->	
	
	<!-- footer -->
	<%@include file="./layout/footer.jsp" %>
	<!-- //footer -->
</div>
</body>
</html>