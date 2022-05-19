<%@ page language="java" pageEncoding="UTF-8"%>
<div id="footer">
	<!-- footer_inner -->
	<div id="footer_inner">
		<h2><img src="/assets/user/images/common/logo_footer.png" alt="북경한의원 원외탕전실" /></h2>
		<div class="copyright">
			<ul>
				<li>상호 : 북경한의원 원외탕전실     /    대표 : 추래흥     /    사업자등록번호 : 297-97-00318</li>
				<li>(우 : 29056) 충북 옥천군 옥천읍 송신길 28 북경한의원 원외탕전실     /    고객센터 : 043.731.5075    /    팩스 : 043.731.5076</li>
				<li>Copyright ⓒ 북경한의원 원외탕전실 All rights reserved.</li>
			</ul>
		</div>
	</div>
	<!-- //footer_inner -->
</div>

<div id="login_popup1" class="Pstyle">
	<span class="b-close"><img src="/assets/user/images/sub/btn_close01.png" alt="닫기" /></span>
	<div class="content loginbox">
		<p class="tit">북경한의원 원외탕전실 로그인</p>
		
		<div class="loginA">
			<div style="padding-left: 5px;">
				<label for="master_type1">마스터 계정</label>
				<input type="radio" name="master_type" id="master_type1" checked="checked" value="1" />
				<label for="master_type2">서브 계정</label>
				<input type="radio" name="master_type" id="master_type2"  value="2" />
			</div>
			<ul>
				<li>
					<input type="text"  	 id="pop_id" 	   name="pop_id" 	  value=""	placeholder="ID를 입력해주세요" style="width:280px;" />
					<input type="password"   id="pop_password" name="pop_password"value=""  placeholder="비밀번호를 입력해주세요" style="width:280px;" />
					<input type="checkbox"   id="pop_idsave" class="ab" style="margin-bottom: 0px;" /> <label for="pop_idsave" style="margin-left:0px;cursor: pointer;">아이디 저장</label>
				</li>
				<li><a href="#" id="popLoginBtn" class="loginB">로그인</a></li>
			</ul>
		</div>

		<div class="conbox">
			아이디 / 비밀번호 찾기 / 회원탈퇴는 고객센터로 연락주시기 바랍니다. <br/>
			<span>고객센터 TEL. 043.731.5075</span>
		</div>

		<ul class="bottom">
			<li>아직 회원이 아니세요?</li>
			<li><a href="/m06/01.do" class="cw h40">회원가입</a></li>
		</ul>

	</div>
</div>
