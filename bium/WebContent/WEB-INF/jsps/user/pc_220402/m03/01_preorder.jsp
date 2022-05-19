<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>	
	<title>청담원외탕전</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta name="title" content="청담원외탕전" />
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/style.css" />
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
				,'height'    : 190
				,'width'     : 529
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
	     		    url  : '01_preorder_proc.do',
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
<!-- container -->
	<div class="popup">
		<form action="01_preorder_proc.do" name="frm" id="frm">
			<input type="hidden" name="goods_seqno" value="${view.p_seq}" />
			<input type="hidden" name="p_seq"       value="${view.p_seq}" />
			<input type="hidden" id="sing_img"      name="sing_img" value="${order_view.sing_img }" />
			<p class="tit">사전조제지시서 작성</p>
			<div class="innerArea">
				<table class="popT">
					<colgroup>
						<col width="13%"/>
						<col width="*"/>
						<col width="15%"/>
						<col width="30%"/>
					</colgroup>
					<tr>
						<th>상품</th>
						<td>${view.p_name }</td>
						<th>조제수량</th>
						<td>
							<select name="ea" id="ea" class="opt" style="width:70px;">
								<c:set var="nowNum" value="101"></c:set>
								<c:forEach var="i" begin="1" end="${nowNum}">
									<option value="${nowNum - i}">${nowNum - i}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th colspan="4">서명<span class="fc03"> (아래 영역에서 마우스 왼쪽버튼을 누른채 드래그하시면 됩니다.)</span></th>
					</tr>
					<tr>
						<td colspan="4">
							<div class="bbline" style="height:200px;" id="signature"></div>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="ar"><a href="#" id="clearBtn"><span class="h25 cB">서명지우기</span></a></td>
					</tr>
				</table>
			</div>
			<!-- btnarea -->
			<div class="btn_area01">
				<a href="#" id="closeBtn"><span class="cw h30 w120">취소</span></a>
				<a href="#" id="saveBtn"><span class="cp h30 w120">완료</span></a>
			</div>
			<!-- //btnarea -->
		</form>
	</div>
</body>
</html>	