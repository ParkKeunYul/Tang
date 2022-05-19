<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<title>관리자</title>
	<link rel="stylesheet" href="/assets/admin/css/admin.css" />
	<link rel="stylesheet" type="text/css" href="/assets/admin/css/admin.css"/> 
	<script  src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script type="text/javascript" src="/assets/admin/js/setting.js"></script>
	<script type="text/javascript" src="/assets/admin/js/validation.js"></script>
	<script type="text/javascript">
	function login(){
		
		if(!valCheck('id','아이디를 입력하세요')){ return;}
		if(!valCheck('pwd','비밀번호를 입력하세요')){ return;}
			
		$.ajax({
		    url: '/admin/loginPro.do?id='+$('#id').val()+'&pwd='+$('#pwd').val(),
		    type : "POST",
		    error: function(){
		    	alert('에러가 발생했습니다. 관리자에 문의하세요.');
		    },
		    success: function(data){
				console.log('data = ', data);
		    	if(data.suc){
		    		location.href='/admin/main.do';
		    	}else{
		    		alert(data.msg);
		    	}
		    }
		});
	}
</script>
</head>
<body>
<!-- <div id="warp">
	<div class="loginB">
		<div class="loginArea">
			정보 입력 폼
			<div class="inputA">
				<form action="#" id="loginForm" name="loginForm" >
					<p><input type="text" style="width:190px;" placeholder="ID를 입력해주세요"></p>
					<p><input type="password" style="width:190px;" placeholder="비밀번호를 입력해주세요" javascript: if (event.keyCode == 13) {login();}></p>
					<p class="bt_login">
						<a href="#" onclick="login();"><img src="images/btn_login.png" ></a>
					</p>
				</form>
			</div>
			//정보 입력 폼
		</div>
		<div class="foot">
			COPYRIGHT(C) 2019 관리자. ALL RIGHTS RESERVED.
		</div>
	</div>
</div>
 -->
<div id="warp">
	<div class="loginB">
		<div class="loginArea">
			<!-- 정보 입력 폼 -->
			<div class="inputA">
				<p>
					<input type="text" style="width:190px;" placeholder="ID를 입력해주세요" name="id" id="id" value="" onkeydown="javascript: if (event.keyCode == 13) {login();}">
				</p>
				<p>
					<input type="password" style="width:190px;" placeholder="비밀번호를 입력해주세요"  name="pwd" id="pwd" value="" onkeydown="javascript: if (event.keyCode == 13) {login();}">
				</p>
				<p class="bt_login">
					<a href="#" onclick="login();"><img src="/assets/admin/images/btn_login.png" ></a>
				</p>
			</div>
			<!-- //정보 입력 폼 -->
		</div>
		<div class="foot">
			COPYRIGHT(C) 2019 관리자. ALL RIGHTS RESERVED.
		</div>
	</div>
</div>
</body>
</html>

