<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@include file="../layout_mem/top.jsp" %>
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

	
	var rtnUrl  = getRepVal($('#rtnUrl').val(), '');
	
	
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
				
				if(rtnUrl != null && rtnUrl != ''){
					
					var cString = 'cdherb.com/';
					var cutInt  = rtnUrl.indexOf(cString);
					
					if(cutInt != -1){
						rtnUrl = rtnUrl.substring(cutInt + cString.length-1, rtnUrl.length);	
					}
					
					location.href = rtnUrl;
				}else{
					location.href = data.url;
				}
				
			} else {
				alert(data.msg);
			}
		}
	});
}

function getRepVal(val , rep){
	try{
		if(val == null || val == "" || val == undefined){
			
			if(rep != undefined && rep != null){
				return rep;
			}else{
				return "";
			}
			
		}
	}catch (e) {
		return "";
	}
	
	return val;
}
</script>
		<div class="banner">
			<h3>로그인</h3>
			<p class="txtarea"><strong>청담원외탕전에 방문해주셔서 감사합니다.</strong><br/>회원가입을 거쳐 로그인을 하시면 청담원외탕전의 모든 메뉴를 사용하실 수 있습니다.</p>
		</div>
		<input type="hidden" id="rtnUrl" value="${bean.rtnUrl}" />

		<!-- 본문내용 -->
		<div class="loginbox pt40">
			<div class="loginA">
				<ul>
					<li>
						<input type="text"      id="pop_id" 	  name="pop_id" value="" placeholder="ID를 입력해주세요" style="width:426px;" />
						<input type="password"  id="pop_password" name="pop_password" value="" placeholder="비밀번호를 입력해주세요" style="width:426px;" />
						<input type="checkbox" class="ab" id="pop_idsave"/> <label for="pop_idsave">아이디 저장</label>
					</li>
					<li><a href="#" id="popLoginBtn" class="loginB">로그인</a></li>
				</ul>
			</div>

			<div class="conbox">
				아이디 / 비밀번호 찾기 / 회원탈퇴는 고객센터로 연락주시기 바랍니다. <br/>
				<span>고객센터 TEL. 054-242-1079</span>
			</div>

			<p class="bottom">
				<a href="/m06/01.do" class="cw h40">회원가입</a>
			</p>
		</div>
		<!-- //본문내용 -->

	</div>
	<!-- // joinArea -->
	<!-- footer -->
	<%@include file="../layout_mem/footer.jsp" %>
	<!-- //footer -->
</div>
</body>
</html>
		