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
		
	<!-- 본문내용 -->
	<div class="loginbox">
		<div class="loginA">
			<ul>
				<li>
					<input type="text"      id="pop_id" 	  name="pop_id" value="" placeholder="ID를 입력해주세요." style="width:426px;" />
					<input  type="password"  id="pop_password" name="pop_password" value="" placeholder="비밀번호를 입력해주세요." style="width:426px;margin-bottom: 5px;" />
					<input type="checkbox" class="ab" id="pop_idsave"  style="margin-bottom: 2px;"/> <label for="pop_idsave">아이디 저장</label>
				</li>
				<li><a href="#" id="popLoginBtn" class="loginB">로그인</a></li>
			</ul>
		</div>

		<div class="conbox">
			아이디 / 비밀번호 찾기 / 회원탈퇴는 고객센터로 연락주시기 바랍니다. <br/>
			<span>고객센터 TEL. 051-941-5104</span>
		</div>

		<div class="bottomB">
			<p class="fl">아직 비움환원외탕전실 회원이 아니신가요?</p><a href="/m06/01_step1_1.do" class="cw h40">회원가입</a>
		</div>
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
		