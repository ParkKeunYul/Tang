<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
$(document).ready(function() {
	$("#popLoginBtn").click(function() {
		userLoginProc();
		return false;
	});
	
	$("#pop_id, #pop_password").keydown(function(key) {
		if (key.keyCode == 13) {
			userLoginProc();
		}
	});
	
	var cookie_exist = objToStr(CookieManager.get("loginID"), '');
	if (cookie_exist != '') {
		$('#pop_id').val(cookie_exist);
		$("#pop_idsave").prop("checked", true);
	}
});

function userLoginProc() {
	if (!valCheck('pop_id', '아이디를 입력하세요.'))
		return;
	if (!valCheck('pop_password', '비밀번호를 입력하세요.'))
		return;

	$.ajax({
		url : '/login_proc.do',
		type : 'POST',
		data : {
			id : $('#pop_id').val(),
			password : $('#pop_password').val()
		},
		error : function() {
			alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		},
		success : function(data) {
			// console.log('data = ', data);
			if (data.suc) {
				if ($("#pop_idsave").is(":checked")) {
					CookieManager.put('loginID', $('#pop_id').val(), 60);
				} else {
					CookieManager.put('loginID', $('#pop_id').val(), 0);
					CookieManager.remove('loginID');
				}
				$('#pop_id').val('');
				$('#pop_password').val('');
				location.href = data.url;
				
			} else {
				alert(data.msg);
			}
		}
	});
}
</script>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">로그인</p>		
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<div class="contents" id="contents">				
		<div class="loginbox">
			<div class="loginA">
				<span><input type="text" id="pop_id" 	  name="pop_id" value="" placeholder="ID를 입력해주세요" style="width:100%;" /></span>
				<span><input type="password"  id="pop_password" name="pop_password" value=""  placeholder="비밀번호를 입력해주세요" style="width:100%;" /></span>
				<span><input type="checkbox" id="pop_idsave" /> <label for="pop_idsave">아이디 저장</label></span>
				<button type="button" id="popLoginBtn" class="btnTypeBasic colorGreen w100"><span>로그인</span></button>
			</div>

			<div class="conbox">
				아이디 / 비밀번호 찾기 / 회원탈퇴는 고객센터로 연락주시기 바랍니다. <br/>
				<span>고객센터 TEL. 054.242-1079</span>
			</div>

			<p class="bottom">
				<button type="button" id="" onclick="location.href='/m/m06/01.do'" class="btnTypeBasic colorWhite w100"><span>회원가입</span></button>
			</p>
		</div>
	</div>
	<!-- //본문 -->

</div>
<!-- //container -->
		