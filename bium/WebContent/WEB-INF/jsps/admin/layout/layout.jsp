<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"
%><%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%><%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<meta http-equiv="Expires" content="-1"> 
	<meta http-equiv="Pragma" content="no-cache"> 
	<meta http-equiv="Cache-Control" content="No-Cache">	
	<meta name="viewport" content="width=device-width, initial-scale=1"> 


	<title>원외탕전 관리자</title>
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
</head>
<% 
 response.setHeader("Cache-Control","no-cache"); 
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0); 
%>

<body>
<div id="warp"> 
    <div id="headerWr">
		<t:insertAttribute name="header" />
	</div>
	<div id="container">
		<div id="leftM">
			<t:insertAttribute name="letfmenu" />
		</div>
		<div id="contents">
			<t:insertAttribute name="body" />
		</div>
	</div>
	
	<div id="footerWr">
		<t:insertAttribute name="footer" />
	</div>
		
</div>
</body>
</html>