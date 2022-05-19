<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html lang="ko">
<head>	
	<title>청담원외탕전</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta name="title" content="청담원외탕전">
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/style.css" />
	<script  src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script src="/assets/common/js/jSignature/jSignature.min.js"></script>
	<!--[if lt IE 9]> 
		<script type="text/javascript" src="/assets/common/js/jSignature/flashcanvas.js"></script> 
	<![endif]-->
	<script type="text/javascript">
	$(document).ready(function() {
		$("#signature").jSignature({
			 'UndoButton':false
			,'height'    : 200
			,'width'     : 400
		});
		
		init_img();
		
		
		setTimeout(function(){
    		print();	
    	},500);
	});
	
	function init_img(){
		console.log(23222);
		var sign_img = $('#sign_img').val();
		
		if(sign_img != null){
			console.log('sign_img = ',sign_img);
			$("#signature").jSignature("importData", sign_img);
			$("#signature2").jSignature("importData", sign_img);
			
			
			var data = $('#signature').jSignature("getData", "image");
			//console.log('data = ', data);
			
			var i = new Image()
	        i.src = "data:" + data[0] + "," + data[1];
			
			$(".signature").attr("src", i.src);
		}
		
	}
	</script>
<style type="text/css" media="print">
    @page 
    {
        size: auto;   /* auto is the initial value */
        margin: 0mm;  /* this affects the margin in the printer settings */
    }
</style>
<body>
<input type="hidden" id="sign_img"  name="sign_img" value="${bean.sign_img }" />
<div class="paperArea">
	<p><img src="/assets/user/pc/images/sub/paper/01.jpg" alt="" /></p>
	<div class="pager02">
		<table style="width:790px; top:295px !important; left:165px;">
			<colgroup>
				<col width="420px" />
				<col width="*" />
			</colgroup>
			<tr>
				<td height="42" style="padding:8px 0 0 55px;vertical-align: top;">${bean.han_name}</td>
				<td style="padding:8px 0 0 50px;vertical-align: top;">
					<c:if test="${info.part eq 1 }" >한의원</c:if>
					<c:if test="${info.part eq 2 }" >한방병원</c:if>
				</td>
			</tr>
			<tr>
				<td height="42" style="padding:8px 0 0 55px;vertical-align: top;line-height: 20px;">
					(${bean.han_zipcode}) ${bean.han_address01} ${bean.han_address02}
				</td>
				<td style="padding:22px 0 0 50px;"><p style="width: 130px;">${bean.han_tel_1}-${bean.han_tel_2}-${bean.han_tel_3}</p><p style="padding-left:55px;">${bean.han_fax_1 }-${bean.han_fax_2}-${bean.han_fax_3}</p></td>
			</tr>
			<tr>
				<td height="40" style="padding:24px 0 0 2px;">
					<!-- 코드번호 -->
				</td>
				<td style="padding:24px 0 0 40px;"> <font style="padding-left:40px;"> </font> <font style="padding-left:50px;"> </font></td>
			</tr>
		</table>
		<table style="width:400px; bottom:140px; left:510px;">
			<tr>
				<td style="text-align:right;vertical-align: top;">${info.g_year} <font style="padding-left:40px;">${info.g_month}</font> <font style="padding-left:30px;">${info.g_day}</font></td>
			</tr>
			<tr>
				<td height="30" style="text-align: right;padding-right: 75px;">${bean.ceo}</td>
			</tr>
		</table>
		
		<img src="/assets/user/pc/images/sub/paper/02.jpg" alt="" />
		<img style="height: 75px;width: 150px;margin: 1280px 0px 0px -225px;position: absolute;" id="signature" class="signature" >
	</div>
	<p><img src="/assets/user/pc/images/sub/paper/03.jpg" alt="" /></p>
	<p><img src="/assets/user/pc/images/sub/paper/04.jpg" alt="" /></p>
	<div class="pager02">
		<table style="width:400px; bottom:114px; left:510px;p">
		<tr>
			<td height="30" style="text-align: right;padding-right: 75px;">
				${bean.ceo }
				<img style="height: 75px;width: 150px;margin: -30px 0px 0px 0px;position: absolute;bottom:0px;"  class="signature" >
			</td>
			
		</tr>
	</table>
	</div>
	<p><img src="/assets/user/pc/images/sub/paper/05.jpg" alt="" /></p>
	<div class="pager02">		
		<table style="width:770px; top:193px; left:390px;">
			<colgroup>
				<col width="220px" />
				<col width="140px" />
				<col width="*" />
			</colgroup>
			<tr>
				<td height="36">${bean.han_name }</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td height="36" colspan="3">(${bean.han_zipcode}) ${bean.han_address01} ${bean.han_address02}</td>
			</tr>
			<tr>
				<td height="36">${bean.ceo }</td>
				<td></td>
				<td>${info.jumin } - </td>
			</tr>
			<tr>
				<td height="36"></td>
				<td></td>
				<td style="padding-left:65px;vertical-align:top;padding-top:5px;">${info.license_no } </td>
			</tr>
		</table>
		<table style="width:400px; top:918px; left:360px;">
			<tr>
				<td>${info.g_year} <font style="padding-left:120px;">${info.g_month}</font> <font style="padding-left:120px;">${info.g_day}</font></td>
			</tr>
			<tr>
				<td height="30" style="text-align:right; padding:31px 0 0 270px;">
					${bean.ceo }
					<img style="height: 75px;width: 150px;margin: -30px 0px 0px 0px;position: absolute;" class="signature" >
				</td>
			</tr>
		</table>
		<img src="/assets/user/pc/images/sub/paper/06.jpg" alt="" /><br/>
	</div>
	<p><img src="/assets/user/pc/images/sub/paper/07.jpg" alt="" /></p>
	<p><img src="/assets/user/pc/images/sub/paper/08.jpg" alt="" /></p>
	<p><img src="/assets/user/pc/images/sub/paper/09.jpg" alt="" /></p>
	<p><img src="/assets/user/pc/images/sub/paper/10.jpg" alt="" /></p>
	<p><img src="/assets/user/pc/images/sub/paper/11.jpg" alt="" /></p>
	<p><img src="/assets/user/pc/images/sub/paper/12.jpg" alt="" /></p>
</div>
</body>
</html>