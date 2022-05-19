<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>	
	<title>청담원외탕전</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta name="title" content="청담원외탕전" />
	<link rel="stylesheet" type="text/css" href="/assets/user/m/css/public.css?" />
	<script  src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="/assets/common/js/jSignature/jSignature.min.js"></script> 
	<!-- <script src="libs/modernizr.js"></script> --> 
	<!--[if lt IE 9]> 
		<script type="text/javascript" src="/assets/common/js/jSignature/flashcanvas.js"></script> 
	<![endif]-->


	<script>
		$(document).ready(function() {
			$("#closeBtn").click(function() {
				window.close();
				return false;
			});
			
			$("#signature").jSignature({
				 'UndoButton':false
				,'height'    : 100
				,'width'     : '100%'
			});
			
			$("#clearBtn").click(function() {
				$('#signature').jSignature('reset');
				return false;
			});
			
			
			$("#saveBtn").click(function() {
				 
				var ea = $('#ea').val();
				
				if(ea<=0){
					alert('조제수량은 0개 이상이여야 합니다.');
					$('#ea').focus();
					return false;
				}
				
				
				var data = $('#signature').jSignature("getData", "base30");
	             var i = new Image()
	             i.src = "data:" + data[0] + "," + data[1];
		        
	             if(i.src == 'data:image/jsignature;base30,'){
		        	 alert('서명이 필요합니다.');
		        	 return false;
		         }
	             
	             $('#sing_img').val(i.src);
	             
	             $.ajax({
	     		    url  : '/m03/01_preorder_proc.do',
	     		    type : "POST",
	     		    data : $("#frm").serialize(),
	     		    error: function(){
	     		    	alert('에러가 발생했습니다. 관리자에 문의하세요.');
	     		    },
	     		    success: function(data){
	     				alert(data.msg);
	     				if(data.suc){
	     					opener.parent.location.reload();
	     					window.close();
	     				}
	     		    }
	     		});
				
				return false;
			});
			
			init_img();
		});	
		
		function init_img(){
			var sing_img = $('#sing_img').val();
			
			if(sing_img != null && sing_img != null){
				$("#signature").jSignature("importData", sing_img);
			}
			
		}
	</script>
</head>
<body>
	<form action="/m03/01_preorder_proc.do" name="frm" id="frm">
		<input type="hidden" name="goods_seqno" value="${view.p_seq}" />
		<input type="hidden" name="p_seq"       value="${view.p_seq}" />
		<input type="hidden" id="sing_img"      name="sing_img" value="${order_view.sing_img }" />
		<div class="wrapper">
			<!-- header -->
			<div class="headerWrapper" id="header">
				<h1 class="logo"><a href="#"><img src="/assets/user/m/images/logo_top.png" alt="청담원외탕전"></a></h1>
			</div>
			<!-- //header -->
		
			<!-- container -->
			<div class="container sub" id="contents">
				<!-- LNB -->
				<div class="localMenu">
					<p class="tit">사전조제지시서 작성</p>
				</div>
				<!-- LNB -->
		
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- 사전조제지시서 작성 -->
					<div class="askForminner">
						<ul class="askForm">
							<li class="type02">
								<label class="title">상품</label>
								<div>${view.p_name }</div>
							</li>						
							<li class="type02">
								<label class="title">조제수량</label>
								<div>
									<select name="ea" id="ea"  style="width:30%">
										<c:set var="nowNum" value="101"></c:set>
								<c:forEach var="i" begin="1" end="${nowNum}">
									<option value="${nowNum - i}">${nowNum - i}</option>
								</c:forEach>
									</select>
								</div>
							</li>
							<li class="type03">
								<label class="title2" for="">서명<span>(아래 영역에서 손가락으로 서명하시면 됩니다.)</span></label>
							</li>
							<li style="display:inline-block;">
								<%-- <textarea name="" id="" style="width:100%; height:100px;resize:none;"></textarea> --%>
								<div class="bbline" style="height:100px;background-color: #fff;" id="signature"></div>
							</li>
						</ul>
						<a href="#" class="btnTypeBasic sizeXS colorBlack" id="clearBtn"><span>서명지우기</span></a>
					</div>
					<!-- // 사전조제지시서 작성 -->
					<div class="btnArea write">
						<button type="button" id="closeBtn" class="btnTypeBasic colorWhite"><span>취소</span></button>
						<button type="button" id="saveBtn" class="btnTypeBasic colorGreen"><span>완료</span></button>
					</div>
				</div>
				<!-- //본문 -->
		
			</div>
			<!-- //container -->
		</div>
	</form>
</body>
</html>	