<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="Expires" content="-1"> 
<meta http-equiv="Pragma" content="no-cache"> 
<meta http-equiv="Cache-Control" content="No-Cache">	
<title>탕전주문내역서</title>
<link rel="stylesheet" href="/assets/admin/css/admin.css" />
<script  src="https://code.jquery.com/jquery-1.12.4.js" ></script>
<script src="/assets/common/js/jSignature/jSignature.min.js"></script>
<!--[if lt IE 9]> 
	<script type="text/javascript" src="/assets/common/js/jSignature/flashcanvas.js"></script> 
<![endif]-->
<style>
	body {
		margin: 0;
		padding: 0;
	}

	*{
		box-sizing: border-box;
		-moz-box-sizing: border-box;
	}

	.page {
		width: 21cm;
		min-height: 29.7cm;
		padding: 2cm;
		margin: 0 auto;
		background:#eee;
	}

	.subpage {
		border: 2px gray dott;
		background:#fff;   
		height: 257mm;
	}

	@page {
	size: A4;
		margin: 0;
	}

	@media print {

		html, body {
			width: 210mm;
			height: 297mm;
		}

		.page {
			margin: 0;
			border: initial;
			width: initial;
			min-height: initial;
			box-shadow: initial;
			background: initial;
			page-break-after: always;
		}
	}
	
	.basic02 tbody tr td{
		padding : 4px 0 2px 0;
		
	}
</style>

<script>
$(document).ready(function() {
	
	$("#signature").jSignature({
		 'UndoButton':false
		,'height'    : 190
		,'width'     : 479
	});
	
	init_img();
	
	setTimeout(function(){
		window.print();
   	},200);
});

function init_img(){
	var sing_img = $('#sing_img').val();
	
	if(sing_img != null && sing_img != null){
		//console.log('sing_img = ',sing_img);
		$("#signature").jSignature("importData", sing_img);
		
		
		var data = $('#signature').jSignature("getData", "image");
		//console.log('data = ', data);
		
		var i = new Image()
        i.src = "data:" + data[0] + "," + data[1];
		
		$("#signature_img").attr("src", i.src);
	}
	
}
</script>
</head>
<body style="background-color: #fff;">
<input type="hidden" id="sing_img"  name="sing_img" value="${sign.sing_img }" />

<div class="page">
	<div class="subpage">
	 	<div style="position: relative;">
			<div id="area1"  style="padding-top: 15px;position: relative;">
				<h2 style="font-size: 28px;font-weight: 700;padding-top: 5px;margin-bottom: 15px;">1 . 개요</h2>
				<table class="basic02" style="border-top : 1px solid #e5e5e5;">
					<colgroup>
						<col width="30%" />
						<col width="35%" />
						<col width="35%" />
					</colgroup>
					<tbody>
						<tr>
							<th>조제의뢰처</th>
							<th>조제지시월</th>
							<th>주의사항</th>
						</tr>
						
						<tr>
							<td>${info.han_name}</td>
							<td>${fn:replace(bean.search_month, '/', '년 ')}월</td>
							<td></td>
						</tr>
						
						<tr>
							<th>주소</th>
							<td colspan="2" style="text-align:left;padding-left:10px;">
								<c:if test="${not empty info.zipcode }">(${info.zipcode})</c:if>
								${info.address01 } ${info.address02}
							</td>						
						</tr>
						<tr>
							<th>연락처</th>
							<td colspan="2"  style="text-align:left;padding-left:10px;">
								${info.handphone }								
							</td>						
						</tr>
					</tbody>
				</table>
			</div>
			
			<div id="area2" style="padding-top: 15px;position: relative;height: 720px;overflow: hidden;">
				<h2 style="font-size: 28px;font-weight: 700;padding-top: 5px;margin-bottom: 15px;">2 . 조제 주문 처방</h2>
				<table class="basic02" style="border-top : 1px solid #e5e5e5;">
					<colgroup>
						<col width="10%" />
						<col width="70%" />
						<col width="20%" />
					</colgroup>
					<tbody>
						<tr>
							<th>순번</th>
							<th>처방명</th>
							<th>주문량</th>
						</tr>
						
						<c:forEach var="list" items="${list}">
							<c:set var="q" value="${q+1}"></c:set>
							<tr>
								<td>${q}</td>
								<td style="text-align:left;padding-left:5px;">${list.goods_name }</td>
								<td style="text-align:right;padding-right:43px;"><fmt:formatNumber value="${list.print_ea}" pattern="#,###" /></td>
							</tr>
						</c:forEach>					
					</tbody>
				</table>
			</div>		
			
			<div id="area3">
				<div style="text-align: right;position: relative;">
					<table class="basic02" style="border:none;">
						<colgroup>
							<col width="*" />
						</colgroup>
						<tr>
							<td style="border:none;font-size:20px;font-weight: 700;text-align:right;padding-right:10px;">
								${info.han_name} ( 서명 )
								<img style="height: 100px;width: 100px;margin:-40px 0 0 -75px" id="signature_img" >
							</td>
						</tr>
						
					</table>
					<div class="bbline" style="height:200px;width: 100%;display: none;" id="signature" ></div>
				</div>
			</div>
		</div>
	</div>
</div>	
	
</body>
</html>