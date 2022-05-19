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
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/style.css?12" />
	<link rel="stylesheet" type="text/css" href="/assets/user/pc/css/swiper.min.css" />
	
	
	<script  src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>
	<script type="text/javascript" src="/assets/user/pc/js/common.js" ></script>
	<script type="text/javascript" src="/assets/common/js/validation.js" ></script>
	<script type="text/javascript">
    	$(document).ready(function() {
    		
    	});
    	
	</script>
</head>
<body>
	<div id="wrap">
		
		<t:insertAttribute name="header" />
		
		<!-- container -->
		<div id="container">
			<t:insertAttribute name="body" />
		</div>
		
		<t:insertAttribute name="footer" />
		
	</div>
</body>
</html>