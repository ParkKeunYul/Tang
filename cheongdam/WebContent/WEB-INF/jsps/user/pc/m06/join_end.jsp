<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

	<%@include file="../layout_mem/top.jsp" %>
		<!-- 본문내용 -->
		<div class="joinend">
			<p class="tit">회원가입이 완료되었습니다.</p>
			<p class="txtbox">
				가입하신 유형에 따라 제출하신 서류를 확인 후 정회원으로 전환됩니다.<br/>회원가입 과정에서 관련 서류를 제출하지 못하신 경우 아래 내용을 확인하신 후<br/>서류를 제출해주시기 바랍니다.<br/><br/>
				로그인을 하시면 바로 청담원외탕전을 이용하실 수 있습니다.
			</p>

			<div class="comment">
				<p>제출서류</p>
				<ul class="listLDotted">
					<li><strong>의료기관 :</strong> 사업자등록증, 한의사 면허증</li>
					<li><strong>한의사 :</strong> 한의사 면허증</li>
				</ul>
				
				<p>서류제출 방법</p>
				<ul class="listLDotted">
					<li><strong>E-mail 발송 : </strong> cdherb@naver.com으로 스캔파일 첨부 후 발송</li>
					<li><strong>Fax 발송 :</strong> 054-232-1079로 서류 팩스발송</li>
				</ul>
			</div>

			<!-- btnarea -->
			<div class="btn_area01 pt0">
				<a href="/index.jsp"><span class="cw h60">메인화면</span></a>
				<a href="/m06/login.do"><span class="cg h60">로그인</span></a>
			</div>
			<!-- //btnarea -->
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
		