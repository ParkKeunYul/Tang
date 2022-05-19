<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% pageContext.setAttribute("newChar", "--"); %>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>탕전주문내역서</title>
	<link rel="stylesheet" href="/assets/admin/css/admin.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
	<link type="text/css" rel="stylesheet" href="/assets/common/jqGrid4.7/css/ui.jqgrid.css" />
	
	
	<script  src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="/assets/admin/js/jquery/jquery.ui.datepicker-ko.js"></script>
	
 	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/i18n/grid.locale-kr.js"></script> 
	<script type="text/javascript" src="/assets/common/jqGrid4.7/js/jquery.jqGrid.js"></script>		
	<script type="text/javascript" src="/assets/admin/js/setting.js"></script>
	<script type="text/javascript" src="/assets/admin/js/validation.js"></script>
	
	<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>
	<script language="JavaScript"> 
		$(document).ready(function() {
			
		});

		var initBody;
		
		function beforePrint(){ 
			initBody = document.body.innerHTML; 
			document.body.innerHTML = idPrint.innerHTML; 
		} 
		
		function afterPrint(){ 
			document.body.innerHTML = initBody; 
		}
		
		function printArea() { 
			window.print(); 
		} 
		
		window.onbeforeprint = beforePrint; 
		window.onafterprint  = afterPrint; 
	
	</script> 
</head>
<body style="background-color: #fff;" onload="printArea();">
	<div id="idPrint"> 
	  <table style="width:1360px;margin-top:200px;">
	  	<tr>
	  		<td style="text-align:center;widhh:760px;">
	  			<table style="width:100%;">
	  				<tr>
	  					<td colspan="2">
	  						<strong><font size=6 color="#333333">${info.w_name}&nbsp;님</font></strong>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td style="text-align:left;padding-top:100px;font-size:30px;line-height:35px;" colspan="2">
	  						&nbsp;${fn:replace(info.c_bokyong_contents, newLineChar, "<br/>")}
	  					</td>
	  				</tr>
	  				<tr>
	  					<td width="400" align="center"><strong></strong></td>
                  		<td width="300" align="center" style="padding-top:300px;line-height:35px;text-align:right;">
                  			<strong><font size=6 color="#333333">${info.han_name}<br>                    
                    		${fn:replace(info.mem_han_tel, newChar, "")}</font></strong>
                    	</td>
	  				</tr>
	  			</table>
	  		<td style="text-align:center;widhh:600px;"></td>
	  	</tr>
	  </table>
		  
	</div>
</body>
</html>